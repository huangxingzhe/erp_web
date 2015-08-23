<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<form id="form" action="list.do" method="post" onsubmit="return check();">
	<input type="hidden" name="menuId" value="${menuId}">
	<input type="hidden" name="type" value="${timeType}" id="type"/>
	<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
	  <td class="tx-c">员工名称</td>
      <td>
      		<input type="hidden"  name="empId" value="${empId}"  />
    		<input  name="empName" value="${empName}" id="salesMan" readonly="readonly" onclick="showDialog(this,'业务员','../employee/dialog.do',25,100,2);"/>
	  </td> 
	  <td class="tx-c">产品名称</td>
      <td>
      	 	<input type="hidden" name="goodsId" value="${goodsId}"/>
			<input name="goodsName" value="${goodsName}" id="goodsName" readonly="readonly" onclick="showDialog(this,'产品名称','../goods/dialog.do',25,100,2);"/>
	  </td> 
      <td class="tx-c"><spring:message code="order.label.type"/></td>
      <td>
      	<select name="timeType" id="timeType" onchange="selectTimeType()">
      		<option value="2" <c:if test="${timeType==2}">selected</c:if>><spring:message code="order.label.month"/></option>
    		<option value="1" <c:if test="${timeType==1}">selected</c:if>><spring:message code="order.label.day"/></option>
    		<option value="3" <c:if test="${timeType==3}">selected</c:if>><spring:message code="order.label.year"/></option>
   		</select>
	  </td> 
      <td  class="tx-c"><spring:message code="order.label.payTime"/></td>
      <td colspan="2">
      	<span id="time1" style="display:none;">
      	<input name="dayTime" type="text" id="dateTime1" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${dayTime}" readonly=true style="width:150px;" />
      	TO
      	<input name="endDateTime" type="text" id="endDateTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${endDateTime}" readonly=true style="width:150px;" />
	 	</span>
	 	<span id="time2" style="display:none;">
      	<input name="monthTime" type="text" id="dateTime2" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM'});" value="${monthTime}" readonly=true style="width:150px;" />
	 	</span>
	 	<span id="time3" style="display:none;">
      	<input name="yearTime" type="text" id="dateTime3" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy'});" value="${yearTime}" readonly=true style="width:150px;" />
	 	</span>
	  </td>
	   <td><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
	   <td><input type="reset" value="清空 " class="button"></td>
    </tr>
  </table>
 </div>
	</form>
	<div class=searchzone>
	
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td align=right colspan=3>
				<c:if test="${add!=null}"><input
					onclick="javascript:location.href='init.do'" type="button" value="<spring:message code="admin.label.add"/>"
					class="button">
				</c:if>
				<input onclick="location.href='list.do'"
				type="button" value="<spring:message code="admin.label.refresh"/>" class="button" /></td>
			</tr>
		</tbody>
		</table>
	</div>
	
		<div class=listzone>
			<c:if test="${empName==null || empName==''}" >
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">业务员</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">销售金额</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">采购金额</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">中国运费</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">越南运费</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">利润</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">提成金额</span></td>
					</tr>
					<c:forEach items="${empMoneys}" var="money" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="money${money.id}">
							<td class=content>&nbsp;</td>
							<td class=content>${money.empName}</td>
						<td class=content><fmt:formatNumber value="${money.receiveMoney}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.buyMoney}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.cnFare}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.vnFare}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.profit}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.cut}" pattern="#,##0.00#"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
			<c:if test="${empName!=null && empName!=''}" >
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">业务员</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">合同编号</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">客户名称</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">付款时间</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">销售金额</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">采购金额</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">中国运费</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">越南运费</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">利润</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">计算范围</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">提成比</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">提成金额</span></td>
					</tr>
					<c:forEach items="${empMoneys}" var="money" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="money${money.id}">
							<td class=content>&nbsp;</td>
							<td class=content>${money.empName}</td>
							<td class=content>${money.payNo}</td>
							<td class=content>${money.cusName}</td>
							<td class=content>${fn:substring(money.payTime, 0, 19)}</td>
							<td class=content><fmt:formatNumber value="${money.receiveMoney}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.buyMoney}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.cnFare}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.vnFare}" pattern="#,##0.00#"/></td>
							<td class=content><fmt:formatNumber value="${money.profit}" pattern="#,##0.00#"/></td>
							<td class=content>${money.discount}</td>
							<td class=content>${money.rate}</td>
							<td class=content>${money.cut}</td>
						</tr>
					</c:forEach>
					<tr>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total style="text-align:left;"><spring:message code="admin.label.pagecount"/>：</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>￥<fmt:formatNumber value="${total.totalReceiveMoney}" pattern="#,##0.00#"/></td>
						<td height=20 class=total>￥<fmt:formatNumber value="${total.totalBuyMoney}" pattern="#,##0.00#"/></td>
						<td height=20 class=total>￥<fmt:formatNumber value="${total.totalCnFare}" pattern="#,##0.00#"/></td>
						<td height=20 class=total>￥<fmt:formatNumber value="${total.totalVnFare}" pattern="#,##0.00#"/></td>
						<td height=20 class=total>￥<fmt:formatNumber value="${total.totalProfit}" pattern="#,##0.00#"/></td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>￥<fmt:formatNumber value="${total.totalCut}" pattern="#,##0.00#"/></td>
					</tr>
				</tbody>
			</table>
			</c:if>
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
	<script language="javascript" type="text/javascript">
		function selectTimeType(){
			var type = $("#timeType").val();
			$("#time1").hide();
			$("#time2").hide();
			$("#time3").hide();
			if(type==''){
				type = 2;
			}
			$("#time"+type).show();
		}
		selectTimeType();
		function check(){
			var type = $("#timeType").val();
			var time = $("#dateTime"+type).val();
			if(time==''){
				alert("请选择付款时间!");
				return false;
			}
			return true;
		}
	</script>


</body>
</html>
