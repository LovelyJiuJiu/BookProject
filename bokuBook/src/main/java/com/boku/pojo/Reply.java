package com.boku.pojo;

import java.util.Date;

public class Reply {
    
    private Integer id;

    
    private Integer bookId;

    
    private Integer userId;

    
    private String replycontents;

    
    private Date replytime;

    
    public Integer getId() {
        return id;
    }

    
    public void setId(Integer id) {
        this.id = id;
    }

    
    public Integer getBookId() {
        return bookId;
    }

    
    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    
    public Integer getUserId() {
        return userId;
    }

    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    
    public String getReplycontents() {
        return replycontents;
    }

    
    public void setReplycontents(String replycontents) {
        this.replycontents = replycontents == null ? null : replycontents.trim();
    }

    
    public Date getReplytime() {
        return replytime;
    }

    
    public void setReplytime(Date replytime) {
        this.replytime = replytime;
    }
}