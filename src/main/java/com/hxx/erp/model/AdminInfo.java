package com.hxx.erp.model;

import java.io.Serializable;
/**
 * 用户信息
 */
public class AdminInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private Integer id;
	/**
	 * 登陆账号
	 */
	private String account;
	/**
	 * 登陆密码，md5加密
	 */
	private String password;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 手机
	 */
	private String phone;
	/**
	 * 电话
	 */
	private String tel;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 添加时间
	 */
	private String createTime;
	/**
	 * 状态：1正常，0冻结
	 */
	private int status;
	/**
	 * 角色id
	 */
	private String roleId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	
	
}
