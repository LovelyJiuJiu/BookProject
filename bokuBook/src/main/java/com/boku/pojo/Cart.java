package com.boku.pojo;

import java.util.Date;

public class Cart {
    
    private Integer id;

    
    private Integer userId;

    
    private Date createTime;

    
    private Date lastUpdateTime;

    
    public Integer getId() {
        return id;
    }

    
    public void setId(Integer id) {
        this.id = id;
    }

    
    public Integer getUserId() {
        return userId;
    }

    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    
    public Date getCreateTime() {
        return createTime;
    }

    
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    
    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    
    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    
	@Override
	public String toString() {
		return "Cart [id=" + id + ", userId=" + userId + ", createTime=" + createTime + ", lastUpdateTime="
				+ lastUpdateTime + "]";
	}
}