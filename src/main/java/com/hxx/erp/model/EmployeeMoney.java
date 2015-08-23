package com.hxx.erp.model;
//业务员提成临时类
public class EmployeeMoney { 
	private int id;
	private int empId;
	private String empName;
	private double buyMoney;//采购金额
	private double receiveMoney;//应收金额
	private double cnFare;
	private double vnFare;
	private double profit;
	private double cut;//提成
	private double salary;
	private double entry;//考勤
	private double income;//实际收入
	private int type; //计算方法
	private String discount;//计算范围
	private String rate;//提成比
	private double totalBuyMoney;
	private double totalReceiveMoney;
	private double totalCnFare;
	private double totalVnFare;
	private double totalProfit;
	private double totalCut;
	private String payNo;//合同编号
	private String cusName;//客户名称
	private String payTime;
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
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
	public double getCnFare() {
		return cnFare;
	}
	public void setCnFare(double cnFare) {
		this.cnFare = cnFare;
	}
	public double getVnFare() {
		return vnFare;
	}
	public void setVnFare(double vnFare) {
		this.vnFare = vnFare;
	}
	public double getProfit() {
		return profit;
	}
	public void setProfit(double profit) {
		this.profit = profit;
	}
	public double getCut() {
		return cut;
	}
	public void setCut(double cut) {
		this.cut = cut;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public double getEntry() {
		return entry;
	}
	public void setEntry(double entry) {
		this.entry = entry;
	}
	public double getIncome() {
		return income;
	}
	public void setIncome(double income) {
		this.income = income;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getTotalBuyMoney() {
		return totalBuyMoney;
	}
	public void setTotalBuyMoney(double totalBuyMoney) {
		this.totalBuyMoney = totalBuyMoney;
	}
	public double getTotalReceiveMoney() {
		return totalReceiveMoney;
	}
	public void setTotalReceiveMoney(double totalReceiveMoney) {
		this.totalReceiveMoney = totalReceiveMoney;
	}
	public double getTotalCnFare() {
		return totalCnFare;
	}
	public void setTotalCnFare(double totalCnFare) {
		this.totalCnFare = totalCnFare;
	}
	public double getTotalVnFare() {
		return totalVnFare;
	}
	public void setTotalVnFare(double totalVnFare) {
		this.totalVnFare = totalVnFare;
	}
	public double getTotalProfit() {
		return totalProfit;
	}
	public void setTotalProfit(double totalProfit) {
		this.totalProfit = totalProfit;
	}
	public double getTotalCut() {
		return totalCut;
	}
	public void setTotalCut(double totalCut) {
		this.totalCut = totalCut;
	}
	public String getPayNo() {
		return payNo;
	}
	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}
	public String getCusName() {
		return cusName;
	}
	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	public String getPayTime() {
		return payTime;
	}
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	
}
