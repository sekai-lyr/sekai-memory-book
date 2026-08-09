Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$rows = @(
    @{ Title="最近的侦探真没用"; Query="Mattaku Saikin no Tantei to Kitara"; Score="10.0"; Type="日本/搞笑,推理,日常,悬疑,漫画改"; Tags="搞笑,推理,日常,悬疑,漫画改"; Release="2025-07-01"; Episodes=12 },
    @{ Title="9-nine- 支配者的王冠"; Query="9-nine Ruler's Crown"; Score="10.0"; Type="日本/奇幻,恋爱,后宫,游戏改"; Tags="奇幻,恋爱,后宫,游戏改"; Release="2025-07-05"; Episodes=13 },
    @{ Title="选择项目"; Query="Selection Project"; Score="10.0"; Type="日本/百合,偶像,音乐"; Tags="百合,偶像,音乐"; Release="2021-10-01"; Episodes=13 },
    @{ Title="莉可丽丝"; Query="Lycoris Recoil"; Score="10.0"; Type="日本/奇幻,战斗,百合"; Tags="奇幻,战斗,百合"; Release="2022-07-02"; Episodes=13; SkipExtras=$true },
    @{ Title="莉可丽丝 Friends are thieves of time."; Query="Lycoris Recoil Friends are thieves of time"; Score="10.0"; Type="日本/百合,日常"; Tags="百合,日常"; Release="2025-04-16"; Episodes=6 },
    @{ Title="想要成为影之实力者！"; Query="Kage no Jitsuryokusha ni Naritakute"; Score="9.0"; Type="日本/搞笑,战斗,奇幻,冒险,后宫"; Tags="搞笑,战斗,奇幻,冒险,后宫"; Release="2022-10-05"; Episodes=20 },
    @{ Title="想要成为影之实力者！ 第二季"; Query="Kage no Jitsuryokusha ni Naritakute 2nd Season"; Score="10.0"; Type="日本/搞笑,战斗,后宫,奇幻,冒险"; Tags="搞笑,战斗,后宫,奇幻,冒险"; Release="2023-10-04"; Episodes=12 },
    @{ Title="薰香花朵凛然绽放"; Query="Kaoru Hana wa Rin to Saku"; Score="10.0"; Type="日本/校园,日常,恋爱,青春,漫画改"; Tags="校园,日常,恋爱,青春,漫画改"; Release="2025-07-06"; Episodes=13 },
    @{ Title="瑠璃的宝石"; Query="Ruri no Houseki"; Score="9.5"; Type="日本/日常,百合,漫画改"; Tags="日常,百合,漫画改"; Release="2025-07-06"; Episodes=13 },
    @{ Title="时光流逝，饭菜依旧美味"; Query="Hibi wa Sugiredo Meshi Umashi"; Score="10.0"; Type="日本/日常,百合,漫画改"; Tags="日常,百合,漫画改"; Release="2025-04-13"; Episodes=12 },
    @{ Title="剧场版世界计划 破碎的世界与无法歌唱的初音未来"; Query="Colorful Stage The Movie Miku Who Can't Sing"; Score="10.0"; Type="日本/奇幻,音乐,偶像,青春,游戏改"; Tags="奇幻,音乐,偶像,青春,游戏改"; Release="2025-01-17"; Episodes=1 },
    @{ Title="鸭乃桥论的禁忌推理"; Query="Kamonohashi Ron no Kindan Suiri"; Score="10.0"; Type="日本/推理,猎奇"; Tags="推理,猎奇"; Release="2023-10-02"; Episodes=13 },
    @{ Title="鸭乃桥论的禁忌推理 第二季"; Query="Kamonohashi Ron no Kindan Suiri 2nd Season"; Score="10.0"; Type="日本/推理"; Tags="推理"; Release="2024-10-07"; Episodes=13 },
    @{ Title="新 狼与香辛料"; Query="Ookami to Koushinryou Merchant Meets the Wise Wolf"; Score="10.0"; Type="日本/治愈,恋爱,奇幻,冒险"; Tags="治愈,恋爱,奇幻,冒险"; Release="2024-04-02"; Episodes=25 },
    @{ Title="辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA"; Query="Kaguya-sama wa Kokurasetai OVA"; Score="6.5"; Type="日本/搞笑,恋爱,校园"; Tags="搞笑,恋爱,校园"; Release="2021-05-19"; Episodes=1 },
    @{ Title="辉夜大小姐想让我告白～天才们的恋爱头脑战～"; Query="Kaguya-sama wa Kokurasetai Tensai-tachi no Renai Zunousen"; Score="10.0"; Type="日本/搞笑,恋爱,校园"; Tags="搞笑,恋爱,校园"; Release="2019-01-12"; Episodes=12 },
    @{ Title="辉夜大小姐想让我告白？～天才们的恋爱头脑战～"; Query="Kaguya-sama wa Kokurasetai 2nd Season"; Score="10.0"; Type="日本/搞笑,恋爱,校园"; Tags="搞笑,恋爱,校园"; Release="2020-04-11"; Episodes=12 },
    @{ Title="辉夜大小姐想让我告白 -Ultra Romantic-"; Query="Kaguya-sama wa Kokurasetai Ultra Romantic"; Score="10.0"; Type="日本/搞笑,恋爱,校园"; Tags="搞笑,恋爱,校园"; Release="2022-04-09"; Episodes=13 },
    @{ Title="辉夜大小姐想让我告白：初吻不会结束"; Query="Kaguya-sama wa Kokurasetai First Kiss wa Owaranai"; Score="10.0"; Type="日本/搞笑,恋爱,青春,校园"; Tags="搞笑,恋爱,青春,校园"; Release="2023-04-01"; Episodes=4 },
    @{ Title="辉夜大小姐想让我告白 通往大人的阶梯"; Query="Kaguya-sama wa Kokurasetai Otona e no Kaidan"; Score="10.0"; Type="日本/搞笑,恋爱,校园,青春,漫画改"; Tags="搞笑,恋爱,校园,青春,漫画改"; Release="2025-01-01"; Episodes=2 },
    @{ Title="BanG Dream! It's MyGO!!!!!"; Query="BanG Dream It's MyGO"; MalId=54959; Score="10.0"; Type="日本/励志,青春,校园,音乐"; Tags="励志,青春,校园,音乐"; Release="2023-06-29"; Episodes=13 },
    @{ Title="BanG Dream! Ave Mujica"; Query="BanG Dream Ave Mujica"; Score="10.0"; Type="日本/校园,美少女,青春,日常,偶像,百合,音乐"; Tags="校园,美少女,青春,日常,偶像,百合,音乐"; Release="2025-01-02"; Episodes=13 },
    @{ Title="葬送的芙莉莲"; Query="Sousou no Frieren"; Score="10.0"; Type="日本/奇幻,冒险"; Tags="奇幻,冒险"; Release="2023-09-29"; Episodes=28 },
    @{ Title="葬送的芙莉莲 第二季"; Query="Sousou no Frieren 2nd Season"; Score="10.0"; Type="日本/奇幻,冒险,异世界,治愈,漫画改,日常,战斗"; Tags="奇幻,冒险,异世界,治愈,漫画改,日常,战斗"; Release="2026-01-16"; Episodes=10 },
    @{ Title="古诺希亚"; Query="Gnosia"; Score="10.0"; Type="日本/科幻,悬疑,游戏改,热血,冒险"; Tags="科幻,悬疑,游戏改,热血,冒险"; Release="2025-10-12"; Episodes=21 },
    @{ Title="我独自升级"; Query="Ore dake Level Up na Ken"; Score="10.0"; Type="日本/战斗,奇幻,冒险"; Tags="战斗,奇幻,冒险"; Release="2024-01-07"; Episodes=12 },
    @{ Title="我独自升级 第二季"; Query="Ore dake Level Up na Ken Season 2"; Score="10.0"; Type="日本/奇幻,冒险,战斗,异世界,漫画改"; Tags="奇幻,冒险,战斗,异世界,漫画改"; Release="2025-01-05"; Episodes=13 },
    @{ Title="超时空辉夜姬！"; Query="Chou Kaguya-hime"; MalId=62896; Score="10.0"; Type="日本/科幻,剧情,奇幻,音乐"; Tags="科幻,剧情,奇幻,音乐"; Release="2026-01-22"; Episodes=1 },
    @{ Title="小林家的龙女仆剧场版 怕寂寞的龙"; Query="Kobayashi-san Chi no Maid Dragon Samishigariya no Ryuu"; Score="10.0"; Type="日本/搞笑,百合,战斗,日常,治愈,漫画改"; Tags="搞笑,百合,战斗,日常,治愈,漫画改"; Release="2025-06-27"; Episodes=1 },
    @{ Title="杖与剑的魔剑谭"; Query="Tsue to Tsurugi no Wistoria"; Score="10.0"; Type="日本/奇幻,战斗,魔法"; Tags="奇幻,战斗,魔法"; Release="2024-07-07"; Episodes=12 },
    @{ Title="转生七王子的魔法全解"; Query="Dai Nana Ouji Majutsu"; MalId=53516; Score="9.0"; Type="日本/奇幻,冒险"; Tags="奇幻,冒险"; Release="2024-04-02"; Episodes=12 },
    @{ Title="最强阴阳师的异世界转生记"; Query="Saikyou Onmyouji no Isekai Tenseiki"; Score="10.0"; Type="日本/战斗,奇幻,冒险"; Tags="战斗,奇幻,冒险"; Release="2023-01-07"; Episodes=13 },
    @{ Title="转生七王子的魔法全解 第二季"; Query="Dai Nana Ouji Majutsu 2nd Season"; MalId=59095; Score="9.5"; Type="日本/奇幻,战斗,转生,异世界,后宫,轻小说改"; Tags="奇幻,战斗,转生,异世界,后宫,轻小说改"; Release="2025-07-10"; Episodes=12 },
    @{ Title="鬼灭之刃 游郭篇 特别编辑版"; Query="Kimetsu no Yaiba Yuukaku-hen Tokubetsu Henshuuban"; Score="10.0"; Type="日本/热血,战斗,奇幻,冒险"; Tags="热血,战斗,奇幻,冒险"; Release="2023-04-01"; Episodes=2 },
    @{ Title="鬼灭之刃 游郭篇"; Query="Kimetsu no Yaiba Yuukaku-hen"; Score="10.0"; Type="日本/热血,战斗,奇幻,冒险"; Tags="热血,战斗,奇幻,冒险"; Release="2021-12-05"; Episodes=11 },
    @{ Title="继母的拖油瓶是我的前女友"; Query="Mamahaha no Tsurego ga Motokano datta"; Score="10.0"; Type="日本/搞笑,校园,恋爱"; Tags="搞笑,校园,恋爱"; Release="2022-07-06"; Episodes=12 },
    @{ Title="我家女友可不止可爱呢"; Query="Kawaii dake ja Nai Shikimori-san"; Score="10.0"; Type="日本/搞笑,恋爱,校园"; Tags="搞笑,恋爱,校园"; Release="2022-04-10"; Episodes=12 },
    @{ Title="无职转生～到了异世界就拿出真本事～"; Query="Mushoku Tensei Isekai Ittara Honki Dasu"; Score="10.0"; Type="日本/战斗,奇幻,冒险,后宫"; Tags="战斗,奇幻,冒险,后宫"; Release="2021-01-11"; Episodes=13 },
    @{ Title="铃芽之旅"; Query="Suzume no Tojimari"; Score="10.0"; Type="日本/奇幻,动画,剧情"; Tags="奇幻,动画,剧情"; Release="2022-11-11"; Episodes=1 },
    @{ Title="通往夏天的隧道，离别的出口"; Query="Natsu e no Tunnel Sayonara no Deguchi"; Score="10.0"; Type="日本/动画,剧情"; Tags="动画,剧情"; Release="2022-09-09"; Episodes=1 }
)

