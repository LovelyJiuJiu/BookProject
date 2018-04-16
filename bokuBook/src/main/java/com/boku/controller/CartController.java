package com.boku.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.boku.pojo.CartBook;
import com.boku.service.CartService;

@Controller
@RequestMapping("cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	
	private List<CartBook> getCartIdByUserId(Integer userId){
		return null;
//		return cartService.getBookIdListByUserId(userId);	
		
	}

}
