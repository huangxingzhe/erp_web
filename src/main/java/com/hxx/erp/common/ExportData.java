package com.hxx.erp.common;

import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.util.DateUtil;

public class ExportData {
	private static Log log = LogFactory.getLog(ExportData.class);

	//公共的导出方法
	/**
	 * 
	 * @param list 查询的列表集合(转范型之后的集合)
	 * @param fileName 资源文件名
	 * @param headArray  头部数组
	 * @param widthArray  设置excel每列的宽度
	 * @param cols 显示多少列
	 * @param c 反射的类（通过它可以访问类中的属性以及方法）
	 * @return
	 * @throws Exception
	 */
		public static void export(List list,String fileName,String[] headArray,int[] width,int cols,Class<?> c,HttpServletResponse response)throws Exception{
			try{ 
				/*********创建excel阶段*********/ 
				 String exportfileName = fileName +"-"+ DateUtil.today() ;
				//设置响应方式
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
			//	String name = URLEncoder.encode(exportfileName, "UTF-8");
				String name=new String((exportfileName).getBytes("gbk"),"iso8859-1");
	
				response.setHeader("Content-Disposition", "attachment;filename="+name);
			    //创建execl第一行数句(标题)
				
				// 标题字体
				jxl.write.WritableFont wfc = new jxl.write.WritableFont(
				jxl.write.WritableFont.COURIER, 13, jxl.write.WritableFont.NO_BOLD, true);
				jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc);
				wcfFC.setAlignment(jxl.format.Alignment.CENTRE);
				wcfFC.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
				wcfFC.setBackground(Colour.GREY_50_PERCENT);
				
				//创建一个excel文档
				WritableWorkbook book = Workbook.createWorkbook(response.getOutputStream());
				//创建sheet工作表+ ".xls"
				WritableSheet sheet = book.createSheet(exportfileName+".xls", 0);
				//创建字体对象
				WritableFont font = new WritableFont(WritableFont.createFont("黑体"),13,WritableFont.NO_BOLD);
				WritableFont font2 = new WritableFont(WritableFont.createFont("黑体"),12,WritableFont.NO_BOLD);
				
				//创建格式化对象
				WritableCellFormat format = new WritableCellFormat();
				format.setFont(font);//设置字体
				format.setAlignment(Alignment.CENTRE);//设置居中
				format.setVerticalAlignment(VerticalAlignment.CENTRE);
				format.setBackground(Colour.GRAY_25);//设置背景色
				
				WritableCellFormat format2 = new WritableCellFormat();
				format2.setFont(font2);//设置字体
				format2.setAlignment(Alignment.CENTRE);//设置居中
				format2.setVerticalAlignment(VerticalAlignment.CENTRE);
				
			    /***********开始写第二行已下的数据************/
				for (int i = 0; i < headArray.length; i++) {
					sheet.addCell(new Label(i,cols,headArray[i],format));//添加表头
					sheet.setColumnView(i, width[i]);
					
				}
		    	//得到类中所有的属性
				Field[] fields=c.getDeclaredFields();
		    	for (int i = 0; i < list.size(); i++) {
		    		Object object=list.get(i);
		    		for (int j = 0; j < cols; j++) {
		    		   String sname = fields[j].getName(); // 获取属性的名字
		    		   sname = sname.substring(0, 1).toUpperCase() + sname.substring(1); // 将属性的首字符大写，方便构造get，set方法
					if(fields[j].getGenericType().toString().equals("class java.lang.String")){
						  Method m = (Method) object.getClass().getMethod(  
		                            "get" +sname);  
						  String val = (String) m.invoke(object);
						  if (val != null) {  
							  	sheet.addCell(new Label(j,i+(cols+1),val,format2));
		                    }else{
		                    	sheet.addCell(new Label(j,i+(cols+1),"",format2));
		                    }  
					}
					 // 如果类型是Integer  
	                if (fields[j].getGenericType().toString().equals(  
	                        "class java.lang.Integer")) {  
	                    Method m = (Method) object.getClass().getMethod(  
	                            "get" +sname);  
	                    Integer val = (Integer) m.invoke(object);  
	                    if (val != null) {  
	                    	sheet.addCell(new Label(j,i+(cols+1),val+"",format2));
	                    }else{
	                    	sheet.addCell(new Label(j,i+(cols+1),0+"",format2));
	                    }  
	                }  
	                // 如果类型是Double  
	                if (fields[j].getGenericType().toString().equals(  
	                        "class java.lang.Double")) {  
	                    Method m = (Method) object.getClass().getMethod(  
	                            "get" + sname);  
	                    Double val = (Double) m.invoke(object);  
	                    if (val != null) {  
	                    	sheet.addCell(new Label(j,i+(cols+1),val+"",format2));
	                    } else{
	                    	sheet.addCell(new Label(j,i+(cols+1),0.0+"",format2));
	                    }   
	                }  
	                // 如果类型是Boolean 是封装类  
	                if (fields[j].getGenericType().toString().equals(  
	                        "class java.lang.Boolean")) {  
	                    Method m = (Method) object.getClass().getMethod(  
	                    		sname);  
	                    Boolean val = (Boolean) m.invoke(object);  
	                    if (val != null) {  
	                    	sheet.addCell(new Label(j,i+(cols+1),val+"",format2));
	                    }  else{
							  sheet.addCell(new Label(j,i+(cols+1),"",format2));
	                    }
	                }  
	                // 如果类型是boolean 基本数据类型不一样 这里有点说名如果定义名是 isXXX的 那就全都是isXXX的  
	                // 反射找不到getter的具体名  
	                if (fields[j].getGenericType().toString().equals("boolean")) {  
	                    Method m = (Method) object.getClass().getMethod(  
	                    		sname);  
	                    Boolean val = (Boolean) m.invoke(object);  
	                    if (val != null) {  
	                    	sheet.addCell(new Label(j,i+(cols+1),val+"",format2));
	                    }  else{
							  sheet.addCell(new Label(j,i+(cols+1),"",format2));
	                    }
	                }  
	                // 如果类型是Short  
	                if (fields[j].getGenericType().toString().equals(  
	                        "class java.lang.Short")) {  
	                    Method m = (Method) object.getClass().getMethod(  
	                            "get" + sname);  
	                    Short val = (Short) m.invoke(object);  
	                    if (val != null) {  
	                    	sheet.addCell(new Label(j,i+(cols+1),val+"",format2));
	                    }else{
	                    	sheet.addCell(new Label(j,i+(cols+1),0+"",format2));
	                    }    
	                }
	                // 如果类型是Date 
	                if (fields[j].getGenericType().toString().equals(  
	                        "class java.util.Date")) {  
	                    Method m = (Method) object.getClass().getMethod(  
	                            "get" + sname);  
	                    Date val = (Date) m.invoke(object); 
	                    SimpleDateFormat sfEnd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	                    String time= sfEnd.format(val);
	                    if (val != null) {  
	                    	sheet.addCell(new Label(j,i+(cols+1),time+"",format2));
	                    }else{
	                    	sheet.addCell(new Label(j,i+(cols+1),"",format2));
	                    }    
	                }  
		    	}
			}
	    	// 加入标题
	    	sheet.mergeCells(0, 0, cols-1, cols-1);
	    	sheet.addCell(new jxl.write.Label(0, 0, fileName, wcfFC));
	    	book.write();//写execel文档
			book.close();
		}catch(Exception e){
			log.error("",e);
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println(false);
			out.flush();
			out.close();
		}
	}
		
		public static void exportByProperties(List list,String fileName,String[] headArray,String[] properties,String[] types,int[] width,int cols,HttpServletResponse response)throws Exception{
			try{ 
				/*********创建excel阶段*********/ 
				 String exportfileName = fileName +"-"+ DateUtil.today() ;
				//设置响应方式
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
			//	String name = URLEncoder.encode(exportfileName, "UTF-8");
				String name=new String((exportfileName).getBytes("gbk"),"iso8859-1");
	
				response.setHeader("Content-Disposition", "attachment;filename="+name);     //创建execl第一行数句(标题)
				
				// 标题字体
				jxl.write.WritableFont wfc = new jxl.write.WritableFont(
				jxl.write.WritableFont.COURIER, 13, jxl.write.WritableFont.NO_BOLD, false);
				jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc);
				wcfFC.setAlignment(jxl.format.Alignment.CENTRE);
				wcfFC.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
				//wcfFC.setBackground(Colour.GREY_50_PERCENT);
				
				//创建一个excel文档
				WritableWorkbook book = Workbook.createWorkbook(response.getOutputStream());
				//创建sheet工作表+ ".xls"
				WritableSheet sheet = book.createSheet(exportfileName+".xls", 0);
				//创建字体对象
				WritableFont font = new WritableFont(WritableFont.createFont("宋体"),12,WritableFont.NO_BOLD);
				WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"),11,WritableFont.NO_BOLD);
				
				//创建格式化对象
				WritableCellFormat format = new WritableCellFormat();
				format.setFont(font);//设置字体
				format.setAlignment(Alignment.CENTRE);//设置居中
				format.setVerticalAlignment(VerticalAlignment.CENTRE);
				format.setBackground(Colour.GRAY_25);//设置背景色
				format.setBorder(Border.ALL, BorderLineStyle.THIN);
				WritableCellFormat format2 = new WritableCellFormat();
				format2.setFont(font2);//设置字体
				format2.setAlignment(Alignment.CENTRE);//设置居中
				format2.setVerticalAlignment(VerticalAlignment.CENTRE);
				format2.setBorder(Border.ALL, BorderLineStyle.THIN);
				int top = 3;//距离顶部行数
			    /***********开始写第二行已下的数据************/
				for (int i = 0; i < headArray.length; i++) {
					sheet.addCell(new Label(i,top,headArray[i],format));//添加表头
					sheet.setColumnView(i, width[i]);
					
				}
				
				
		    	//得到类中所有的属性
		    	for (int i = 0; i < list.size(); i++) {
		    		Object object=list.get(i);
		    		if(object instanceof OrderInfo){
		    			OrderInfo o = (OrderInfo)object;
		    			if(o.getReceiveMoney()>0){
							double all = o.getAmount()+o.getCnFare()+o.getVnFare();
							o.setProfit((o.getReceiveMoney()-all)/o.getReceiveMoney()*100);
						}else{
							o.setProfit(0);
						}
		    		}
		    		
					
		    		for (int j = 0; j < cols; j++) {
		    		   String sname = properties[j]; // 获取属性的名字
		    		   sname = sname.substring(0, 1).toUpperCase() + sname.substring(1); // 将属性的首字符大写，方便构造get，set方法
						if(types[j].toString().equals("String")){
							  Method m = (Method) object.getClass().getMethod(  
			                            "get" +sname);  
							  String val = (String) m.invoke(object);
							  if (val != null) {  
								  	sheet.addCell(new Label(j,i+(top+1),val,format2));
			                    }else{
			                    	sheet.addCell(new Label(j,i+(top+1),"",format2));
			                    }  
						}
						 // 如果类型是Integer  
		                if (types[j].toString().equals("Integer")) {  
		                    Method m = (Method) object.getClass().getMethod(  
		                            "get" +sname);  
		                    Integer val = (Integer) m.invoke(object);  
		                    if (val != null) {  
		                    	sheet.addCell(new Label(j,i+(top+1),val+"",format2));
		                    }else{
		                    	sheet.addCell(new Label(j,i+(top+1),0+"",format2));
		                    }  
		                }  
		                // 如果类型是Double  
		                if (types[j].toString().equals("Double")) {  
		                    Method m = (Method) object.getClass().getMethod(  
		                            "get" + sname);  
		                    Double val = (Double) m.invoke(object);  
		                    DecimalFormat df = new DecimalFormat("#.##");
		                    if(sname.equals("Profit")){
		                    	if (val != null) {  
			                    	sheet.addCell(new Label(j,i+(top+1),df.format(val)+"%",format2));
			                    } else{
			                    	sheet.addCell(new Label(j,i+(top+1),0.00+"%",format2));
			                    }   
		                    }else{
		                    	if (val != null) {  
			                    	sheet.addCell(new Label(j,i+(top+1),df.format(val)+"",format2));
			                    } else{
			                    	sheet.addCell(new Label(j,i+(top+1),0.00+"",format2));
			                    }   
		                    }
		                    
		                }  
		                // 如果类型是Boolean 是封装类  
		                if (types[j].toString().equals("Boolean")) {  
		                    Method m = (Method) object.getClass().getMethod(  
		                    		sname);  
		                    Boolean val = (Boolean) m.invoke(object);  
		                    if (val != null) {  
		                    	sheet.addCell(new Label(j,i+(top+1),val+"",format2));
		                    }  else{
								  sheet.addCell(new Label(j,i+(top+1),"",format2));
		                    }
		                }  
		                // 如果类型是boolean 基本数据类型不一样 这里有点说名如果定义名是 isXXX的 那就全都是isXXX的  
		                // 反射找不到getter的具体名  
		                if (types[j].toString().equals("boolean")) {  
		                    Method m = (Method) object.getClass().getMethod(  
		                    		sname);  
		                    Boolean val = (Boolean) m.invoke(object);  
		                    if (val != null) {  
		                    	sheet.addCell(new Label(j,i+(top+1),val+"",format2));
		                    }  else{
								  sheet.addCell(new Label(j,i+(top+1),"",format2));
		                    }
		                }  
		                // 如果类型是Short  
		                if (types[j].toString().equals("Short")) {  
		                    Method m = (Method) object.getClass().getMethod(  
		                            "get" + sname);  
		                    Short val = (Short) m.invoke(object);  
		                    if (val != null) {  
		                    	sheet.addCell(new Label(j,i+(top+1),val+"",format2));
		                    }else{
		                    	sheet.addCell(new Label(j,i+(top+1),0+"",format2));
		                    }    
		                }
		                // 如果类型是Date 
		                if (types[j].toString().equals("Date")) {  
		                    Method m = (Method) object.getClass().getMethod(  
		                            "get" + sname);  
		                    Date val = (Date) m.invoke(object); 
		                    SimpleDateFormat sfEnd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		                    String time= sfEnd.format(val);
		                    if (val != null) {  
		                    	sheet.addCell(new Label(j,i+(top+1),time+"",format2));
		                    }else{
		                    	sheet.addCell(new Label(j,i+(top+1),"",format2));
		                    }    
		                }  
		    	}
			}
	    	// 加入标题
	    	sheet.mergeCells(0, 0, cols-1, top-1);
	    	sheet.addCell(new jxl.write.Label(0, 0, fileName, wcfFC));
	    	book.write();//写execel文档
			book.close();
		}catch(Exception e){
			log.error("",e);
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println(false);
			out.flush();
			out.close();
		}
	}
	
	public static void main(String[] args) {
	
	}
}
