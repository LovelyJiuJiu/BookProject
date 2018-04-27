package com.boku.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.OrderBookMapper;
import com.boku.mapper.OrderMapper;
import com.boku.pojo.Order;
import com.boku.pojo.OrderBook;
import com.boku.pojo.UserCart;
import com.boku.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired 
	private OrderMapper orderMapper;
	
	@Autowired
	private OrderBookMapper orderBookMapper;

	@Override
	public Order addOrder(List<UserCart> userCarts, Integer userId) {
		double orderPrice = 0;
		String orderNo = getRandomOrderNo();
		Order order = new Order();
		List<OrderBook> orderBooks = new ArrayList<OrderBook>();
		order.setOrderNo(orderNo);
		order.setUserId(userId);
		for (UserCart userCart : userCarts) {
			orderPrice += userCart.getTotalPrice();
		}
		order.setPrice(orderPrice);
		order.setStatus(0);
		int result = orderMapper.insertSelective(order);
		if (result == 1) {
			for (UserCart userCart : userCarts) {
				OrderBook orderBook = new OrderBook();
				orderBook.setBookId(userCart.getId());
				orderBook.setNumber(userCart.getNumber());
				orderBook.setOrderId(order.getId());
				orderBooks.add(orderBook);
			}
			int insertRes = orderBookMapper.insert(orderBooks);
			if (insertRes > 0) {
				return order;
			}
		}
		return null;
	}
	
	private String getRandomOrderNo() {
		//格式化当前时间
		SimpleDateFormat sfDate = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String strDate = sfDate.format(new Date());
		System.out.println("时间17位：" + strDate);
		String random = getRandomWithPointedCount(3);
		System.out.println("订单号20位：" + strDate + random);
		return strDate + random;
	}

	private String getRandomWithPointedCount(int i) {
		String result = "";
		Random rand = new Random();
		int randInt = 0;
		for (int m = 0; m < i; m++) {
			randInt = rand.nextInt(10);
			result += randInt;
		}
		return result;
	}

	@Override
	public List<Order> queryOrderByUserId(Integer id) {
		List<Order> orders = orderMapper.queryOrderByUserId(id);
		System.out.println(orders);
		return orders;
	}

	@Override
	public List<UserCart> selectOrderDetail(Integer orderId) {
		List<UserCart> orderDetail = orderBookMapper.selectOrderDetail(orderId);
		for (UserCart userCart : orderDetail) {
			userCart.setTotalPrice(userCart.getPrice() * userCart.getNumber());
		}
		return orderDetail;
	}

	@Override
	public Order selectOrderByOrderId(Integer orderId) {
		return orderMapper.selectByPrimaryKey(orderId);
	}

}
