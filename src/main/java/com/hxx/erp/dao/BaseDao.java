package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

public interface BaseDao<T> {
	 /**
     * 对对象进行持久化操作，如果成功则返回持久化后的ID
     * 失败则返回null
     * @param obj
     * @return
     */
    int add(T obj);
    
    
    /**
     * 删除指定id的持久化对象
     * @param id
     */
    int delete(int id);
    int delete(long id);
    
    
    /**
     * 修改指定的持久化对象
     * @param id
     * @param obj
     */
    int update(T obj);
    
    /**
     * 返回持久化对象
     * @param id
     * @return 找到则返回，否则返回空
     */
    T get(Integer id);
    
    T get(long id);
    
    
    /**
     * 返回所有持久化对象
     * @return
     */
    List<T> list();
    
    T query(T entity);
    List<T> queryList(Map<String,Object> params);

}
