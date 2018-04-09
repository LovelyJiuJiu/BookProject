package com.boku.pojo;

import java.math.BigDecimal;
import java.util.Date;

public class Order {
    
    private Integer id;

    
    private String orderNo;

    
    private Integer userId;

    
    private BigDecimal price;

    
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

    
    public BigDecimal getPrice() {
        return price;
    }

    
    public void setPrice(BigDecimal price) {
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
}