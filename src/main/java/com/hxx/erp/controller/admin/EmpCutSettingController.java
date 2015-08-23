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
import com.hxx.erp.model.EmpCutSetting;
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.GoodsRate;
import com.hxx.erp.service.EmpCutSettingService;
import com.hxx.erp.service.GoodsRateService;

@Controller
@RequestMapping("/admin/setting")
public class EmpCutSettingController {

	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private EmpCutSettingService service;
	@Autowired
	private GoodsRateService rateService;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				EmpCutSetting setting = service.get(Integer.valueOf(id));
				Map<String,Object> params = new HashMap<String, Object>();
				params.put("status", 1);
				params.put("goodsId", setting.getGoodsId());
				List<GoodsRate> rates = rateService.queryList(params);
				model.addAttribute("setting", setting);
				model.addAttribute("rates", rates);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/user/emp_cut_setting_add";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			String empId = request.getParameter("empId");
			String salesMan = request.getParameter("salesMan");
			String cusId = request.getParameter("cusId");
			String cusName = request.getParameter("cusName");
			String goodsId = request.getParameter("goodsId");
			String goodsName = request.getParameter("goodsName");
			Page<Goods> page = new Page<Goods>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("page", page);
			List<EmpCutSetting> settings = service.queryListByPage(params);
			model.addAttribute("settings", settings);
			model.addAttribute("page",page);
			model.addAttribute("empId",empId);
			model.addAttribute("salesMan",salesMan);
			model.addAttribute("cusId",cusId);
			model.addAttribute("cusName",cusName);
			model.addAttribute("goodsId",goodsId);
			model.addAttribute("goodsName",goodsName);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/user/emp_cut_setting_list";
	}
	
	
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute EmpCutSetting setting){
		int ret = 0;
		try {
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("empId", setting.getEmpId());
			params.put("cusId", setting.getCusId());
			params.put("rateId", setting.getRateId());
			List<EmpCutSetting> list = service.queryList(params);
			
			//存在
			if(list!=null && list.size()>0){
				if(setting.getId()==0||setting.getId()!=list.get(0).getId()){
					return ret =2;
				}
			}
			
			if(setting.getId() == 0){
				service.add(setting);
			}else{
				service.update(setting);
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
