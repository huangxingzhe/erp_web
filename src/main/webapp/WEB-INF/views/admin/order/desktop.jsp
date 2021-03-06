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
<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
  <tbody>
  	<tr class=list>
		<td width="150" height=28 class=biaoti><span
			class="searchzone">订单状态</span></td>
		<td width="150" height=28 class=biaoti><span
			class="searchzone">订单数</span></td>
		<td width="150" height=28 class=biaoti><span
			class="searchzone">货款金额(元)</span></td>
		<td width="150" height=28 class=biaoti><span
			class="searchzone">国内运费(元)</span></td>
		<td width="150" height=28 class=biaoti><span
			class="searchzone">越南运费(元)</span></td>
		<td width="150" height=28 class=biaoti><span
			class="searchzone">账转费用(元)</span></td>
	</tr>						
   <tr>
    <td width="150" class="content"><spring:message code="order.label.desktop.peddingsend"/>：</td>
    <td width=150 class="content"><a id="s1" href="javascript:void(0)" onclick="gotoUrl(1)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n1" href="javascript:void(0)" onclick="gotoUrl(1)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c1" href="javascript:void(0)" onclick="gotoUrl(1)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v1" href="javascript:void(0)" onclick="gotoUrl(1)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f1" href="javascript:void(0)" onclick="gotoUrl(1)" style="color:red;text-decoration:underline">0</a></td>
  </tr>
  <tr bgcolor="f2f9fd">
    <td width="150" class="content"><spring:message code="order.label.desktop.sendtoborder"/>：</td>
    <td width=150 class="content"><a id="s2" href="javascript:void(0)" onclick="gotoUrl(2)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n2" href="javascript:void(0)" onclick="gotoUrl(2)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c2" href="javascript:void(0)" onclick="gotoUrl(2)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v2" href="javascript:void(0)" onclick="gotoUrl(2)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f2" href="javascript:void(0)" onclick="gotoUrl(2)" style="color:red;text-decoration:underline">0</a></td>
 	
  </tr>
   <tr>
    <td width=150 class="content"><spring:message code="order.label.desktop.arriveborder"/>：</td>
    <td width=150 class="content"><a id="s3" href="javascript:void(0)" onclick="gotoUrl(3)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n3" href="javascript:void(0)" onclick="gotoUrl(3)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c3" href="javascript:void(0)" onclick="gotoUrl(3)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v3" href="javascript:void(0)" onclick="gotoUrl(3)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f3" href="javascript:void(0)" onclick="gotoUrl(3)" style="color:red;text-decoration:underline">0</a></td>
  	
  </tr>
   <tr bgcolor="f2f9fd">
    <td width=150 class="content"><spring:message code="order.label.desktop.hadget"/>：</td>
    <td width=150 class="content"><a id="s4" href="javascript:void(0)" onclick="gotoUrl(4)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n4" href="javascript:void(0)" onclick="gotoUrl(4)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c4" href="javascript:void(0)" onclick="gotoUrl(4)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v4" href="javascript:void(0)" onclick="gotoUrl(4)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f4" href="javascript:void(0)" onclick="gotoUrl(4)" style="color:red;text-decoration:underline">0</a></td>
  	
  </tr>
   <tr>
    <td width=150 class="content"><spring:message code="order.label.desktop.sendtohn"/>：</td>
    <td width=150 class="content"><a id="s5" href="javascript:void(0)" onclick="gotoUrl(5)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n5" href="javascript:void(0)" onclick="gotoUrl(5)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c5" href="javascript:void(0)" onclick="gotoUrl(5)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v5" href="javascript:void(0)" onclick="gotoUrl(5)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f5" href="javascript:void(0)" onclick="gotoUrl(5)" style="color:red;text-decoration:underline">0</a></td>
  	
  </tr>
   <tr bgcolor="f2f9fd">
    <td width=150 class="content"><spring:message code="order.label.desktop.sendtohcm"/>：</td>
     <td width=150 class="content"><a id="s6" href="javascript:void(0)" onclick="gotoUrl(6)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n6" href="javascript:void(0)" onclick="gotoUrl(6)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c6" href="javascript:void(0)" onclick="gotoUrl(6)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v6" href="javascript:void(0)" onclick="gotoUrl(6)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f6" href="javascript:void(0)" onclick="gotoUrl(6)" style="color:red;text-decoration:underline">0</a></td>
  	
  </tr>
  <tr>
    <td width=150 class="content"><spring:message code="order.label.desktop.goodsinware"/>：</td>
    <td width=150 class="content"><a id="s7" href="javascript:void(0)" onclick="gotoUrl(7)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n7" href="javascript:void(0)" onclick="gotoUrl(7)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c7" href="javascript:void(0)" onclick="gotoUrl(7)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v7" href="javascript:void(0)" onclick="gotoUrl(7)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f7" href="javascript:void(0)" onclick="gotoUrl(7)" style="color:red;text-decoration:underline">0</a></td>
 	
  </tr>
  <tr bgcolor="f2f9fd">
    <td width=150 class="content"><spring:message code="order.label.desktop.peddingreceivemoney"/>：</td>
    <td width=150 class="content"><a id="s8" href="javascript:void(0)" onclick="gotoUrl(8)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n8" href="javascript:void(0)" onclick="gotoUrl(8)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c8" href="javascript:void(0)" onclick="gotoUrl(8)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v8" href="javascript:void(0)" onclick="gotoUrl(8)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f8" href="javascript:void(0)" onclick="gotoUrl(8)" style="color:red;text-decoration:underline">0</a></td>
  	
  </tr>
  <tr>
    <td width=150 class="content"><spring:message code="order.label.desktop.finish"/>：</td>
    <td width=150 class="content"><a id="s9" href="javascript:void(0)" onclick="gotoUrl(9)" style="color:red;text-decoration:underline"> 0 </a></td>
    <td width=150 class="content"><a id="n9" href="javascript:void(0)" onclick="gotoUrl(9)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="c9" href="javascript:void(0)" onclick="gotoUrl(9)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="v9" href="javascript:void(0)" onclick="gotoUrl(9)" style="color:red;text-decoration:underline">0</a></td>
    <td width=150 class="content"><a id="f9" href="javascript:void(0)" onclick="gotoUrl(9)" style="color:red;text-decoration:underline">0</a></td>
 	
  </tr>
   </tbody>
