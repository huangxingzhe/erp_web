package com.hxx.erp.model;

import java.util.Date;


public class MoneyStat {
	private int id;
	private Date month;//月份
	private double buyMoney;//采购金额
	private double receiveMoney;//销售金额
	private double fee;//转账手续费
	private double cnFee;//国内运费
	private double vnFee;//越南运费
	private double rent;//房租
	private double salary;//工资
	private double safe;//保险
	private double water;//水电费
	private double tel;//电话费用
	private double ext;//其他费用
	private String mark;//备注
	private double manageFee;//管理杂费
	private double profit;//利润
	private double profitReceive;//利润占销售金额比
	private double profitBuy;//利润占采购金额比
	private String yearMonth;//年月
	private double receiveMOM;//销售环比
	private double buyMOM;//采购环比
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public Date getMonth() {
		return month;
	}
	public void setMonth(Date month) {
		this.month = month;
	}
	public double getBuyMoney() {
		return buyMoney;
	}
	public void setBuyMoney(double buyMoney) {
		this.buyMoney = buyMoney;
	}
	public double getReceiveMoney() {
		return receiveMoney;
	}
	public void setReceiveMoney(double receiveMoney) {
		this.receiveMoney = receiveMoney;
	}
	public double getFee() {
		return fee;
	}
	public void setFee(double fee) {
		this.fee = fee;
	}
	public double getCnFee() {
		return cnFee;
	}
	public void setCnFee(double cnFee) {
		this.cnFee = cnFee;
	}
	public double getVnFee() {
		return vnFee;
	}
	public void setVnFee(double vnFee) {
		this.vnFee = vnFee;
	}
	public double getRent() {
		return rent;
	}
	public void setRent(double rent) {
		this.rent = rent;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public double getSafe() {
		return safe;
	}
	public void setSafe(double safe) {
		this.safe = safe;
	}
	public double getWater() {
		return water;
	}
	public void setWater(double water) {
		this.water = water;
	}
	public double getTel() {
		return tel;
	}
	public void setTel(double tel) {
		this.tel = tel;
	}
	public double getExt() {
		return ext;
	}
	public void setExt(double ext) {
		this.ext = ext;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public double getManageFee() {
		return manageFee;
	}
	public void setManageFee(double manageFee) {
		this.manageFee = manageFee;
	}
	public double getProfit() {
		profit = receiveMoney -buyMoney-fee-cnFee-vnFee-manageFee-rent-salary-safe-tel-water-ext;
		return profit;
	}
	public void setProfit(double profit) {
		this.profit = profit;
	}
	public double getProfitReceive() {
		profitReceive = profit/receiveMoney;
		return profitReceive;
	}
	public void setProfitReceive(double profitReceive) {
		this.profitReceive = profitReceive;
	}
	public double getProfitBuy() {
		profitBuy = profit/buyMoney;
		return profitBuy;
	}
	public void setProfitBuy(double profitBuy) {
		this.profitBuy = profitBuy;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public double getReceiveMOM() {
		return receiveMOM;
	}
	public void setReceiveMOM(double receiveMOM) {
		this.receiveMOM = receiveMOM;
	}
	public double getBuyMOM() {
		return buyMOM;
	}
	public void setBuyMOM(double buyMOM) {
		this.buyMOM = buyMOM;
	}
	
	

	
}
