package com.boku.pojo;

import java.math.BigDecimal;
import java.util.Date;

public class Book {
	
    private Integer id;
    private String bookname;
    private Integer typeId;
    private String bookAuthor;
    private String bookIntroduction;
    private String bookPublisher;
    private String bookImage;
    private BigDecimal bookPrice;
    private Integer status;
    private Date createTime;
    private Date lastUpdateTime;
    
    
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    
    public String getBookname() {
        return bookname;
    }

    
    public void setBookname(String bookname) {
        this.bookname = bookname == null ? null : bookname.trim();
    }

    
    public Integer getTypeId() {
        return typeId;
    }

    
    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    
    public String getBookAuthor() {
        return bookAuthor;
    }

    
    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor == null ? null : bookAuthor.trim();
    }

    
    public String getBookIntroduction() {
        return bookIntroduction;
    }

    
    public void setBookIntroduction(String bookIntroduction) {
        this.bookIntroduction = bookIntroduction == null ? null : bookIntroduction.trim();
    }

    
    public String getBookPublisher() {
        return bookPublisher;
    }

    
    public void setBookPublisher(String bookPublisher) {
        this.bookPublisher = bookPublisher == null ? null : bookPublisher.trim();
    }

    
    public String getBookImage() {
        return bookImage;
    }

    
    public void setBookImage(String bookImage) {
        this.bookImage = bookImage == null ? null : bookImage.trim();
    }

    
    public BigDecimal getBookPrice() {
        return bookPrice;
    }

    
    public void setBookPrice(BigDecimal bookPrice) {
        this.bookPrice = bookPrice;
    }

    
    public Integer getStatus() {
        return status;
    }

    
    public void setStatus(Integer status) {
        this.status = status;
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
		return "Book [id=" + id + ", bookname=" + bookname + ", typeId=" + typeId + ", bookAuthor=" + bookAuthor
				+ ", bookIntroduction=" + bookIntroduction + ", bookPublisher=" + bookPublisher + ", bookImage="
				+ bookImage + ", bookPrice=" + bookPrice + ", status=" + status + ", createTime=" + createTime
				+ ", lastUpdateTime=" + lastUpdateTime + "]";
	}
    
    
}