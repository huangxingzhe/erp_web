package com.hxx.erp.model;

import com.hxx.erp.util.Pinyin;

public class Provider {
	
	private int id;
	private String code;
	private String name;
	private String address;
	private int status;
	private String pinyin;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
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
