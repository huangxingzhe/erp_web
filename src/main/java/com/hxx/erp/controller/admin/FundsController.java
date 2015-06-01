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
import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Funds;
import com.hxx.erp.model.FundsProcess;
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.FundsProcessService;
import com.hxx.erp.service.FundsService;
import com.hxx.erp.service.ProviderService;

@Controller
@RequestMapping("/admin/funds")
public class FundsController {
	private static final Log log = LogFactory.getLog(FundsController.class);
	@Autowired
	private FundsService service;
	@Autowired
	private FundsProcessService processService;
	@Autowired
	private ProviderService providerService;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				Funds funds = service.get(Integer.valueOf(id));
				model.addAttribute("funds", funds);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/funds/add";
	}
	
	@RequestMapping("/list")
	public String list(Model model){
		try {
			List<Funds> funds = service.queryList(null);
			model.addAttribute("funds", funds);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/funds/list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Funds funds){
		int ret = 0;
		try {
			Funds f = service.query(funds);
			if(f !=null && !f.getAccount().equals(funds.getAccount())){//已存在相同编号
				ret = 2;
				return ret;
			}
			if(funds.getId() == 0){
				service.add(funds);
			}else{
				service.update(funds);
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	@RequestMapping("/addMoney")
	public String addMoney(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		try {
			Funds funds = service.get(Integer.valueOf(id));
			model.addAttribute("funds", funds);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/funds/money";
	}
	
	@RequestMapping("/updateMoney")
	@ResponseBody
	public int updateMoney(@ModelAttribute Funds funds,HttpServletRequest request){
		int ret = 0;
		try {
			String mark = request.getParameter("mark");
			Funds f = service.get(funds.getId());
			double money = f.getOverMoney();
			if(funds.getType()==1||funds.getType()==2){
				money = money+funds.getMoney();
				f.setIncome(f.getIncome()+funds.getMoney());
			}else{
				money = money-funds.getMoney();
				f.setOutcome(f.getOutcome()+funds.getMoney());
			}
			f.setOverMoney(money);
			service.update(f);
			FundsProcess process = new FundsProcess();
			process.setAmount(funds.getMoney());
			process.setType(funds.getType());
			process.setCreateTime(new Date());
			process.setFundsName(f.getName());
			process.setMark(mark);
			process.setProviderName("");
			String userName = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_NAME);
			process.setUserId(userName);
			processService.add(process);
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
			int result = service.delete(id);
			if(result == 1){
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...",e);
		}
		return ret;
	}
	
	//资金流水
	@RequestMapping("/process")
	public String process(HttpServletRequest request,Model model){
		try {
			String fundsName = request.getParameter("fundsName");
			String type = request.getParameter("type");
			String providerName = request.getParameter("providerName");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("fundsName", fundsName);
			params.put("type", type);
			params.put("providerName", providerName);
			params.put("startTime", startTime);
			params.put("endTime", endTime);
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<FundsProcess> page = new Page<FundsProcess>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			params.put("page", page);
			
			List<FundsProcess> process = processService.queryListByPage(params);
			model.addAttribute("process", process);
			List<Provider> providers = providerService.queryList(null);
			model.addAttribute("providers", providers);
			model.addAttribute("fundsName", fundsName);
			model.addAttribute("type", type);
			model.addAttribute("providerName", providerName);
			model.addAttribute("startTime", startTime);
			model.addAttribute("endTime", endTime);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/funds/process";
	}
	
	@RequestMapping("/getOverMoney")
	@ResponseBody
	public String getOverMoney(HttpServletRequest request){
		String id = request.getParameter("id");
		if(StringUtils.isEmpty(id)){
			return "";
		}
		try {
			Funds fund = service.get(Integer.valueOf(id));
			if(fund!= null){
				DecimalFormat df = new DecimalFormat("#.00");
				return df.format(fund.getOverMoney());
			}
		} catch (Exception e) {
			log.error("",e);
		}
		return "";
	}
}
