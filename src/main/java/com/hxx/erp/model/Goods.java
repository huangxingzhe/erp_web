package com.hxx.erp.model;

import com.hxx.erp.util.Pinyin;

public class Goods {

	private int id;
	private String code;
	private String name;
	private int status;
	private String type;//表示产品的类型,如T十字绣 G杂货
	private String pinyin;
	private int providerId;//供应商ID
	private String providerName;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public int getProviderId() {
		return providerId;
	}
	public void setProviderId(int providerId) {
		this.providerId = providerId;
	}
	public String getProviderName() {
		return providerName;
	}
	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}
}
