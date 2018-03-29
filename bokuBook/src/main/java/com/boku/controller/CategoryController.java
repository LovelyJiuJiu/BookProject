package com.boku.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.boku.pojo.Category;
import com.boku.service.CategoryService;

// 告诉spring mvc这是一个控制器类
@Controller
@RequestMapping("")
public class CategoryController {
	@Autowired
	CategoryService categoryService;

	@RequestMapping("getInfo")
	@ResponseBody
	public String listCategory(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "5")int limit){
		Gson gson = new Gson();
		PageHelper.startPage(page, limit);
		List<Category> cs= categoryService.list(10);
		PageInfo<Category> pageInfo = new PageInfo<Category>(cs);
		System.out.println(gson.toJson(pageInfo));
		return gson.toJson(pageInfo);
	}
	
	@RequestMapping(value = "getInfo", method = RequestMethod.GET)
	public ModelAndView listCategory1(@RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = "5")int limit){
		Gson gson = new Gson();
		ModelAndView modelAndView = new ModelAndView("testLayui");
		PageHelper.startPage(page, limit);
		List<Category> cs= categoryService.list(10);
		PageInfo<Category> pageInfo = new PageInfo<Category>(cs);
		System.out.println(gson.toJson(pageInfo));
		modelAndView.addObject("page", pageInfo);
		return modelAndView;
	}
	
	@RequestMapping("user/test")
	public void demo(String sl, int lo){
		System.out.println(sl);
		System.out.println(lo);
	}
	
	@RequestMapping("login")
	@ResponseBody
	public Category userLogin(@RequestBody Category category){
		Category c = categoryService.login(category);
		return c;
	}
	
	@RequestMapping("update")
	@ResponseBody
	public String update(@RequestParam(value = "id") int id, 
						@RequestParam(value = "name") String name, 
						@RequestParam(value = "password") String password) {
		ModelAndView modelAndView = new ModelAndView();
		Category category = new Category();
		category.setId(id);
		category.setName(name);
		category.setPassword(password);
		int res = categoryService.update(category);
		System.out.println(res);
		return "listCategory";
	}

	@RequestMapping("testLayui")
	public String showTable(){
		return "testLayui";
	}
	
	@RequestMapping("bookMain")
	public String showIndex(){
		return "user/bookMain";
	}
}
