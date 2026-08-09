import argparse
import csv
import gzip
import hashlib
import html
import json
import os
import re
import subprocess
import sys
import time
import urllib.parse
import urllib.request
import zlib
from pathlib import Path
from xml.etree import ElementTree


MIXIN_KEY_ENC_TAB = [
    46, 47, 18, 2, 53, 8, 23, 32, 15, 50, 10, 31, 58, 3, 45, 35,
    27, 43, 5, 49, 33, 9, 42, 19, 29, 28, 14, 39, 12, 38, 41, 13,
    37, 48, 7, 16, 24, 55, 40, 61, 26, 17, 0, 1, 60, 51, 30, 4,
    22, 25, 54, 21, 56, 59, 6, 63, 57, 62, 11, 36, 20, 34, 44, 52,
]
BVID_PATTERN = re.compile(r"(?i)\b(BV[0-9A-Za-z]{10})\b")
AID_PATTERN = re.compile(r"(?i)(?:/video/av|\bav)(\d{5,})")
TAG_PATTERN = re.compile(r"<[^>]+>")
BAD_TITLE_WORDS = ("关注", "三连", "点赞", "投币", "求赞", "解说", "盘点")


def request_bytes(url, referer="https://www.bilibili.com/", timeout=25):
    headers = {
        "User-Agent": "Mozilla/5.0 SekaiMemory/1.0",
        "Referer": referer,
        "Accept-Encoding": "gzip, deflate",
    }
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=timeout) as response:
        data = response.read()
        encoding = response.headers.get("Content-Encoding", "").lower()
    if encoding == "gzip":
        return gzip.decompress(data)
    if encoding == "deflate":
        try:
            return zlib.decompress(data)
        except zlib.error:
            return zlib.decompress(data, -zlib.MAX_WBITS)
    return data


def request_json(url, referer="https://www.bilibili.com/"):
    return json.loads(request_bytes(url, referer=referer).decode("utf-8"))


def strip_title(value):
    value = TAG_PATTERN.sub("", value or "")
    return html.unescape(value).strip()


def normalize(value):
    if not value:
        return ""
    return "".join(ch.lower() for ch in value if ch.isalnum())


def lcs_len(a, b):
    if not a or not b:
        return 0
    prev = [0] * (len(b) + 1)
    for ca in a:
        cur = [0]
        for j, cb in enumerate(b, start=1):
            if ca == cb:
                cur.append(prev[j - 1] + 1)
            else:
                cur.append(max(prev[j], cur[-1]))
        prev = cur
    return prev[-1]


def text_score(needle, haystack):
    a = normalize(needle)
    b = normalize(haystack)
    if not a or not b:
        return 0.0
    if a in b or b in a:
        return min(len(a), len(b)) / max(len(a), len(b))
    return lcs_len(a, b) / max(len(a), len(b))


def parse_duration(value):
    if value is None:
        return 0.0
    if isinstance(value, (int, float)):
        return float(value)
    parts = str(value).strip().split(":")
    try:
        total = 0
        for part in parts:
            total = total * 60 + int(part)
        return float(total)
    except ValueError:
        return 0.0


def sql_literal(value):
    return "'" + str(value).replace("'", "''") + "'"


def run_mysql(args, sql, read=True):
    env = os.environ.copy()
    env["MYSQL_PWD"] = args.mysql_password
    cmd = [
        "mysql",
        "--default-character-set=utf8mb4",
        f"-u{args.mysql_user}",
        "-D",
        args.database,
    ]
    if read:
        cmd.extend(["-N", "-B", "--raw", "-e", sql])
    process = subprocess.run(
        cmd,
        input=None if read else sql,
        text=True,
        encoding="utf-8",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        env=env,
        check=False,
    )
    if process.returncode != 0:
        raise RuntimeError(process.stderr.strip() or "mysql failed")
    return process.stdout


