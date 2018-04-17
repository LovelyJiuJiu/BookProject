package com.boku.controller;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.boku.mapper.BookMapper;
import com.boku.mapper.ReplyMapper;
import com.boku.pojo.Book;
import com.boku.pojo.UserReply;

@Controller
@RequestMapping("book")
public class BookController {
	
	@Autowired
	private BookMapper bookMapper;
	@Autowired
	private ReplyMapper replyMapper;

	@RequestMapping("bookInfo")
	public ModelAndView bookInfo(@RequestParam(value = "id") int id){
		ModelAndView modelAndView = new ModelAndView();
		
		//get bookObj
		Book book = bookMapper.selectByPrimaryKey(id);		
		modelAndView.addObject("book", book);
		
		if (book != null) {
			//get user and reply object order by replyTime		
			List<UserReply> userReplyList = replyMapper.selectByBookId(book.getId());
			modelAndView.addObject("userReplyList", userReplyList);
			modelAndView.setViewName("user/bookInfo");
		}
		return modelAndView;
	}
	
}


