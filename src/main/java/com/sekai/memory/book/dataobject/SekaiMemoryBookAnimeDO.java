package com.sekai.memory.book.dataobject;

import com.sekai.memory.book.model.Anime;
import org.springframework.beans.BeanUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class SekaiMemoryBookAnimeDO {

    /**
     * 番剧ID，主键，自增
     */
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 番剧名称
     */
    private String title;

    /**
     * 番剧类型
     */
    private String type;

    /**
     * 观看状态
     */
    private String status;

    /**
     * 评分，例如 9.5
     */
    private BigDecimal score;

    /**
     * 番剧封面图片地址
     */
    private String coverUrl;

    /**
     * 观看日期
     */
    private LocalDate watchDate;

    private LocalDate releaseDate;

    private Integer totalEpisodes;

    private Integer currentEpisode;

    private LocalDate lastWatchDate;

    /**
     * 个人回忆、观后感
     */
    private String memoryText;

    private String tags;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getScore() {
        return score;
    }

    public void setScore(BigDecimal score) {
        this.score = score;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public LocalDate getWatchDate() {
        return watchDate;
    }

    public void setWatchDate(LocalDate watchDate) {
        this.watchDate = watchDate;
    }

    public LocalDate getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Integer getTotalEpisodes() {
        return totalEpisodes;
    }

    public void setTotalEpisodes(Integer totalEpisodes) {
        this.totalEpisodes = totalEpisodes;
    }

    public Integer getCurrentEpisode() {
        return currentEpisode;
    }

    public void setCurrentEpisode(Integer currentEpisode) {
        this.currentEpisode = currentEpisode;
    }

    public LocalDate getLastWatchDate() {
        return lastWatchDate;
    }

    public void setLastWatchDate(LocalDate lastWatchDate) {
        this.lastWatchDate = lastWatchDate;
    }

    public String getMemoryText() {
        return memoryText;
    }

    public void setMemoryText(String memoryText) {
        this.memoryText = memoryText;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    public SekaiMemoryBookAnimeDO() {} // 👈 必须加！

    public SekaiMemoryBookAnimeDO(Anime anime) {
        BeanUtils.copyProperties(anime, this);
    }

    public Anime convertToAnime() {
        Anime anime = new Anime();
        BeanUtils.copyProperties(this, anime);
        return anime;
    }
}
