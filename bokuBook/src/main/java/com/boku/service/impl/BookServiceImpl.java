package com.boku.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.BookMapper;
import com.boku.pojo.Book;
import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;
import com.boku.service.BookService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

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
			List<Book> bookList = bookMapper.getBookListByIds(bookIdList);//得到的是book list 但是要把属性转化成userCart的
			for (int i = 0; i < bookList.size(); i++) {
				Book book = bookList.get(i);
				int number = CartBookList.get(i).getNumber();
				UserCart temp = new UserCart(book.getId(), book.getBookname(), book.getBookImage(), book.getBookPrice(), number, number*book.getBookPrice());
				resultList.add(temp);
			}	
		}
		return resultList;
	}

	@Override
	public List<Book> getBookSuggestion(String keyWords) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("keyWords", keyWords);
		params.put("symbol", null);
		return bookMapper.selectBookByKeywords(params);
	}

	@Override
	public PageInfo<Book> getBookByKeywords(String keyWord, int page, int limit) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("keyWords", keyWord);
		params.put("symbol", new Object());
		PageHelper.startPage(page, limit);
		List<Book> books = bookMapper.selectBookByKeywords(params);
		PageInfo<Book> selectedBook = new PageInfo<Book>(books);
		return selectedBook;
	}

	@Override
	public List<Book> getNewBookList() {		
		return bookMapper.getNewBookList();
	}

	@Override
	public List<Book> getHotBookList() {
		return bookMapper.getHotBookList();
	}
	
}
