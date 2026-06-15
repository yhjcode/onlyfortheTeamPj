package com.bggchef.dto;

import java.sql.Date;

public class ChefIntroDTO {
    private String userId;
    private String intro;
    private Date   updatedAt;

    public String getUserId()   { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getIntro()    { return intro; }
    public void setIntro(String intro) { this.intro = intro; }

    public Date getUpdatedAt()  { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
