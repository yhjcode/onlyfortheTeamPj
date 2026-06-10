package com.bggchef.dto;

public class ChefRankingDTO {
    private String userId;
    private String nickname;
    private String profileImg;
    private long   totalViewCount;
    private Double avgRating;
    private int    recipeCount;

    public String getUserId()           { return userId; }
    public void   setUserId(String v)   { this.userId = v; }
    public String getNickname()         { return nickname; }
    public void   setNickname(String v) { this.nickname = v; }
    public String getProfileImg()           { return profileImg; }
    public void   setProfileImg(String v)   { this.profileImg = v; }
    public long   getTotalViewCount()       { return totalViewCount; }
    public void   setTotalViewCount(long v) { this.totalViewCount = v; }
    public Double getAvgRating()            { return avgRating; }
    public void   setAvgRating(Double v)    { this.avgRating = v; }
    public int    getRecipeCount()          { return recipeCount; }
    public void   setRecipeCount(int v)     { this.recipeCount = v; }
}
