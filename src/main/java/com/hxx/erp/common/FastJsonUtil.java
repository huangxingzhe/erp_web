package com.hxx.erp.common;

import java.util.Map;

import com.alibaba.fastjson.JSON;

/**
 * gson的工具类
 * @author miles
 *
 */
public class FastJsonUtil  {
 
	/**
	 * @author jon
	 * @date 2015年6月16日
	 * @param ret
	 * @return
	 */
	public static <T> T jsonToObject(String json, Class<T> clazz) {
		return JSON.parseObject(json,clazz);
	}

	/**
	 * @author jon
	 * @date 2015年6月24日
	 * @param source
	 * @return
	 */
	public static Map<String, String> jsonToMap(String source) {
		@SuppressWarnings("unchecked")
		Map<String,String> map = (Map<String, String>)JSON.parse(source);
		return map;
	}

	/**
	 * 
	 * @author jon
	 * @date 2015年7月7日
	 * @param t
	 * @return
	 */
	public static <T> String toJson(T t) {
		return JSON.toJSON(t).toString();
	}
}
