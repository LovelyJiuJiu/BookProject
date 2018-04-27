package com.boku.service.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.boku.mapper.AdminMapper;
import com.boku.mapper.UserMapper;
import com.boku.pojo.Admin;
import com.boku.pojo.User;
import com.boku.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public Admin register(Admin admin) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Admin login(Admin admin) {
		Admin admin1 = adminMapper.selectByAdminNameAndPassword(admin);
		if (admin1 != null) {
			admin1.setAdminPassword(null);
			return admin1;
		}
		return null;
	}

	@Override
	public boolean editUserInfo(Admin user, HttpServletRequest request, MultipartFile file)
			throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean checkPasswordByUserId(Integer id, String password) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updatePasswordByUserId(Integer id, String password) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<User> getUserList() {		
		return userMapper.getUserList();
	}



}
