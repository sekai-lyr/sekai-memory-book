package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.model.Anime;

import java.time.LocalDateTime;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

final class AnimeArchiveSorter {

    private static final Pattern SERIES_TAG_PATTERN = Pattern.compile(
            "(?:^|[,\\uFF0C;\\uFF1B/])\\s*(?:series|\\u7CFB\\u5217)\\s*[:\\uFF1A]\\s*([^,\\uFF0C;\\uFF1B/]+)",
            Pattern.CASE_INSENSITIVE);
    private static final Pattern SEASON_PATTERN = Pattern.compile(
            "(?i)(?:\\bseason\\s*(\\d+)\\b|\\bs(\\d+)\\b|\\u7B2C\\s*([0-9]+|[\\u96F6\\u3007\\u4E00\\u4E8C\\u4E09\\u56DB\\u4E94\\u516D\\u4E03\\u516B\\u4E5D\\u5341\\u4E24]+)\\s*\\u5B63)");
    private static final Pattern SEASON_SUFFIX_PATTERN = Pattern.compile(
            "(?i)\\s*(?:\\bseason\\s*\\d+\\b|\\bs\\d+\\b|\\u7B2C\\s*(?:[0-9]+|[\\u96F6\\u3007\\u4E00\\u4E8C\\u4E09\\u56DB\\u4E94\\u516D\\u4E03\\u516B\\u4E5D\\u5341\\u4E24]+)\\s*\\u5B63)\\s*.*$");
    private static final Pattern TRAILING_SUBTITLE_PATTERN = Pattern.compile("\\s*[-\\u2013\\u2014]+[^-\\u2013\\u2014]+[-\\u2013\\u2014]*\\s*$");

    private AnimeArchiveSorter() {
    }

    static List<Anime> sortForArchive(List<Anime> animeList) {
        if (animeList == null || animeList.isEmpty()) {
            return List.of();
        }

        Map<Anime, SortKey> keyByAnime = new IdentityHashMap<>();
        for (Anime anime : animeList) {
            keyByAnime.put(anime, buildSortKey(anime));
        }

        return animeList.stream()
                .sorted((left, right) -> compareByArchiveOrder(
                        keyByAnime.get(left),
                        keyByAnime.get(right)))
                .toList();
    }

    private static int compareByArchiveOrder(SortKey left, SortKey right) {
        int compared = compareTime(left.time(), right.time());
        if (compared != 0) {
            return compared;
        }
        compared = compareText(left.seriesKey(), right.seriesKey());
        if (compared != 0) {
            return compared;
        }
        compared = compareText(left.typeKey(), right.typeKey());
        if (compared != 0) {
            return compared;
        }
        compared = Integer.compare(left.season(), right.season());
        if (compared != 0) {
            return compared;
        }
        compared = compareText(left.titleKey(), right.titleKey());
        if (compared != 0) {
            return compared;
        }
        return Long.compare(left.id(), right.id());
    }

    private static SortKey buildSortKey(Anime anime) {
        String title = anime == null ? "" : Objects.toString(anime.getTitle(), "");
        String series = extractSeriesFromTags(anime == null ? null : anime.getTags());
        if (series == null) {
            series = deriveSeriesFromTitle(title);
        }
        return new SortKey(
                normalizeKey(series),
                normalizeKey(anime == null ? null : anime.getType()),
                normalizeKey(title),
                extractSeason(title),
                resolveArchiveTime(anime),
                anime == null || anime.getId() == null ? Long.MAX_VALUE : anime.getId());
    }

    private static String extractSeriesFromTags(String tags) {
        if (tags == null || tags.isBlank()) {
            return null;
        }
        Matcher matcher = SERIES_TAG_PATTERN.matcher(tags);
        if (!matcher.find()) {
            return null;
        }
        String series = matcher.group(1).trim();
        return series.isEmpty() ? null : series;
    }

    private static String deriveSeriesFromTitle(String title) {
        if (title == null || title.isBlank()) {
            return "";
        }
        String baseTitle = SEASON_SUFFIX_PATTERN.matcher(title.trim()).replaceFirst("").trim();
        baseTitle = TRAILING_SUBTITLE_PATTERN.matcher(baseTitle).replaceFirst("").trim();
        return baseTitle.isEmpty() ? title : baseTitle;
    }

    private static int extractSeason(String title) {
        if (title == null || title.isBlank()) {
            return 1;
        }
        Matcher matcher = SEASON_PATTERN.matcher(title);
        if (!matcher.find()) {
            return 1;
        }
        for (int index = 1; index <= matcher.groupCount(); index++) {
            String value = matcher.group(index);
            if (value != null && !value.isBlank()) {
                return parseSeasonNumber(value);
            }
        }
        return 1;
    }

    private static int parseSeasonNumber(String value) {
        String trimmed = value.trim();
        if (trimmed.chars().allMatch(Character::isDigit)) {
            return Integer.parseInt(trimmed);
        }
        if (trimmed.indexOf('\u5341') >= 0) {
            String[] parts = trimmed.split("\\u5341", -1);
            int tens = parts[0].isEmpty() ? 1 : chineseDigit(parts[0].charAt(parts[0].length() - 1));
            int ones = parts.length < 2 || parts[1].isEmpty() ? 0 : chineseDigit(parts[1].charAt(0));
            return tens * 10 + ones;
        }
        return chineseDigit(trimmed.charAt(trimmed.length() - 1));
    }

    private static int chineseDigit(char value) {
        return switch (value) {
            case '\u96F6', '\u3007' -> 0;
            case '\u4E00' -> 1;
            case '\u4E8C', '\u4E24' -> 2;
            case '\u4E09' -> 3;
            case '\u56DB' -> 4;
            case '\u4E94' -> 5;
            case '\u516D' -> 6;
            case '\u4E03' -> 7;
            case '\u516B' -> 8;
            case '\u4E5D' -> 9;
            default -> 1;
        };
    }

    private static LocalDateTime resolveArchiveTime(Anime anime) {
        if (anime == null) {
            return null;
        }
        if (anime.getReleaseDate() != null) {
            return anime.getReleaseDate().atStartOfDay();
        }
        if (anime.getWatchDate() != null) {
            return anime.getWatchDate().atStartOfDay();
        }
        return anime.getCreateTime();
    }

    private static String normalizeKey(String value) {
        if (value == null) {
            return "";
        }
        return value.trim()
                .replace('\u3000', ' ')
                .replace('\uFF1A', ':')
                .replaceAll("\\s+", " ")
                .toLowerCase(Locale.ROOT);
    }

    private static int compareTime(LocalDateTime left, LocalDateTime right) {
        if (left == null && right == null) {
            return 0;
        }
        if (left == null) {
            return 1;
        }
        if (right == null) {
            return -1;
        }
        return left.compareTo(right);
    }

    private static int compareText(String left, String right) {
        return Objects.toString(left, "").compareTo(Objects.toString(right, ""));
    }

    private record SortKey(String seriesKey, String typeKey, String titleKey, int season, LocalDateTime time, long id) {
    }
}
