package com.bggchef.dto;

public class ThemeRecipeDTO {
    // 테이블의 컬럼과 동일하게 필드 구성
    private int themeId;
    private int recipeId;
    private String description; // 테마별 요리 소개글 필드 추가

    // 1. 기본 생성자
    public ThemeRecipeDTO() {
        super();
    }

    // 2. 파라미터가 있는 생성자 (데이터 담기 편함)
    public ThemeRecipeDTO(int themeId, int recipeId, String description) {
        super();
        this.themeId = themeId;
        this.recipeId = recipeId;
        this.description = description;
    }

    // 3. Getter & Setter 메서드
    public int getThemeId() {
        return themeId;
    }

    public void setThemeId(int themeId) {
        this.themeId = themeId;
    }

    public int getRecipeId() {
        return recipeId;
    }

    public void setRecipeId(int recipeId) {
        this.recipeId = recipeId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // 4. 디버깅용 toString()
    @Override
    public String toString() {
        return "ThemeRecipeDTO [themeId=" + themeId + ", recipeId=" + recipeId + ", description=" + description + "]";
    }
}