package com.sekai.memory.book.dataobject;

import com.sekai.memory.book.model.Quote;
import org.springframework.beans.BeanUtils;

import java.time.LocalDateTime;

public class SekaiMemoryBookQuoteDO {

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
     * 台词视频地址
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

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public SekaiMemoryBookQuoteDO() {} // 👈 必须加！

    public SekaiMemoryBookQuoteDO(Quote quote) {
        BeanUtils.copyProperties(quote, this);
    }

    public Quote convertToQuote() {
        Quote quote = new Quote();
        BeanUtils.copyProperties(this, quote);
        return quote;
    }
}