def load_quotes(args):
    where = [
        f"q.user_id = {int(args.user_id)}",
        "q.content IS NOT NULL",
        "q.content <> ''",
    ]
    if args.only_missing_local:
        where.append("(q.video_url IS NULL OR q.video_url = '' OR q.video_url NOT LIKE '/uploads/quote-videos/%')")
    if args.ids:
        ids = ",".join(str(int(value)) for value in args.ids.split(",") if value.strip())
        where.append(f"q.id IN ({ids})")
    sql = f"""
        SELECT
          q.id,
          REPLACE(REPLACE(COALESCE(a.title,''), CHAR(9), ' '), CHAR(10), ' '),
          REPLACE(REPLACE(COALESCE(q.character_name,''), CHAR(9), ' '), CHAR(10), ' '),
          REPLACE(REPLACE(COALESCE(q.content,''), CHAR(9), ' '), CHAR(10), ' '),
          COALESCE(q.video_url,'')
        FROM sekai_memory_book_quote q
        LEFT JOIN sekai_memory_book_anime a ON q.anime_id = a.id
        WHERE {" AND ".join(where)}
        ORDER BY q.id
        LIMIT {int(args.limit)}
    """
    rows = []
    for line in run_mysql(args, sql).splitlines():
        parts = line.split("\t")
        if len(parts) < 5:
            continue
        rows.append({
            "id": int(parts[0]),
            "anime": parts[1],
            "character": parts[2],
            "content": parts[3],
            "video_url": parts[4],
        })
    return rows


def extract_video_key(url):
    if not url:
        return None
    match = BVID_PATTERN.search(url)
    if match:
        return {"kind": "bvid", "value": match.group(1)}
    match = AID_PATTERN.search(url)
    if match:
        return {"kind": "aid", "value": match.group(1)}
    return None


def get_wbi_key():
    data = request_json("https://api.bilibili.com/x/web-interface/nav")
    wbi = data.get("data", {}).get("wbi_img", {})
    raw = ""
    for field in ("img_url", "sub_url"):
        match = re.search(r"/([^/]+)\.png", wbi.get(field, ""))
        if match:
            raw += match.group(1)
    if len(raw) < 64:
        raise RuntimeError("Unable to read Bilibili WBI key")
    return "".join(raw[i] for i in MIXIN_KEY_ENC_TAB)[:32]


def sign_wbi(params, key):
    clean = {
        name: "".join(ch for ch in str(value) if ch not in "!'()*")
        for name, value in params.items()
        if value is not None
    }
    clean["wts"] = int(time.time())
    query = urllib.parse.urlencode(dict(sorted(clean.items())))
    return query + "&w_rid=" + hashlib.md5((query + key).encode("utf-8")).hexdigest()


def search_bilibili(query, key, page_size=8):
    params = {
        "search_type": "video",
        "keyword": query,
        "page": 1,
        "page_size": page_size,
    }
    url = "https://api.bilibili.com/x/web-interface/wbi/search/type?" + sign_wbi(params, key)
    data = request_json(url)
    if data.get("code") != 0:
        return []
    results = []
    for item in data.get("data", {}).get("result", []) or []:
        bvid = item.get("bvid")
        title = strip_title(item.get("title"))
        if not bvid or not title:
            continue
        if any(word in title for word in BAD_TITLE_WORDS):
            continue
        results.append({
            "bvid": bvid,
            "url": f"https://www.bilibili.com/video/{bvid}/",
            "title": title,
            "duration": parse_duration(item.get("duration")),
            "source": "search",
        })
    return results


def candidate_score(quote, candidate):
    title = candidate.get("title", "")
    score = 0.0
    score += text_score(quote["content"], title) * 5
    score += text_score(quote["character"], title) * 2
    score += text_score(quote["anime"], title) * 1.5
    if any(word in title for word in ("台词", "语音", "片段", "名场面", "cut", "CUT")):
        score += 1.0
    duration = candidate.get("duration") or 0
    if 0 < duration <= 25:
        score += 2.0
    elif duration <= 60:
        score += 1.0
    elif duration >= 600:
        score -= 2.0
    return score


