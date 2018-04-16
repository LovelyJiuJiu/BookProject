package com.boku.service;

import java.util.List;

import com.boku.pojo.Cart;
import com.boku.pojo.CartBook;

public interface CartService {
	int addCart(Cart cart);
	List<CartBook> getcartBookObjListByUserId(Integer userId);
}	
