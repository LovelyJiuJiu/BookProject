package com.boku.pojo;

import java.util.Date;

public class UserReply {
    private String replycontents;
    private Date replytime;
    private String username;
    private String email;
    private String imgName;
    private String dateStr;

	public String getDateStr() {
		return dateStr;
	}
	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
	}
	public String getReplycontents() {
		return replycontents;
	}
	public void setReplycontents(String replycontents) {
		this.replycontents = replycontents;
	}
	public Date getReplytime() {
		return replytime;
	}
	public void setReplytime(Date replytime) {
		this.replytime = replytime;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	@Override
	public String toString() {
		return "UserReply [replycontents=" + replycontents + ", replytime=" + replytime + ", username=" + username
				+ ", email=" + email + ", imgName=" + imgName + ", dateStr=" + dateStr + "]";
	}
	public UserReply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserReply(String replycontents, Date replytime, String username, String email, String imgName) {
		super();
		this.replycontents = replycontents;
		this.replytime = replytime;
		this.username = username;
		this.email = email;
		this.imgName = imgName;
	}
    
}