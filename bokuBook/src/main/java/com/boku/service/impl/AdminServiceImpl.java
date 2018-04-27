package com.boku.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.boku.mapper.AdminMapper;
import com.boku.mapper.BookMapper;
import com.boku.mapper.TypeMapper;
import com.boku.mapper.UserMapper;
import com.boku.pojo.Admin;
import com.boku.pojo.Book;
import com.boku.pojo.Type;
import com.boku.pojo.User;
import com.boku.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private TypeMapper typeMapper;

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
	public List<User> getUserList() {		
		return userMapper.getUserList();
	}

	@Override
	public List<Book> getBookList() {
		return bookMapper.getBookList();
	}

	@Override
	public List<Type> getAllType() {
		return typeMapper.getAllType();
	}

	@Override
	public String uploadBookImg(HttpServletRequest request, MultipartFile file) throws IllegalStateException, IOException {
		String name = RandomStringUtils.randomAlphanumeric(10);  // 随机数
		String newFileName = name + ".jpg";

		File newFile = new File(request.getServletContext().getRealPath("/image"), newFileName);
		newFile.getParentFile().mkdirs();
		file.transferTo(newFile);
		
		return newFileName;		
	}

	@Override
	public boolean addBook(Book book) {
		
		if(("").equals(book.getBookImage())) {
			book.setBookImage("deafultBook.jpg");
		}
		
		book.setStatus(0);
		Date date = new Date();
		book.setCreateTime(date);
		book.setLastUpdateTime(date);
		System.out.println("book2"+book.toString());
		int result = bookMapper.insert(book);
		if (result == 1) {
			return true;
		}		
		return false;
	}

}