def build_candidates(quote, args, wbi_key, manual):
    candidates = []
    seen = set()

    def add(candidate):
        key = candidate.get("bvid") or candidate.get("url")
        if key and key not in seen:
            seen.add(key)
            candidates.append(candidate)

    manual_row = manual.get(quote["id"])
    if manual_row and manual_row.get("source_url"):
        add({
            "url": manual_row["source_url"],
            "title": "manual-source",
            "duration": max(0.0, manual_row["end"] - manual_row["start"]),
            "source": "manual",
        })
    if args.search:
        queries = [
            f"{quote['content']} {quote['character']}",
            f"{quote['character']} {quote['content']} 台词",
            f"{quote['anime']} {quote['character']} 台词",
        ]
        for query in queries:
            for result in search_bilibili(query, wbi_key, args.search_page_size):
                add(result)
            time.sleep(0.2)
    key = extract_video_key(quote.get("video_url"))
    if key:
        add({
            "url": quote["video_url"],
            "title": "existing-url",
            "duration": 0,
            "source": "existing",
            "bvid": key["value"] if key["kind"] == "bvid" else None,
            "aid": key["value"] if key["kind"] == "aid" else None,
        })
    for candidate in candidates:
        candidate["score"] = candidate_score(quote, candidate)
    return sorted(candidates, key=lambda item: item["score"], reverse=True)[:args.max_candidates]


def fetch_video_detail(candidate):
    key = extract_video_key(candidate.get("url", ""))
    if not key and candidate.get("bvid"):
        key = {"kind": "bvid", "value": candidate["bvid"]}
    if not key and candidate.get("aid"):
        key = {"kind": "aid", "value": candidate["aid"]}
    if not key:
        return None
    if key["kind"] == "bvid":
        url = "https://api.bilibili.com/x/web-interface/view?" + urllib.parse.urlencode({"bvid": key["value"]})
    else:
        url = "https://api.bilibili.com/x/web-interface/view?" + urllib.parse.urlencode({"aid": key["value"]})
    data = request_json(url, referer=candidate.get("url") or "https://www.bilibili.com/")
    if data.get("code") != 0:
        return None
    detail = data.get("data") or {}
    detail["_key"] = key
    return detail


def select_page(detail, source_url):
    pages = detail.get("pages") or []
    if not pages:
        return None
    page_number = 1
    match = re.search(r"[?&]p=(\d+)", source_url or "")
    if match:
        page_number = int(match.group(1))
    for page in pages:
        if int(page.get("page") or 0) == page_number:
            return page
    return pages[0]


def fetch_subtitles(detail, page, source_url):
    key = detail.get("_key") or {}
    params = {"cid": page.get("cid")}
    if key.get("kind") == "bvid":
        params["bvid"] = key["value"]
    elif key.get("kind") == "aid":
        params["aid"] = key["value"]
    else:
        return []
    url = "https://api.bilibili.com/x/player/v2?" + urllib.parse.urlencode(params)
    data = request_json(url, referer=source_url)
    subtitles = data.get("data", {}).get("subtitle", {}).get("subtitles", []) or []
    rows = []
    for subtitle in subtitles:
        sub_url = subtitle.get("subtitle_url")
        if not sub_url:
            continue
        if sub_url.startswith("//"):
            sub_url = "https:" + sub_url
        body = request_json(sub_url, referer=source_url)
        rows.extend(body.get("body", []) or [])
    return rows


def match_subtitle_time(quote, subtitles, threshold):
    best = None
    for index in range(len(subtitles)):
        for window in range(1, 5):
            group = subtitles[index:index + window]
            if not group:
                continue
            text = "".join(str(item.get("content") or "") for item in group)
            score = text_score(quote["content"], text)
            if best is None or score > best["score"]:
                best = {
                    "score": score,
                    "start": float(group[0].get("from") or 0),
                    "end": float(group[-1].get("to") or group[0].get("from") or 0),
                    "text": text,
                    "method": "subtitle",
                }
    return best if best and best["score"] >= threshold else None


