package com.boku.service;

import java.util.List;

import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;

public interface CartService {

	List<CartBook> getcartBookObjListByUserId(Integer userId);
	
}
