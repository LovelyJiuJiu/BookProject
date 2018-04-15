package com.boku.controller;

import java.io.IOException;
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

import com.boku.pojo.User;
import com.boku.pojo.UserCart;
import com.boku.service.UserService;
import com.google.gson.Gson;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
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
			userService.editUserInfo(user, request, null);
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
			userService.editUserInfo(user, request, file);
			result.put("code", 0);
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
	public String cartPageTemp(){
		return "user/cart";
	}
	
	
	@RequestMapping("cart")
	@ResponseBody
	public String cart(HttpServletRequest request){
		String pageNumStr = request.getParameter("page");//得到第几页
		String limitStr = request.getParameter("limit");//得到每页多少个
		System.out.println(pageNumStr+"~~~~~~" + limitStr);
		//模拟数据的
		List<UserCart> cartList = new ArrayList<UserCart>();
		for(int i = 1; i<=20; i++) {
			UserCart userCart = new UserCart(i, "书名", "bookInfo",3.0, i, 3*i);
			cartList.add(userCart);
		}
		Gson gson = new Gson();
		String json = gson.toJson(cartList);
		//写一个查询数量的  放在count变量中传到前台
		int count = cartList.size();		
		String result = "{\"code\":0,\"msg\":\"\",\"count\":"+ count +",\"data\":" + json + "}";
		return result;
	}
}