def fetch_danmaku(cid, source_url):
    url = f"https://comment.bilibili.com/{cid}.xml"
    text = request_bytes(url, referer=source_url).decode("utf-8", errors="replace")
    root = ElementTree.fromstring(text)
    rows = []
    for node in root.findall("d"):
        p = node.attrib.get("p", "")
        try:
            at = float(p.split(",", 1)[0])
        except (ValueError, IndexError):
            continue
        rows.append({"time": at, "text": node.text or ""})
    return rows


def match_danmaku_time(quote, rows, threshold, allow_character):
    best = None
    for row in rows:
        score = text_score(quote["content"], row["text"])
        method = "danmaku"
        if allow_character and score < threshold:
            character_score = text_score(quote["character"], row["text"])
            if character_score > score:
                score = character_score * 0.55
                method = "danmaku-character"
        if best is None or score > best["score"]:
            best = {
                "score": score,
                "start": row["time"],
                "end": row["time"] + 1,
                "text": row["text"],
                "method": method,
            }
    return best if best and best["score"] >= threshold else None


def manual_times(path):
    if not path or not Path(path).exists():
        return {}
    with open(path, "r", encoding="utf-8-sig", newline="") as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        data = {}
        for row in reader:
            row_lower = {key.lower(): value for key, value in row.items() if key}
            quote_id = row_lower.get("id") or row_lower.get("quote_id")
            start = row_lower.get("start") or row_lower.get("start_seconds")
            end = row_lower.get("end") or row_lower.get("end_seconds")
            if quote_id and start and end:
                data[int(quote_id)] = {
                    "start": float(start),
                    "end": float(end),
                    "source_url": row_lower.get("source_url") or row_lower.get("url") or "",
                }
        return data


def fetch_play_urls(detail, page, source_url, quality):
    key = detail.get("_key") or {}
    params = {
        "cid": page.get("cid"),
        "qn": quality,
        "fnval": 16,
        "fourk": 0,
    }
    if key.get("kind") == "bvid":
        params["bvid"] = key["value"]
    elif key.get("kind") == "aid":
        params["avid"] = key["value"]
    else:
        return None
    url = "https://api.bilibili.com/x/player/playurl?" + urllib.parse.urlencode(params)
    data = request_json(url, referer=source_url)
    if data.get("code") != 0:
        return None
    payload = data.get("data") or {}
    if payload.get("dash"):
        videos = payload["dash"].get("video") or []
        audios = payload["dash"].get("audio") or []
        videos = sorted(videos, key=lambda item: item.get("bandwidth") or 0)
        audios = sorted(audios, key=lambda item: item.get("bandwidth") or 0)
        avc = [item for item in videos if str(item.get("codecs", "")).startswith("avc")]
        video = (avc or videos)[0] if videos else None
        audio = audios[0] if audios else None
        if video and audio:
            return {"kind": "dash", "video": video["baseUrl"], "audio": audio["baseUrl"]}
    durl = payload.get("durl") or []
    if durl:
        return {"kind": "durl", "url": durl[0].get("url")}
    return None


def ffmpeg_headers(source_url):
    return f"Referer: {source_url}\r\nUser-Agent: Mozilla/5.0 SekaiMemory/1.0\r\n"


def cut_segment(args, play_urls, source_url, start, end, output):
    output.parent.mkdir(parents=True, exist_ok=True)
    duration = max(0.1, end - start)
    headers = ffmpeg_headers(source_url)
    if play_urls["kind"] == "dash":
        cmd = [
            args.ffmpeg,
            "-hide_banner", "-loglevel", "error", "-y",
            "-headers", headers, "-ss", f"{start:.3f}", "-i", play_urls["video"],
            "-headers", headers, "-ss", f"{start:.3f}", "-i", play_urls["audio"],
            "-t", f"{duration:.3f}",
            "-map", "0:v:0", "-map", "1:a:0",
            "-c:v", "libx264", "-preset", "veryfast", "-crf", "28",
            "-c:a", "aac", "-b:a", "96k",
            "-movflags", "+faststart",
            str(output),
        ]
    else:
        cmd = [
            args.ffmpeg,
            "-hide_banner", "-loglevel", "error", "-y",
            "-headers", headers, "-ss", f"{start:.3f}", "-i", play_urls["url"],
            "-t", f"{duration:.3f}",
            "-c:v", "libx264", "-preset", "veryfast", "-crf", "28",
            "-c:a", "aac", "-b:a", "96k",
            "-movflags", "+faststart",
            str(output),
        ]
    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, encoding="utf-8", errors="replace")
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or "ffmpeg failed")
    if not output.exists() or output.stat().st_size <= 0:
        raise RuntimeError("ffmpeg produced no output")


