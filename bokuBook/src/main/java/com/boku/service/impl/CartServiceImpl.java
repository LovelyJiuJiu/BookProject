package com.boku.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.CartMapper;
import com.boku.pojo.Cart;
import com.boku.service.CartService;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;

	@Override
	public int addCart(Cart cart) {
		return cartMapper.insertSelective(cart);
	}

}
