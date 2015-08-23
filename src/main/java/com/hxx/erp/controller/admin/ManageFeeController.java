package com.hxx.erp.controller.admin;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxx.erp.common.Constant;
import com.hxx.erp.common.Page;
import com.hxx.erp.model.Funds;
import com.hxx.erp.model.FundsProcess;
import com.hxx.erp.model.ManageFee;
import com.hxx.erp.model.MoneyStat;
import com.hxx.erp.service.FundsProcessService;
import com.hxx.erp.service.FundsService;
import com.hxx.erp.service.ManageFeeService;
import com.hxx.erp.service.MoneyStatService;
import com.hxx.erp.util.DateUtil;

@Controller
@RequestMapping("/admin/fee")
public class ManageFeeController {
	Log log = LogFactory.getLog(this.getClass());
	private static final DecimalFormat df = new DecimalFormat("#.00");
	@Autowired
	private ManageFeeService service;
	@Autowired
	private FundsService fundsService;
	@Autowired
	private FundsProcessService processService;
	@Autowired
	private MoneyStatService moneyService;

	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		try {
			String id = request.getParameter("id");
			List<Funds> funds = fundsService.queryList(null);
			if (!StringUtils.isEmpty(id)) {
				ManageFee fee = service.get(Integer.valueOf(id));
				model.addAttribute("fee", fee);
			}
			model.addAttribute("funds", funds);
		} catch (Exception e) {
			log.error("", e);
		}

