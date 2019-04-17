package com.smart.domain;

import java.util.Date;

public class TakeOff {
    private Integer offId;

    private Integer offType;

    private Date startDate;

    private Date endDate;

    private String offReason;

    private Integer userId;

    private Integer firstCheckUserId;

    private String firstCheckUserOpinion;

    private Integer secondCheckUserId;

    private String secondCheckUserOpinion;

    private Integer thirdCheckUserId;

    private String thirdCheckUserOpinion;

    private Date firstCheckDatetime;

    private Date secondCheckDatetime;

    private Date thirdCheckDatetime;

    private Date applyDatetime = new Date();

    private Integer offStatus;

    private Integer isAcceptedByFirst;

    private Integer isAcceptedBySecond;

    private Integer isAcceptedByThird;

    public Integer getOffId() {
        return offId;
    }

    public void setOffId(Integer offId) {
        this.offId = offId;
    }

    public Integer getOffType() {
        return offType;
    }

    public void setOffType(Integer offType) {
        this.offType = offType;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getOffReason() {
        return offReason;
    }

    public void setOffReason(String offReason) {
        this.offReason = offReason == null ? null : offReason.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getFirstCheckUserId() {
        return firstCheckUserId;
    }

    public void setFirstCheckUserId(Integer firstCheckUserId) {
        this.firstCheckUserId = firstCheckUserId;
    }

    public String getFirstCheckUserOpinion() {
        return firstCheckUserOpinion;
    }

    public void setFirstCheckUserOpinion(String firstCheckUserOpinion) {
        this.firstCheckUserOpinion = firstCheckUserOpinion == null ? null : firstCheckUserOpinion.trim();
    }

    public Integer getSecondCheckUserId() {
        return secondCheckUserId;
    }

    public void setSecondCheckUserId(Integer secondCheckUserId) {
        this.secondCheckUserId = secondCheckUserId;
    }

    public String getSecondCheckUserOpinion() {
        return secondCheckUserOpinion;
    }

    public void setSecondCheckUserOpinion(String secondCheckUserOpinion) {
        this.secondCheckUserOpinion = secondCheckUserOpinion == null ? null : secondCheckUserOpinion.trim();
    }

    public Integer getThirdCheckUserId() {
        return thirdCheckUserId;
    }

    public void setThirdCheckUserId(Integer thirdCheckUserId) {
        this.thirdCheckUserId = thirdCheckUserId;
    }

    public String getThirdCheckUserOpinion() {
        return thirdCheckUserOpinion;
    }

    public void setThirdCheckUserOpinion(String thirdCheckUserOpinion) {
        this.thirdCheckUserOpinion = thirdCheckUserOpinion == null ? null : thirdCheckUserOpinion.trim();
    }

    public Date getFirstCheckDatetime() {
        return firstCheckDatetime;
    }

    public void setFirstCheckDatetime(Date firstCheckDatetime) {
        this.firstCheckDatetime = firstCheckDatetime;
    }

    public Date getSecondCheckDatetime() {
        return secondCheckDatetime;
    }

    public void setSecondCheckDatetime(Date secondCheckDatetime) {
        this.secondCheckDatetime = secondCheckDatetime;
    }

    public Date getThirdCheckDatetime() {
        return thirdCheckDatetime;
    }

    public void setThirdCheckDatetime(Date thirdCheckDatetime) {
        this.thirdCheckDatetime = thirdCheckDatetime;
    }

    public Date getApplyDatetime() {
        return applyDatetime;
    }

    public void setApplyDatetime(Date applyDatetime) {
        this.applyDatetime = applyDatetime;
    }

    public Integer getOffStatus() {
        return offStatus;
    }

    public void setOffStatus(Integer offStatus) {
        this.offStatus = offStatus;
    }

    public Integer getIsAcceptedByFirst() {
        return isAcceptedByFirst;
    }

    public void setIsAcceptedByFirst(Integer isAcceptedByFirst) {
        this.isAcceptedByFirst = isAcceptedByFirst;
    }

    public Integer getIsAcceptedBySecond() {
        return isAcceptedBySecond;
    }

    public void setIsAcceptedBySecond(Integer isAcceptedBySecond) {
        this.isAcceptedBySecond = isAcceptedBySecond;
    }

    public Integer getIsAcceptedByThird() {
        return isAcceptedByThird;
    }

    public void setIsAcceptedByThird(Integer isAcceptedByThird) {
        this.isAcceptedByThird = isAcceptedByThird;
    }
}