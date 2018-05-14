package com.boku.pojo;

import java.util.Date;

public class Order {
    
    private Integer id;

    
    private String orderNo;

    
    private Integer userId;
    
    private String userName;

    
    private Double price;

    
    private Integer status;

    
    private Date submitTime;

    
    private Date payTime;

    
    public Integer getId() {
        return id;
    }

    
    public void setId(Integer id) {
        this.id = id;
    }

    
    public String getOrderNo() {
        return orderNo;
    }

    
    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo == null ? null : orderNo.trim();
    }

    
    public Integer getUserId() {
        return userId;
    }

    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    
    public Double getPrice() {
        return price;
    }

    
    public void setPrice(Double price) {
        this.price = price;
    }

    
    public Integer getStatus() {
        return status;
    }

    
    public void setStatus(Integer status) {
        this.status = status;
    }

    
    public Date getSubmitTime() {
        return submitTime;
    }

    
    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    
    public Date getPayTime() {
        return payTime;
    }

    
    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }


	@Override
	public String toString() {
		return "Order [id=" + id + ", orderNo=" + orderNo + ", userId=" + userId + ", userName=" + userName + ", price=" + price + ", status="
				+ status + ", submitTime=" + submitTime + ", payTime=" + payTime + "]";
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}
    
    
}