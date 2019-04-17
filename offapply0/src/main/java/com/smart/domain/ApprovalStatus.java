package com.smart.domain;

import java.util.Date;

public class ApprovalStatus {
    private Integer userType;
    private Date checkDatetime;
    private Integer checkUserId;
    private String checkUserOpinion;

    public Date getCheckDatetime() {
        return checkDatetime;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public void setCheckDatetime(Date checkDatetime) {
        this.checkDatetime = checkDatetime;
    }

    public Integer getCheckUserId() {
        return checkUserId;
    }

    public void setCheckUserId(Integer checkUserId) {
        this.checkUserId = checkUserId;
    }

    public String getCheckUserOpinion() {
        return checkUserOpinion;
    }

    public void setCheckUserOpinion(String checkUserOpinion) {
        this.checkUserOpinion = checkUserOpinion;
    }
}
