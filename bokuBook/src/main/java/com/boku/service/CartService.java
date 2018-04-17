package com.boku.service;

import java.util.List;

import com.boku.pojo.Cart;
import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;

public interface CartService {
	int addCart(Cart cart);
	List<CartBook> getcartBookObjListByUserId(Integer userId);
	List<UserCart> addBookToCart(UserCart userCart, List<UserCart> userCarts);
	void addCartToDb(Integer id, List<UserCart> userCarts);
}	
