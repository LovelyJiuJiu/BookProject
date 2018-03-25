package com.boku.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.CategoryMapper;
import com.boku.pojo.Category;
import com.boku.service.CategoryService;

@Service
public class CategoryServiceImpl  implements CategoryService{
	@Autowired
	CategoryMapper categoryMapper;
	
	
	public List<Category> list(int id){
		return categoryMapper.list(id);
	}


	@Override
	public Category login(Category category) {
		return categoryMapper.login(category);
	}


	@Override
	public int update(Category category) {
		return categoryMapper.update(category);
	};

}
