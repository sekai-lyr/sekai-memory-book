package com.sekai.memory.book.model;

import java.time.LocalDateTime;

public class CharacterFavorite {

    /**
     * 角色收藏ID，主键，自增
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
     * 角色名称
     */
    private String characterName;

    /**
     * 角色图片地址
     */
    private String imageUrl;

    /**
     * 喜欢原因
     */
    private String reason;

    /**
     * 喜爱程度，1到5
     */
    private Integer favoriteLevel;

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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getFavoriteLevel() {
        return favoriteLevel;
    }

    public void setFavoriteLevel(Integer favoriteLevel) {
        this.favoriteLevel = favoriteLevel;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }
}
