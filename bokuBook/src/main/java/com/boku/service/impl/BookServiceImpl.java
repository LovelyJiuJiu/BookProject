package com.boku.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.BookMapper;
import com.boku.pojo.Book;
import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;
import com.boku.service.BookService;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookMapper bookMapper;

	@Override
	public List<UserCart> getUserCartObjListByList(List<CartBook> CartBookList) {

		List<Integer> bookIdList = new ArrayList<Integer>();
		List<UserCart> resultList = new ArrayList<UserCart>();
		if (CartBookList.size() > 0) {
			for(int i = 0;i < CartBookList.size(); i++) {
				bookIdList.add(CartBookList.get(i).getBookId());
			}
			System.out.println("bookId们"+bookIdList.toString());
			List<Book> bookList = bookMapper.getBookListByIds(bookIdList);//得到的是book list 但是要把属性转化成userCart的
			System.out.println("book们"+bookList.toString());
			for (int i = 0; i < bookList.size(); i++) {
				Book book = bookList.get(i);
				int number = CartBookList.get(i).getNumber();
				UserCart temp = new UserCart(book.getId(), book.getBookname(), book.getBookImage(), book.getBookPrice(), number, number*book.getBookPrice());
				resultList.add(temp);
			}	
		} else {
			resultList = null;
		}
		return resultList;
	}
	
}
