package com.boku.controller;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import com.boku.pojo.Admin;
import com.boku.pojo.Book;
import com.boku.pojo.Type;
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
	
	
	@RequestMapping("bookList")
	@ResponseBody
	public String bookList(int page, int limit){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Book> bookList = adminService.getBookList();
		int fromIndex = (page - 1) * limit;
		int toIndex = fromIndex + limit;
		toIndex = toIndex > bookList.size() ? bookList.size() : toIndex;
		List<Book> actualBookList = bookList.subList(fromIndex, toIndex);
		
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", bookList.size());
		result.put("data", actualBookList);
			
		return gson.toJson(result);
	}
	
	@RequestMapping("bookListPage")
	public String bookListTemp(){
		return "admin/bookList";
	}
	
	@RequestMapping("addBookPage")
	public String addBookTemp(){
		return "admin/addBook";
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
		
	@RequestMapping("userList")
	@ResponseBody	
	public String userList(int page, int limit){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<User> userList = adminService.getUserList();
		int fromIndex = (page - 1) * limit;
		int toIndex = fromIndex + limit;
		toIndex = toIndex > userList.size() ? userList.size() : toIndex;
		List<User> actualUserList = userList.subList(fromIndex, toIndex);
		
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", userList.size());
		result.put("data", actualUserList);
			
		return gson.toJson(result);
	}
	
	@RequestMapping("typeList")
	@ResponseBody	
	public String getTypeList(){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Type> typeList = adminService.getAllType();
		result.put("typeList", typeList);	

		return gson.toJson(result);
	}	
	
	@RequestMapping("addBook")
	@ResponseBody	
	public String addBook(Book book){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(adminService.addBook(book)) {
			result.put("code", 1);
		}else{
			result.put("code", 0);
		}		
		return gson.toJson(result);
	}
	
	@RequestMapping("uploadBookImg")
	@ResponseBody	
	public String uploadBookImg(HttpServletRequest request, MultipartFile file){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
			try {
				String imgName = adminService.uploadBookImg(request, file);
				result.put("code", 1);
				result.put("imgName", imgName);
			} catch (Exception e) {
				e.printStackTrace();
				result.put("code", 0);
			}
		return gson.toJson(result);
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


