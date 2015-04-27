package com.hxx.erp.model;

public class Funds {

	private int id;
	private String account;
	private String name;
	private String address;
	private int status;
	private double income;//收入
	private double outcome;//支出
	private double overMoney;//余额
	private int type ;//类型
	private double money;//增加或减少的钱
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
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
	public double getIncome() {
		return income;
	}
	public void setIncome(double income) {
		this.income = income;
	}
	public double getOutcome() {
		return outcome;
	}
	public void setOutcome(double outcome) {
		this.outcome = outcome;
	}
	public double getOverMoney() {
		return overMoney;
	}
	public void setOverMoney(double overMoney) {
		this.overMoney = overMoney;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}

	
	
}
