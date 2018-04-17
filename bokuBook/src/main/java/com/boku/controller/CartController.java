package com.boku.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boku.pojo.Cart;
import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;
import com.boku.service.CartService;
import com.google.gson.Gson;

@Controller
@RequestMapping("user")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping("addBookToCart")
	@ResponseBody
	public String addBookToCart(UserCart userCart, HttpSession session) {
		UserCart userCart2 = new UserCart(3, "", "", 10, 5, 0);
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		List<UserCart> userCarts = (List<UserCart>) session.getAttribute("cart");
		userCarts = cartService.addBookToCart(userCart2, userCarts);
		session.setAttribute("cart", userCarts);
		result.put("result", 1);
		return gson.toJson(result);
	}
}
