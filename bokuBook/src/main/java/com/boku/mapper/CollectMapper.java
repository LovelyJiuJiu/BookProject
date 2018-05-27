package com.boku.mapper;

import java.util.List;

import com.boku.pojo.Collect;

public interface CollectMapper {

	List<Collect> getCollectList(Integer userId);
	
	int deleteBookInCollect(Integer bookId, Integer userId);
	
	int addBookInCollect(Integer bookId, Integer userId);
}