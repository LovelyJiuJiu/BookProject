package com.boku.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.boku.pojo.Admin;
import com.boku.pojo.Book;
import com.boku.pojo.Order;
import com.boku.pojo.Type;
import com.boku.pojo.User;

public interface AdminService {
	
	Admin login(Admin admin);
	
	List<User> getUserList();
	
	List<Book> getBookList();
	
	List<Type> getAllType();
	
	String uploadBookImg(HttpServletRequest request, MultipartFile file) throws IllegalStateException, IOException;
	
	boolean addBook(Book book);
	
	boolean changeStatusByBookId(int bookId, int status);

	List<Order> getOrderList();

	int confirmOrder(Integer orderId);
	
	String uploadBookQR(HttpServletRequest request, MultipartFile file) throws IllegalStateException, IOException;
}
