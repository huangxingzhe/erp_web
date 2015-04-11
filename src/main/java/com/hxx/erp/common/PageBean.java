package com.hxx.erp.common;

import java.util.List;

/**
 * 分页实体类
 * 
 * @author Administrator
 * 
 */
public class PageBean<T> {
	
	private T entity;
	
	/**
	 * 每页的大小
	 */
	private Integer pageNo;
	/**
	 * 当前页
	 */
	private Integer page;

	/**
	 * 总记录数
	 */
	private Integer total;

	/**
	 * 当前页的数据
	 */
	private List<T> rows;

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public T getEntity() {
		return entity;
	}

	public void setEntity(T entity) {
		this.entity = entity;
	}

}
