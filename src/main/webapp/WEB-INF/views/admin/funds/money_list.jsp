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
	<form id="form" action="list.do" method="post">
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
							class="searchzone"><spring:message code="money.label.month"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.receiveMoney"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.buyMoney"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.cnFee"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.vnFee"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.fee"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.manageFee"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.rent"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.salary"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.safe"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.water"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.tel"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.ext"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.profit"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.profitReceive"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="money.label.profitBuy"/></span></td>
						<td class=biaoti width=150><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${moneys}" var="money" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="money${money.id}">
							<td class=content>&nbsp;</td>
							<td class=content><fmt:formatDate value="${money.month}" pattern="yyyy-MM"/></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.receiveMoney}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.buyMoney}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.cnFee}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.vnFee}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.fee}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.manageFee}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.rent}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.salary}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.safe}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.water}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.tel}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.ext}" /></td>
							<td class=content><fmt:formatNumber type="number" pattern="#,##0.00#" value="${money.profit}" /></td>
							<td class=content><fmt:formatNumber type="percent"  value="${money.profitReceive}" /></td>
							<td class=content><fmt:formatNumber type="percent" value="${money.profitBuy}"/></td>
							<td class=content id="opt_${money.id}">
							<c:if test="${update!=null}">
								<a href="javascript:edit(${money.id})"><spring:message code="admin.label.edit"/></a>
							</c:if>
							</td>
						</tr>
					</c:forEach>
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
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<script language="javascript" type="text/javascript">
		function edit(id){
			location.href="init.do?id="+id;
		}
		
		function query(){
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
		function DelRow(idx) {
			if(confirm($.i18n.prop('confirm'))){
			    var data = {
					id : idx
				};
				$.post("delete.do", data, function(result) {
					if (result > 0) //成功 
					{
						alert($.i18n.prop('opSucc'));
						$("#money" + idx).remove();
						//设置关闭弹出层
					} else {
						alert($.i18n.prop('opFail')+"error:" + result);
					}
				});
			}
		}
		
		
	</script>

</body>
</html>
