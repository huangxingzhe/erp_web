package com.hxx.erp.service.impl;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.hxx.erp.dao.FundsDao;
import com.hxx.erp.dao.FundsProcessDao;
import com.hxx.erp.dao.MoneyStatDao;
import com.hxx.erp.dao.OperationLogDao;
import com.hxx.erp.dao.OrderCustomerDao;
import com.hxx.erp.dao.OrderInfoDao;
import com.hxx.erp.model.Funds;
import com.hxx.erp.model.FundsProcess;
import com.hxx.erp.model.MoneyStat;
import com.hxx.erp.model.OperationLog;
import com.hxx.erp.model.OrderCustomer;
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.service.OrderInfoService;
import com.hxx.erp.util.DateUtil;

@Service
public class OrderInfoServiceImpl implements OrderInfoService {
	Log log = LogFactory.getLog(this.getClass());
	private static final DecimalFormat df = new DecimalFormat("#.00");
	@Autowired
	private OrderInfoDao dao;
	@Autowired
	private FundsDao fundsDao;
	@Autowired
	private FundsProcessDao processDao;
	@Autowired
	private OrderCustomerDao oCustomerDao;
	@Autowired
	private MoneyStatDao moneyStatDao;
	@Autowired
	private OperationLogDao opLogDao;

