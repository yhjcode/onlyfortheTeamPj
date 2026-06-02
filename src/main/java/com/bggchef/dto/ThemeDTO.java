package com.bggchef.dto;

import java.sql.Date;

public class ThemeDTO {
    private int themeId;
    private String userId;
    private String title;
    private String description;
    private String thumbnail;
    private String linkUrl;
    private int isVisible;
    private int viewCount;
    private Date createdAt;

    public int getThemeId() { return themeId; }
    public void setThemeId(int themeId) { this.themeId = themeId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String linkUrl) { this.linkUrl = linkUrl; }
    public int getIsVisible() { return isVisible; }
    public void setIsVisible(int isVisible) { this.isVisible = isVisible; }
    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
