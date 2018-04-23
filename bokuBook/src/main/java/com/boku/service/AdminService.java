package com.boku.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.boku.pojo.Admin;
import com.boku.pojo.User;

public interface AdminService {
	Admin register(Admin admin);
	
	Admin login(Admin admin);
	
	boolean editUserInfo(Admin user, HttpServletRequest request, MultipartFile file) throws IllegalStateException, IOException;
	boolean checkPasswordByUserId(Integer id, String password);
	boolean updatePasswordByUserId(Integer id, String password);
	List<User> getUserList();
}