def locate_time(quote, detail, page, candidate, args, manual):
    if quote["id"] in manual:
        start = manual[quote["id"]]["start"]
        end = manual[quote["id"]]["end"]
        return {"method": "manual", "score": 1.0, "start": start, "end": end, "text": ""}
    source_url = candidate["url"]
    subtitles = []
    try:
        subtitles = fetch_subtitles(detail, page, source_url)
    except Exception:
        subtitles = []
    matched = match_subtitle_time(quote, subtitles, args.match_threshold)
    if matched:
        return matched
    danmaku_rows = []
    try:
        danmaku_rows = fetch_danmaku(str(page.get("cid")), source_url)
    except Exception:
        danmaku_rows = []
    matched = match_danmaku_time(quote, danmaku_rows, args.match_threshold, args.allow_character_danmaku)
    if matched:
        return matched
    duration = float(page.get("duration") or detail.get("duration") or candidate.get("duration") or 0)
    high_title_score = candidate.get("score", 0) >= args.short_candidate_score
    if args.allow_short_candidate and 0 < duration <= args.short_candidate_seconds and high_title_score:
        return {"method": "short-candidate", "score": candidate.get("score", 0), "start": 0.0, "end": duration, "text": candidate.get("title", "")}
    return {
        "method": "missing-time",
        "score": 0.0,
        "start": "",
        "end": "",
        "text": f"subtitles={len(subtitles)}, danmaku={len(danmaku_rows)}",
    }


def write_status(path, rows):
    path.parent.mkdir(parents=True, exist_ok=True)
    fields = [
        "id", "anime", "character", "content", "status", "method", "score",
        "start", "end", "cid", "source_url", "candidate_title", "local_url", "note",
    ]
    with open(path, "w", encoding="utf-8-sig", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields, delimiter="\t")
        writer.writeheader()
        for row in rows:
            writer.writerow({field: row.get(field, "") for field in fields})


