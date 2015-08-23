package com.hxx.erp.controller.admin;

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

import com.hxx.erp.common.Page;
import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.GoodsService;

@Controller
@RequestMapping("/admin/goods")
public class GoodsController {
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private GoodsService service;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				Goods goods = service.get(Integer.valueOf(id));
				model.addAttribute("goods", goods);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/config/goods_add";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String providerId = request.getParameter("providerId");
			String providerName = request.getParameter("providerName");
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<Goods> page = new Page<Goods>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("page", page);
			params.put("providerId", providerId);
			List<Goods> goods = service.queryListByPage(params);
			model.addAttribute("goodss", goods);
			model.addAttribute("page",page);
			model.addAttribute("providerId",providerId);
			model.addAttribute("providerName",providerName);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/config/goods_list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Goods goods){
		int ret = 0;
		try {
			Goods good = service.query(goods);
			if(good !=null && good.getId()!=goods.getId()){//已存在相同编号
				ret = 2;
				return ret;
			}
			if(goods.getId() == 0){
				service.add(goods);
			}else{
				service.update(goods);
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	@RequestMapping("/dialog")
	public String dialog(HttpServletRequest request,Model model){
		try {
			String type = request.getParameter("type");
			String keyword = request.getParameter("keyword");
			String currentPage = request.getParameter("currentPage");
			String pageCount = "5";
			Page<Provider> page = new Page<Provider>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("page", page);
			params.put("type", type);
			params.put("keyword", keyword);
			params.put("status", 1);
			List<Goods> goods = service.queryListByPage(params);
			model.addAttribute("goods", goods);
			if(page.getTotalPage()>1){
				model.addAttribute("page",page);
			}
			model.addAttribute("type",type);
			model.addAttribute("keyword",keyword);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/config/dialog_goods_list";
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
	
}
