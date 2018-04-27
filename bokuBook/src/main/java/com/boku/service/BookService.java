package com.boku.service;

import java.util.List;

import com.boku.pojo.Book;
import com.boku.pojo.CartBook;
import com.boku.pojo.UserCart;
import com.github.pagehelper.PageInfo;

public interface BookService {
	
	List<UserCart> getUserCartObjListByList(List<CartBook> CartBookList);

	List<Book> getBookSuggestion(String keyWords);

	PageInfo<Book> getBookByKeywords(String keyWords, int page, int limit);
}