	@Override
	public int add(OrderInfo entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(OrderInfo entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public OrderInfo get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public OrderInfo query(OrderInfo entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<OrderInfo> list() throws Exception {
		return dao.list();
	}

	@Override
	public Map<String, Object> queryCount() {
		return dao.queryCount();
	}

	@Override
	public List<OrderInfo> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<OrderInfo> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}

	@Override
	public int updateType(int id, int type) throws Exception {
		return dao.updateType(id, type);
	}

	@Override
	public Map<String, Object> queryCountAndAmount() {
		return dao.queryCountAndAmount();
	}

	@Override
	public Map<String, Object> totalStat(Map<String, Object> params)
			throws Exception {
		return dao.totalStat(params);
	}

	@Override
	public String getMaxPayNo(Map<String, Object> params) throws Exception {
		return dao.getMaxPayNo(params);
	}

	@Override
	public Map<String, Object> countAllNumAndAmount() {
		return dao.countAllNumAndAmount();
	}

	@Override
	public Map<String, Object> moneyStat(Map<String, Object> params)
			throws Exception {
		return dao.moneyStat(params);
	}

	@Override
	public List<OrderInfo> queryStatByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryStatByPage(params);
	}

	@Override
	@Transactional
	public int addOrUpdate(OrderInfo order, String userName, String account,
			String[] cusIds, String[] sendNums, String[] realNums,
			String[] orderCodes, String[] empIds, String[] amounts,
			String[] payNos, String[] goodsNos, String oldAmount,
			String oldFee, String oldFundsId) {
		int ret = 0;
		Funds funds = fundsDao.get(order.getFundsId());
		if (order.getId() == 0) {// 添加
			double money = funds.getOverMoney();
			double outMoney = order.getAmount() + order.getFee();// 支出金额
			funds.setOutcome(funds.getOutcome() + outMoney);// 支出
			funds.setOverMoney(funds.getOverMoney() - outMoney);// 剩余金额
			fundsDao.update(funds);
			order.setStatus(1);// 待发货
			order.setCreateTime(new Date());
			order.setUpdateTime(new Date());
			if (!StringUtils.isEmpty(order.getGuiNo())) {
				order.setOrderType(1);
			}
			dao.add(order);
			if (outMoney != 0) {
				FundsProcess process = new FundsProcess();
				process.setAmount(outMoney);
				process.setBalance(funds.getOverMoney());
				process.setType(3);// 支出货款
				process.setCreateTime(new Date());
				process.setFundsName(funds.getName());
				process.setMark("合同编号:" + order.getPayNo() + ",共支付货款：￥"
						+ df.format(outMoney));
				process.setReceiveUser(order.getProviderName());

				process.setUserId(userName);
				processDao.add(process);
			}

			// }catch (Exception e) {
			// log.error("add order failed,rollback money", e);
			// funds.setOverMoney(money);
			// fundsDao.update(funds);
			// return ret = 0;
			// }
			for (int i = 0; i < cusIds.length; i++) {
				String empId = StringUtils.isEmpty(empIds) ? null : empIds[i];
				String cusPayNo = StringUtils.isEmpty(payNos) ? null
						: payNos[i];
				String goodsNo = StringUtils.isEmpty(goodsNos) ? null
						: goodsNos[i];
				addOrderCustomer(order, cusIds[i], orderCodes[i], amounts[i],
						sendNums[i], realNums[i], new Date(), empId, cusPayNo,
						goodsNo);
			}
			addOperationLog(order, account, 9);// 8新增订单类型
			ret = 1;
		} else { // 更新
			if (StringUtils.isEmpty(oldFundsId)) {
				return ret = 0;
			}
			double oldMoney = Double.valueOf(oldAmount)
					+ Double.valueOf(oldFee);// 更新前金额
			double amount = order.getAmount() + order.getFee();// 更新后的金额
			if (Integer.valueOf(oldFundsId) == order.getFundsId()) {// 新老账号为同一账号
				if (oldMoney != amount) {
					funds.setOutcome(funds.getOutcome() - oldMoney + amount);// 支出
					funds.setOverMoney(funds.getOverMoney() + oldMoney - amount);// 余额
					fundsDao.update(funds);

					double balance = amount - oldMoney;
					if (balance != 0) {
						// 记录更新金额日志
						FundsProcess process = new FundsProcess();
						process.setBalance(funds.getOverMoney());
						if (balance > 0) {// 说明还要支出金额
							process.setAmount(balance);
							process.setType(3);// 支出货款
							process.setReceiveUser(order.getProviderName());
							process.setMark("合同编号:" + order.getId()
									+ ",金额增加，扣除费用：￥" + df.format(balance));
						} else {// 退回部分金额
							process.setAmount(-balance);
							process.setType(1);// 转入货款
							process.setReceiveUser(funds.getName());
							process.setMark("合同编号:" + order.getId()
									+ ",金额减少，退回费用：￥" + df.format(-balance));
						}
						process.setCreateTime(new Date());
						process.setFundsName(funds.getName());
						process.setUserId(userName);
						processDao.add(process);
					}
				}
			} else {
				// 先把钱退回原来账号
				Funds oldF = fundsDao.get(Integer.valueOf(oldFundsId));
				oldF.setOutcome(oldF.getOutcome() - oldMoney);
				oldF.setOverMoney(oldF.getOverMoney() + oldMoney);
				fundsDao.update(oldF);
				// 退款日志
				if (oldMoney != 0) {
					FundsProcess back = new FundsProcess();
					back.setAmount(oldMoney);
					back.setBalance(oldF.getOverMoney());
					back.setType(1);// 退款转入
					back.setCreateTime(new Date());
					back.setFundsName(oldF.getName());
					back.setMark("合同编号:" + order.getId() + ",切换支付账号，退回费用：￥"
							+ df.format(oldMoney));
					back.setReceiveUser(oldF.getName());
					back.setUserId(userName);
					processDao.add(back);
				}
				// 减少新账号的余额
				funds.setOutcome(funds.getOutcome() + amount);
				funds.setOverMoney(funds.getOverMoney() - amount);
				fundsDao.update(funds);
				// 扣款日志
				if (amount != 0) {
					FundsProcess process = new FundsProcess();
					process.setAmount(amount);
					process.setBalance(funds.getOverMoney());
					process.setType(3);// 支出货款
					process.setCreateTime(new Date());
					process.setFundsName(funds.getName());
					process.setMark("合同编号:" + order.getId() + ",支付费用：￥"
							+ df.format(amount));
					process.setReceiveUser(order.getProviderName());
					process.setUserId(userName);
					processDao.add(process);
				}
			}
			order.setUpdateTime(new Date());
			dao.update(order);
			oCustomerDao.delete(order.getId());
			for (int i = 0; i < cusIds.length; i++) {
				String empId = StringUtils.isEmpty(empIds) ? null : empIds[i];
				String cusPayNo = StringUtils.isEmpty(payNos) ? null
						: payNos[i];
				String goodsNo = StringUtils.isEmpty(goodsNos) ? null
						: goodsNos[i];
				addOrderCustomer(order, cusIds[i], orderCodes[i], amounts[i],
						sendNums[i], realNums[i], order.getCreateTime(), empId,
						cusPayNo, goodsNo);
			}
			updateMoneyStat(order);
			addOperationLog(order, account, 10);// 9编辑订单类型
			ret = 1;
		}
		return ret;
	}

	// 统计金额
	public void updateMoneyStat(OrderInfo order) {
		if (order.getStatus() == 9) {// 交易完成
			Map<String, Object> params = new HashMap<String, Object>();
			String yearMonth = DateUtil.formatDate(order.getPayTime());
			params.put("status", order.getStatus());
			params.put("startTime", yearMonth);
			try {
				Map<String, Object> map = dao.moneyStat(params);
				double amount = Double.valueOf(df.format(map.get("amount")));// 采购金额
				double goodsMoney = Double.valueOf(df.format(map
						.get("goodsMoney")));// 销售金额
				double fee = Double.valueOf(df.format(map.get("fee")));// 转账手续费
				double cnFee = Double.valueOf(df.format(map.get("cnFare")));// 国内运费
				double vnFee = Double.valueOf(df.format(map.get("vnFare")));// 越南运费
				MoneyStat stat = new MoneyStat();
				stat.setYearMonth(yearMonth);
				stat = moneyStatDao.query(stat);
				if (stat != null) {
					stat.setBuyMoney(amount);
					stat.setReceiveMoney(goodsMoney);
					stat.setFee(fee);
					stat.setCnFee(cnFee);
					stat.setVnFee(vnFee);
					moneyStatDao.update(stat);
					log.info("update moneystat success,orderID:"
							+ order.getId());
				} else {
					MoneyStat money = new MoneyStat();
					money.setMonth(DateUtil.formatYearMonth(yearMonth));
					money.setBuyMoney(amount);
					money.setReceiveMoney(goodsMoney);
					money.setFee(fee);
					money.setCnFee(cnFee);
					money.setVnFee(vnFee);
					moneyStatDao.add(money);
				}
			} catch (Exception e) {
				log.error("update moneystat failed", e);
			}
		}
	}

	private void addOperationLog(OrderInfo order, String account, int item) {
		OperationLog opLog = new OperationLog();
		opLog.setAccount(account);
		opLog.setCreateTime(new Date());
		opLog.setItem(item);
		String content = "合同编号:" + order.getPayNo() + " 金额:"
				+ order.getAmount() + " 件数:" + order.getNum() + " 物流单号:"
				+ order.getLogisticsOrder() + " 国内运费:" + order.getCnFare()
				+ " 越南运费:" + order.getVnFare() + " 已收货款:"
				+ order.getReceiveMoney();
		opLog.setContent(content);
		try {
			opLogDao.add(opLog);
		} catch (Exception e) {
			log.error("add operation log error:", e);

		}

	}

	private void addOrderCustomer(OrderInfo order, String cusId,
			String orderCode, String amount, String sendNum, String realNum,
			Date createTime, String empId, String cusPayNo, String goodsNo) {
		OrderCustomer oc = new OrderCustomer();
		oc.setCusId(Integer.valueOf(cusId));
		oc.setOrderId(order.getId());
		oc.setOrderCode(orderCode);
		oc.setPayNo(cusPayNo);
		oc.setGoodsNo(goodsNo);
		if (!StringUtils.isEmpty(empId)) {
			oc.setEmpId(Integer.valueOf(empId));
		}
		if (StringUtils.isEmpty(amount)) {
			amount = "0.00";
		}
		oc.setAmount(Double.valueOf(amount));
		if (StringUtils.isEmpty(sendNum)) {
			sendNum = "0";
		}
		oc.setSendNum(Integer.valueOf(sendNum));
		if (StringUtils.isEmpty(realNum)) {
			realNum = "0";
		}
		oc.setRealNum(Integer.valueOf(realNum));
		oc.setCreateTime(createTime);
		oCustomerDao.add(oc);
	}
}
