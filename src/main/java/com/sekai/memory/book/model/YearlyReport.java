package com.sekai.memory.book.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class YearlyReport {

    private int year;

    private int animeCount;

    private int watchedCount;

    private int characterCount;

    private int quoteCount;

    private BigDecimal averageScore;

    private String topType;

    private String topTag;

    private String topMonth;

    private Anime highestScoreAnime;

    private CharacterFavorite favoriteCharacter;

    private Quote memorableQuote;

    private List<RankedText> tagRanks = new ArrayList<>();

    private List<RankedText> quoteTagRanks = new ArrayList<>();

    private List<MonthlyCount> monthlyCounts = new ArrayList<>();

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getAnimeCount() {
        return animeCount;
    }

    public void setAnimeCount(int animeCount) {
        this.animeCount = animeCount;
    }

    public int getWatchedCount() {
        return watchedCount;
    }

    public void setWatchedCount(int watchedCount) {
        this.watchedCount = watchedCount;
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

    public String getTopMonth() {
        return topMonth;
    }

    public void setTopMonth(String topMonth) {
        this.topMonth = topMonth;
    }

    public Anime getHighestScoreAnime() {
        return highestScoreAnime;
    }

    public void setHighestScoreAnime(Anime highestScoreAnime) {
        this.highestScoreAnime = highestScoreAnime;
    }

    public CharacterFavorite getFavoriteCharacter() {
        return favoriteCharacter;
    }

    public void setFavoriteCharacter(CharacterFavorite favoriteCharacter) {
        this.favoriteCharacter = favoriteCharacter;
    }

    public Quote getMemorableQuote() {
        return memorableQuote;
    }

    public void setMemorableQuote(Quote memorableQuote) {
        this.memorableQuote = memorableQuote;
    }

    public List<RankedText> getTagRanks() {
        return tagRanks;
    }

    public void setTagRanks(List<RankedText> tagRanks) {
        this.tagRanks = tagRanks;
    }

    public List<RankedText> getQuoteTagRanks() {
        return quoteTagRanks;
    }

    public void setQuoteTagRanks(List<RankedText> quoteTagRanks) {
        this.quoteTagRanks = quoteTagRanks;
    }

    public List<MonthlyCount> getMonthlyCounts() {
        return monthlyCounts;
    }

    public void setMonthlyCounts(List<MonthlyCount> monthlyCounts) {
        this.monthlyCounts = monthlyCounts;
    }

    public static class RankedText {

        private String text;

        private int count;

        public RankedText() {
        }

        public RankedText(String text, int count) {
            this.text = text;
            this.count = count;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public int getCount() {
            return count;
        }

        public void setCount(int count) {
            this.count = count;
        }
    }

    public static class MonthlyCount {

        private int month;

        private String label;

        private int count;

        private int percent;

        public MonthlyCount() {
        }

        public MonthlyCount(int month, int count, int maxCount) {
            this.month = month;
            this.label = month + "月";
            this.count = count;
            this.percent = maxCount == 0 ? 0 : Math.max(8, (int) Math.round(count * 100.0 / maxCount));
        }

        public int getMonth() {
            return month;
        }

        public void setMonth(int month) {
            this.month = month;
        }

        public String getLabel() {
            return label;
        }

        public void setLabel(String label) {
            this.label = label;
        }

        public int getCount() {
            return count;
        }

        public void setCount(int count) {
            this.count = count;
        }

        public int getPercent() {
            return percent;
        }

        public void setPercent(int percent) {
            this.percent = percent;
        }
    }
}
