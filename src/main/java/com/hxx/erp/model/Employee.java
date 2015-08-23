package com.hxx.erp.model;

import java.util.Date;

import com.hxx.erp.util.Pinyin;

/**
 * 员工
 * @author tommy
 */
public class Employee {
	private int id;
	private String name;
	private String phone;
	private String email;
	private Date entryDate;
	private Date createTime;
	private double salary;
	private int status;
	private int type;//1业务员 2行政
	private String pinyin;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	
	public String getPinyin() {
		if(pinyin==null)
			pinyin =Pinyin.getPinYinHeadChar(name);
		return pinyin;
	}
	public void setPinyin(String pinyin) {
		if(pinyin==null)
			pinyin =Pinyin.getPinYinHeadChar(name);
		this.pinyin = pinyin;
	}

}
