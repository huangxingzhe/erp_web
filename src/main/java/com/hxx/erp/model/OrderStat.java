package com.hxx.erp.model;

import java.util.Date;

public class OrderStat {
	private int id;
	private Date statDate;
	private double amount;//采购金额
	private double goodsMoney;//应收金额
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getStatDate() {
		return statDate;
	}
	public void setStatDate(Date statDate) {
		this.statDate = statDate;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getGoodsMoney() {
		return goodsMoney;
	}
	public void setGoodsMoney(double goodsMoney) {
		this.goodsMoney = goodsMoney;
	}
	

}
