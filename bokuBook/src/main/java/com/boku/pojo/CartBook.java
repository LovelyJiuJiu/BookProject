package com.boku.pojo;

public class CartBook {
    
    private Integer bookId;   
    private Integer number;
    private Integer cartId;
    
	public Integer getBookId() {
		return bookId;
	}
	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	public Integer getCartId() {
		return cartId;
	}
	public void setCartId(Integer cartId) {
		this.cartId = cartId;
	}
	
	public CartBook(Integer bookId, Integer number, Integer cartId) {
		super();
		this.bookId = bookId;
		this.number = number;
		this.cartId = cartId;
	}

	public CartBook() {
		super();
		// TODO Auto-generated constructor stub
	}   
}