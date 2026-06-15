package com.bggchef.dto;

import java.sql.Date;

public class ListDTO {
	private long RecipeId;
	private String userId;
	private int CategoryId;
	private String title;
	private String thumbnail;
	private String description;
	private int ViewCount;
	private double AvgRating;
	private int IsDeleted;
	private Date createdAt;
	private String nickname;
	private String profileImg;
	private String medalgrade;
	
	
	public long getRecipeId() {
		return RecipeId;
	}
	public void setRecipeId(long setRecipeId) {
		this.RecipeId = setRecipeId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getCategoryId() {
		return CategoryId;
	}
	public void setCategoryId(int categoryId) {
		CategoryId = categoryId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getViewCount() {
		return ViewCount;
	}
	public void setViewCount(int viewCount) {
		ViewCount = viewCount;
	}
	public double getAvgRating() {
		return AvgRating;
	}
	public void setAvgRating(double avgRating) {
		AvgRating = avgRating;
	}
	public int getIsDeleted() {
		return IsDeleted;
	}
	public void setIsDeleted(int isDeleted) {
		IsDeleted = isDeleted;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getMedalgrade() {
		return medalgrade;
	}
	public void setMedalgrade(String medalgrade) {
		this.medalgrade = medalgrade;
	}
	
	
	
	
}
