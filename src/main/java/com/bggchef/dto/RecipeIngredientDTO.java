package com.bggchef.dto;



public class RecipeIngredientDTO {
    private long recipeIngrId;
    private int ingredientId;
    private long recipeId;
    private String amount;
    private String ingredientName;
    private String unit;

    public long getRecipeIngrId() { return recipeIngrId; }
    public void setRecipeIngrId(long recipeIngrId) { this.recipeIngrId = recipeIngrId; }
    public int getIngredientId() { return ingredientId; }
    public void setIngredientId(int ingredientId) { this.ingredientId = ingredientId; }
    public long getRecipeId() { return recipeId; }
    public void setRecipeId(long recipeId) { this.recipeId = recipeId; }
    public String getAmount() { return amount; }
    public void setAmount(String amount) { this.amount = amount; }
    public String getIngredientName() { return ingredientName; }
    public void setIngredientName(String ingredientName) { this.ingredientName = ingredientName; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
}
