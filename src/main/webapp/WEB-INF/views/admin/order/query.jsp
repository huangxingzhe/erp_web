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

</head>

<body>
<form id="form" action="query.do" method="post">
	<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
	  <td height="30" class="tx-c"><spring:message code="order.customer.cusOrderNo"/></td>
      <td><input name="orderCode" type="text" value="${orderCode}" maxlength="11" id="orderCode" class="dtext" /></td>
      <td height="30" class="tx-c"><spring:message code="order.customer.cusNo"/></td>
      <td><input name="cusNo" type="text" value="${cusNo}" maxlength="11" id="cusNo" class="dtext" /></td>
      <td class="tx-c"><spring:message code="order.customer.cusName"/></td>
      <td>
      	<input name="cusName" type="text" value="${cusName}" maxlength="11" id="cusName" class="dtext" />
	  </td>
	  <td colspan="6" style="text-align:center;"><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
    </tr>
  </table>
		</div>
	</form>
	<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="25" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusOrderNo"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusNo"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusName"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.createTime"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.goodsName"/></span></td>
						<td class=biaoti width=150><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${orderCustomers}" var="customer" varStatus="st">
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="order${order.id}">
							<td height=25 class=content>${st.index+1}</td>
							<td class=content>${customer.orderCode}</td>
							<td class=content>${customer.cusNo}</td>
							<td class=content>${customer.cusName}</td>
							<td class=content><fmt:formatDate value="${customer.order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class=content>${customer.order.goodsName}</td>
							<td class=content>
								<a href="javascript:detail(${customer.id})"><spring:message code="admin.label.query"/></a>
							</td>
						</tr>
						<tr style="display:none" id="cus${customer.id}">
							<td class=content colspan="7">
								<ul>
								<c:forEach items="${customer.times}" var="time" varStatus="st2">
									<li>步骤：${st2.index+1}&nbsp;&nbsp;
									<c:if test="${time.status!=7}">
										<c:if test="${time.status==1}">
											<spring:message code="order.label.desktop.peddingsend"/>
										</c:if>
										<c:if test="${time.status==2}">
											<spring:message code="order.label.desktop.sendtoborder"/>
										</c:if>
											<c:if test="${time.status==3}">
										<spring:message code="order.label.desktop.arriveborder"/>
										</c:if>
										<c:if test="${time.status==4}">
											<spring:message code="order.label.desktop.hadget"/>
										</c:if>
										<c:if test="${time.status==5}">
											<spring:message code="order.label.desktop.sendtohn"/>
										</c:if>
										<c:if test="${time.status==6}">
											<spring:message code="order.label.desktop.sendtohcm"/>
										</c:if>
										&nbsp;&nbsp;时间：<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:if>
									</li>
									
								</c:forEach>
								</ul>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="productImg" style="display: none; top: 127px; left: 681px;"></div>
	<br/>
	<br/>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<script language="javascript" type="text/javascript">
		
		function detail(cusId){
			$("#cus"+cusId).toggle();
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
	</script>


</body>
</html>
