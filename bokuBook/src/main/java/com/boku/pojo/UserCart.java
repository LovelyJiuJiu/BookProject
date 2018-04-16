package com.boku.pojo;

import java.math.BigDecimal;

public class UserCart {
    private int id;
    private String bookName;
    private String bookInfo;
    private double price;
    private int number;
    private double totalPrice;
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getBookInfo() {
		return bookInfo;
	}
	public void setBookInfo(String bookInfo) {
		this.bookInfo = bookInfo;
	}

	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}


	public UserCart(int id, String bookName, String bookInfo, double price, int number, double totalPrice) {
		super();
		this.id = id;
		this.bookName = bookName;
		this.bookInfo = bookInfo;
		this.price = price;
		this.number = number;
		this.totalPrice = totalPrice;
	}
	
	public UserCart() {
		super();
		// TODO Auto-generated constructor stub
	}
    
}