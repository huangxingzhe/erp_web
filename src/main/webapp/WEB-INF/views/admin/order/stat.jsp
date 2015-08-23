<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../js/getdate/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
<link href="../../css/dialog.css" type=text/css rel=stylesheet>
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
<script type="text/javascript" src="../../js/language.js"></script>
<script type="text/javascript"src="../../js/interface.js" ></script>

</head>

<body>
<form id="form" action="stat.do" method="post">
<input type="hidden" name="oname" value="${oname}" id="oname"/>
<input type="hidden" name="sort" value="${sort}" id="sort"/>
<input type="hidden" name="type" value="${timeType}" id="type"/>
	<div class=searchzone>
	<input type="hidden" name="status" value="${status}">
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
	 <td class="tx-c"><spring:message code="order.customer.cusName"/></td>
      <td>
      	<input type="hidden" name="cusId" value="${cusId}"/>
    	<input type="hidden" name="cusIdTest" value=""/>
		<input name="cusName" id="cusName" value="${cusName}" readonly="readonly" onclick="showDialog(this,'产品名称','../customer/dialog.do',25,100,2);"/>
      	<%-- <select name="cusNo" id="cusNo">
			<option value=""><spring:message code="admin.label.select"/></option>
			<c:forEach items="${customers}" var="cus" varStatus="status">
				<option value="${cus.code}" <c:if test="${cus.code==cusNo}">selected</c:if> >${cus.code}--${cus.name}</option>
			</c:forEach>
		</select> --%>
	  </td> 
      <td class="tx-c"><spring:message code="order.label.type"/></td>
      <td>
      	<select name="timeType" id="timeType" onchange="selectTimeType()">
    		<option value="1" <c:if test="${timeType==1}">selected</c:if>><spring:message code="order.label.day"/></option>
    		<option value="2" <c:if test="${timeType==2}">selected</c:if>><spring:message code="order.label.month"/></option>
    		<option value="3" <c:if test="${timeType==3}">selected</c:if>><spring:message code="order.label.year"/></option>
   		</select>
	  </td> 
      <td  class="tx-c"><spring:message code="order.label.payTime"/></td>
      <td colspan="2">
      	<span id="time1" style="display:none;">
      	<input name="startPayTime" type="text" id="startPayTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${startPayTime}" readonly=true style="width:150px;" />
      	TO
      	<input name="endPayTime" type="text" id="endPayTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${endPayTime}" readonly=true style="width:150px;" />
	 	</span>
	 	<span id="time2" style="display:none;">
      	<input name="yearMonth" type="text" id="yearMonth" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM'});" value="${yearMonth}" readonly=true style="width:150px;" />
	 	</span>
	 	<span id="time3" style="display:none;">
      	<input name="year" type="text" id="year" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy'});" value="${year}" readonly=true style="width:150px;" />
	 	</span>
	  </td>
	   <td><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
    </tr>
  </table>
		</div>
	</form>
	<div class=listzone>
		<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
			<tbody>
				<tr class=list>
					<td width="100" height=28 class=biaoti ><span
						class="searchzone"><spring:message code="order.customer.cusName"/></span></td>
					<td width="100" height=28 class=biaoti onclick="orderBy('amount')" ><span
						class="searchzone" style="cursor:pointer;"><spring:message code="order.label.amount" /></span></td>
					<td width="100" height=28 class=biaoti onclick="orderBy('cn_fare')"  ><span
						class="searchzone" style="cursor:pointer;"><spring:message code="order.label.cnFare" /></span></td>
					<td width="100" height=28 class=biaoti  onclick="orderBy('vn_fare')" ><span
						class="searchzone" style="cursor:pointer;"><spring:message code="order.label.vnFare"/></span></td>
					<td width="100" height=28 class=biaoti onclick="orderBy('goods_money')" ><span
						class="searchzone" style="cursor:pointer;"><spring:message code="order.label.goodsMoney" /></span></td>
				</tr>
				<c:forEach items="${orders}" var="order" varStatus="st">
					<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="order${order.id}">
						<td height=25 class=content>${order.customerName}</td>
						<td class=content>
							<fmt:formatNumber pattern="￥#,##0.00#" value="${order.amount}" />
						</td>
						<td height=25 class=content><fmt:formatNumber pattern="￥#,##0.00#" value="${order.cnFare}" /></td>
						<td height=25 class=content><fmt:formatNumber pattern="￥#,##0.00#" value="${order.vnFare}" /></td>
						<td class=content><fmt:formatNumber pattern="￥#,##0.00#" value="${order.goodsMoney}" /></td>
					</tr>
				</c:forEach>
				<tr bgcolor="#f2f9fd">
					<td height=25 colspan="3" class="total">&nbsp;</td>
					<td class="total">${allAmount}</td>
					<td class="total">${allGoodsMoney}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class=piliang>
			<div style="float:left;">
		    </div> 
			<div id="pagelist">
				${page.pageStr}
			</div>
	</div>
	<br/>
	<br/>
	<script type="text/javascript"  src="../../js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript"	src="../../js/highcharts/highcharts.js"></script>
	<script type="text/javascript"	src="../../js/highcharts/exporting.js"></script>
	<script type="text/javascript"  src="../../js/highcharts/data.js"></script> 
	<script type="text/javascript"  src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript"  src="../../js/language.js"></script>
	<script language="javascript" type="text/javascript">
		function selectTimeType(){
			var type = $("#timeType").val();
			$("#time1").hide();
			$("#time2").hide();
			$("#time3").hide();
			$("#time"+type).show();
		}
		function selectType(){
			var type = $("#type").val();
			if(type==undefined||type==''||type==null){
				type = 1;
			}
			$("#time"+type).show();
		}
		selectType();
		function orderBy(name){
			var oname = $("#oname").val();
			$("#oname").val(name);
			if(name==oname){
				var sort = $("#sort").val();
				if(sort=="desc"){
					$("#sort").val("asc");
				}else{
					$("#sort").val("desc");
				}
			}
			$("#form").submit();
		}
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
		var amount='${amount}'; 
		var num='${num}';
		var d1='${date}';
		if(amount!=undefined && amount !=''){
			$("#chart").show();
			show();
		}
		function show(){
			 $('#container').highcharts({
			      chart: {
			          type: 'areaspline'
			      },
			      title: {
			          text: ''
			      },
			      legend: {                               // 【图例】位置样式
			          layout: 'horizontal',               // 【图例】显示的样式：水平（horizontal）/垂直（vertical）
			          backgroundColor: '#FFFFFF',
			          borderColor: '#CCC',
			          borderWidth: 1,
			          align: 'center',
			          verticalAlign: 'top',
			          enabled:true,
			          y: 50,
			          shadow: true
			      },
			      xAxis: {
			          categories: d1, //X轴的坐标值
			          labels: {
			              rotation: -45,
			              align: 'right',
			              style: {font: 'normal 8px'}
			          }
			          
			      },
			      yAxis: {
			          title: {
			          	text: '金额-日期' //Y轴坐标标题  
			          }
			      },
			      tooltip: {
			      	 /* formatter: function() {  
			              // 当鼠标悬置数据点时的格式化提示
			               return '<b>'+ this.series.name +'</b><br/>'+  
			               '总金额:' + Highcharts.numberFormat(this.y, 1)+'元<br/>日期:'+ this.x +'';  
			         }   */
			      },
			      credits: {
			          enabled: false   
			      },
			      
			      series: [{
			          name:"金额",  
			          data: amount
			      }]
			  });
		}
	</script>


</body>
</html>
