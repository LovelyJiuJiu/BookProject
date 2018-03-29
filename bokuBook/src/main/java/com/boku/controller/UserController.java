package com.boku.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class UserController {
	
	
	@RequestMapping("login")
	public String userLogin(){
		return "user/login";
	}
	
	@RequestMapping("register")
	public String userRegister(){
		return "user/register";
	}
}
