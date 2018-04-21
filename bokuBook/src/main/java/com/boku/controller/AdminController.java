package com.boku.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
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

import com.boku.pojo.Admin;
import com.boku.pojo.User;
import com.boku.pojo.UserCart;
import com.boku.service.AdminService;
import com.google.gson.Gson;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;


	@RequestMapping("login")
	public String loginTemp(){
		return "admin/login";
	}
	
	@RequestMapping("")
	public String index(){
		return "admin/login";
	}
	
	@RequestMapping("login-submit")
	@ResponseBody
	public String userLogin(Admin admin, @RequestParam(defaultValue = "off") String rememberMe, 
			@CookieValue(required = false) String adminUsername, @CookieValue(required = false) String adminPassword, HttpServletResponse response, 
			HttpSession session) throws UnsupportedEncodingException {
		Gson gson = new Gson();
		Admin admin1 = adminService.login(admin);
		Map<String, Object> result = new HashMap<String, Object>();
		if (admin1 != null) {
			if ("on".equals(rememberMe)) {
				Cookie userNameCookie = new Cookie("adminUsername", URLEncoder.encode(admin.getAdminUsername(), "utf-8"));
				Cookie passwordCookie = new Cookie("adminPassword", URLEncoder.encode(admin.getAdminPassword(), "utf-8"));
				userNameCookie.setMaxAge(60*60*24*7);  
			    userNameCookie.setPath("/");  
			    passwordCookie.setMaxAge(60*60*24*7);  
			    passwordCookie.setPath("/");  
			    response.addCookie(userNameCookie);  
			    response.addCookie(passwordCookie);  
			} else if ("off".equals(rememberMe)) {
				if (adminUsername != null && adminPassword != null) {
					Cookie userNameCookie = new Cookie("adminUsername", "");
					Cookie passwordCookie = new Cookie("adminPassword", "");
					userNameCookie.setMaxAge(0);  
				    userNameCookie.setPath("/");  
				    passwordCookie.setMaxAge(0);  
				    passwordCookie.setPath("/");  
				    response.addCookie(userNameCookie);  
				    response.addCookie(passwordCookie);  
				}
			}
			session.setAttribute("currentAdminUser", admin1);
			result.put("result", 1);
		} else {
			result.put("result", 0);
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("adminMain")
	public String adminMainTemp(){
		return "admin/adminMain";
	}
	
	@RequestMapping("logout")
	@ResponseBody
	public String logout(HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		Admin admin = (Admin) session.getAttribute("currentAdminUser");
		if(admin != null) {
			session.removeAttribute("currentAdminUser");
			result.put("result", 1);	
		}
		return gson.toJson(result);
	}
	
}