def main():
    parser = argparse.ArgumentParser(description="Find and cache tiny local clips for quote videos.")
    parser.add_argument("--database", default="sekai_friend")
    parser.add_argument("--user-id", type=int, default=3)
    parser.add_argument("--mysql-user", default="root")
    parser.add_argument("--mysql-password", default="123456")
    parser.add_argument("--limit", type=int, default=10)
    parser.add_argument("--ids", default="")
    parser.add_argument("--only-missing-local", action="store_true", default=True)
    parser.add_argument("--search", action="store_true")
    parser.add_argument("--search-page-size", type=int, default=8)
    parser.add_argument("--max-candidates", type=int, default=4)
    parser.add_argument("--manual-times", default="target/quote-segment-manual-times.tsv")
    parser.add_argument("--ffmpeg", default=r"C:\Program Files\GNU Octave\Octave-11.1.0\mingw64\bin\ffmpeg.exe")
    parser.add_argument("--output-dir", default="uploads/quote-videos")
    parser.add_argument("--status", default="target/quote-segment-status.tsv")
    parser.add_argument("--quality", type=int, default=16)
    parser.add_argument("--match-threshold", type=float, default=0.62)
    parser.add_argument("--pre-pad", type=float, default=1.8)
    parser.add_argument("--post-pad", type=float, default=2.8)
    parser.add_argument("--danmaku-window", type=float, default=7.0)
    parser.add_argument("--allow-character-danmaku", action="store_true")
    parser.add_argument("--allow-short-candidate", action="store_true")
    parser.add_argument("--short-candidate-seconds", type=float, default=28.0)
    parser.add_argument("--short-candidate-score", type=float, default=5.0)
    parser.add_argument("--update-db", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    if not Path(args.ffmpeg).exists():
        raise SystemExit(f"ffmpeg not found: {args.ffmpeg}")

    quotes = load_quotes(args)
    manual = manual_times(args.manual_times)
    wbi_key = get_wbi_key() if args.search else None
    status_rows = []
    update_sql = ["START TRANSACTION;"]
    cached_count = 0

    for quote in quotes:
        candidates = build_candidates(quote, args, wbi_key, manual)
        if not candidates:
            status_rows.append({**quote, "status": "no-candidate", "note": "no Bilibili candidate"})
            continue
        finished = False
        notes = []
        for candidate in candidates:
            detail = fetch_video_detail(candidate)
            if not detail:
                notes.append(f"{candidate.get('url')}: detail-missing")
                continue
            page = select_page(detail, candidate.get("url"))
            if not page or not page.get("cid"):
                notes.append(f"{candidate.get('url')}: cid-missing")
                continue
            location = locate_time(quote, detail, page, candidate, args, manual)
            if location["method"] == "missing-time":
                notes.append(f"{candidate.get('url')}: {location['text']}")
                continue
            if location["method"] in ("manual", "short-candidate"):
                start = max(0.0, float(location["start"]))
                end = float(location["end"])
            else:
                start = max(0.0, float(location["start"]) - args.pre_pad)
                end = float(location["end"]) + args.post_pad
            if location["method"].startswith("danmaku"):
                end = start + args.danmaku_window
            cid = str(page.get("cid"))
            start_ms = int(start * 1000)
            end_ms = int(end * 1000)
            upload_dir = Path(args.output_dir)
            existing_outputs = sorted(upload_dir.glob(f"*-{cid}-{start_ms}-{end_ms}.mp4")) if upload_dir.exists() else []
            if existing_outputs:
                output_path = existing_outputs[0]
                output_name = output_path.name
            else:
                output_name = f"quote-{quote['id']}-{cid}-{start_ms}-{end_ms}.mp4"
                output_path = upload_dir / output_name
            local_url = f"/uploads/quote-videos/{output_name}"
            row = {
                **quote,
                "status": "matched",
                "method": location["method"],
                "score": f"{location['score']:.3f}",
                "start": f"{start:.3f}",
                "end": f"{end:.3f}",
                "cid": cid,
                "source_url": candidate.get("url"),
                "candidate_title": candidate.get("title"),
                "local_url": local_url,
                "note": location.get("text", ""),
            }
            if not args.dry_run:
                play_urls = fetch_play_urls(detail, page, candidate.get("url"), args.quality)
                if not play_urls:
                    row["status"] = "playurl-missing"
                    status_rows.append(row)
                    continue
                try:
                    cut_segment(args, play_urls, candidate.get("url"), start, end, output_path)
                except Exception as exc:
                    row["status"] = "cut-failed"
                    row["note"] = str(exc)
                    status_rows.append(row)
                    continue
                cached_count += 1
                if args.update_db:
                    update_sql.append(
                        f"UPDATE sekai_memory_book_quote SET video_url={sql_literal(local_url)} "
                        f"WHERE id={int(quote['id'])} AND user_id={int(args.user_id)};"
                    )
                    row["status"] = "cached-and-updated"
                else:
                    row["status"] = "cached"
            status_rows.append(row)
            finished = True
            break
        if not finished:
            candidate_note = " || ".join(
                f"{item.get('title')} [{item.get('duration')}] {item.get('url')}"
                for item in candidates[:4]
            )
            note = " | ".join(notes[:4])
            if candidate_note:
                note = (note + " || candidates: " + candidate_note).strip()
            status_rows.append({**quote, "status": "manual-needed", "note": note})

    update_sql.append("COMMIT;")
    if args.update_db and not args.dry_run and cached_count > 0:
        run_mysql(args, "\n".join(update_sql), read=False)
    write_status(Path(args.status), status_rows)
    print(f"QUOTES={len(quotes)}")
    print(f"CACHED={cached_count}")
    print(f"STATUS={Path(args.status).resolve()}")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        raise
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
