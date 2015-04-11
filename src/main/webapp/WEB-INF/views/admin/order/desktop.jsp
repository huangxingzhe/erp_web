<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>

</head>
<body>
<div class=formzone>
<div class=namezone>订单情况
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=200 height=30><spring:message code="order.label.status.sendToBorder"/>：
    	<span id="s2" style="color:red;text-decoration:underline"> 0 </span>笔
    </td>
    <td height=30>总金额：<span id="n2" style="color:red;text-decoration:underline">0</span>元</td>
  </tr>
   <tr>
    <td align=middle width=200 height=30><spring:message code="order.label.status.arrivedBorder"/>：
    	<span id="s3" style="color:red;text-decoration:underline"> 0 </span>笔
    </td>
    <td height=30>总金额：<span id="n3" style="color:red;text-decoration:underline">0</span>元</td>
  </tr>
   <tr>
    <td align=middle width=200 height=30><spring:message code="order.label.status.hadGet"/>：
    	<span id="s4" style="color:red;text-decoration:underline"> 0 </span>笔
    </td>
    <td height=30>总金额：<span id="n4" style="color:red;text-decoration:underline">0</span>元</td>
  </tr>
   <tr>
    <td align=middle width=200 height=30><spring:message code="order.label.status.sendToHN"/>：
    	<span id="s5" style="color:red;text-decoration:underline"> 0 </span>笔
    </td>
    <td height=30>总金额：<span id="n5" style="color:red;text-decoration:underline">0</span>元</td>
  </tr>
   <tr>
    <td align=middle width=200 height=30><spring:message code="order.label.status.sendToHCM"/>：
    	<span id="s6" style="color:red;text-decoration:underline"> 0 </span>笔
    </td>
    <td height=30>总金额：<span id="n6" style="color:red;text-decoration:underline">0</span>元</td>
  </tr>
   <tr>
    <td align=middle width=200 height=30><spring:message code="order.label.status.getMoney"/>：
    	<span id="s7" style="color:red;text-decoration:underline"> 0 </span>笔
    </td>
    <td height=30>总金额：<span id="n7" style="color:red;text-decoration:underline">0</span>元</td>
  </tr>
   </tbody>
</table>
</div>
</div>
</div>

	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<script type="text/javascript">
	 $(function(){
	        jQuery.i18n.properties({
	            name : 'strings', //资源文件名称
	            path : '../../js/i18n/', //资源文件路径
	            mode : 'map', //用Map的方式使用资源文件中的值
	            language :curlang ,
	            callback : function() {//加载成功后设置显示内容
	            }
	        });
	 });
	
	
	$.getJSON("queryCountAndAmount.do",function(data){
		for(var key in data){
			var val = data[key] ;
			if(val==undefined || val ==null){
				val =0;
			}
			if(key.indexOf("s")!=-1){
				$("#"+key).text(data[key]);
			}else{
				$("#"+key).text(data[key]);
			}
		}
	});
	</script>

</body>
</html>
