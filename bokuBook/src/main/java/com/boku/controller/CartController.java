package com.boku.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boku.pojo.User;
import com.boku.pojo.UserCart;
import com.boku.service.CartService;
import com.google.gson.Gson;

@Controller
@RequestMapping("cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("deleteBook")
	@ResponseBody
	public String deleteBookInCart(HttpSession session, @RequestParam(value = "id") int id) {
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		List<UserCart> cartItemList = (List<UserCart>) session.getAttribute("cart");
		int resultNum = 0;

		for (int i = 0; i<cartItemList.size(); i++) {
			if (id == cartItemList.get(i).getId()) {
				cartItemList.remove(i);
				session.setAttribute("cart", cartItemList);
				resultNum = 1;
			}
		}
		result.put("result", resultNum);
		return gson.toJson(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("addBookToCart")
	@ResponseBody
	public String addBookToCart(UserCart userCart, HttpSession session) {
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			result.put("result", 2);
			return gson.toJson(result);
		}
		List<UserCart> userCarts = (List<UserCart>) session.getAttribute("cart");
		userCarts = cartService.addBookToCart(userCart, userCarts);
		session.setAttribute("cart", userCarts);
		System.out.println(session.getAttribute("cart"));
		result.put("result", 1);
		result.put("cartSize", userCarts.size());
		return gson.toJson(result);
	}
}
