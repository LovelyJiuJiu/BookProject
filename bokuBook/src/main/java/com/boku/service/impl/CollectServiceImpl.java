package com.boku.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boku.mapper.CollectMapper;
import com.boku.pojo.Collect;
import com.boku.service.CollectService;

@Service
public class CollectServiceImpl implements CollectService {

	@Autowired
	private CollectMapper collectMapper;
	
	@Override
	public List<Collect> getCollectList(Integer userId) {
		return collectMapper.getCollectList(userId);
	}

	@Override
	public int deleteBookInCollect(Integer bookId, Integer userId) {
		return collectMapper.deleteBookInCollect(bookId, userId);
	}

	@Override
	public int addBookInCollect(Integer bookId, Integer userId) {
		return collectMapper.addBookInCollect(bookId, userId);
	}
	

}
