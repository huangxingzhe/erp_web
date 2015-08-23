package com.hxx.erp.model;

import java.io.Serializable;
import java.util.Date;

public class GoodsGui implements Serializable {
    //
    private Integer id;

    //供应商
    private Integer providerId;

    //产品
    private Integer goodsId;

    //
    private Date createTime;

    //付款时间
    private String payTime;

    //柜号
    private String guiNo;

    //合同号
    private String payNo;

    //手续费
    private Double fee;

    //采购金额
    private Double buyAmount;

    //销售金额RMB
    private Double saleAmountCn;

    //销售金额VND
    private Double saleAmountVn;

    //余额
    private Double balance;

    //汇率
    private Double rate;

    //定金
    private Double deposit;

    //件数
    private Integer num;

    //中国港口
    private String cnPort;

    //越南港口
    private String vnPort;

    //制单人
    private String maker;

    //产品图片
    private String picUrl;

    //状态
    private Integer status;

    //备注
    private String demo;

    static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProviderId() {
        return providerId;
    }

    public void setProviderId(Integer providerId) {
        this.providerId = providerId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public String getGuiNo() {
        return guiNo;
    }

    public void setGuiNo(String guiNo) {
        this.guiNo = guiNo;
    }

    public String getPayNo() {
        return payNo;
    }

    public void setPayNo(String payNo) {
        this.payNo = payNo;
    }

    public Double getFee() {
        return fee;
    }

    public void setFee(Double fee) {
        this.fee = fee;
    }

    public Double getBuyAmount() {
        return buyAmount;
    }

    public void setBuyAmount(Double buyAmount) {
        this.buyAmount = buyAmount;
    }

    public Double getSaleAmountCn() {
        return saleAmountCn;
    }

    public void setSaleAmountCn(Double saleAmountCn) {
        this.saleAmountCn = saleAmountCn;
    }

    public Double getSaleAmountVn() {
        return saleAmountVn;
    }

    public void setSaleAmountVn(Double saleAmountVn) {
        this.saleAmountVn = saleAmountVn;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public Double getDeposit() {
        return deposit;
    }

    public void setDeposit(Double deposit) {
        this.deposit = deposit;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
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

    public String getMaker() {
        return maker;
    }

    public void setMaker(String maker) {
        this.maker = maker;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDemo() {
        return demo;
    }

    public void setDemo(String demo) {
        this.demo = demo;
    }
}