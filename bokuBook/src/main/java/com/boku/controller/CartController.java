package com.boku.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.boku.pojo.Cart;
import com.boku.pojo.CartBook;
import com.boku.service.CartService;

@Controller
@RequestMapping("cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping("addCart")
	public String addCart() {	// 先判断是否存在再决定是要执行插入操作或更新操作
		Cart cart = new Cart();
		cart.setUserId(16);
		cartService.addCart(cart);
		System.out.println(cart.getId());
		return null;
	}
	
	@RequestMapping("addBookToCart")
	private List<CartBook> getCartIdByUserId(Integer userId){
		
		Integer userd = 10;
		
		System.out.println(cartService.getcartBookObjListByUserId(userd));
		return null;	
	}
}


