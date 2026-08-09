package com.sekai.memory.book.model;

public class SearchResult {

    private String type;

    private String title;

    private String subtitle;

    private String body;

    private String href;

    public SearchResult() {
    }

    public SearchResult(String type, String title, String subtitle, String body, String href) {
        this.type = type;
        this.title = title;
        this.subtitle = subtitle;
        this.body = body;
        this.href = href;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }
}
