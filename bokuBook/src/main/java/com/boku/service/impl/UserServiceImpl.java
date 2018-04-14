package com.boku.service.impl;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

	@Override
	public boolean editUserInfo(User user, HttpServletRequest request, MultipartFile file) throws IllegalStateException, IOException {
		String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".jpg";
        System.out.println(newFileName);
        File newFile = new File(request.getServletContext().getRealPath("/image"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        user.setImgName(newFileName);
//		userMapper.editUserInfo();
		return false;
	}

}
