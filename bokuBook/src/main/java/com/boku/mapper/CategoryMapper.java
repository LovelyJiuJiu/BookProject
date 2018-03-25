package com.boku.mapper;
 
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.boku.pojo.Category;
 
public interface CategoryMapper {
 
   
    public int add(Category category);  
       
      
    public void delete(int id);  
       
      
    public List<Category> get(Map<String, String> map);  
     
      
    public int update(Category category);   
       
    @Select(" select * from   category_ where id <= #{id}")
    public List<Category> list(int id);
    
      
    public int count();  
    
    @Select("select * from   category_  where name = #{name} and password = #{password}")
    public Category login(Category category);
    
}