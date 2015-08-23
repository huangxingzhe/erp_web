<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>

</head>

<body>
	<div class=searchzone>
	<form id="form" action="all.do" method="post">
		<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
			<tbody>
				<tr>
					<td align=left colspan=3>
					<select name="year" id="year" onchange="query();">
						<c:forEach items="${years}" var="year">
							<option <c:if test="${year==selYear}">selected</c:if> >${year}</option>
						</c:forEach>
					</select>
					</td>
				</tr>
			</tbody>
			</table>
		</form>
	</div>
	
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">月份</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">采购金额</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">采购环比</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">销售金额</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">销售环比</span></td>
					</tr>
					<c:forEach items="${moneys}" var="money" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="money${money.id}">
							<td class=content>&nbsp;</td>
							<td class=content><fmt:formatDate value="${money.month}" pattern="yyyy-MM"/></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.receiveMoney}" /></td>
							<td class=content><fmt:formatNumber type="percent"  value="${money.receiveMOM}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.buyMoney}" /></td>
							<td class=content><fmt:formatNumber type="percent"  value="${money.buyMOM}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class=piliang>
			<div style="float:left;">
				 
		    </div> 
		</div>
	
	<br/>
	<br/>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script>
	function query(){
		$("#form").submit();
	}
	</script>

</body>
</html>
