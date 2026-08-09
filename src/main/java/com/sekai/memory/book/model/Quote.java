package com.sekai.memory.book.model;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Quote {

    private static final Pattern BILIBILI_BVID_PATTERN = Pattern.compile("(BV[0-9A-Za-z]{10,})");

    /**
     * 台词ID，主键，自增
     */
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 番剧ID
     */
    private Long animeId;

    /**
     * 说出台词的角色名
     */
    private String characterName;

    /**
     * 台词内容
     */
    private String content;

    /**
     * 这句台词带来的感受
     */
    private String feeling;

    /**
     * 标签
     */
    private String tag;

    /**
     * 台词视频地址，可为本地上传地址、视频直链或可嵌入播放页
     */
    private String videoUrl;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getAnimeId() {
        return animeId;
    }

    public void setAnimeId(Long animeId) {
        this.animeId = animeId;
    }

    public String getCharacterName() {
        return characterName;
    }

    public void setCharacterName(String characterName) {
        this.characterName = characterName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFeeling() {
        return feeling;
    }

    public void setFeeling(String feeling) {
        this.feeling = feeling;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public boolean hasVideoUrl() {
        return videoUrl != null && !videoUrl.isBlank();
    }

    public boolean isDirectVideoUrl() {
        if (!hasVideoUrl()) {
            return false;
        }
        String value = videoUrl.trim().toLowerCase(Locale.ROOT);
        int queryIndex = value.indexOf('?');
        if (queryIndex >= 0) {
            value = value.substring(0, queryIndex);
        }
        return value.startsWith("/uploads/quote-videos/")
                || value.endsWith(".mp4")
                || value.endsWith(".webm")
                || value.endsWith(".ogg")
                || value.endsWith(".mov");
    }

    public String getEmbeddableVideoUrl() {
        if (!hasVideoUrl() || isDirectVideoUrl()) {
            return null;
        }
        String value = videoUrl.trim();
        try {
            URI uri = URI.create(value);
            String host = uri.getHost();
            if (host == null) {
                return null;
            }
            String lowerHost = host.toLowerCase(Locale.ROOT);
            if (lowerHost.equals("youtu.be")) {
                String id = firstPathSegment(uri.getPath());
                return isSafeVideoId(id) ? "https://www.youtube.com/embed/" + id : null;
            }
            if (lowerHost.endsWith("youtube.com")) {
                String path = uri.getPath() == null ? "" : uri.getPath();
                if (path.startsWith("/embed/")) {
                    String id = firstPathSegment(path.substring("/embed/".length()));
                    return isSafeVideoId(id) ? "https://www.youtube.com/embed/" + id : null;
                }
                if (path.startsWith("/shorts/")) {
                    String id = firstPathSegment(path.substring("/shorts/".length()));
                    return isSafeVideoId(id) ? "https://www.youtube.com/embed/" + id : null;
                }
                String id = queryParam(uri.getRawQuery(), "v");
                return isSafeVideoId(id) ? "https://www.youtube.com/embed/" + id : null;
            }
            if (lowerHost.equals("player.bilibili.com")) {
                return value;
            }
            if (lowerHost.endsWith("bilibili.com")) {
                Matcher matcher = BILIBILI_BVID_PATTERN.matcher(value);
                if (matcher.find()) {
                    return "https://player.bilibili.com/player.html?bvid=" + matcher.group(1) + "&autoplay=0";
                }
            }
            return null;
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }

    public String getVideoSearchUrl() {
        String query = compactJoin(characterName, content, "台词视频");
        return "https://www.bing.com/videos/search?q=" + URLEncoder.encode(query, StandardCharsets.UTF_8);
    }

    private String queryParam(String rawQuery, String key) {
        if (rawQuery == null || rawQuery.isBlank()) {
            return null;
        }
        String prefix = key + "=";
        for (String part : rawQuery.split("&")) {
            if (part.startsWith(prefix)) {
                return part.substring(prefix.length());
            }
        }
        return null;
    }

    private String firstPathSegment(String path) {
        if (path == null) {
            return null;
        }
        String cleanPath = path.startsWith("/") ? path.substring(1) : path;
        int slashIndex = cleanPath.indexOf('/');
        return slashIndex >= 0 ? cleanPath.substring(0, slashIndex) : cleanPath;
    }

    private boolean isSafeVideoId(String value) {
        return value != null && value.matches("[0-9A-Za-z_-]{6,}");
    }

    private String compactJoin(String... values) {
        StringBuilder builder = new StringBuilder();
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                if (builder.length() > 0) {
                    builder.append(' ');
                }
                builder.append(value.trim());
            }
        }
        return builder.toString();
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }
}
