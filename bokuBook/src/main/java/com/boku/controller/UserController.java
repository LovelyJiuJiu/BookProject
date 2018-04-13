package com.boku.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boku.pojo.User;
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
}
