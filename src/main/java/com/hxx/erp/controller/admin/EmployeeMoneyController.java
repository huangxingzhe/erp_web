package com.hxx.erp.controller.admin;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;

import com.hxx.erp.model.Customer;
import com.hxx.erp.model.EmpCutSetting;
import com.hxx.erp.model.Employee;
import com.hxx.erp.model.EmployeeMoney;
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.service.CustomerService;
import com.hxx.erp.service.EmpCutSettingService;
import com.hxx.erp.service.EmployeeService;
import com.hxx.erp.service.OrderInfoService;
import com.hxx.erp.util.Arith;
import com.hxx.erp.util.DateUtil;
/**
 * 按业务员统计业绩提成
 *
 */
@Controller
@RequestMapping("/admin/empMoney")
public class EmployeeMoneyController {
	private Log log = LogFactory.getLog(getClass());
	@Autowired
	private EmployeeService  empService;
	@Autowired
	private OrderInfoService orderService;
	@Autowired
	private EmpCutSettingService settingService;
	@Autowired
	private CustomerService cusService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		String empId = request.getParameter("empId");
		String empName = request.getParameter("empName");
		String goodsId = request.getParameter("goodsId");
		String goodsName = request.getParameter("goodsName");
		String type = request.getParameter("timeType");
		if(StringUtils.isEmpty(type)){
			return "/admin/order/emp_money_list";
		}
		int timeType = Integer.valueOf(type);
		
