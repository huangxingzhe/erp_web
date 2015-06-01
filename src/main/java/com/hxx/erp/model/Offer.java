package com.hxx.erp.model;

import java.util.Date;
//报价
public class Offer {
	private int id;
	private String productCN;
	private String productVN;
	private String discount;
	private Date createDate;
	private Date updateDate;
	private String mark;
	private String userName;
	private String providerName;//名称
	private String providerPhone;//电话
	private String providerUrl;//网址
	private String providerAddr;//地址
	private String providerUser;//联系人
	private double fee;//运费
	private double price;
	private String profit;//利润率
	private String format;//规格
	private String customerName;
	private String customerPhone;
	private String customerEmail;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProductCN() {
		return productCN;
	}
	public void setProductCN(String productCN) {
		this.productCN = productCN;
	}
	public String getProductVN() {
		return productVN;
	}
	public void setProductVN(String productVN) {
		this.productVN = productVN;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getProviderName() {
		return providerName;
	}
	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}
	public String getProviderPhone() {
		return providerPhone;
	}
	public void setProviderPhone(String providerPhone) {
		this.providerPhone = providerPhone;
	}
	public String getProviderUrl() {
		return providerUrl;
	}
	public void setProviderUrl(String providerUrl) {
		this.providerUrl = providerUrl;
	}
	public String getProviderAddr() {
		return providerAddr;
	}
	public void setProviderAddr(String providerAddr) {
		this.providerAddr = providerAddr;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getProfit() {
		return profit;
	}
	public void setProfit(String profit) {
		this.profit = profit;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getProviderUser() {
		return providerUser;
	}
	public void setProviderUser(String providerUser) {
		this.providerUser = providerUser;
	}
	public double getFee() {
		return fee;
	}
	public void setFee(double fee) {
		this.fee = fee;
	}
	
	
}
