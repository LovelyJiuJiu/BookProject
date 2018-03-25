package com.boku.service;

import java.util.List;

import com.boku.pojo.Category;

public interface CategoryService {

	List<Category> list(int id);
	
	Category login(Category category);
	
	int update(Category category);

}
