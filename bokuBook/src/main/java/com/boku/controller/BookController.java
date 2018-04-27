package com.boku.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boku.mapper.BookMapper;
import com.boku.mapper.ReplyMapper;
import com.boku.pojo.Book;
import com.boku.pojo.Reply;
import com.boku.pojo.User;
import com.boku.pojo.UserReply;
import com.google.gson.Gson;

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
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");
			for(int i=0;i<userReplyList.size();i++) {
				String sDate=sdf.format(userReplyList.get(i).getReplytime().getTime());
				userReplyList.get(i).setDateStr(sDate);
			}
			modelAndView.addObject("userReplyList", userReplyList);
			modelAndView.setViewName("user/bookInfo");
		}
		return modelAndView;
	}
	
	@RequestMapping("addReply")
	@ResponseBody
	public String addReply(HttpSession session,@RequestParam int id,@RequestParam String replycontents){
		
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("id"+id);
		System.out.println("replycontents"+replycontents);
		Date date = new Date();
		System.out.println("date"+date);
		User user = (User) session.getAttribute("currentUser");
		Reply record = new Reply(id, user.getId(), replycontents, date);		
		result.put("result", replyMapper.insertSelective(record));
		return gson.toJson(result);
	}
	
}


