package com.bggchef.dto;

import java.sql.Date;

public class UserDTO {
    private String userId;
    private String email;
    private String password;
    private String nickname;
    private String phone;
    private String profileImg;
    private Date birthday;
    private int isDeleted;
    private String medalGrade;
    // 검색기능에 필요해서 추가
    private Double avgRating;
    private int    recipeCount;

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getProfileImg() { return profileImg; }
    public void setProfileImg(String profileImg) { this.profileImg = profileImg; }
    public Date getBirthday() { return birthday; }
    public void setBirthday(Date birthday) { this.birthday = birthday; }
    public int getIsDeleted() { return isDeleted; }
    public void setIsDeleted(int isDeleted) { this.isDeleted = isDeleted; }
    public String getMedalGrade() { return medalGrade; }
    public void setMedalGrade(String medalGrade) { this.medalGrade = medalGrade; }
	
    public Double getAvgRating() {
		return avgRating;
	}
	public void setAvgRating(Double avgRating) {
		this.avgRating = avgRating;
	}
	public int getRecipeCount() {
		return recipeCount;
	}
	public void setRecipeCount(int recipeCount) {
		this.recipeCount = recipeCount;
	}
    
}
