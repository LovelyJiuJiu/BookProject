package com.boku.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.boku.pojo.CartBook;
import com.boku.pojo.User;
import com.boku.pojo.UserCart;
import com.boku.service.BookService;
import com.boku.service.CartService;
import com.boku.service.UserService;
import com.google.gson.Gson;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private CartService cartService;
	@Autowired
	private BookService bookService;
	
	@RequestMapping("register-submit")
	@ResponseBody
	public String userRegister(User user, HttpSession session) {
		Gson gson = new Gson();
		User user1 = userService.register(user);
		if (user1 != null) {
			session.setAttribute("currentUser", user1);
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("result", 1);
			System.out.println(gson.toJson(result));
			return gson.toJson(result);
		}
		return null;
	}
	
	@RequestMapping("login-submit")
	@ResponseBody
	public String userLogin(User user, @RequestParam(defaultValue = "off") String rememberMe, 
			@CookieValue(required = false) String username, @CookieValue(required = false) String password, HttpServletResponse response, 
			HttpSession session) throws UnsupportedEncodingException {
		System.out.println(user);
		System.out.println(rememberMe);
		Gson gson = new Gson();
		User user1 = userService.login(user);
		Map<String, Object> result = new HashMap<String, Object>();
		if (user1 != null) {
			if ("on".equals(rememberMe)) {
				Cookie userNameCookie = new Cookie("username", URLEncoder.encode(user.getUsername(), "utf-8"));
				Cookie passwordCookie = new Cookie("password", URLEncoder.encode(user.getPassword(), "utf-8"));
				userNameCookie.setMaxAge(60*60*24*7);  
			    userNameCookie.setPath("/");  
			    passwordCookie.setMaxAge(60*60*24*7);  
			    passwordCookie.setPath("/");  
			    response.addCookie(userNameCookie);  
			    response.addCookie(passwordCookie);  
			} else if ("off".equals(rememberMe)) {
				if (username != null && password != null) {
					Cookie userNameCookie = new Cookie("username", "");
					Cookie passwordCookie = new Cookie("password", "");
					userNameCookie.setMaxAge(0);  
				    userNameCookie.setPath("/");  
				    passwordCookie.setMaxAge(0);  
				    passwordCookie.setPath("/");  
				    response.addCookie(userNameCookie);  
				    response.addCookie(passwordCookie);  
				}
			}
			session.setAttribute("currentUser", user1);
			result.put("result", 1);
		} else {
			result.put("result", 0);
		}
		System.out.println(gson.toJson(result));
		return gson.toJson(result);
	}
	
	@RequestMapping("logout")
	@ResponseBody
	public String logout(HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		if (session.getAttribute("currentUser") != null) {
			session.removeAttribute("currentUser");
			result.put("result", 1);
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("editProfileWithoutImg")
	@ResponseBody
	public String editUserInfo(User user, HttpServletRequest request){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boolean isSuccess = userService.editUserInfo(user, request, null);
			if (isSuccess) {
				result.put("code", 0);
				request.getSession().removeAttribute("currentUser");
			} else {
				result.put("code", 2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 1);
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("editProfileWithImg")
	@ResponseBody
	public String editUserInfo(User user, MultipartFile file, HttpServletRequest request){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(file.getSize());
		try {
			boolean isSuccess = userService.editUserInfo(user, request, file);
			if (isSuccess) {
				result.put("code", 0);
				request.getSession().removeAttribute("currentUser");
			} else {
				result.put("code", 2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 1);
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("login")
	public String loginTemp(){
		return "user/login";
	}
	
	@RequestMapping("register")
	public String registerTemp(){
		return "user/register";
	}
	
	@RequestMapping("editUserInfo")
	public String editUserInfoTemp(){
		return "user/userInfo";
	}

	@RequestMapping("cartPage")
	public String cartPageTemp(HttpSession session){
		return "user/cart";
	}

	
	@RequestMapping("bookNumber")
	@ResponseBody
	public String bookNumber(HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<UserCart> resultList = new ArrayList<UserCart>();
		User user =(User)session.getAttribute("currentUser");
		
		if (user != null) {
			List<CartBook> result = cartService.getcartBookObjListByUserId(user.getId());
			resultList = bookService.getUserCartObjListByList(result);
			session.setAttribute("cart", resultList);
			resultMap.put("result", result.size());
		} else {
			resultMap.put("result", 0);
		}
		return gson.toJson(resultMap);		
	}
	
	
	@RequestMapping("checkPassword")
	@ResponseBody
	public String checkPasswordByUserId(String password, HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", 0);
		User currentUser = (User)session.getAttribute("currentUser");
		
		if (currentUser!= null) {
			if (userService.checkPasswordByUserId(currentUser.getId(), password)) {
				result.put("result", 1);
			}		
		} 
		return gson.toJson(result);
	}

	
	@RequestMapping("updatePassword")
	@ResponseBody
	public String updatePasswordByUserId(String password, HttpSession session, HttpServletResponse response){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", 0);
		User currentUser = (User)session.getAttribute("currentUser");

		if (currentUser!= null) {
			if (userService.updatePasswordByUserId(currentUser.getId(), password)) {
				result.put("result", 1);
				session.removeAttribute("currentUser");
				//remove cookie
				Cookie userNameCookie = new Cookie("username", "");
				Cookie passwordCookie = new Cookie("password", "");
				userNameCookie.setMaxAge(0);  
			    userNameCookie.setPath("/");  
			    passwordCookie.setMaxAge(0);  
			    passwordCookie.setPath("/");  
			    response.addCookie(userNameCookie);  
			    response.addCookie(passwordCookie);  
			}
		} 
		return gson.toJson(result);
	}
	
	
	
	@RequestMapping("cart")
	@ResponseBody
	public String cart(HttpSession session, int page, int limit){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		@SuppressWarnings("unchecked")
		List<UserCart> cartItemList = (List<UserCart>) session.getAttribute("cart");
		int fromIndex = (page - 1) * limit;
		int toIndex = fromIndex + limit;
		toIndex = toIndex > cartItemList.size() ? cartItemList.size() : toIndex;
		List<UserCart> actualCartItem = cartItemList.subList(fromIndex, toIndex);
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", cartItemList.size());
		result.put("data", actualCartItem);
		return gson.toJson(result);
	}
}