		return "/admin/order/fee_add";
	}

	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
		try {
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String payAccount = request.getParameter("payAccount");
			String payNo = request.getParameter("payNo");
			String receiveUser = request.getParameter("receiveUser");

			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<ManageFee> page = new Page<ManageFee>();
			if (!StringUtils.isEmpty(pageCount)) {
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if (!StringUtils.isEmpty(currentPage)) {
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("page", page);
			params.put("startDate", startDate);
			params.put("endDate", endDate);
			params.put("payAccount", payAccount);
			params.put("payNo", payNo);
			params.put("receiveUser", receiveUser);

			List<ManageFee> fees = service.queryListByPage(params);
			model.addAttribute("fees", fees);
			model.addAttribute("page", page);
			model.addAttribute("startDate", startDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("payAccount", payAccount);
			model.addAttribute("payNo", payNo);
			model.addAttribute("receiveUser", receiveUser);
		} catch (Exception e) {
			log.error("", e);
		}
		return "/admin/order/fee_list";
	}

	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute ManageFee fee, HttpServletRequest request) {
		int ret = 0;
		try {
			String oldAmount = request.getParameter("oldAmount");
			String oldFundsId = request.getParameter("oldFundsId");
			String userName = (String) request.getSession().getAttribute(
					Constant.SESSION_LOGIN_ADMIN_NAME);
			ManageFee mf = service.query(fee);
			if (mf != null && mf.getId() != fee.getId()) {// 已存在相同编号
				ret = 2;
				return ret;
			}
			Funds funds = fundsService.get(fee.getFundsId());
			if (fee.getId() == 0) {
				double money = funds.getOverMoney();
				funds.setOutcome(funds.getOutcome() + fee.getAmount());
				funds.setOverMoney(funds.getOverMoney() - fee.getAmount());
				fundsService.update(funds);
				try {
					fee.setUserName(userName);
					fee.setCreateTime(new Date());
					service.add(fee);
					if (fee.getAmount() != 0) {
						FundsProcess process = new FundsProcess();
						process.setAmount(fee.getAmount());
						process.setBalance(funds.getOverMoney());
						process.setType(3);// 支出货款
						process.setCreateTime(new Date());
						process.setFundsName(funds.getName());
						process.setMark("共支付费用：￥" + df.format(fee.getAmount()));
						process.setReceiveUser(fee.getReceiveUser());
						process.setUserId(userName);
						processService.add(process);
					}
				} catch (Exception e) {
					log.error("add order failed,rollback money", e);
					funds.setOverMoney(money);
					fundsService.update(funds);
					return ret = 0;
				}
			} else {
				if (StringUtils.isEmpty(oldFundsId)) {
					return ret = 0;
				}
				if (Integer.valueOf(oldFundsId) == fee.getFundsId()) {// 新老账号为同一账号
					if (Double.valueOf(oldAmount) != fee.getAmount()) {
						funds.setOutcome(funds.getOutcome()
								- Double.valueOf(oldAmount) + fee.getAmount());
						funds.setOverMoney(funds.getOverMoney()
								+ Double.valueOf(oldAmount) - fee.getAmount());
						fundsService.update(funds);

						double balance = fee.getAmount()
								- Double.valueOf(oldAmount);
						// 记录更新金额日志
						FundsProcess process = new FundsProcess();
						process.setBalance(funds.getOverMoney());
						if (balance > 0) {// 说明还要支出金额
							process.setAmount(balance);
							process.setType(3);// 支出货款
							process.setReceiveUser(fee.getReceiveUser());
							process.setMark("费用id:" + fee.getId()
									+ ",金额增加，扣除费用：￥" + df.format(balance));
						} else {// 退回部分金额
							process.setAmount(-balance);
							process.setType(1);// 转入货款
							process.setReceiveUser(funds.getName());
							process.setMark("费用id:" + fee.getId()
									+ ",金额减少，退回费用：￥" + df.format(-balance));
						}
						process.setCreateTime(new Date());
						process.setFundsName(funds.getName());
						process.setUserId(userName);
						processService.add(process);
					}
				} else {
					// 先把钱退回原来账号
					Funds oldF = fundsService.get(Integer.valueOf(oldFundsId));
					oldF.setOutcome(oldF.getOutcome()
							- Double.valueOf(oldAmount));
					oldF.setOverMoney(oldF.getOverMoney()
							+ Double.valueOf(oldAmount));
					fundsService.update(oldF);
					// 退款日志
					if (Double.valueOf(oldAmount) != 0) {
						FundsProcess back = new FundsProcess();
						back.setAmount(Double.valueOf(oldAmount));
						back.setBalance(oldF.getOverMoney());
						back.setType(1);// 退款转入
						back.setCreateTime(new Date());
						back.setFundsName(oldF.getName());
						back.setMark("费用id:" + fee.getId() + ",切换支付账号，退回费用：￥"
								+ df.format(Double.valueOf(oldAmount)));
						back.setReceiveUser(oldF.getName());
						back.setUserId(userName);
						processService.add(back);
					}

					// 减少新账号的余额
					funds.setOutcome(funds.getOutcome() + fee.getAmount());
					funds.setOverMoney(funds.getOverMoney() - fee.getAmount());
					fundsService.update(funds);
					// 退款日志
					if (fee.getAmount() != 0) {
						FundsProcess process = new FundsProcess();
						process.setAmount(fee.getAmount());
						process.setBalance(funds.getOverMoney());
						process.setType(3);// 支出货款
						process.setCreateTime(new Date());
						process.setFundsName(funds.getName());
						process.setMark("费用id:" + fee.getId() + ",支付费用：￥"
								+ df.format(fee.getAmount()));
						process.setReceiveUser(fee.getReceiveUser());
						process.setUserId(userName);
						processService.add(process);
					}
				}
				service.update(fee);
			}
			//統計管理雜費
			updateMoneyStat(fee);
			ret = 1;// 操作成功
		} catch (Exception e) {
			log.error("", e);
		}
		return ret;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam int id) {
		String ret = "0";
		try {
			ManageFee fee = service.get(id);
			Funds funds = fundsService.get(fee.getFundsId());
			if (funds != null) {
				funds.setOutcome(funds.getOutcome() - fee.getAmount());
				funds.setOverMoney(funds.getOverMoney() + fee.getAmount());
				fundsService.update(funds);
			}
			int result = service.delete(id);
			if (result == 1) {
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...", e);
		}
		return ret;
	}

	// 统计金额
	public void updateMoneyStat(ManageFee mFee) {
		if(mFee.getType()!=2&&mFee.getType()!=4&&mFee.getType()!=5){
			return;
		}
		Map<String, Object> params = new HashMap<String, Object>();
		String yearMonth = DateUtil.formatDate(mFee.getPayTime());
		List<Integer> list = new ArrayList<Integer>();
		list.add(2);
		list.add(4);
		list.add(5);
		params.put("types", list);// 話費 手續費 樣品
		params.put("yearMonth", yearMonth);
		try {
			Map<String,Object> map = service.queryStat(params);
			if(map == null)
				return;
			double amount = Double.valueOf(df.format(map.get("amount")));
			MoneyStat stat = new MoneyStat();
			stat.setYearMonth(yearMonth);
			stat = moneyService.query(stat);
			if (stat != null) {
				stat.setManageFee(amount);
				moneyService.update(stat);
				log.info("update moneystat success,mFeeID:" +mFee.getId());
			} else {
				MoneyStat money = new MoneyStat();
				money.setMonth(DateUtil.formatYearMonth(yearMonth));
				money.setManageFee(amount);
				moneyService.add(money);
			}
		} catch (Exception e) {
			log.error("update moneystat failed", e);
		}
	}

}
