package com.bggchef.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class RecipeDTO {
    private long recipeId;
    private String userId;
    private int categoryId;
    private String title;
    private String thumbnail;
    private String description;
    private int servings;
    private int cookTime;
    private int difficulty;
    private int viewCount;
    private Double avgRating;
    private int isDeleted;
    private Date createdAt;
    private String nickname;
    private String categoryName;
    private List<RecipeIngredientDTO> ingredients = new ArrayList<>();
    private List<RecipeStepDTO> steps = new ArrayList<>();
    
    

    public long getRecipeId() { return recipeId; }
    public void setRecipeId(long recipeId) { this.recipeId = recipeId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getServings() { return servings; }
    public void setServings(int servings) { this.servings = servings; }
    public int getCookTime() { return cookTime; }
    public void setCookTime(int cookTime) { this.cookTime = cookTime; }
    public int getDifficulty() { return difficulty; }
    public void setDifficulty(int difficulty) { this.difficulty = difficulty; }
    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
    public Double getAvgRating() { return avgRating; }
    public void setAvgRating(Double avgRating) { this.avgRating = avgRating; }
    public int getIsDeleted() { return isDeleted; }
    public void setIsDeleted(int isDeleted) { this.isDeleted = isDeleted; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public List<RecipeIngredientDTO> getIngredients() { return ingredients; }
    public void setIngredients(List<RecipeIngredientDTO> ingredients) { this.ingredients = ingredients; }
    public List<RecipeStepDTO> getSteps() { return steps; }
    public void setSteps(List<RecipeStepDTO> steps) { this.steps = steps; }
}
