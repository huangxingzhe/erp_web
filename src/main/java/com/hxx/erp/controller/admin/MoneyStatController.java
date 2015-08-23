package com.hxx.erp.controller.admin;

import java.text.SimpleDateFormat;
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

import com.hxx.erp.common.Page;
import com.hxx.erp.model.Goods;
import com.hxx.erp.model.MoneyStat;
import com.hxx.erp.service.MoneyStatService;
import com.hxx.erp.util.DateUtil;

@Controller
@RequestMapping("/admin/money")
public class MoneyStatController {
	private static final Log log = LogFactory.getLog(MoneyStatController.class);
	@Autowired
	private MoneyStatService service;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				MoneyStat money = service.get(Integer.valueOf(id));
				model.addAttribute("money", money);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/funds/money_add";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String year = request.getParameter("year");
			if(StringUtils.isEmpty(year)){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
				year = sdf.format(new Date());
			}
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
			params.put("year", year);
			List<MoneyStat> moneys = service.queryListByPage(params);
			model.addAttribute("moneys", moneys);
			model.addAttribute("page", page);
			model.addAttribute("years", getYears());
			model.addAttribute("selYear", year);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/funds/money_list";
	}
	
	@RequestMapping("/all")
	public String all(HttpServletRequest request,Model model){
		try {
			String year = request.getParameter("year");
			if(StringUtils.isEmpty(year)){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
				year = sdf.format(new Date());
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("year", year);
			List<MoneyStat> moneys = service.queryAllForStat(params);
			double lastMonthReceive = 0;//上个月销售金额
			double lastMonthBuy = 0;//上个月采购金额
			if(moneys!=null && moneys.size()>0){
				for(int i=0;i<moneys.size();i++){
					if(i==0){
						String month = DateUtil.formatYearMonth(moneys.get(0).getMonth());
						if(month.indexOf("-01")!=-1){
							//获取上年的数据
							params.clear();
							params.put("month", (Integer.valueOf(year)-1)+"-12");
							List<MoneyStat> ms = service.queryAllForStat(params);
							if(ms!=null && ms.size()>0){
								lastMonthReceive = ms.get(0).getReceiveMoney();
								lastMonthBuy = ms.get(0).getBuyMoney();
							}
						}
					}
					MoneyStat money = moneys.get(i);
					double receiveMOM = lastMonthReceive>0?(money.getReceiveMoney()-lastMonthReceive)/lastMonthReceive:1;
					money.setReceiveMOM(receiveMOM);
					double buyMOM =lastMonthBuy>0?(money.getBuyMoney()-lastMonthBuy)/lastMonthBuy:1;
					money.setBuyMOM(buyMOM);
					lastMonthReceive = money.getReceiveMoney();
					lastMonthBuy = money.getBuyMoney();
				}
			}
			model.addAttribute("moneys", moneys);
			model.addAttribute("years", getYears());
			model.addAttribute("selYear", year);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/funds/money_stat";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute MoneyStat money,HttpServletRequest request){
		int ret = 0;
		try {
			money.setMonth(DateUtil.formatYearMonth(money.getYearMonth()));
			MoneyStat stat = service.query(money);
			String oldMonth = DateUtil.formatYearMonth(stat.getMonth());
			if(stat !=null && !oldMonth.equals(money.getYearMonth())){//已存在相同年月份
				ret = 2;
				return ret;
			}
			if(money.getId() == 0){
				service.add(money);
			}else{
				stat.setRent(money.getRent());
				stat.setSafe(money.getSafe());
				stat.setWater(money.getWater());
				stat.setSalary(money.getSalary());
				stat.setExt(money.getExt());
				stat.setMark(money.getMark());
				service.update(stat);
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
	
	private List<String> getYears(){
		List<String> years = new ArrayList<String>();
		int startYear = 2015;//表示数据的最早记录的年份 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		int nowYear = Integer.valueOf(sdf.format(new Date()));
		if(nowYear>=startYear){
			for(int i=nowYear-startYear;i>=0;i--){
				years.add(String.valueOf(startYear+i));
				
			}
		}else{
			years.add("2015");
		}
		return years;
		
	}
	
}