		String startTime = null;
		String endTime = null;
		String dayTime = request.getParameter("dayTime");
		String monthTime = request.getParameter("monthTime");
		String yearTime = request.getParameter("yearTime");
		if(timeType==1){//日查询
			startTime = dayTime;
			endTime = request.getParameter("endDateTime");
		}else if(timeType==2){//月查询
			startTime = monthTime +"-01";
			endTime = DateUtil.lastdayofmonth(monthTime);
		}else if(timeType==3){//年查询
			startTime = yearTime +"-01-01";
			endTime = yearTime +"-12-31";
		}
		List<EmployeeMoney> empMoneys = new ArrayList<EmployeeMoney>();
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		if(!StringUtils.isEmpty(goodsId)){
			params.put("goodsId", goodsId);
		}
		Map<String,List<EmpCutSetting>> settingMap = new HashMap<String,List<EmpCutSetting>>();
		try{
			if(StringUtils.isEmpty(empId)){//查所有员工业绩
				params.put("status", 1);
				List<Employee> emps = empService.queryList(params);
				if(emps!=null&&emps.size()>0){
					for(Employee e : emps){
						params.clear();
						params.put("empId", e.getId());
						params.put("startTime", startTime);
						params.put("endTime", endTime);
						List<OrderInfo> orders = orderService.queryList(params);
						EmployeeMoney em = new EmployeeMoney();
						em.setEmpName(e.getName());
						double buyMoney = 0,receiveMoney=0,cnFare=0,vnFare=0,cut=0;
						int num = 0;
						for(OrderInfo o : orders){
							buyMoney=Arith.add(buyMoney, o.getAmount());
							receiveMoney=Arith.add(receiveMoney, o.getGoodsMoney());
							vnFare=Arith.add(vnFare, o.getVnFare());
							cnFare=Arith.add(cnFare, o.getCnFare());
							num+=o.getNum();
							String key = o.getEmpId()+"-"+o.getGoodsId()+"-"+o.getCusId();
							List<EmpCutSetting> settings = settingMap.get(key);
							if(settings == null){
								params.clear();
								params.put("goodsId", o.getGoodsId());
								params.put("empId", o.getEmpId());
								params.put("cusId",o.getCusId());
								settings = settingService.queryList(params);
								if(settings!=null && settings.size()>0){
									settingMap.put(key, settings);
								}
							}
							//计算每笔订单实际提成
							cut = Arith.add(cut,getCut(o,settings,num,em));;
							
						}
						em.setBuyMoney(buyMoney);
						em.setReceiveMoney(receiveMoney);
						em.setCnFare(cnFare);
						em.setVnFare(vnFare);
						em.setCut(cut);
						empMoneys.add(em);
					}
				}
			}else{
				params.put("empId", empId);
				List<OrderInfo> orders = orderService.queryList(params);
				int num = 0;
				EmployeeMoney total = new EmployeeMoney();
				for(OrderInfo o : orders){
					EmployeeMoney em = new EmployeeMoney();
					em.setEmpName(empName);
					em.setBuyMoney(o.getAmount());
					em.setReceiveMoney(o.getGoodsMoney());
					em.setCnFare(o.getCnFare());
					em.setVnFare(o.getVnFare());
					em.setProfit(Arith.getValue(o.getGoodsMoney()-o.getAmount()-o.getCnFare()-o.getVnFare()));
					total.setTotalBuyMoney(Arith.add(total.getTotalBuyMoney(), o.getAmount()));
					total.setTotalReceiveMoney(Arith.add(total.getTotalReceiveMoney(), o.getGoodsMoney()));
					total.setTotalCnFare(Arith.add(total.getTotalCnFare(), o.getCnFare()));
					total.setTotalVnFare(Arith.add(total.getTotalVnFare(), o.getVnFare()));
					total.setTotalProfit(Arith.add(total.getTotalProfit(), Arith.getValue(o.getGoodsMoney()-o.getAmount()-o.getCnFare()-o.getVnFare())));
					String key = o.getEmpId()+"-"+o.getGoodsId()+"-"+o.getCusId();
					List<EmpCutSetting> settings = settingMap.get(key);
					
					String cusName = "";
					if(settings == null){
						params.clear();
						params.put("goodsId", o.getGoodsId());
						params.put("empId", o.getEmpId());
						params.put("cusId",o.getCusId());
						settings = settingService.queryList(params);
						if(settings!=null && settings.size()>0){
							cusName = settings.get(0).getCusName();
							settingMap.put(key, settings);
						}
					}
					em.setPayTime(o.getPayTime());
					//计算每笔订单实际提成
					em.setCut(getCut(o,settings,num,em));
					total.setTotalCut(Arith.add(total.getTotalCut(), em.getCut()));
					em.setPayNo(o.getPayNo());
					if(StringUtils.isEmpty(cusName)){
						Customer customer = cusService.get(o.getCusId());
						if(customer !=null)
							cusName = customer.getName();
					}
					em.setCusName(cusName);
					empMoneys.add(em);
					model.addAttribute("total", total);
				}
			}
		
		}catch(Exception e){
			log.error("",e);
		}
		model.addAttribute("timeType", timeType);
		model.addAttribute("type", timeType);
		model.addAttribute("dayTime", dayTime);
		model.addAttribute("monthTime", monthTime);
		model.addAttribute("yearTime", yearTime);
		model.addAttribute("empId", empId);
		model.addAttribute("empName", empName);
		model.addAttribute("goodsId", goodsId);
		model.addAttribute("goodsName", goodsName);
		model.addAttribute("empMoneys", empMoneys);
		return "/admin/order/emp_money_list";
	}
	
	private double getCut(OrderInfo order,List<EmpCutSetting> settings,int num,EmployeeMoney em){
		if(settings == null || settings.size()==0){
			return 0;
		}
		double cut = 0;
		if(settings.size()==1){
			EmpCutSetting setting = settings.get(0);
			if(setting.getType() == 1){//按折扣
				cut = order.getGoodsMoney()*(Double.valueOf(setting.getRate().replace("%", ""))/100);
			}else if(setting.getType() ==2){//按销量
				cut = order.getGoodsMoney()*(Double.valueOf(setting.getRate().replace("%", ""))/100);
			}
			em.setDiscount(setting.getDiscount());
			em.setRate(setting.getRate());
		}else{
			for(EmpCutSetting s : settings){
				em.setDiscount(s.getDiscount());
				em.setRate(s.getRate());
				if(s.getType() == 1){//按折扣
					cut = order.getGoodsMoney()*(Double.valueOf(s.getRate().replace("%", ""))/100);
					return cut;
				}else if(s.getType() ==2){//按销量
					String discount = s.getDiscount();
					if(discount!=null){
						String[] range = discount.split("-");
						if(num>=Integer.valueOf(range[0]) && num <=Integer.valueOf(range[1])){
							cut = order.getGoodsMoney()*(Double.valueOf(s.getRate().replace("%", ""))/100);
							return cut;
						}
					}
				}
			}
		}
		
		return cut;
		
	}

}
