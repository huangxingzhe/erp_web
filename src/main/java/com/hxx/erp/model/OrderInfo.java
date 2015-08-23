package com.hxx.erp.model;

import java.util.Date;
import java.util.List;

//货物订单信息
public class OrderInfo {
	private int id;
	private Date createTime;//创建时间
	private String payNo;//付款编号
	private double amount;//金额
	private String payTime;//付款时间
	private int providerId;//供应商ID
	private String providerName;//供应商名称
	private int goodsId;//物品ID
	private String goodsName;//物品名称
	private String userId;//操作员
	private Date updateTime;//更新时间
	private int num;//总数量
	private String borderAddr;//边界地址
	private String goalAddr;//目的地址
	private String receiveUser;//收货员
	private int status;//货物最新状态
	private String logisticsName;//物流名称
	private String logisticsOrder;//物流单号
	private String statTime;
	private int days;
	private String picUrl;//图片路径
	private String packageUrl;//包装图片
	private String borderAddrStr;//边界地址 ,只针对导出
	private String goalAddrStr;//目的地址 只针对导出
	private String borderLogistics;//边界货运名称
	private String borderPhone;//边界货运电话
	private double cnFare;//国内运费
	private double vnFare;//越南运费
	private double fee;//转账手续费
	private String getGoodsUser;//提货人
	private String cnReceiverPhone;//国内收货人电话
	private String vnReceiverPhone;//越南收货联系电话
	private double receiveMoney;//已收金额
	private double exchangeRate;//汇率
	private double goodsMoney;//应收金额
	private double vnMoney;//越南盾
	private double balance;//应收余额
	private String mark;//备注
	private int fundsId;//付款账户id
	private double profit;//利润率
	private String productUrl;//产品地址
	private List<OrderTime> times;
	private List<OrderCustomer> oCusList;
	private Date offerDate;//采购日期
	private String offerType;//采购联系方式
	private String salesMan;//业务员
	private String customerName;//客户名称
	private int cusId;//客户ID
	private int empId;
	private String guiNo;//货柜编号
	private String cnPort;//中国港口
	private String vnPort;//越南港口
	private int orderType;//0默认订单 1货柜订单
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getPayTime() {
		if(payTime !=null && payTime.length()>19){
			return payTime.substring(0, 19);
		}
		return payTime;
	}
	public void setPayTime(String payTime) {
		this.payTime = payTime;
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
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBorderAddr() {
		return borderAddr;
	}
	public void setBorderAddr(String borderAddr) {
		this.borderAddr = borderAddr;
	}
	public String getGoalAddr() {
		return goalAddr;
	}
	public void setGoalAddr(String goalAddr) {
		this.goalAddr = goalAddr;
	}
	public String getReceiveUser() {
		return receiveUser;
	}
	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getLogisticsName() {
		return logisticsName;
	}
	public void setLogisticsName(String logisticsName) {
		this.logisticsName = logisticsName;
	}
	public String getLogisticsOrder() {
		return logisticsOrder;
	}
	public void setLogisticsOrder(String logisticsOrder) {
		this.logisticsOrder = logisticsOrder;
	}
	public String getPayNo() {
		return payNo;
	}
	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}
	public String getStatTime() {
		return statTime;
	}
	public void setStatTime(String statTime) {
		this.statTime = statTime;
	}
	public int getDays() {
		Date date = null;
		if(status==8){
			date = updateTime;
		}else{
			date = new Date();
		}
		long time = date.getTime()-createTime.getTime();
		long day = 86400000;
		Long ret = (time%day==0)?time/day:(time/day+1);
		return ret.intValue();
	}
	public void setDays(int days) {
		this.days = days;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getBorderAddrStr() {
		if(borderAddr.equals("1")){
			return "东兴";
		}else if(borderAddr.equals("2")){
			return "凭祥";
		}else{
			return "";
		}
	}
	public void setBorderAddrStr(String borderAddrStr) {
		this.borderAddrStr = borderAddrStr;
	}
	public String getGoalAddrStr() {
		if(goalAddr.equals("1")){
			return "河内";
		}else if(goalAddr.equals("2")){
			return "胡志明";
		}else{
			return "";
		}
	}
	public void setGoalAddrStr(String goalAddrStr) {
		this.goalAddrStr = goalAddrStr;
	}
	public String getBorderLogistics() {
		return borderLogistics;
	}
	public void setBorderLogistics(String borderLogistics) {
		this.borderLogistics = borderLogistics;
	}
	public String getBorderPhone() {
		return borderPhone;
	}
	public void setBorderPhone(String borderPhone) {
		this.borderPhone = borderPhone;
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
	public String getGetGoodsUser() {
		return getGoodsUser;
	}
	public void setGetGoodsUser(String getGoodsUser) {
		this.getGoodsUser = getGoodsUser;
	}
	public String getCnReceiverPhone() {
		return cnReceiverPhone;
	}
	public void setCnReceiverPhone(String cnReceiverPhone) {
		this.cnReceiverPhone = cnReceiverPhone;
	}
	public String getVnReceiverPhone() {
		return vnReceiverPhone;
	}
	public void setVnReceiverPhone(String vnReceiverPhone) {
		this.vnReceiverPhone = vnReceiverPhone;
	}
	public double getReceiveMoney() {
		return receiveMoney;
	}
	public void setReceiveMoney(double receiveMoney) {
		this.receiveMoney = receiveMoney;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public double getProfit() {
		return profit;
	}
	public void setProfit(double profit) {
		this.profit = profit;
	}
	public List<OrderTime> getTimes() {
		return times;
	}
	public void setTimes(List<OrderTime> times) {
		this.times = times;
	}
	public double getFee() {
		return fee;
	}
	public void setFee(double fee) {
		this.fee = fee;
	}
	public List<OrderCustomer> getoCusList() {
		return oCusList;
	}
	public void setoCusList(List<OrderCustomer> oCusList) {
		this.oCusList = oCusList;
	}
	public int getFundsId() {
		return fundsId;
	}
	public void setFundsId(int fundsId) {
		this.fundsId = fundsId;
	}
	public double getExchangeRate() {
		return exchangeRate;
	}
	public void setExchangeRate(double exchangeRate) {
		this.exchangeRate = exchangeRate;
	}
	public double getGoodsMoney() {
		return goodsMoney;
	}
	public void setGoodsMoney(double goodsMoney) {
		this.goodsMoney = goodsMoney;
	}
	
	public double getVnMoney() {
		return goodsMoney * exchangeRate;
	}
	public void setVnMoney(double vnMoney) {
		this.vnMoney = vnMoney;
	}
	public double getBalance() {
		return getVnMoney()-receiveMoney;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getProductUrl() {
		return productUrl;
	}
	public void setProductUrl(String productUrl) {
		this.productUrl = productUrl;
	}
	public Date getOfferDate() {
		return offerDate;
	}
	public void setOfferDate(Date offerDate) {
		this.offerDate = offerDate;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getPackageUrl() {
		return packageUrl;
	}
	public void setPackageUrl(String packageUrl) {
		this.packageUrl = packageUrl;
	}
	public String getSalesMan() {
		return salesMan;
	}
	public void setSalesMan(String salesMan) {
		this.salesMan = salesMan;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getCusId() {
		return cusId;
	}
	public void setCusId(int cusId) {
		this.cusId = cusId;
	}
	public String getGuiNo() {
		return guiNo;
	}
	public void setGuiNo(String guiNo) {
		this.guiNo = guiNo;
	}
	public String getCnPort() {
		return cnPort;
	}
	public void setCnPort(String cnPort) {
		this.cnPort = cnPort;
	}
	public String getVnPort() {
		return vnPort;
	}
	public void setVnPort(String vnPort) {
		this.vnPort = vnPort;
	}
	public int getOrderType() {
		return orderType;
	}
	public void setOrderType(int orderType) {
		this.orderType = orderType;
	}

}
