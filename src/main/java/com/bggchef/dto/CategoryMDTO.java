package com.bggchef.dto;



public class CategoryMDTO {
    private int categorymId;
    private int categorylId;
    private String name;
    private String type;

    public int getCategorymId() { return categorymId; }
    public void setCategorymId(int categorymId) { this.categorymId = categorymId; }
    public int getCategorylId() { return categorylId; }
    public void setCategorylId(int categorylId) { this.categorylId = categorylId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
}
