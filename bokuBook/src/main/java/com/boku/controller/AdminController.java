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
import org.springframework.web.servlet.ModelAndView;

import com.boku.mapper.TypeMapper;
import com.boku.pojo.Admin;
import com.boku.pojo.Book;
import com.boku.pojo.Order;
import com.boku.pojo.Type;
import com.boku.pojo.User;
import com.boku.pojo.UserCart;
import com.boku.service.AdminService;
import com.boku.service.BookService;
import com.boku.service.OrderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private OrderService orderService;

	@Autowired
	private BookService bookService;

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
		PageHelper.startPage(page, limit);
		List<Book> bookList = adminService.getBookList();
		PageInfo<Book> books = new PageInfo<Book>(bookList);
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", books.getTotal());
		result.put("data", books.getList());
			
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
	
	@RequestMapping("orderListPage")
	public String orderListTemp(){
		return "admin/orderList";
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
		PageHelper.startPage(page, limit);
		List<User> userList = adminService.getUserList();
		PageInfo<User> users = new PageInfo<User>(userList);
		
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", users.getTotal());
		result.put("data", users.getList());
			
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
		System.out.println(book.toString());
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
	
	@RequestMapping("changeStatus")
	@ResponseBody
	public String changeStatus(int bookId, int status){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		if(adminService.changeStatusByBookId(bookId, status)) {
			result.put("code", 1);
		} else{
			result.put("code", 0);
		}		
		return gson.toJson(result);
	}
	
	@RequestMapping("orderList")
	@ResponseBody
	public String orderList(int page, int limit){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		PageHelper.startPage(page, limit);
		List<Order> orderList = adminService.getOrderList();
		PageInfo<Order> orders = new PageInfo<Order>(orderList);
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", orders.getTotal());
		result.put("data", orders.getList());
			
		return gson.toJson(result);
	}
	
	@RequestMapping("confirmOrder")
	@ResponseBody
	public String confirmOrder(Integer orderId){
		Gson gson = new Gson();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = adminService.confirmOrder(orderId);
		if (result == 1) {
			resultMap.put("result", 1);
		} else {
			resultMap.put("result", 0);
		}
		return gson.toJson(resultMap);
	}
	
	@RequestMapping("showOrderDetail")
	public ModelAndView showOrderDetail(Integer orderId) {
		ModelAndView modelAndView = new ModelAndView("user/orderDetail");
		Order order = orderService.selectOrderByOrderId(orderId);
		List<UserCart> orderDetail = orderService.selectOrderDetail(orderId);
		modelAndView.addObject("orderDetail", orderDetail);
		modelAndView.addObject("order", order);
		modelAndView.addObject("type", "admin");
		return modelAndView;
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
	
	@RequestMapping("bookMainPage")
	public String bookMainPageTemp(){
		return "admin/bookMain";
	}
	
	@RequestMapping("getSaleInfo")
	@ResponseBody
	public String getSaleInfo(){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		List<String> labels = new ArrayList<>();
		labels.add("一月");
		labels.add("二月");
		labels.add("三月");
		labels.add("四月");
		labels.add("五月");
		labels.add("六月");
		labels.add("七月");
		labels.add("八月");
		labels.add("九月");
		labels.add("十月");
		labels.add("十一月");
		labels.add("十二月");
		result.put("labels", labels);
		
		int[] data={1,2,3,6,3,4,5,6,3,3,4,46};  
		result.put("data", data);
		return gson.toJson(result);
	}
	
}


