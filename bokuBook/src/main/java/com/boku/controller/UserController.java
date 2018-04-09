package com.boku.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping("login")
	public String loginTemp(HttpServletRequest request){
		return "user/login";
	}
	
	@RequestMapping("register")
	public String registerTemp(){
		return "user/register";
	}
}
