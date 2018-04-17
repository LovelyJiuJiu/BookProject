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

import com.boku.pojo.Cart;
import com.boku.pojo.CartBook;
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


