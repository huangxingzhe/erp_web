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
import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Offer;
import com.hxx.erp.service.CustomerService;
import com.hxx.erp.service.OfferService;

@Controller
@RequestMapping("/admin/offer")
public class OfferController {
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private OfferService service;
	@Autowired
	private CustomerService customerService;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			List<Customer> customers = customerService.queryList(null);
			if(!StringUtils.isEmpty(id)){
				Offer offer = service.get(Integer.valueOf(id));
				model.addAttribute("offer", offer);
			}
			model.addAttribute("customers", customers);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/offer/add";
	}
	
	@RequestMapping("/detail")
	public String detail(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			List<Customer> customers = customerService.queryList(null);
			if(!StringUtils.isEmpty(id)){
				Offer offer = service.get(Integer.valueOf(id));
				model.addAttribute("offer", offer);
			}
			model.addAttribute("customers", customers);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/offer/detail";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String customerName = request.getParameter("customerName");
			String providerName = request.getParameter("providerName");
			String productCN = request.getParameter("productCN");
			String productVN = request.getParameter("productVN");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("customerName", customerName);
			params.put("providerName", providerName);
			params.put("productCN", productCN);
			params.put("productVN", productVN);
			params.put("startDate", startDate);
			params.put("endDate", endDate);
			List<Customer> customers = customerService.queryList(null);
			List<Offer> offer = service.queryList(params);
			model.addAttribute("offers", offer);
			model.addAttribute("customers", customers);
			model.addAttribute("customerName", customerName);
			model.addAttribute("providerName", providerName);
			model.addAttribute("productCN", productCN);
			model.addAttribute("productVN", productVN);
			model.addAttribute("startDate", startDate);
			model.addAttribute("endDate", endDate);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/offer/list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Offer offer,HttpServletRequest request){
		int ret = 0;
		try {
			Offer off = service.query(offer);
			String userName = (String)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_NAME);
			if(off !=null && off.getId()!=offer.getId()){//已存在相同编号
				ret = 2;
				return ret;
			}
			offer.setUserName(userName);
			offer.setUpdateDate(new Date());
			if(offer.getId() == 0){
				offer.setCreateDate(new Date());
				service.add(offer);
			}else{
				service.update(offer);
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
			int result = service.delete(id);
			if(result == 1){
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...",e);
		}
		return ret;
	}
	
	public static void main(String args[]){
		DecimalFormat myformat = new DecimalFormat();
		myformat.applyPattern("##,###.00");
		System.out.println(myformat.format(11112345.12345));
	}
	
}
