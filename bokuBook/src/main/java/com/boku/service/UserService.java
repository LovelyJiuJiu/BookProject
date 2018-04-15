package com.boku.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.boku.pojo.User;

public interface UserService {
	User register(User user);
	
	User login(User user);
	
	boolean editUserInfo(User user, HttpServletRequest request, MultipartFile file) throws IllegalStateException, IOException;
}
