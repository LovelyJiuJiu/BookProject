package com.boku.service;

import java.util.List;

import com.boku.pojo.Order;
import com.boku.pojo.UserCart;


public interface OrderService {
	Order addOrder(List<UserCart> orders, Integer userId);

	List<Order> queryOrderByUserId(Integer id);

	List<UserCart> selectOrderDetail(Integer orderId);

	Order selectOrderByOrderId(Integer orderId);

	int changeOrderStatusToFinish(Integer orderId, Integer id);

	int cancelOrder(Integer id, Integer userId);
}	
