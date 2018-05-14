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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boku.mail.MailSender;
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
	@Autowired
	private MailSender MailSender;
	
	@RequestMapping("order-submit/{userId}")
	@ResponseBody
	public String addOrder(@RequestBody ArrayList<UserCart> books, @PathVariable Integer userId, HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			result.put("result", 2);
			return gson.toJson(result);
		}
		Order order = orderService.addOrder(books, userId);
		if (order == null) {
			result.put("result", 1);
			result.put("msg", "添加失败");
		} else {
			
			// 删除购物车中包含在已提交订单中的商品
			@SuppressWarnings("unchecked")
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
			result.put("orderId", order.getId());
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("purchse-at-time")
	@ResponseBody
	public String purchseAtTime(UserCart userCart, HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			result.put("result", 2);
			return gson.toJson(result);
		}
		List<UserCart> userCarts = new ArrayList<UserCart>();
		userCarts.add(userCart);
		Order order = orderService.addOrder(userCarts, user.getId());
		if (order == null) {
			result.put("result", 1);
			result.put("msg", "添加失败");
		} else {
			result.put("result", 0);
			result.put("orderId", order.getId());
		}
		return gson.toJson(result);
	}
	
	@RequestMapping("getOrderList")
	@ResponseBody
	public String queryOrder(int page, int limit, HttpSession session) {
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user != null) {
			PageHelper.startPage(page, limit);
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
	
	@RequestMapping(value = {"orderConfirm", "orderDetail"})
	public ModelAndView showOrderDetail(Integer orderId, HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView("user/orderDetail");
		if (user != null) {
			Order order = orderService.selectOrderByOrderId(orderId);
			if (order.getStatus() == 0) {
				modelAndView.setViewName("user/orderConfirm");
			}
			List<UserCart> orderDetail = orderService.selectOrderDetail(orderId);
			modelAndView.addObject("orderDetail", orderDetail);
			modelAndView.addObject("order", order);
		} else {
			modelAndView.setViewName("user/login");
		}
		return modelAndView;
	}
	
	@RequestMapping("orderPay")
	@ResponseBody
	public String payOrder(Integer id, HttpSession session) {
		Gson gson = new Gson();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user != null) {
			int result = orderService.changeOrderStatusToFinish(id, user.getId());
			if (result == 0) {
				resultMap.put("result", 1);
				resultMap.put("msg", "未找到对应的订单记录");
			} else {
				if(user.getEmail() != ""){
					System.out.println("发送邮件");
					MailSender.sendMail(user.getEmail(), "博库书城支付详情", "您的订单已经支付，具体详情请登录博库书城网页进行查看。");
				}
				resultMap.put("result", 0);
				resultMap.put("msg", "支付成功");
			}
		} else {
			resultMap.put("result", 2);
		}
		return gson.toJson(resultMap);
	}
	
	@RequestMapping("cancelOrder")
	@ResponseBody
	public String cancelOrder(Integer id, HttpSession session) {
		Gson gson = new Gson();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		if (user != null) {
			int result = orderService.cancelOrder(id, user.getId());
			if (result == 0) {
				resultMap.put("result", 1);
			} else {
				resultMap.put("result", 0);
			}
		} else {
			resultMap.put("result", 2);
		}
		return gson.toJson(resultMap);
	}
}


