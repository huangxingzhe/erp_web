package com.hxx.erp.controller.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.solr.client.solrj.SolrRequest.METHOD;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.MapSolrParams;
import org.springframework.util.StringUtils;

public class App {
	/**
     * 初始化索引数据
     * @param solrServer
     * @throws Exception
     */ 
    public static void buildIndex(String solrServer)throws Exception {  
        Connection connect = null;  
        Statement statement = null;  
        ResultSet resultSet = null;  
        HttpSolrServer server = null;  
        long start = System.currentTimeMillis();
        try {  
            Class.forName("com.mysql.jdbc.Driver");  
            connect = DriverManager  
                    .getConnection("jdbc:mysql://localhost/erp?" 
                            + "user=root&password=123456");  
            statement = connect.createStatement();  
            resultSet = statement  
                    .executeQuery("select pay_no,goods_name,provider_name,pay_time,location from t_order_info");  
            long end = System.currentTimeMillis();
            System.out.println("times:"+(end -start) +" size:"+resultSet.getFetchSize());
//            server = new HttpSolrServer(solrServer);  
 
            int count = 0;  
 
            int eachCommit = 100;  
            //从数据库中获取酒店数据  
            while (resultSet.next()) {  
                String pay_no = resultSet.getString(1);  
                String goods_name = resultSet.getString(2);  
                String provider_name = resultSet.getString(3);  
                Date pay_time = resultSet.getDate(4);  
                String location = resultSet.getString(5);  
                if (StringUtils.isEmpty(location)) {  
                    continue;  
                }  
                count++;  
                //添加酒店数据到Solr索引中  
                SolrInputDocument doc = new SolrInputDocument();  
                doc.addField("pay_no", pay_no);  
                doc.addField("goods_name", goods_name);  
                doc.addField("provider_name", provider_name);  
                doc.addField("pay_time", pay_time);  
                doc.addField("latlng", location);  
//                server.add(doc);  
                //100条commit一次  
                if (count % eachCommit ==0) {  
//                    server.commit();  
                    count = 0;  
                }  
            }  
            if (count > 0) {  
//                server.commit();  
                count = 0;  
            }  
        } finally {  
            if (null != resultSet) {  
                try {  
                    resultSet.close();  
                } catch (SQLException ex) {  
 
                }  
            }  
            if (null != statement) {  
                try {  
                    statement.close();  
                } catch (SQLException ex) {  
 
                }  
            }  
            if (null != connect) {  
                try {  
                    connect.close();  
                } catch (SQLException ex) {  
 
                }  
            }  
        }  
    }  
    public static void main(String[] args)throws Exception {  
    	long start = System.currentTimeMillis();
        String URL = "http://localhost:8080/solr/core0";  
        //构建索引到Solr库  
        buildIndex(URL);  
            //索引周边查询  
//        queryTest(URL);  
        long end = System.currentTimeMillis();
//        System.out.println("times:"+(end-start)+"ms");
    }  
    /**
     * 测试索引查询
     * http://localhost:8080/solr/core0/select?q=*%3A*&fq=%7B%21geofilt%7D&pt=31.26552%2C121.460815&sfield=latlng&d=2&sort=geodist%28%29+asc&fl=*%2Cscore&start=0&rows=10
     * @param solrServer
     * @throws Exception
     */ 
    public static void queryTest(String solrServer)throws Exception {  
    	long start = System.currentTimeMillis();
        HttpSolrServer server = new HttpSolrServer(solrServer);  
        Map<String,String> params = new HashMap<String,String>();   
        params.put("q", "*:*");  
        params.put("fq", "{!geofilt}");//距离过滤函数 
        params.put("pt", "31.26552,121.460815");//当前经纬度 
        params.put("sfield", "latlng");//经纬度的字段 
        params.put("d", "200");//就近2公里的所有酒店  
        params.put("sort", "geodist() asc");//根据距离排序 
//        params.put("fl", "*,score");  
        params.put("start", "0");//记录开始位置  
        params.put("rows", "10");//查询的行数  
        QueryResponse resp = server.query(new MapSolrParams(params), METHOD.POST);  
        SolrDocumentList docs = resp.getResults();  
        for(int i=0;i<docs.size();i++){  
            System.out.println(docs.get(i));  
        }  
        long end = System.currentTimeMillis();
        System.out.println((end-start)+"ms");
    }  

}
