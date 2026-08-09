package com.sekai.memory.book.model;

import java.math.BigDecimal;

public class DashboardStats {

    private int animeCount;

    private int characterCount;

    private int quoteCount;

    private int watchedCount;

    private BigDecimal averageScore;

    private String topType;

    private String topTag;

    public int getAnimeCount() {
        return animeCount;
    }

    public void setAnimeCount(int animeCount) {
        this.animeCount = animeCount;
    }

    public int getCharacterCount() {
        return characterCount;
    }

    public void setCharacterCount(int characterCount) {
        this.characterCount = characterCount;
    }

    public int getQuoteCount() {
        return quoteCount;
    }

    public void setQuoteCount(int quoteCount) {
        this.quoteCount = quoteCount;
    }

    public int getWatchedCount() {
        return watchedCount;
    }

    public void setWatchedCount(int watchedCount) {
        this.watchedCount = watchedCount;
    }

    public BigDecimal getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(BigDecimal averageScore) {
        this.averageScore = averageScore;
    }

    public String getTopType() {
        return topType;
    }

    public void setTopType(String topType) {
        this.topType = topType;
    }

    public String getTopTag() {
        return topTag;
    }

    public void setTopTag(String topTag) {
        this.topTag = topTag;
    }
}
