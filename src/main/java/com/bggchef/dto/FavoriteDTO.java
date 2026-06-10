package com.bggchef.dto;

import java.sql.Date;

public class FavoriteDTO {
    private long favoriteId;
    private String userId;
    private long recipeId;
    private Date createdAt;
    private String recipeTitle;   // ← 추가
    private String thumbnail;     // ← 추가

    public long getFavoriteId() { return favoriteId; }
    public void setFavoriteId(long favoriteId) { this.favoriteId = favoriteId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public long getRecipeId() { return recipeId; }
    public void setRecipeId(long recipeId) { this.recipeId = recipeId; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public String getRecipeTitle() { return recipeTitle; }
    public void setRecipeTitle(String recipeTitle) { this.recipeTitle = recipeTitle; }
    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
}