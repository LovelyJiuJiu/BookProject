package com.boku.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boku.mapper.BookMapper;
import com.boku.mapper.ReplyMapper;
import com.boku.pojo.Book;
import com.boku.pojo.Order;
import com.boku.pojo.User;
import com.boku.pojo.UserCart;
import com.boku.service.OrderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;

@Controller
@RequestMapping("order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping("order-submit/{userId}")
	@ResponseBody
	public String addOrder(@RequestBody ArrayList<UserCart> books, @PathVariable Integer userId, HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		Order order = orderService.addOrder(books, userId);
		if (order == null) {
			result.put("result", 1);
			result.put("msg", "添加失败");
		} else {
			List<UserCart> userCarts = (List<UserCart>) session.getAttribute("cart");
			if (userCarts != null && userCarts.size() > 0) {
				Iterator<UserCart> uc1 = books.iterator();
				Iterator<UserCart> uc2 = userCarts.iterator();
				while(uc1.hasNext()) {
				    UserCart userCart = uc1.next();
				    while (uc2.hasNext()) {
				    	UserCart userCart2 = uc2.next();
						if (userCart.getId() == userCart2.getId()) {
							uc2.remove();
							break;
						}
					}
				}
				session.setAttribute("cart", userCarts);
			}
			result.put("result", 0);
			result.put("orderNo", order.getOrderNo());
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("myOrder")
	public String showOrderPage() {
		return "user/orderList";
	}
	
	@RequestMapping("queryOrder")
	@ResponseBody
	public String queryOrder(int page, int limit, HttpSession session) {
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user != null) {
			PageHelper.startPage(page, 1);
			List<Order> orders = orderService.queryOrderByUserId(user.getId());
			PageInfo<Order> selectedOrders = new PageInfo<Order>(orders);
			result.put("code", 0);
			result.put("msg", "");
			result.put("count", selectedOrders.getTotal());
			result.put("data", orders);
		} else {
			result.put("msg", "你还没有登录哦(～￣▽￣)～ ");
		}
		System.out.println(gson.toJson(result));
		return gson.toJson(result);
	}
	
	@RequestMapping("orderDetail")
	public ModelAndView showOrderDetail(Integer orderId, HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView("user/orderDetail");
		if (user != null) {
			List<UserCart> orderDetail = orderService.selectOrderDetail(orderId);
			modelAndView.addObject("orderDetail", orderDetail);
		} else {
			modelAndView.addObject("msg", "你还没有登录哦(～￣▽￣)～ ");
		}
		return modelAndView;
	}
}


