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
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.GoodsRate;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.GoodsRateService;
import com.hxx.erp.service.GoodsService;

@Controller
@RequestMapping("/admin/rate")
public class GoodsRateController {

Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private GoodsRateService service;
	@Autowired
	private GoodsService goodsService;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				GoodsRate rate = service.get(Integer.valueOf(id));
				if(rate!=null){
					Goods goods = goodsService.get(rate.getGoodsId());
					rate.setGoodsName(goods.getName());
				}
				model.addAttribute("rate", rate);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/config/goods_rate_add";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String goodsId = request.getParameter("goodsId");
			String goodsName = request.getParameter("goodsName");
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
			params.put("goodsId", goodsId);
			List<GoodsRate> rates = service.queryListByPage(params);
			model.addAttribute("rates", rates);
			model.addAttribute("page",page);
			model.addAttribute("goodsId",goodsId);
			model.addAttribute("goodsName",goodsName);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/config/goods_rate_list";
	}
	
	@RequestMapping("/json")
	@ResponseBody
	public List<GoodsRate> json(HttpServletRequest request,Model model){
		try {
			String goodsId = request.getParameter("goodsId");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("goodsId", goodsId);
			params.put("status", 1);
			List<GoodsRate> rates = service.queryList(params);
			return rates;
		} catch (Exception e) {
			log.error("",e);
		}
		return null;
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
			List<GoodsRate> rates = service.queryListByPage(params);
			model.addAttribute("rates", rates);
			if(page.getTotalPage()>1){
				model.addAttribute("page",page);
			}
			model.addAttribute("type",type);
			model.addAttribute("keyword",keyword);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/config/dialog_goods_rate_list";
	}
	
	
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute GoodsRate rate){
		int ret = 0;
		try {
			if(rate.getId() == 0){
				rate.setStatus(1);
				service.add(rate);
			}else{
				service.update(rate);
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
	
}
