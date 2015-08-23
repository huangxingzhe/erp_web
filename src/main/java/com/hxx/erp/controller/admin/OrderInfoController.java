package com.hxx.erp.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hxx.erp.common.Constant;
import com.hxx.erp.common.ExportData;
import com.hxx.erp.common.Page;
import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Employee;
import com.hxx.erp.model.Funds;
import com.hxx.erp.model.FundsProcess;
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.MoneyStat;
import com.hxx.erp.model.OperationLog;
import com.hxx.erp.model.OrderCustomer;
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.model.OrderTime;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.CustomerService;
import com.hxx.erp.service.EmployeeService;
import com.hxx.erp.service.FundsProcessService;
import com.hxx.erp.service.FundsService;
import com.hxx.erp.service.GoodsService;
import com.hxx.erp.service.MoneyStatService;
import com.hxx.erp.service.OperationLogService;
import com.hxx.erp.service.OrderCustomerService;
import com.hxx.erp.service.OrderInfoService;
import com.hxx.erp.service.OrderTimeService;
import com.hxx.erp.service.ProviderService;
import com.hxx.erp.util.DateUtil;
import com.hxx.erp.util.HttpClientUtil;

@Controller
@RequestMapping("/admin/order")
public class OrderInfoController {
Log log = LogFactory.getLog(this.getClass());
	@Autowired
	private OrderInfoService service;
	@Autowired
	private ProviderService providerService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private OrderCustomerService oCusService;
	@Autowired
	private OrderTimeService orderTimeService;
	@Autowired
	private OperationLogService opService;
	@Autowired
	private FundsService fundsService;
	@Autowired
	private FundsProcessService processService;
	@Autowired
	private MoneyStatService moneyService;
	@Autowired
	private EmployeeService employeeService;
	private static final DecimalFormat df = new DecimalFormat("#.00");
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		String detail = request.getParameter("type");
		String status = request.getParameter("status");
		String orderType = request.getParameter("orderType");
		try {
			String id = request.getParameter("id");
			
			List<Funds> funds = fundsService.queryList(null);
			List<Employee> employees = employeeService.queryList(null);
			model.addAttribute("funds", funds);
			model.addAttribute("status", status);
			model.addAttribute("employees", employees);
			if(!StringUtils.isEmpty(id)){
				OrderInfo orderInfo = service.get(Integer.valueOf(id));
				orderInfo.setTimes(orderTimeService.getByOrderId(Integer.valueOf(id)));
				model.addAttribute("order", orderInfo);
				Map<String,Object> params = new HashMap<String,Object>();
				params.put("orderId", id);
				List<OrderCustomer> orderCustomers = oCusService.queryList(params);
				model.addAttribute("orderCustomers", orderCustomers);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		if(StringUtils.isEmpty(orderType)){
			if(StringUtils.isEmpty(detail)){
				return "/admin/order/add";
			}else{
				return "/admin/order/detail";
			}
		}else{
			if(StringUtils.isEmpty(detail)){
				return "/admin/order/gui_add";
			}else{
				return "/admin/order/gui_detail";
			}
		}
		
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute OrderInfo order,HttpServletRequest request){
		int ret = 0;
		try {
			String[] cusIds = request.getParameterValues("cusIds");
			String[] sendNums = request.getParameterValues("sendNums");
			String[] realNums = request.getParameterValues("realNums");
			String[] orderCodes = request.getParameterValues("orderCodes");
			String[] empIds = request.getParameterValues("empIds");
			String[] amounts = request.getParameterValues("amounts");
			String oldAmount = request.getParameter("oldAmount");
			String oldFee = request.getParameter("oldFee");
			String oldFundsId = request.getParameter("oldFundsId");
			if(StringUtils.isEmpty(cusIds)){
				ret = 2;
				return ret;
			}
			if(cusIds.length!=sendNums.length ||cusIds.length!=realNums.length 
					||cusIds.length!=orderCodes.length||cusIds.length!=amounts.length){
				ret = 2;
				return ret;
			}
			
			String account = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ACCOUNT);
			String userName = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_NAME);
			Funds funds = fundsService.get(order.getFundsId());
			if(order.getId() == 0){//添加
				double money = funds.getOverMoney();
				double outMoney = order.getAmount()+order.getFee();//支出金额
				funds.setOutcome(funds.getOutcome()+outMoney);//支出
				funds.setOverMoney(funds.getOverMoney()-outMoney);//剩余金额
				fundsService.update(funds);
				order.setStatus(1);//待发货
				order.setCreateTime(new Date());
				order.setUpdateTime(new Date());
				try{
					if(!StringUtils.isEmpty(order.getGuiNo())){
						order.setOrderType(1);
					}
					service.add(order);
					if(outMoney !=0){
						FundsProcess process = new FundsProcess();
						process.setAmount(outMoney);
						process.setBalance(funds.getOverMoney());
						process.setType(3);//支出货款
						process.setCreateTime(new Date());
						process.setFundsName(funds.getName());
						process.setMark("合同编号:"+order.getPayNo()+",共支付货款：￥"+df.format(outMoney));
						process.setReceiveUser(order.getProviderName());
						
						process.setUserId(userName);
						processService.add(process);
					}
				}catch(Exception e){
					log.error("add order failed,rollback money",e);
					funds.setOverMoney(money);
					fundsService.update(funds);
					return ret = 0;
				}
				for(int i=0;i<cusIds.length;i++){
					String empId = StringUtils.isEmpty(empIds)?null:empIds[i];
					addOrderCustomer(order,cusIds[i],orderCodes[i],amounts[i],sendNums[i],realNums[i],new Date(),empId);
				}
				addOperationLog(order,account,9);//8新增订单类型
			}else{ //更新
				if(StringUtils.isEmpty(oldFundsId)){
					return ret=0;
				}	
				double oldMoney = Double.valueOf(oldAmount) +Double.valueOf(oldFee);//更新前金额
				double amount = order.getAmount() + order.getFee();//更新后的金额
				if(Integer.valueOf(oldFundsId) == order.getFundsId()){//新老账号为同一账号
					if(oldMoney!=amount){
						funds.setOutcome(funds.getOutcome()-oldMoney+amount);//支出
						funds.setOverMoney(funds.getOverMoney()+oldMoney-amount);//余额
						fundsService.update(funds);
						
						double balance = amount-oldMoney;
						if(balance !=0){
							//记录更新金额日志
							FundsProcess process = new FundsProcess();
							process.setBalance(funds.getOverMoney());
							if(balance >0){//说明还要支出金额
								process.setAmount(balance);
								process.setType(3);//支出货款
								process.setReceiveUser(order.getProviderName());
								process.setMark("合同编号:"+order.getId()+",金额增加，扣除费用：￥"+df.format(balance));
							}else{//退回部分金额
								process.setAmount(-balance);
								process.setType(1);//转入货款
								process.setReceiveUser(funds.getName());
								process.setMark("合同编号:"+order.getId()+",金额减少，退回费用：￥"+df.format(-balance));
							}
							process.setCreateTime(new Date());
							process.setFundsName(funds.getName());
							process.setUserId(userName);
							processService.add(process);
						}
					}
				}else{
					//先把钱退回原来账号
					Funds oldF = fundsService.get(Integer.valueOf(oldFundsId));
					oldF.setOutcome(oldF.getOutcome()-oldMoney);
					oldF.setOverMoney(oldF.getOverMoney()+oldMoney);
					fundsService.update(oldF);
					//退款日志
					if(oldMoney!=0){
						FundsProcess back = new FundsProcess();
						back.setAmount(oldMoney);
						back.setBalance(oldF.getOverMoney());
						back.setType(1);//退款转入
						back.setCreateTime(new Date());
						back.setFundsName(oldF.getName());
						back.setMark("合同编号:"+order.getId()+",切换支付账号，退回费用：￥"+df.format(oldMoney));
						back.setReceiveUser(oldF.getName());
						back.setUserId(userName);
						processService.add(back);
					}
					//减少新账号的余额
					funds.setOutcome(funds.getOutcome()+amount);
					funds.setOverMoney(funds.getOverMoney()-amount);
					fundsService.update(funds);
					//扣款日志
					if(amount !=0){
						FundsProcess process = new FundsProcess();
						process.setAmount(amount);
						process.setBalance(funds.getOverMoney());
						process.setType(3);//支出货款
						process.setCreateTime(new Date());
						process.setFundsName(funds.getName());
						process.setMark("合同编号:"+order.getId()+",支付费用：￥"+df.format(amount));
						process.setReceiveUser(order.getProviderName());
						process.setUserId(userName);
						processService.add(process);
					}
				}
				order.setUpdateTime(new Date());
				service.update(order);
				oCusService.delete(order.getId());
				for(int i=0;i<cusIds.length;i++){
					String empId = StringUtils.isEmpty(empIds)?null:empIds[i];
					addOrderCustomer(order,cusIds[i],orderCodes[i],amounts[i],sendNums[i],realNums[i],order.getCreateTime(),empId);
				}
				updateMoneyStat(order);
				addOperationLog(order,account,10);//9编辑订单类型
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	private void addOrderCustomer(OrderInfo order,String cusId,String orderCode,
			String amount,String sendNum,String realNum,Date createTime,String empId) throws Exception{
		OrderCustomer oc = new OrderCustomer();
		oc.setCusId(Integer.valueOf(cusId));
		oc.setOrderId(order.getId());
		oc.setOrderCode(orderCode);
		if(!StringUtils.isEmpty(empId)){
			oc.setEmpId(Integer.valueOf(empId));
		}
		if(StringUtils.isEmpty(amount)){
			amount = "0.00";
		}
		oc.setAmount(Double.valueOf(amount));
		if(StringUtils.isEmpty(sendNum)){
			sendNum = "0";
		}
		oc.setSendNum(Integer.valueOf(sendNum));
		if(StringUtils.isEmpty(realNum)){
			realNum = "0";
		}
		oc.setRealNum(Integer.valueOf(realNum));
		oc.setCreateTime(createTime);
		oCusService.add(oc);
	}
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		String status = (String)request.getParameter("status");
		String cusNo = request.getParameter("cusNo");
		String payNo = request.getParameter("payNo");
		String orderCode = request.getParameter("orderCode");//客户订单号
		String salesMan = request.getParameter("salesMan");
		String goodsName = request.getParameter("goodsName");
		String logisticsOrder = request.getParameter("logisticsOrder");
		String logisticsName = request.getParameter("logisticsName");
		String providerName = request.getParameter("providerName");
		String startPayTime = request.getParameter("startPayTime");
		String endPayTime = request.getParameter("endPayTime");
		String orderType = request.getParameter("orderType");//0默认订单，1货柜订单
		if(StringUtils.isEmpty(orderType)){
			orderType = "0";
		}
		String guiNo = request.getParameter("guiNo");//货柜编号
		String currentPage = request.getParameter("currentPage");
		String pageCount = request.getParameter("pageCount");
		try {
			if(StringUtils.isEmpty(status)){
				status="1";
			}
			Map<String,Object> params = new HashMap<String,Object>();
			if(!"11".equals(status)){
				params.put("status", status);
			}
			params.put("payNo", payNo);
			params.put("goodsName", goodsName);
			params.put("salesMan", salesMan);
			params.put("logisticsOrder", logisticsOrder);
			params.put("logisticsName", logisticsName);
			params.put("providerName",providerName );
			params.put("startPayTime",startPayTime);
			params.put("endPayTime",endPayTime);
			params.put("orderType", orderType);
			params.put("guiNo", guiNo);
			if(!StringUtils.isEmpty(cusNo)){
				params.put("cusNo",cusNo);
			}
			if(!StringUtils.isEmpty(orderCode)){
				params.put("orderCode",orderCode);
			}
			Page<OrderInfo> page = new Page<OrderInfo>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			params.put("page", page);
			
			List<OrderInfo> orderInfos = service.queryListByPage(params);
			
			int nums = 0;
			double amounts = 0;
			double goodsMoney =0;
			Map<String,Object> orderIdParam = new HashMap<String,Object>();
			for(OrderInfo o: orderInfos){
				nums+=o.getNum();
				amounts+=o.getAmount();
				goodsMoney+=o.getGoodsMoney();
				if(o.getGoodsMoney()>0){
					double all = o.getAmount()+o.getCnFare()+o.getVnFare()+o.getFee();
					o.setProfit((o.getGoodsMoney()-all)/o.getGoodsMoney());
				}else{
					o.setProfit(0);
				}
				orderIdParam.put("orderId", o.getId());
				List<OrderCustomer> oCusList = oCusService.queryList(orderIdParam);
				o.setoCusList(oCusList);
				orderIdParam.clear();
				
			}
			model.addAttribute("orders", orderInfos);
			model.addAttribute("page",page);
			List<Provider> providers = providerService.queryList(null);
			model.addAttribute("providers", providers);
			List<Goods> goods = goodsService.queryList(null);
			model.addAttribute("goodss", goods);
			model.addAttribute("status", status);
			model.addAttribute("cusNo", cusNo);
			model.addAttribute("payNo", payNo);
			model.addAttribute("orderCode", orderCode);
			model.addAttribute("salesMan", salesMan);
			model.addAttribute("goodsName", goodsName);
			model.addAttribute("logisticsOrder", logisticsOrder);
			model.addAttribute("logisticsName", logisticsName);
			model.addAttribute("providerName", providerName);
			model.addAttribute("startPayTime", startPayTime);
			model.addAttribute("endPayTime", endPayTime);
			model.addAttribute("nums", nums);
			model.addAttribute("orderType", orderType);
			model.addAttribute("guiNo", guiNo);
			model.addAttribute("amounts", df.format(amounts));
			model.addAttribute("goodsMoney", df.format(goodsMoney));
			//如果大于1页才去查
			if(orderInfos!=null && orderInfos.size()>=page.getPageCount()){
				Map<String,Object> statMap = service.totalStat(params);
				model.addAttribute("totalNums", statMap.get("num"));
				model.addAttribute("totalAmounts", df.format(statMap.get("amount")));
				model.addAttribute("totalGoodsMoney", df.format(statMap.get("goodsMoney")));
			}else{
				model.addAttribute("totalNums", nums);
				model.addAttribute("totalAmounts", df.format(amounts));
				model.addAttribute("totalGoodsMoney", df.format(goodsMoney));
			}
			
			
			
		} catch (Exception e) {
			log.error("",e);
		}
		if(!StringUtils.isEmpty(orderType)){
			return "/admin/order/gui_list"; 
		}
		if("11".equals(status)){ //订单查询页面
			return "/admin/order/all_list";
		}else{
			return "/admin/order/list";
		}
		
	}
	
	//客户或客服查询接口
	@RequestMapping("/query")
	public String query(HttpServletRequest request,Model model){
		String type = request.getParameter("type");
		if("init".equals(type)){
			return "/admin/order/query";
		}
		String orderCode = request.getParameter("orderCode");//客户订单号
		String cusNo = request.getParameter("cusNo");
		String cusName = request.getParameter("cusName");
		String payNo = request.getParameter("payNo");
		String orderType = request.getParameter("orderType");//0默认订单，1货柜订单
		String guiNo = request.getParameter("guiNo");//货柜编号
		String logisticsOrder = request.getParameter("logisticsOrder");
		if(StringUtils.isEmpty(orderCode)&&StringUtils.isEmpty(cusNo)&&
				StringUtils.isEmpty(cusName)&&StringUtils.isEmpty(payNo)&&
				StringUtils.isEmpty(logisticsOrder)){
			return "/admin/order/query"; 
		}
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("orderCode", orderCode);
		params.put("cusNo", cusNo);
		params.put("cusName", cusName);
		params.put("payNo", payNo);
		params.put("logisticsOrder", logisticsOrder);
		String startTime = DateUtil.addDays(-60);//只查最近60天记录
		params.put("startTime", startTime);
		params.put("orderType", orderType);
		params.put("guiNo", guiNo);
		try {
			List<OrderCustomer> ocs = oCusService.queryList(params);
			for(OrderCustomer o : ocs){
				o.setOrder(service.get(o.getOrderId()));
				o.setTimes(orderTimeService.getByOrderId(o.getOrderId()));
			}
			model.addAttribute("orderCustomers", ocs);
			model.addAttribute("orderCode", orderCode);
			model.addAttribute("cusNo", cusNo);
			model.addAttribute("cusName", cusName);
			model.addAttribute("payNo", payNo);
			model.addAttribute("logisticsOrder", logisticsOrder);
			model.addAttribute("orderType", orderType);
			model.addAttribute("guiNo", guiNo);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/order/query";
	}
	
	@RequestMapping("/export")
	@ResponseBody
	public String export(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			String status = (String)request.getParameter("status");
			String cusNo = request.getParameter("cusNo");
			String payNo = request.getParameter("payNo");
			String cusName = request.getParameter("cusName");
			String goodsName = request.getParameter("goodsName");
			String logisticsOrder = request.getParameter("logisticsOrder");
			String providerName = request.getParameter("providerName");
			String startPayTime = request.getParameter("startPayTime");
			String endPayTime = request.getParameter("endPayTime");
			
			if(StringUtils.isEmpty(status)){
				status="1";
			}
			Map<String,Object> params = new HashMap<String,Object>();
			if(!"11".equals(status)){
				params.put("status", status);
			}
			params.put("goodsName", goodsName);
			params.put("logisticsOrder", logisticsOrder);
			params.put("providerName",providerName );
			params.put("startPayTime",startPayTime);
			params.put("endPayTime",endPayTime);
			params.put("payNo", payNo);
			if(!StringUtils.isEmpty(cusNo)){
				params.put("cusNo",cusNo);
			}
			if(!StringUtils.isEmpty(cusName)){
				params.put("cusName",cusName);
			}
			Page<OrderInfo> page = new Page<OrderInfo>();
			page.setCurrentPage(1);
			page.setPageCount(1000);
			params.put("page", page);
			List<OrderInfo> orderInfos = service.queryListByPage(params);
			String head[] = {"汇款单号","供应商","产品名称","付款时间","订单时间","交易时长(天)","边界地点","目的地点","件数","采购金额",
					"国内运费","越南运费","应收金额","利润率"};
			String properties[] = {"payNo","providerName","goodsName","payTime","updateTime","days","borderAddrStr","goalAddrStr",
					"num","amount","cnFare","vnFare","receiveMoney","profit"};
			String types[] = {"String","String","String","String","Date","Integer","String","String","Integer","Double","Double",
					"Double","Double","Double"};
			int[] width=new int[]{20,20,20,25,25,15,15,15,15,15,15,15,15,15};
			ExportData.exportByProperties(orderInfos,"货物订单明细表", head,properties,types, width, width.length, response);
		} catch (Exception e) {
			log.error("",e);
		}
		return null;
	}
	
	@RequestMapping("/toStat")
	public String toStat(Model model){
		try {
			List<Provider> providers = providerService.queryList(null);
			List<Goods> goods = goodsService.queryList(null);
			List<Customer> customers = customerService.queryList(null);
			model.addAttribute("customers", customers);
			model.addAttribute("providers", providers);
			model.addAttribute("goodss", goods);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/order/stat";
	}
	
	@RequestMapping("/stat")
	public String stat(HttpServletRequest request,Model model){
		try {
			String cusId = request.getParameter("cusId");
			String cusName = request.getParameter("cusName");
			String salesMan = request.getParameter("salesMan");
			int timeType = Integer.valueOf(request.getParameter("timeType"));
			String yearMonth = request.getParameter("yearMonth");
			String year = request.getParameter("year");
			String startPayTime = request.getParameter("startPayTime");
			String endPayTime = request.getParameter("endPayTime");
			String oname = request.getParameter("oname");
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			if(StringUtils.isEmpty(oname)){
				oname = "amount";
			}
			String sort = request.getParameter("sort");
			if(StringUtils.isEmpty(sort)){
				sort = "desc";
			}
			
			if(timeType ==1){//日统计
				if(StringUtils.isEmpty(startPayTime)|| StringUtils.isEmpty(endPayTime)){
					log.warn("query date can not empty!");
					return "/admin/order/stat";
				}
			}else if(timeType ==2){//为月统计
				startPayTime = yearMonth+"-01";
				endPayTime = DateUtil.lastdayofmonth();
			}else if(timeType ==3){//为年统计
				startPayTime = year +"-01-01";
				endPayTime = year + "-12-31";
			}
			
			Page<OrderInfo> page = new Page<OrderInfo>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("startPayTime",startPayTime);
			params.put("endPayTime",endPayTime);
			params.put("cusId",cusId);
			params.put("cusName",cusName);
			params.put("oname", oname);
			params.put("sort", sort);
			params.put("page", page);
			List<OrderInfo> orderInfos = service.queryStatByPage(params);
			List<Customer> customers = customerService.queryList(null);
			model.addAttribute("customers", customers);
			model.addAttribute("cusId", cusId);
			model.addAttribute("cusName", cusName);
			if(timeType==1){
				model.addAttribute("startPayTime", startPayTime);
				model.addAttribute("endPayTime", endPayTime);
			}
			model.addAttribute("salesMan", salesMan);
			model.addAttribute("timeType", timeType);
			model.addAttribute("yearMonth", yearMonth);
			model.addAttribute("year", year);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("page",page);
			model.addAttribute("orders", orderInfos);
			model.addAttribute("oname", oname);
			model.addAttribute("sort", sort);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/order/stat";
	}
	
	@RequestMapping("/updateStatus")
	@ResponseBody
	public String update(HttpServletRequest request){
		String ret = "fail";
		String status = request.getParameter("status");
		String id = request.getParameter("id");
		try {
			int st = Integer.valueOf(status);
			int orderStatus;
			if(st !=10){//10为发往芒街
				orderStatus = st+1;
			}else {
				orderStatus = st;
			}
			OrderInfo order = service.get(Integer.valueOf(id));
			String account = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ACCOUNT);
			if(order != null){
				order.setStatus(orderStatus);
				order.setUpdateTime(new Date());
				service.update(order);
				OrderTime ot = new OrderTime();
				ot.setFinishTime(new Date());
				ot.setStatus(orderStatus);
				ot.setOrderId(order.getId());
				ot.setUserId(account);
				orderTimeService.add(ot);
				ret = "success";
				updateMoneyStat(order);//统计金额
				addOperationLog(order,account,st);//操作类型
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return ret;
	}
	
	//统计金额
	public void updateMoneyStat(OrderInfo order){
		if(order.getStatus() ==9){//交易完成
			Map<String,Object> params = new HashMap<String,Object>();
			String yearMonth = DateUtil.formatDate(order.getPayTime());
			params.put("status", order.getStatus());
			params.put("startTime",yearMonth);
			try {
				Map<String,Object> map = service.moneyStat(params);
				double amount = Double.valueOf(df.format(map.get("amount")));//采购金额
				double goodsMoney = Double.valueOf(df.format(map.get("goodsMoney")));//销售金额
				double fee = Double.valueOf(df.format(map.get("fee")));//转账手续费
				double cnFee = Double.valueOf(df.format(map.get("cnFare")));//国内运费
				double vnFee = Double.valueOf(df.format(map.get("vnFare")));//越南运费
				MoneyStat stat = new MoneyStat();
				stat.setYearMonth(yearMonth);
				stat = moneyService.query(stat);
				if(stat != null){
					stat.setBuyMoney(amount);
					stat.setReceiveMoney(goodsMoney);
					stat.setFee(fee);
					stat.setCnFee(cnFee);
					stat.setVnFee(vnFee);
					moneyService.update(stat);
					log.info("update moneystat success,orderID:"+order.getId());
				}else{
					MoneyStat money = new MoneyStat();
					money.setMonth(DateUtil.formatYearMonth(yearMonth));
					money.setBuyMoney(amount);
					money.setReceiveMoney(goodsMoney);
					money.setFee(fee);
					money.setCnFee(cnFee);
					money.setVnFee(vnFee);
					moneyService.add(money);
				}
			} catch (Exception e) {
				log.error("update moneystat failed",e);
			}
		}
	}
	
	public static void main(String args[]){
		Object a = "100.86";
		double b  = Double.valueOf((String)a);
		System.out.println(b);
	}
	
	
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam int id){
		String ret = "0";
		try {
			OrderInfo order = service.get(id);
			Funds funds = fundsService.get(order.getFundsId());
			if(funds !=null){
				funds.setOutcome(funds.getOutcome()-order.getAmount());
				funds.setOverMoney(funds.getOverMoney()+order.getAmount());
				fundsService.update(funds);
			}
			int result = service.updateType(id, 1);//1表示逻辑删除 0为正常
			if(result == 1){
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...",e);
		}
		return ret;
	}
	
	@RequestMapping("/queryCount")
	@ResponseBody
	public Map<String,Object> getNewOrderNum(){
		Map<String,Object> map = service.queryCount();
		return map;
		
	}
	
	@RequestMapping("/desktop")
	public String desktop(){
		return "/admin/order/desktop";
		
	}
	
	@RequestMapping("/queryCountAndAmount")
	@ResponseBody
	public Map<String,Object> queryCountAndAmount(){
		DecimalFormat df = new DecimalFormat("##,###.00");
		Map<String,Object> map = service.queryCountAndAmount();
		for(Map.Entry<String, Object> m :map.entrySet()){
			String key = m.getKey();
			if(key.indexOf("s")==-1){
				m.setValue(df.format(m.getValue()));
			}
		}
		return map;
		
	}
	
	
	@RequestMapping("/countAllNumAndAmount")
	@ResponseBody
	public Map<String,Object> countAllNumAndAmount(){
		DecimalFormat df = new DecimalFormat("##,###.00");
		Map<String,Object> map = service.countAllNumAndAmount();
		for(Map.Entry<String, Object> m :map.entrySet()){
			String key = m.getKey();
			if(key.indexOf("num")==-1){
				m.setValue(df.format(m.getValue()));
			}
		}
		return map;
		
	}
	@RequestMapping("/uploadPhoto")  
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, ModelMap model) {  
//      String path = request.getSession().getServletContext().getRealPath("upload");  
		String oldPicUrl = request.getParameter("oldPicUrl");
		String id = request.getParameter("id");
		String temp = System.getProperty("catalina.base")+"/upload/temp/";
		String path = System.getProperty("catalina.base")+"/upload/images/";
        String fileName =file.getOriginalFilename().substring(file.getOriginalFilename().indexOf("."));
        fileName = System.currentTimeMillis()+fileName;
        log.info(path);  
        File targetFile = new File(temp, fileName);  
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }  
        int width = 200;
        if(2==Integer.valueOf(id)){
        	width = 400;//包装图片
        }
        //保存  
        try {  
            file.transferTo(targetFile);  
           
            Thumbnails.of(temp+fileName).size(width, width).toFile(path+fileName);//按比例生成缩略图
            targetFile.delete();//删除临时图片
            if(!StringUtils.isEmpty(oldPicUrl)){//删除旧的图片
            	String name = oldPicUrl.substring(oldPicUrl.lastIndexOf("/"));
            	File old = new File(path+name);
            	if(old.exists()){
            		old.delete();
            	}
            }
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        model.addAttribute("picUrl", path+fileName); 
        model.addAttribute("id", id); 
        return "/admin/order/iframe_upload";  
    }  
	

	@RequestMapping("/showPhoto")
    public void showPhoto( HttpServletRequest request,HttpServletResponse response) throws IOException {
		String path = request.getParameter("path");
        File file = new File(path);

        //判断文件是否存在如果不存在就返回
        if(!file.exists()) {
        	path = request.getRealPath("/images/nopic.png"); 
        	file = new File(path);
        }
        FileInputStream inputStream = new FileInputStream(file);
        byte[] data = new byte[(int)file.length()];
        int length = inputStream.read(data);
        inputStream.close();

        response.setContentType("image/jpeg");
        response.setContentLength(length);
        OutputStream stream = response.getOutputStream();
        stream.write(data);
        stream.flush();
        stream.close();
    }
	
	private void addOperationLog(OrderInfo order,String account,int item){
		OperationLog opLog = new OperationLog();
		opLog.setAccount(account);
		opLog.setCreateTime(new Date());
		opLog.setItem(item);
		String content ="合同编号:"+order.getPayNo()+" 金额:"+order.getAmount()+
				" 件数:"+order.getNum()+" 物流单号:"+order.getLogisticsOrder()+
				" 国内运费:"+order.getCnFare()+" 越南运费:"+order.getVnFare()+" 已收货款:"+order.getReceiveMoney();
		opLog.setContent(content);
		try {
			opService.add(opLog);
		} catch (Exception e) {
			log.error("add operation log error:",e);
			
		}
		
	}
	
	@RequestMapping("/getMaxPayNo")
	@ResponseBody
	public String getMaxPayNo(HttpServletRequest request){
		String payType = request.getParameter("payType");
		String ret = "0";
		try {
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("payType", payType);
			ret = service.getMaxPayNo(params);
			if(ret == null){
				ret =payType+"001";
			}else{
				ret =ret.substring(1);
				int newNum = Integer.valueOf(ret)+1;
				if(newNum>9 && newNum<100){
					ret =payType+"0"+newNum;
				}else if(newNum <10){
					ret =payType+"00"+newNum; 
				}else{
					ret =payType+newNum; 
				}
			}
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	@RequestMapping("/queryKuaidi")
	@ResponseBody
	public String queryKuaiDi(HttpServletRequest request){
		String no = request.getParameter("no");
		if(StringUtils.isEmpty(no)){
			return "";
		}
		no = StringUtils.trimWhitespace(no);
		String url = "http://www.kuaidi100.com/autonumber/autoComNum?text="+no;
		try {
			String ret = HttpClientUtil.get(url);
			log.info("kuaidi result:"+ret);
			JSONObject obj = JSONObject.parseObject(ret);
			JSONArray array = (JSONArray)obj.get("auto");
			JSONObject auto = array.getJSONObject(0);
			String type = auto.getString("comCode");
			String temp = System.currentTimeMillis()+"";
			url = "http://www.kuaidi100.com/query?type="+type+"&postid="+no+"&id=1&valicode=&temp="+temp;
			log.info("query url:"+url);
			ret = HttpClientUtil.get(url);
			return ret;
		} catch (Exception e) {
			log.error("",e);
		}
		return "";
	}
	@RequestMapping("/offerInit")
	public String offerInit(HttpServletRequest request,Model model){
		String detail = request.getParameter("type");
		String status = request.getParameter("status");
		try {
			String id = request.getParameter("id");
			
//			List<Provider> providers = providerService.queryList(null);
//			List<Goods> goods = goodsService.queryList(null);
//			List<Customer> customers = customerService.queryList(null);
//			List<Funds> funds = fundsService.queryList(null);
//			model.addAttribute("customers", customers);
//			model.addAttribute("providers", providers);
//			model.addAttribute("goodss", goods);
//			model.addAttribute("funds", funds);
			model.addAttribute("status", status);
			if(!StringUtils.isEmpty(id)){
				OrderInfo orderInfo = service.get(Integer.valueOf(id));
				orderInfo.setTimes(orderTimeService.getByOrderId(Integer.valueOf(id)));
				model.addAttribute("order", orderInfo);
				Map<String,Object> params = new HashMap<String,Object>();
				params.put("orderId", id);
				List<OrderCustomer> orderCustomers = oCusService.queryList(params);
				model.addAttribute("orderCustomers", orderCustomers);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		if(StringUtils.isEmpty(detail)){
			return "/admin/order/add";
		}else{
			return "/admin/order/detail";
		}
		
	}

	public static final String GOAL_ADDR_HN="1";
	public static final String GOAL_ADDR_HCM="2";
}
