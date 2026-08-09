package com.sekai.memory.book.model;

import java.time.LocalDateTime;

public class User {

    /**
     * 用户ID，主键，自增
     */
    private Long id;

    /**
     * 用户名，用于登录
     */
    private String userName;

    /**
     * 密码
     */
    private String password;

    /**
     * 昵称
     */
    private String nickName;

    /**
     * 头像地址
     */
    private String avatar;

    private String phoneNumber;

    private String membershipPlan;

    private LocalDateTime proExpireTime;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getMembershipPlan() {
        return membershipPlan;
    }

    public void setMembershipPlan(String membershipPlan) {
        this.membershipPlan = membershipPlan;
    }

    public LocalDateTime getProExpireTime() {
        return proExpireTime;
    }

    public void setProExpireTime(LocalDateTime proExpireTime) {
        this.proExpireTime = proExpireTime;
    }

    public boolean isPro() {
        return "PRO".equalsIgnoreCase(membershipPlan)
                && proExpireTime != null
                && proExpireTime.isAfter(LocalDateTime.now());
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }
}