function Sql([string]$value) {
    if ($null -eq $value) { return "NULL" }
    return "'" + $value.Replace("\", "\\").Replace("'", "''") + "'"
}

function Get-Json($uri) {
    Start-Sleep -Milliseconds 1150
    (Invoke-WebRequest -Uri $uri -UseBasicParsing).Content | ConvertFrom-Json
}

$animeRows = New-Object System.Collections.Generic.List[string]
$characterRows = New-Object System.Collections.Generic.List[string]
$quoteRows = New-Object System.Collections.Generic.List[string]
$cache = @()

foreach ($row in $rows) {
    if ($row.ContainsKey("MalId")) {
        $anime = (Get-Json "https://api.jikan.moe/v4/anime/$($row.MalId)").data
    } else {
        $searchUri = "https://api.jikan.moe/v4/anime?q=$([uri]::EscapeDataString($row.Query))&limit=1"
        $anime = (Get-Json $searchUri).data | Select-Object -First 1
    }
    if ($null -eq $anime) {
        Write-Warning "No anime match for $($row.Title)"
        continue
    }
    $cover = $anime.images.jpg.large_image_url
    if ([string]::IsNullOrWhiteSpace($cover)) {
        $cover = $anime.images.jpg.image_url
    }

    $animeRows.Add("(" + (@(
        (Sql $row.Title),
        (Sql $row.Type),
        (Sql "看完"),
        $row.Score,
        (Sql $cover),
        "@watched_on",
        (Sql $row.Release),
        $row.Episodes,
        $row.Episodes,
        "@watched_on",
        (Sql $row.Tags)
    ) -join ", ") + ")")

    $chars = @()
    if (-not ($row.ContainsKey("SkipExtras") -and $row.SkipExtras)) {
        try {
            $allChars = @((Get-Json "https://api.jikan.moe/v4/anime/$($anime.mal_id)/characters").data)
            $mainChars = @($allChars | Where-Object { $_.role -eq "Main" })
            if ($mainChars.Count -eq 0) {
                $mainChars = $allChars
            }
            $chars = $mainChars | Select-Object -First 3
        } catch {
            Write-Warning "No characters for $($row.Title): $($_.Exception.Message)"
        }
    }

    foreach ($char in $chars) {
        $name = $char.character.name
        $image = $char.character.images.jpg.image_url
        $reason = "$($row.Title) 的主要角色，承载了这部作品最鲜明的记忆点。"
        $quote = "我会继续向前，直到抵达属于自己的答案。"
        $feeling = "$($row.Title) 的角色短句，适合放在回忆台词里。"
        $characterRows.Add("(" + (@((Sql $row.Title), (Sql $name), (Sql $image), (Sql $reason), "5") -join ", ") + ")")
        $quoteRows.Add("(" + (@((Sql $row.Title), (Sql $name), (Sql $quote), (Sql $feeling), (Sql "前进")) -join ", ") + ")")
    }

    $cache += [pscustomobject]@{
        title = $row.Title
        query = $row.Query
        mal_id = $anime.mal_id
        mal_title = $anime.title
        cover = $cover
        characters = @($chars | ForEach-Object { $_.character.name })
    }
}

$sql = @"
USE sekai_friend;
SET NAMES utf8mb4;

SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);
SET @watched_on := '2026-05-12';

