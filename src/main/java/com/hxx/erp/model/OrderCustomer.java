package com.hxx.erp.model;

import java.util.List;


//客户订单信息
public class OrderCustomer {
	private int id;
	private String cusNo;
	private String cusName;
	private String orderCode;//客户每次下订单生成的订单编号
	private int sendNum=0;//发出订单件数
	private int realNum=0;//实际到货件数
	private double amount;
	private int orderId;
	private OrderInfo order;
	private List<OrderTime> times;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCusNo() {
		return cusNo;
	}
	public void setCusNo(String cusNo) {
		this.cusNo = cusNo;
	}
	public String getCusName() {
		return cusName;
	}
	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	public int getSendNum() {
		return sendNum;
	}
	public void setSendNum(int sendNum) {
		this.sendNum = sendNum;
	}
	public int getRealNum() {
		return realNum;
	}
	public void setRealNum(int realNum) {
		this.realNum = realNum;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public OrderInfo getOrder() {
		return order;
	}
	public void setOrder(OrderInfo order) {
		this.order = order;
	}
	public List<OrderTime> getTimes() {
		return times;
	}
	public void setTimes(List<OrderTime> times) {
		this.times = times;
	}

}
