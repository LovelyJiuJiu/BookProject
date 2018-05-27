package com.boku.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.boku.pojo.Collect;
import com.boku.pojo.Reply;
import com.boku.pojo.User;
import com.boku.pojo.UserReply;
import com.boku.service.AdminService;
import com.boku.service.BookService;
import com.boku.service.CollectService;
import com.google.gson.Gson;

@Controller
@RequestMapping("book")
public class BookController {
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ReplyMapper replyMapper;

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private CollectService collectService;
	
	@RequestMapping("accessCountPage")
	public String cartPageTemp(){
		return "user/accessCountPage";
	}
	
	
	
	
	
	@RequestMapping("bookInfo")
	public ModelAndView bookInfo(@RequestParam(value = "id") int id,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		
		//get bookObj
		Book book = bookMapper.selectByPrimaryKey(id);	
		modelAndView.addObject("book", book);
		
		if (book != null) {
			//get user and reply object order by replyTime		
			List<UserReply> userReplyList = replyMapper.selectByBookId(book.getId());		
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for(int i=0;i<userReplyList.size();i++) {
				String sDate=sdf.format(userReplyList.get(i).getReplytime().getTime());
				userReplyList.get(i).setDateStr(sDate);
			}
			modelAndView.addObject("userReplyList", userReplyList);
			modelAndView.setViewName("user/bookInfo");
		}
		
		User user = (User) session.getAttribute("currentUser");
		if(user != null) {
			List<Collect> collectBook = collectService.getCollectList(user.getId());
			modelAndView.addObject("collectResult", 0);
			for (int i = 0; i<collectBook.size(); i++) {
				if (id == collectBook.get(i).getBookId()) {
					modelAndView.addObject("collectResult", 1);
				}
			}
		} else{
			modelAndView.addObject("collectResult", 0);
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
	
	@RequestMapping("salesCountPage")
	@ResponseBody
	public ModelAndView salesCountPage(){
		ModelAndView modelAndView = new ModelAndView("user/salesCountPage");		
		modelAndView.addObject("hotBookList", bookService.getHotBookAndCountList());
		return modelAndView;
	}
	
	
	@RequestMapping("classification")
	@ResponseBody
	public ModelAndView getClassificationList(){	
		ModelAndView modelAndView = new ModelAndView("user/classification");		
		modelAndView.addObject("typeList", adminService.getAllType());
		return modelAndView;
	}
	
	@RequestMapping("search")
	@ResponseBody
	public String search(String order,Integer type, Integer priceMin, Integer priceMax){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("bookList", bookService.seachBook(order, type, priceMin, priceMax));
		return gson.toJson(result);
	}
	
	@RequestMapping("addBookToCollect")
	@ResponseBody
	public String addBookToCollect(Integer bookId,HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		int resultCount = collectService.addBookInCollect(bookId, user.getId());
		result.put("result", resultCount);
		return gson.toJson(result);
	}
	
	
	@RequestMapping("delBookToCollect")
	@ResponseBody
	public String delBookToCollect(Integer bookId,HttpSession session){
		Gson gson = new Gson();
		Map<String, Object> result = new HashMap<String, Object>();
		User user = (User) session.getAttribute("currentUser");
		int resultCount = collectService.deleteBookInCollect(bookId, user.getId());
		result.put("result", resultCount);
		return gson.toJson(result);
	}
	
	
	@RequestMapping("myCollect")
	@ResponseBody
	public ModelAndView myCollect(HttpSession session){
		User user = (User) session.getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView("user/myCollect");	
		
		if(user!=null) {
			List<Collect> collectBook = collectService.getCollectList(user.getId());
			List<Integer> bookIds = new ArrayList<>();
			for(int i = 0;i <collectBook.size();i++) {
				bookIds.add(collectBook.get(i).getBookId());
			}
			modelAndView.addObject("bookList", bookMapper.getBookListByIds(bookIds));
		}
		return modelAndView;
	}
	
}


