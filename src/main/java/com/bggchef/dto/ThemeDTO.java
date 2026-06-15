package com.bggchef.dto;

import java.util.Date;

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
    private String subtitle;

    // 1. 기본 생성자
    public ThemeDTO() {
        this.isVisible = 1;      // 기본값 설정
        this.viewCount = 0;      // 기본값 설정
        this.createdAt = new Date(); // 생성 시점의 현재 시간으로 초기화
    }

    // 2. Getter & Setter
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

    public String getSubtitle() { return subtitle; }
    public void setSubtitle(String subtitle) { this.subtitle = subtitle; }

    // 3. 디버깅용 toString() 메서드
    @Override
    public String toString() {
        return "ThemeDTO [themeId=" + themeId + ", userId=" + userId + 
               ", title=" + title + ", subtitle=" + subtitle + 
               ", createdAt=" + createdAt + "]";
    }
}