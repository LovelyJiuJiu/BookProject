package com.boku.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.UserMapper;
import com.boku.pojo.User;
import com.boku.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public User register(User user) {
		int result = userMapper.insertSelective(user);
		if (result == 1) {
			user.setPassword(null);
			return user;
		}
		return null;
	}

	@Override
	public User login(User user) {
		User user1 = userMapper.selectByUserNameAndPassword(user);
		if (user1 != null) {
			user1.setPassword(null);
			return user1;
		}
		return null;
	}

}
