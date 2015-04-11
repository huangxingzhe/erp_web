package com.hxx.erp.model;

public class UserRole {
	
	private int id;
	private int roleId;
	private int userId;
	
	public UserRole(){
		
	}
	
	public UserRole(int userId,int roleId){
		this.userId = userId;
		this.roleId = roleId;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	

}
