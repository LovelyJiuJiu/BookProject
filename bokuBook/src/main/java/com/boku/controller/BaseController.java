package com.boku.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boku.pojo.Book;
import com.boku.service.BookService;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;

// 告诉spring mvc这是一个控制器类
@Controller
@RequestMapping("")
public class BaseController {
	
	@Autowired
	private BookService bookService;
	
//	@RequestMapping("getInfo")
//	@ResponseBody
//	public String listCategory(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "5")int limit){
//		Gson gson = new Gson();
//		PageHelper.startPage(page, limit);
//		List<Category> cs= categoryService.list(10);
//		PageInfo<Category> pageInfo = new PageInfo<Category>(cs);
//		System.out.println(gson.toJson(pageInfo));
//		return gson.toJson(pageInfo);
//	}
	
//	@RequestMapping(value = "getInfo", method = RequestMethod.GET)
//	public ModelAndView listCategory1(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "5")int limit){
//		Gson gson = new Gson();
//		ModelAndView modelAndView = new ModelAndView("testLayui");
//		PageHelper.startPage(page, limit);
//		List<Category> cs= categoryService.list(10);
//		PageInfo<Category> pageInfo = new PageInfo<Category>(cs);
//		System.out.println(gson.toJson(pageInfo));
//		modelAndView.addObject("page", pageInfo);
//		return modelAndView;
//	}
	
	@RequestMapping("getSuggestion")
	@ResponseBody
	public String getSuggestion(String keyWords) {
		Gson gson = new Gson();
		List<Book> books = bookService.getBookSuggestion(keyWords);
		return gson.toJson(books);
	}
	
	@RequestMapping(value = "search", produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchBookByKeywords(String keyword, @RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "5") int limit) {
		Gson gson = new Gson();
		PageInfo<Book> books = bookService.getBookByKeywords(keyword, page, limit);
		System.out.println(gson.toJson(books));
		return gson.toJson(books);
	}
	
//	@RequestMapping("login")
//	@ResponseBody
//	public Category userLogin(@RequestBody Category category){
//		Category c = categoryService.login(category);
//		return c;
//	}
//	
//	@RequestMapping("update")
//	@ResponseBody
//	public String update(@RequestParam(value = "id") int id, 
//						@RequestParam(value = "name") String name, 
//						@RequestParam(value = "password") String password) {
//		ModelAndView modelAndView = new ModelAndView();
//		Category category = new Category();
//		category.setId(id);
//		category.setName(name);
//		category.setPassword(password);
//		int res = categoryService.update(category);
//		System.out.println(res);
//		return "listCategory";
//	}

	@RequestMapping("testLayui")
	public String showTable(){
		return "testLayui";
	}
	
	@RequestMapping("bookMain")
	public String showIndex(){
		return "user/bookMain";
	}
}
