package com.boku.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.CartBookMapper;
import com.boku.mapper.CartMapper;
import com.boku.pojo.Cart;
import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;
import com.boku.service.CartService;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private CartBookMapper cartBookMapper;

	@Override
	public int addCart(Cart cart) {
		return cartMapper.insertSelective(cart);
	}
	
	@Override
	public List<CartBook> getcartBookObjListByUserId(Integer userId){				
		return cartMapper.getcartBookObjListByUserId(userId);		
	}

	@Override
	public List<UserCart> addBookToCart(UserCart userCart, List<UserCart> userCarts) {
		if (userCarts == null) {
			userCarts = new ArrayList<UserCart>();
		}
		for (UserCart uCart : userCarts) {
			if (uCart.getId() == userCart.getId()) {
				uCart.setNumber(uCart.getNumber() + userCart.getNumber());
				uCart.setTotalPrice(uCart.getNumber() * uCart.getPrice().doubleValue());
				return userCarts;
			}
		}
		BigDecimal number = new BigDecimal(Double.toString(userCart.getNumber()));
		BigDecimal price = new BigDecimal(Double.toString(userCart.getPrice()));
		BigDecimal result = number.multiply(price);
		System.out.println(result.toString());
		BigDecimal one = new BigDecimal("1");
		Double a = result.divide(one, 2, BigDecimal.ROUND_HALF_UP).doubleValue();// 保留1位数
		System.out.println(a);
		userCart.setTotalPrice(a);
		userCarts.add(userCart);
		return userCarts;
	}

	@Override
	public void addCartToDb(Integer id, List<UserCart> userCarts) {
		List<CartBook> cartBooks = new ArrayList<CartBook>();
		Cart cart = cartMapper.selectByUserId(id);
		if (cart == null) {
			cart = new Cart();
			cart.setUserId(id);
			int result = cartMapper.insertSelective(cart);
			if (result != 1) {
				return;
			}
		} else {
			cartMapper.updateByPrimaryKey(cart);
		}
		for (UserCart userCart : userCarts) {
			CartBook cartBook = new CartBook();
			cartBook.setBookId(userCart.getId());
			cartBook.setCartId(cart.getId());
			cartBook.setNumber(userCart.getNumber());
			cartBooks.add(cartBook);
		}
		cartBookMapper.deleteByCartId(cart.getId());
		if (cartBooks.size() > 0) {
			cartBookMapper.insert(cartBooks);
		}
	}	

}
