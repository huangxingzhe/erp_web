package com.hxx.erp.common;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;


@Intercepts({@Signature(method="prepare",type=StatementHandler.class,args={Connection.class})})
public class PageInterceptor implements Interceptor {
	
	private String dataBaseType=null;
    private static Log log=LogFactory.getLog(PageInterceptor.class);
	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		RoutingStatementHandler handler=(RoutingStatementHandler)invocation.getTarget();
		StatementHandler statement=(StatementHandler)getObjectValueByPropertyName(handler, "delegate");
		BoundSql boundSql=statement.getBoundSql();	
		Object obj=boundSql.getParameterObject();
		if (obj instanceof PageBean<?>) {
			PageBean<?>  pageBean= (PageBean<?>) obj;
			MappedStatement mappedStatement=(MappedStatement) getObjectValueByPropertyName(statement, "mappedStatement");
			Connection connection=(Connection) invocation.getArgs()[0];
			setTotalRecord(obj, pageBean, mappedStatement, connection);
			String pageSql=this.getPageSql(boundSql.getSql(), pageBean);
			log.info("page sql:"+pageSql);
			this.setObjectValueByPropertyName(boundSql, "sql", pageSql);
			
		}
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object arg0) {
		// TODO Auto-generated method stub
		return Plugin.wrap(arg0, this);
	}

	@Override
	public void setProperties(Properties properties) {
		this.dataBaseType=properties.getProperty("dataBaseType");
		
	}
	private Object getObjectValueByPropertyName(Object obj,String propertyName) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException{
		Field field=this.getFieldByFieldName(obj, propertyName);
		field.setAccessible(true);
		return field.get(obj);
	}
	private void setObjectValueByPropertyName(Object obj,String propertyName,String value) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException{
		Field field=obj.getClass().getDeclaredField(propertyName);
		field.setAccessible(true);
		field.set(obj, value);
	}
	private Field getFieldByFieldName(Object obj,String propertyName) throws  SecurityException{
		for(Class<?> supperClass=obj.getClass();supperClass!=Object.class;supperClass=supperClass.getSuperclass()){
			try {
				Field field=supperClass.getDeclaredField(propertyName);
				return field;
			} catch (NoSuchFieldException e) {
			}
 		
          		}
		return null;
	}
	private void setTotalRecord(Object obj,PageBean<?> pageBean,MappedStatement mappedStatement,Connection connect){
		BoundSql boundSql=mappedStatement.getBoundSql(obj);
		String sql=boundSql.getSql();
		String countSql=getCountSql(sql);
		List<ParameterMapping> parameterMappings=boundSql.getParameterMappings();
		BoundSql countBoundSql=new BoundSql(mappedStatement.getConfiguration(), countSql, parameterMappings, obj);
		ParameterHandler parameterHandler=new DefaultParameterHandler(mappedStatement, obj, countBoundSql);
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			ps=connect.prepareStatement(countSql);
			parameterHandler.setParameters(ps);
			rs=ps.executeQuery();
			if(rs!=null&&rs.next()){
				pageBean.setTotal(rs.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(ps!=null){
					ps.close();
					}
					if(rs!=null){
						ps.close();
					}

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	}
	private String getCountSql(String sql){
		int index=sql.indexOf("from");
		return " select count(1)"+sql.substring(index);
	}
	private String getPageSql(String sql,PageBean<?> pageBean){
		StringBuffer pageSql=new StringBuffer();
		int pageNo=pageBean.getPageNo();
		int page=pageBean.getPage();
		int total=pageBean.getTotal();
		int start=pageNo*(page-1);
		int end=pageNo*page>total?total:pageNo*page;
		if("mysql".equalsIgnoreCase(dataBaseType)){
			return getMySql(start, pageNo, pageSql, sql);
		   
		}else if("oracle".equalsIgnoreCase(this.dataBaseType)){
			return getOracleSql(start, end, pageSql, sql);
		}
		return sql;
	}
	private String getMySql(int start,int rows,StringBuffer sb,String sql){
		sb.append(sql);
		return sb.append("  limit "+start+","+rows+"").toString();
	}
	private String getOracleSql(int start,int end,StringBuffer sb,String sql){
		sb.append("select * from (select rownum r   ");
		sb.append(sql.substring(7));
		sb.append("where rownum<="+end+") where r>="+start);	
		return sb.toString();
	}
	

}
