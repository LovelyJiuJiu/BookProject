package com.boku.pojo;

public class Collect {
    
	private Integer id;
	private Integer userId;
	private Integer bookId;
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
	public Integer getBookId() {
		return bookId;
	}
	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}
	@Override
	public String toString() {
		return "collect [id=" + id + ", userId=" + userId + ", bookId=" + bookId + "]";
	}
    
}