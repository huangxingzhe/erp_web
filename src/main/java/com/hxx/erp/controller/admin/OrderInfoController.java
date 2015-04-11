package com.hxx.erp.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.hxx.erp.common.Constant;
import com.hxx.erp.common.ExportData;
import com.hxx.erp.common.Page;
import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.OrderCustomer;
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.model.OrderTime;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.CustomerService;
import com.hxx.erp.service.GoodsService;
import com.hxx.erp.service.OrderCustomerService;
import com.hxx.erp.service.OrderInfoService;
import com.hxx.erp.service.OrderTimeService;
import com.hxx.erp.service.ProviderService;
import com.hxx.erp.util.DateUtil;

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
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		String detail = request.getParameter("type");
		try {
			String id = request.getParameter("id");
			
			List<Provider> providers = providerService.queryList(null);
			List<Goods> goods = goodsService.queryList(null);
			List<Customer> customers = customerService.queryList(null);
			model.addAttribute("customers", customers);
			model.addAttribute("providers", providers);
			model.addAttribute("goodss", goods);
			if(!StringUtils.isEmpty(id)){
				OrderInfo orderInfo = service.get(Integer.valueOf(id));
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
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute OrderInfo order,HttpServletRequest request){
		int ret = 0;
		try {
			String[] cusNos = request.getParameterValues("cusNos");
			String[] sendNums = request.getParameterValues("sendNums");
			String[] realNums = request.getParameterValues("realNums");
			String[] orderCodes = request.getParameterValues("orderCodes");
			String[] amounts = request.getParameterValues("amounts");
			if(cusNos==null || sendNums==null ||realNums==null ||orderCodes ==null||amounts==null){
				return ret;
			}
			if(cusNos.length!=sendNums.length ||cusNos.length!=realNums.length 
					||cusNos.length!=orderCodes.length||cusNos.length!=amounts.length){
				return ret;
			}
			
			String account = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ACCOUNT);
			if(account == null)
				return ret;
			order.setUpdateTime(new Date());
			if(order.getId() == 0){
				order.setStatus(1);//待发货
				order.setCreateTime(new Date());
				order.setUserId(account);
				service.add(order);
				for(int i=0;i<cusNos.length;i++){
					OrderCustomer oc = new OrderCustomer();
					oc.setCusNo(cusNos[i].split("#")[0]);
					oc.setCusName(cusNos[i].split("#")[1]);
					oc.setOrderId(order.getId());
					oc.setOrderCode(orderCodes[i]);
					oc.setAmount(Double.valueOf(amounts[i]));
					oc.setSendNum(Integer.valueOf(sendNums[i]));
					oc.setRealNum(Integer.valueOf(realNums[i]));
					oCusService.add(oc);
				}
			}else{
				service.update(order);
				oCusService.delete(order.getId());
				for(int i=0;i<cusNos.length;i++){
					OrderCustomer oc = new OrderCustomer();
					oc.setCusNo(cusNos[i].split("#")[0]);
					oc.setCusName(cusNos[i].split("#")[1]);
					oc.setOrderId(order.getId());
					oc.setOrderCode(orderCodes[i]);
					oc.setAmount(Double.valueOf(amounts[i]));
					oc.setSendNum(Integer.valueOf(sendNums[i]));
					oc.setRealNum(Integer.valueOf(realNums[i]));
					oCusService.add(oc);
				}
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String status = (String)request.getParameter("status");
			String cusNo = request.getParameter("cusNo");
			String cusName = request.getParameter("cusName");
			String goodsName = request.getParameter("goodsName");
			String logisticsOrder = request.getParameter("logisticsOrder");
			String providerName = request.getParameter("providerName");
			String startPayTime = request.getParameter("startPayTime");
			String endPayTime = request.getParameter("endPayTime");
			
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			if(StringUtils.isEmpty(status)){
				status="1";
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("status", status);
			params.put("goodsName", goodsName);
			params.put("logisticsOrder", logisticsOrder);
			params.put("providerName",providerName );
			params.put("startPayTime",startPayTime);
			params.put("endPayTime",endPayTime);
			if(!StringUtils.isEmpty(cusNo)){
				params.put("cusNo",cusNo);
			}
			if(!StringUtils.isEmpty(cusName)){
				params.put("cusName",cusName);
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
			for(OrderInfo o: orderInfos){
				nums+=o.getNum();
				amounts+=o.getAmount();
				double all = o.getAmount()+o.getCnFare()+o.getVnFare();
				o.setProfit((o.getReceiveMoney()-all)/all*100);
			}
			model.addAttribute("orders", orderInfos);
			model.addAttribute("page",page);
			List<Provider> providers = providerService.queryList(null);
			model.addAttribute("providers", providers);
			List<Goods> goods = goodsService.queryList(null);
			model.addAttribute("goodss", goods);
			model.addAttribute("status", status);
			model.addAttribute("cusNo", cusNo);
			model.addAttribute("cusName", cusName);
			model.addAttribute("goodsName", goodsName);
			model.addAttribute("logisticsOrder", logisticsOrder);
			model.addAttribute("providerName", providerName);
			model.addAttribute("startPayTime", startPayTime);
			model.addAttribute("endPayTime", endPayTime);
			model.addAttribute("nums", nums);
			DecimalFormat df = new DecimalFormat("#.00");
			model.addAttribute("amounts", df.format(amounts));
			//如果大于1页才去查
			if(orderInfos!=null && orderInfos.size()>=page.getPageCount()){
				Map<String,Object> statMap = service.totalStat(params);
				model.addAttribute("totalNums", statMap.get("num"));
				model.addAttribute("totalAmounts", df.format(statMap.get("amount")));
			}else{
				model.addAttribute("totalNums", nums);
				model.addAttribute("totalAmounts", df.format(amounts));
			}
			
			
			
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/order/list";
	}
	
	@RequestMapping("/export")
	@ResponseBody
	public String export(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			String status = (String)request.getParameter("status");
			String cusNo = request.getParameter("cusNo");
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
			params.put("status", status);
			params.put("goodsName", goodsName);
			params.put("logisticsOrder", logisticsOrder);
			params.put("providerName",providerName );
			params.put("startPayTime",startPayTime);
			params.put("endPayTime",endPayTime);
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
			String head[] = {"产品名称","汇款单号","付款金额","付款时间","供应商","订单时间","交易时长(天)","件数","边界地点","目的地点"};
			String properties[] = {"goodsName","payNo","amount","payTime","providerName","updateTime","days","num","borderAddrStr","goalAddrStr"};
			String types[] = {"String","String","Double","String","String","Date","Integer","Integer","String","String"};
			int[] width=new int[]{25,20,20,30,30,30,20,20,20,20};
			ExportData.exportByProperties(orderInfos,"货物订单明细表", head,properties,types, width, width.length, response);
		} catch (Exception e) {
			log.error("",e);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			out.println(false);    
			out.flush();
			out.close();
		}
		return null;
	}
	
	@RequestMapping("/toStat")
	public String toStat(Model model){
		try {
			List<Provider> providers = providerService.queryList(null);
			List<Goods> goods = goodsService.queryList(null);
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
			String status = (String)request.getParameter("status");
			String goodsName = request.getParameter("goodsName");
			String providerName = request.getParameter("providerName");
			String startPayTime = request.getParameter("startPayTime");
			String endPayTime = request.getParameter("endPayTime");
			
			Map<String,Object> params = new HashMap<String,Object>();
			if(!StringUtils.isEmpty(status)){
				params.put("status", status);
			}
			
			params.put("goodsName", goodsName);
			params.put("providerName",providerName );
			params.put("startPayTime",startPayTime);
			params.put("endPayTime",endPayTime);
			
			List<OrderInfo> orderInfos = service.queryList(params);
			List<Provider> providers = providerService.queryList(null);
			model.addAttribute("providers", providers);
			List<Goods> goods = goodsService.queryList(null);
			model.addAttribute("goodss", goods);
			model.addAttribute("status", status);
			model.addAttribute("goodsName", goodsName);
			model.addAttribute("providerName", providerName);
			model.addAttribute("startPayTime", startPayTime);
			model.addAttribute("endPayTime", endPayTime);
			
			StringBuilder date = new StringBuilder("["); 
			StringBuilder amount = new StringBuilder("["); 
			StringBuilder num = new StringBuilder("["); 
			DecimalFormat df = new DecimalFormat("#.00");
			if(orderInfos!=null && orderInfos.size()>0){
				for(int i=0;i<orderInfos.size();i++){
					if(i==orderInfos.size()-1){
						date.append("'"+DateUtil.formatDate(orderInfos.get(i).getStatTime(),"yyyy-MM-dd")+"']");
						amount.append(df.format(orderInfos.get(i).getAmount())+"]");
						num.append(orderInfos.get(i).getNum()+"]");
					}else{
						date.append("'"+DateUtil.formatDate(orderInfos.get(i).getStatTime(),"yyyy-MM-dd")+"',");
						amount.append(df.format(orderInfos.get(i).getAmount())+",");
						num.append(orderInfos.get(i).getNum()+",");
					}
				}
				model.addAttribute("orders", orderInfos);
				model.addAttribute("date", date);
				model.addAttribute("amount", amount);
				model.addAttribute("num", num);
			}
			
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
			
			OrderInfo order = service.get(Integer.valueOf(id));
			String account = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ACCOUNT);
			if(order != null){
				order.setStatus(Integer.valueOf(status)+1);
				order.setUpdateTime(new Date());
				service.update(order);
				OrderTime ot = new OrderTime();
				ot.setFinishTime(new Date());
				if(order.getGoalAddr().endsWith(GOAL_ADDR_HN) && Integer.valueOf(status) ==6){//6表示正发往河内或胡志明
					ot.setStatus(Integer.valueOf(status)-1);
				}else{
					ot.setStatus(Integer.valueOf(status));
				}
				ot.setOrderId(order.getId());
				ot.setUserId(account);
				orderTimeService.add(ot);
				ret = "success";
			}
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
//			int result = service.delete(id);
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
		Map<String,Object> map = service.queryCountAndAmount();
		return map;
		
	}
	
	@RequestMapping("/uploadPhoto")  
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, ModelMap model) {  
//      String path = request.getSession().getServletContext().getRealPath("upload");  
		String path = System.getProperty("catalina.base")+"/upload/images/";
        String fileName =file.getOriginalFilename().substring(file.getOriginalFilename().indexOf("."));
        fileName = System.currentTimeMillis()+fileName;
        log.info(path);  
        File targetFile = new File(path, fileName);  
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }  
  
        //保存  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        model.addAttribute("picUrl", path+fileName);  
        return "/admin/order/iframe_upload";  
    }  
	

	@RequestMapping("/showPhoto")
    public void showPhoto( HttpServletRequest request,HttpServletResponse response) throws IOException {
		String path = request.getParameter("path");
        File file = new File(path);

        //判断文件是否存在如果不存在就返回
        if(!file.exists()) {
            return;
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

	public static final String GOAL_ADDR_HN="1";
	public static final String GOAL_ADDR_HCM="2";
}
