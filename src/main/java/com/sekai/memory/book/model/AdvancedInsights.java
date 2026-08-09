package com.sekai.memory.book.model;

import java.util.ArrayList;
import java.util.List;

public class AdvancedInsights {

    private List<RankedText> tagRanks = new ArrayList<>();

    private List<RankedText> emotionRanks = new ArrayList<>();

    private List<ProgressLane> progressLanes = new ArrayList<>();

    private List<Anime> continueWatching = new ArrayList<>();

    private List<Anime> shareCandidates = new ArrayList<>();

    private List<Recommendation> recommendations = new ArrayList<>();

    private List<ActionItem> actionItems = new ArrayList<>();

    private List<ScoreBand> scoreBands = new ArrayList<>();

    public List<RankedText> getTagRanks() {
        return tagRanks;
    }

    public void setTagRanks(List<RankedText> tagRanks) {
        this.tagRanks = tagRanks;
    }

    public List<RankedText> getEmotionRanks() {
        return emotionRanks;
    }

    public void setEmotionRanks(List<RankedText> emotionRanks) {
        this.emotionRanks = emotionRanks;
    }

    public List<ProgressLane> getProgressLanes() {
        return progressLanes;
    }

    public void setProgressLanes(List<ProgressLane> progressLanes) {
        this.progressLanes = progressLanes;
    }

    public List<Anime> getContinueWatching() {
        return continueWatching;
    }

    public void setContinueWatching(List<Anime> continueWatching) {
        this.continueWatching = continueWatching;
    }

    public List<Anime> getShareCandidates() {
        return shareCandidates;
    }

    public void setShareCandidates(List<Anime> shareCandidates) {
        this.shareCandidates = shareCandidates;
    }

    public List<Recommendation> getRecommendations() {
        return recommendations;
    }

    public void setRecommendations(List<Recommendation> recommendations) {
        this.recommendations = recommendations;
    }

    public List<ActionItem> getActionItems() {
        return actionItems;
    }

    public void setActionItems(List<ActionItem> actionItems) {
        this.actionItems = actionItems;
    }

    public List<ScoreBand> getScoreBands() {
        return scoreBands;
    }

    public void setScoreBands(List<ScoreBand> scoreBands) {
        this.scoreBands = scoreBands;
    }

    public static class RankedText {

        private String text;

        private int count;

        private int percent;

        public RankedText() {
        }

        public RankedText(String text, int count, int maxCount) {
            this.text = text;
            this.count = count;
            this.percent = maxCount == 0 ? 0 : Math.max(8, (int) Math.round(count * 100.0 / maxCount));
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

        public int getPercent() {
            return percent;
        }

        public void setPercent(int percent) {
            this.percent = percent;
        }
    }

    public static class ProgressLane {

        private String status;

        private int count;

        private int percent;

        private List<Anime> animeList = new ArrayList<>();

        public ProgressLane() {
        }

        public ProgressLane(String status, int count, int total, List<Anime> animeList) {
            this.status = status;
            this.count = count;
            this.percent = total == 0 ? 0 : (int) Math.round(count * 100.0 / total);
            this.animeList = animeList;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
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

        public List<Anime> getAnimeList() {
            return animeList;
        }

        public void setAnimeList(List<Anime> animeList) {
            this.animeList = animeList;
        }
    }

    public static class Recommendation {

        private Anime anime;

        private int matchScore;

        private String reason;

        public Recommendation() {
        }

        public Recommendation(Anime anime, int matchScore, String reason) {
            this.anime = anime;
            this.matchScore = matchScore;
            this.reason = reason;
        }

        public Anime getAnime() {
            return anime;
        }

        public void setAnime(Anime anime) {
            this.anime = anime;
        }

        public int getMatchScore() {
            return matchScore;
        }

        public void setMatchScore(int matchScore) {
            this.matchScore = matchScore;
        }

        public String getReason() {
            return reason;
        }

        public void setReason(String reason) {
            this.reason = reason;
        }
    }

    public static class ActionItem {

        private String title;

        private String detail;

        private String href;

        private String level;

        public ActionItem() {
        }

        public ActionItem(String title, String detail, String href, String level) {
            this.title = title;
            this.detail = detail;
            this.href = href;
            this.level = level;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getDetail() {
            return detail;
        }

        public void setDetail(String detail) {
            this.detail = detail;
        }

        public String getHref() {
            return href;
        }

        public void setHref(String href) {
            this.href = href;
        }

        public String getLevel() {
            return level;
        }

        public void setLevel(String level) {
            this.level = level;
        }
    }

    public static class ScoreBand {

        private String label;

        private int count;

        private int percent;

        public ScoreBand() {
        }

        public ScoreBand(String label, int count, int total) {
            this.label = label;
            this.count = count;
            this.percent = total == 0 ? 0 : Math.max(6, (int) Math.round(count * 100.0 / total));
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
