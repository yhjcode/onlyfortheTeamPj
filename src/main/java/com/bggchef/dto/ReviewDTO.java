package com.bggchef.dto;

import java.sql.Date;

public class ReviewDTO {
    private long reviewId;
    private String userId;
    private long recipeId;
    private Double rating;
    private String content;
    private Long parentReviewId;
    private int isDeleted;
    private Date createdAt;
    private String nickname;

    public long getReviewId() { return reviewId; }
    public void setReviewId(long reviewId) { this.reviewId = reviewId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public long getRecipeId() { return recipeId; }
    public void setRecipeId(long recipeId) { this.recipeId = recipeId; }
    public Double getRating() { return rating; }
    public void setRating(Double rating) { this.rating = rating; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Long getParentReviewId() { return parentReviewId; }
    public void setParentReviewId(Long parentReviewId) { this.parentReviewId = parentReviewId; }
    public int getIsDeleted() { return isDeleted; }
    public void setIsDeleted(int isDeleted) { this.isDeleted = isDeleted; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
}