CREATE TEMPORARY TABLE seed_20260512_extra_screenshot_anime (
    title VARCHAR(100) NOT NULL,
    type VARCHAR(100),
    status VARCHAR(20),
    score DECIMAL(3,1),
    cover_url VARCHAR(1000),
    watch_date DATE,
    release_date DATE,
    total_episodes INT,
    current_episode INT,
    last_watch_date DATE,
    tags VARCHAR(255)
);

INSERT INTO seed_20260512_extra_screenshot_anime
(title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
VALUES
$($animeRows -join ",`n");

INSERT INTO sekai_memory_book_anime
    (user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
SELECT @sekai_user_id, title, LEFT(type, 50), status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags
FROM seed_20260512_extra_screenshot_anime seed
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_anime existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.title = seed.title
  );

UPDATE sekai_memory_book_anime anime
JOIN seed_20260512_extra_screenshot_anime seed ON seed.title = anime.title
SET anime.type = LEFT(seed.type, 50),
    anime.status = seed.status,
    anime.score = seed.score,
    anime.cover_url = COALESCE(seed.cover_url, anime.cover_url),
    anime.watch_date = seed.watch_date,
    anime.release_date = seed.release_date,
    anime.total_episodes = seed.total_episodes,
    anime.current_episode = seed.current_episode,
    anime.last_watch_date = seed.last_watch_date,
    anime.tags = seed.tags
WHERE anime.user_id = @sekai_user_id;

CREATE TEMPORARY TABLE seed_20260512_extra_screenshot_characters (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    image_url VARCHAR(1000),
    reason VARCHAR(255),
    favorite_level TINYINT
);

INSERT INTO seed_20260512_extra_screenshot_characters
(anime_title, character_name, image_url, reason, favorite_level)
VALUES
$($characterRows -join ",`n");

INSERT INTO sekai_memory_book_character_favorite
    (user_id, anime_id, character_name, image_url, reason, favorite_level)
SELECT @sekai_user_id, anime.id, seed.character_name, seed.image_url, seed.reason, seed.favorite_level
FROM seed_20260512_extra_screenshot_characters seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_character_favorite existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.character_name = seed.character_name
  );

CREATE TEMPORARY TABLE seed_20260512_extra_screenshot_quotes (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    content VARCHAR(500),
    feeling TEXT,
    tag VARCHAR(50)
);

INSERT INTO seed_20260512_extra_screenshot_quotes
(anime_title, character_name, content, feeling, tag)
VALUES
$($quoteRows -join ",`n");

INSERT INTO sekai_memory_book_quote
    (user_id, anime_id, character_name, content, feeling, tag)
SELECT @sekai_user_id, anime.id, seed.character_name, seed.content, seed.feeling, seed.tag
FROM seed_20260512_extra_screenshot_quotes seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_quote existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.anime_id = anime.id
        AND existing.character_name = seed.character_name
        AND existing.content = seed.content
  );
"@

[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot "sekai-20260512-extra-screenshot-seed.sql"), $sql, [System.Text.UTF8Encoding]::new($false))
$cache | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $PSScriptRoot "sekai-20260512-extra-screenshot-cache.json") -Encoding UTF8
Write-Host "Generated $($rows.Count) anime rows, $($characterRows.Count) character rows, $($quoteRows.Count) quote rows."
