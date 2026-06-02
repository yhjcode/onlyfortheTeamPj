package com.bggchef.dto;

import java.sql.Date;

public class FavoriteDTO {
    private long favoriteId;
    private String userId;
    private long recipeId;
    private Date createdAt;

    public long getFavoriteId() { return favoriteId; }
    public void setFavoriteId(long favoriteId) { this.favoriteId = favoriteId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public long getRecipeId() { return recipeId; }
    public void setRecipeId(long recipeId) { this.recipeId = recipeId; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
