package com.boku.service;

import java.util.List;
import com.boku.pojo.Collect;

public interface CollectService {
	
	List<Collect> getCollectList(Integer userId);
	
	int deleteBookInCollect(Integer bookId, Integer userId);
	
	int addBookInCollect(Integer bookId, Integer userId);
}