</table>
<br>
<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
  <tbody>
   <tr>
    <td width="150" class="content">包含交易完成总计：</td>
    <td width=150 class="content">金额：<span id="amount1">0</span></td>
    <td width=150 class="content">订单数：<span id="num1">0</span></td>
    <td width=150 class="content">不含交易完成总计</td>
    <td width=150 class="content">金额：<span id="amount2">0</span></td>
    <td width=150 class="content">订单数：<span id="num2">0</span></td>
  </tr>
   </tbody>
</table>
</div>
<div class=tablezone>
<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
  <tbody>
  	<tr class=list>
		<td width="150" height=28 class=biaoti><span class="searchzone">上月采购额</span></td>
		<td width="150" height=28 class=content><span class="searchzone">待实现</span></td>
		<td width="150" height=28 class=biaoti><span class="searchzone">上月销售额</span></td>
		<td width="150" height=28 class=content><span class="searchzone">待实现</span></td>
	</tr>
	<tr class=list>
		<td width="150" height=28 class=biaoti><span class="searchzone">本月采购额</span></td>
		<td width="150" height=28 class=content><span class="searchzone"></span></td>
		<td width="150" height=28 class=biaoti><span class="searchzone">本月销售额</span></td>
		<td width="150" height=28 class=content><span class="searchzone"></span></td>
	</tr>
	<tr class=list>
		<td width="150" height=28 class=biaoti><span class="searchzone">本月/上月百分比</span></td>
		<td width="150" height=28 class=content><span class="searchzone"></span></td>
		<td width="150" height=28 class=biaoti><span class="searchzone">本月/上月百分比</span></td>
		<td width="150" height=28 class=content><span class="searchzone"></span></td>
	</tr>
	<tr class=list>
		<td width="150" height=28 class=biaoti><span class="searchzone">历史最高采购额</span></td>
		<td width="150" height=28 class=content><span class="searchzone"></span></td>
		<td width="150" height=28 class=biaoti><span class="searchzone">历史最高销售额</span></td>
		<td width="150" height=28 class=content><span class="searchzone"></span></td>
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
	$.getJSON("countAllNumAndAmount.do",function(data){
		for(var key in data){
			var val = data[key] ;
			if(val==undefined || val ==null){
				val =0;
			}
			$("#"+key).text(data[key]);
		}
	});
	function gotoUrl(id){
		 parent.document.getElementById("main").src = "../admin/order/list.do?status="+id;
	}
	</script>

</body>
</html>
