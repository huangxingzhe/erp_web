package com.hxx.erp.controller.admin;

import java.text.DecimalFormat;
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
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.service.FundsProcessService;
import com.hxx.erp.service.FundsService;
import com.hxx.erp.service.ManageFeeService;

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
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			List<Funds> funds = fundsService.queryList(null);
			if(!StringUtils.isEmpty(id)){
				ManageFee fee = service.get(Integer.valueOf(id));
				model.addAttribute("fee", fee);
			}
			model.addAttribute("funds", funds);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/order/fee_add";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String payAccount = request.getParameter("payAccount");
			String payNo = request.getParameter("payNo");
			String receiveUser = request.getParameter("receiveUser");
			
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<ManageFee> page = new Page<ManageFee>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("page", page);
			params.put("startDate", startDate);
			params.put("endDate", endDate);
			params.put("payAccount", payAccount);
			params.put("payNo", payNo);
			params.put("receiveUser", receiveUser);
			
			List<ManageFee> fees = service.queryListByPage(params);
			model.addAttribute("fees", fees);
			model.addAttribute("page",page);
			model.addAttribute("startDate",startDate);
			model.addAttribute("endDate",endDate);
			model.addAttribute("payAccount",payAccount);
			model.addAttribute("payNo",payNo);
			model.addAttribute("receiveUser",receiveUser);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/order/fee_list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute ManageFee fee,HttpServletRequest request){
		int ret = 0;
		try {
			String oldAmount = request.getParameter("oldAmount");
			String oldFundsId = request.getParameter("oldFundsId");
			String userName = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_NAME);
			ManageFee mf = service.query(fee);
			if(mf !=null && mf.getId()!=fee.getId()){//已存在相同编号
				ret = 2;
				return ret;
			}
			Funds funds = fundsService.get(fee.getFundsId());
			if(fee.getId() == 0){
				double money = funds.getOverMoney();
				funds.setOutcome(funds.getOutcome()+fee.getAmount());
				funds.setOverMoney(funds.getOverMoney()-fee.getAmount());
				fundsService.update(funds);
				try{
					fee.setUserName(userName);
					fee.setCreateTime(new Date());
					service.add(fee);
					
					FundsProcess process = new FundsProcess();
					process.setAmount(fee.getAmount());
					process.setType(3);//支出货款
					process.setCreateTime(new Date());
					process.setFundsName(funds.getName());
					process.setMark("共支付费用：￥"+df.format(fee.getAmount()));
					process.setProviderName(fee.getReceiveUser());
					
					process.setUserId(userName);
					processService.add(process);
				}catch(Exception e){
					log.error("add order failed,rollback money",e);
					funds.setOverMoney(money);
					fundsService.update(funds);
					return ret = 0;
				}
			}else{
				if(StringUtils.isEmpty(oldFundsId)){
					return ret=0;
				}	
				if(Integer.valueOf(oldFundsId) == fee.getFundsId()){//新老账号为同一账号
					if(Double.valueOf(oldAmount)!=fee.getAmount()){
						funds.setOutcome(funds.getOutcome()-Double.valueOf(oldAmount)+fee.getAmount());
						funds.setOverMoney(funds.getOverMoney()+Double.valueOf(oldAmount)-fee.getAmount());
						fundsService.update(funds);
					}
				}else{
					//先把钱退回原来账号
					Funds oldF = fundsService.get(Integer.valueOf(oldFundsId));
					oldF.setOutcome(oldF.getOutcome()-Double.valueOf(oldAmount));
					oldF.setOverMoney(oldF.getOverMoney()+Double.valueOf(oldAmount));
					fundsService.update(oldF);
					//减少新账号的余额
					funds.setOutcome(funds.getOutcome()+fee.getAmount());
					funds.setOverMoney(funds.getOverMoney()-fee.getAmount());
					fundsService.update(funds);
				}
				
				service.update(fee);
				
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam int id){
		String ret = "0";
		try {
			ManageFee fee = service.get(id);
			Funds funds = fundsService.get(fee.getFundsId());
			if(funds !=null){
				funds.setOutcome(funds.getOutcome()-fee.getAmount());
				funds.setOverMoney(funds.getOverMoney()+fee.getAmount());
				fundsService.update(funds);
			}
			int result = service.delete(id);
			if(result == 1){
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...",e);
		}
		return ret;
	}
	
}
