package com.bggchef.dto;



public class RecipeStepDTO {
    private long stepId;
    private long recipeId;
    private int stepNo;
    private String imageUrl;
    private String content;

    public long getStepId() { return stepId; }
    public void setStepId(long stepId) { this.stepId = stepId; }
    public long getRecipeId() { return recipeId; }
    public void setRecipeId(long recipeId) { this.recipeId = recipeId; }
    public int getStepNo() { return stepNo; }
    public void setStepNo(int stepNo) { this.stepNo = stepNo; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
}
