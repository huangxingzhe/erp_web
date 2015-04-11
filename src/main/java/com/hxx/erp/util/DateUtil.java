/*
 * Copyright 2010 Mttang.com All right reserved. This software is the
 * confidential and proprietary information of Mttang.com ("Confidential
 * Information"). You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered
 * into with Mttang.com.
 */
package com.hxx.erp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 操作时间、日期的工具类
 * @author huangxingzhe
 * @Date  2014/6/6日
 */
public class DateUtil {
	private DateUtil(){}
	
    
    
    /**
     * 格式化字符串为日期
     * @param day 字符串格式为yyyy-MM-dd
     * @return 日期 Date对象
     */
    public static java.util.Date formatDayTime(String day){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return daydf.parse(day);
        } catch (ParseException ex) {
            ex.printStackTrace();
            return new java.util.Date();
        }
    }

    /**
     * 格式字符串为某年某月的第一天。
     * @param yearmonth 格式为2008-10
     * @return 某年某月的第一天
     */
    public static java.util.Date formatMonthTime(String yearmonth){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return daydf.parse(yearmonth + "-01");
        } catch (ParseException ex) {
            ex.printStackTrace();
            return new java.util.Date();
        }
    }
    
    /**
     *返回自1970年1月1日00:00:00GMT以来此日期对象表示的毫秒数
     *@param str 格式为yyyy-MM-dd
     */
    public static long parseDayByYYYYMMDD(String str){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return daydf.parse(str).getTime();
        } catch (Exception ex) {
            return 0L;
        }
    }
    /**
     *返回自1970年1月1日00:00:00GMT以来此时间对象表示的秒数
     *@param str 格式为yyyy-MM-dd HH:mm:ss
     */
    public static int parseTimeByYYYYMMDDHHMMSS(String str){
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(str == null || str.length() != 19) return 0;
        try {
            return (int)(df.parse(str).getTime()/1000L);
        } catch (Exception ex) {
            return 0;
        }
    }
    
    public static String formatDate(String day,String pattern){
    	SimpleDateFormat daydf = new SimpleDateFormat(pattern);
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(parseDayByYYYYMMDD(day));
        return daydf.format(cal.getTime());
    }
    
    /**
     * 得到 yyyy-MM-dd 格式的指定日期的前一天
     */ 
    public static String foreDay(String day){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(parseDayByYYYYMMDD(day));
        cal.add(Calendar.DAY_OF_MONTH, -1);
        return daydf.format(cal.getTime());
    }
    /**
     * 根据时间值构造日期
     */
    public static String parseDay(int time){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        return daydf.format(new java.util.Date(time*1000L));
    }
    /**
     * 显示时间
     * @param millseconds 毫秒数
     * @return 时间显示
     */
    public static String displayTime(long millseconds) {
        if(millseconds < 1000) return millseconds+" ms";
        int seconds = (int)(millseconds/1000);
        if(seconds < 60) return seconds+" s";
        if(seconds < 60*60) return seconds/60+"m"+seconds%60+"s";
        int m = seconds -(seconds/3600)*3600;
        if(seconds < 24*60*60) return seconds/3600+"h"+m/60+"m"+m%60+"s";
        return millseconds+" ms";
    }
    

    /**
     * 转换成yyyy-MM-dd格式的日期字符串
     * @param d Date对象
     */
    public static String formatDay(java.util.Date d){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        return daydf.format(d);
    }
    /**
     * 转换成yyyy-MM-dd格式的日期字符串
     * @param d Calendar对象
     */
    public static String formatDay(java.util.Calendar d){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        return daydf.format(d.getTime());
    }
    /**
     * 转换成yyyy-MM-dd HH:mm:ss格式的时间
     * @param time 毫秒数
     */
    public static String formatyyyyMMddHHmmss(long time){
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return df.format(new java.util.Date(time));
    }

    /**
     * 将时间转换成yyyy-MM-dd HH:mm:ss的格式字符串。
     * @param time 时间对象
     * @return 格式化后的字符串,当输入为null时输出为""
     */
    public static String formatyyyyMMddHHmmss(Date time){
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(time==null){
            return "";
        }
        try{
            return df.format(time);
        }
        catch(Exception ex){
            return "";
        }
    }

    /**
     * 当前日期
     * @return yyyy-MM-dd格式的当前日期
     */
    public static String today() {
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        return daydf.format(new java.util.Date());
    }
    /**
	 * 返回yyyyMMdd格式的当前日期
	 */
	public static String otherdateofnow(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(new java.util.Date());
	}
	
    /**
     * 当前日期的前一天
     * @return 当前日期的前一天
     */
    public static String yesterday(){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Calendar cal =java.util.Calendar.getInstance();
        cal.add(java.util.Calendar.DAY_OF_MONTH, -1);
        return daydf.format(cal.getTime());
    }
    

    /**
     * 当前日期的下一天
     * @return 当前日期的下一天
     */
    public static String tomorrow(){
        java.util.Calendar cal =java.util.Calendar.getInstance();
        SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        cal.add(java.util.Calendar.DAY_OF_MONTH, 1);
        return daydf.format(cal.getTime());
    }
        
    /**
     * 返回本月1号
     * @return 返回本月1号
     */
    public static String currmonth1day(){
    	SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Calendar cal =java.util.Calendar.getInstance();
        cal.set(java.util.Calendar.DAY_OF_MONTH, 1);
        return daydf.format(cal.getTime());
    }
    
    /**
	 * 返回本月最后一天
	 */
	public static String lastdayofmonth(){
		SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar=Calendar.getInstance();   
        Calendar cpcalendar=(Calendar)calendar.clone();   
        cpcalendar.set(Calendar.DAY_OF_MONTH,1); 
        cpcalendar.add(Calendar.MONTH, 1);   
        cpcalendar.add(Calendar.DATE, -1);   
        String date = daydf.format( new Date(cpcalendar.getTimeInMillis()));   
        return date;
	}
	
	/**
	 * 返回本年第一天
	 */
	public static String firstdayofyear(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String year = sdf.format(new java.util.Date());	 
        return year+"-01-01";
	}
	
	/**
	 * 返回本年最后一天
	 */
	public static String lastdayofyear(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String year = sdf.format(new java.util.Date());
        return year+"-12-31";
	}
	
	/**
	 * 给指定时间加上一个数值
	 * @param time1 要加上一数值的时间，为null即为当前时间，格式为yyyy-MM-dd HH:mm:ss
	 * @param addpart 要加的部分：年月日时分秒分别为：YMDHFS
	 * @param num 要加的数值
	 * @return 新时间，格式为yyyy-MM-dd HH:mm:ss
	 */
	public static String addTime(String time1,String addpart,int num){
		try{
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = df.format(new Date());
			time1 = (time1 == null) ? now : time1;
			if (time1.length() < 19){
				time1 += " 00:00:00";
			}
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(df.parse(time1));
			if (addpart.equalsIgnoreCase("Y")){
				cal.add(Calendar.YEAR,num);
			}
			else if (addpart.equalsIgnoreCase("M")){
				cal.add(Calendar.MONTH,num);
			}
			else if (addpart.equalsIgnoreCase("D")){
				cal.add(Calendar.DATE,num);
			}
			else if (addpart.equalsIgnoreCase("H")){
				cal.add(Calendar.HOUR,num);
			}
			else if (addpart.equalsIgnoreCase("F")){
				cal.add(Calendar.MINUTE,num);
			}
			else if (addpart.equalsIgnoreCase("S")){
				cal.add(Calendar.SECOND,num);
			}
			return df.format(cal.getTime());
		}
		catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 给指定日期加上一个数值
	 * @param date1 要加上一数值的日期，为null即为当前日期，格式为yyyy-MM-dd
	 * @param addpart 要加的部分：年月日分别为：YMD
	 * @param num 要加的数值
	 * @return 新日期，格式为yyyy-MM-dd
	 */
	public static String addDate(String date1,String addpart,int num){
		return addTime(date1,addpart,num).substring(0,10);
	}
	
    /**
     * 当前日期
     * @return yyyy-MM-dd HH:mm:ss格式的当前日期
     */
    public static String now() {
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return df.format(new java.util.Date());
    }
    /**
	 * 返回当前时间
	 */
	public static String timeofnow(){
		Calendar curcal = Calendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(curcal.getTime());
	}
	/**
	 * 返回yyyyMMddHHmmss格式的当前时间
	 */
	public static String othertimeofnow(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar curcal = Calendar.getInstance();
		return sdf.format(curcal.getTime());
	}

    /**
     * 得到距离当前天几天的日期表达，格式为1985-12-20。
     * @param step 天数。例如-10表示十天前
     * @return
     */
    public static String dateofSepcial(int step) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        SimpleDateFormat daydf = new SimpleDateFormat("yyyy-MM-dd");
        cal.add(java.util.Calendar.DAY_OF_MONTH, step);
        return daydf.format(cal.getTime());
    }
    
    /**
     * UNIX时间x
     * @return
     */
    public static  String getCurrUnixtimestamp(){
		String ret = "";
		try {
			Date date = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("1970-01-01 00:00:00");
			long l = (new Date().getTime() - date.getTime())/1000;
			ret = String.valueOf(l);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
    /**
     * 根据日期返回星期几
     */
    public static String getWeek(String pTime){  
        String[] weeks = {"星期日","星期一","星期二","星期三","星期四","星期五","星期六"};  
        int week_index = 0;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        Calendar cal = Calendar.getInstance();  
   	 	try {
			cal.setTime(format.parse(pTime));
			week_index = cal.get(Calendar.DAY_OF_WEEK) - 1;  
		    if(week_index<0){  
		        week_index = 0;  
		    }   
		} catch (ParseException e) {
			e.printStackTrace();
		}   
        return weeks[week_index];  
    }  
    
    public static String getWeekForWedding(String pTime){  
        String[] weeks = {"星期日","星期一","星期二","星期三","星期四","星期五","星期六"};  
        int week_index = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        Calendar cal = Calendar.getInstance();  
   	 	try {
			cal.setTime(sdf.parse(pTime));
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			int hour = cal.get(Calendar.HOUR_OF_DAY);
			int min = cal.get(Calendar.MINUTE);
			String hourStr="";
			hourStr=hour<10?"0"+hour:""+hour;
			String minStr="";
			minStr=min<10?"0"+min:""+min;
			week_index = cal.get(Calendar.DAY_OF_WEEK) - 1;  
		    if(week_index<0){  
		        week_index = 0;  
		    }   
		    return year+"-"+month+"-"+day+" ("+weeks[week_index]+") "+hourStr+":"+minStr; 
		} catch (ParseException e) {
			e.printStackTrace();
		}   
        return "";
    }  
    
    public static void main(String args[]){
    	String week = getWeekForWedding("2014-12-20 14:20:15");
    	System.out.println(week);
    }
}
