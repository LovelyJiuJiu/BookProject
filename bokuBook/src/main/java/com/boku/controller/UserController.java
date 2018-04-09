package com.boku.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class UserController {
	
	@RequestMapping("login")
	public String userLogin(HttpServletRequest request){
		return "user/login";
	}
	
	@RequestMapping("register")
	public String userRegister(){
		return "user/register";
	}
}
