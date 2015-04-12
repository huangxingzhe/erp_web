<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
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
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td align=right colspan=3><input
					onclick="javascript:location.href='init.do'" type="button" value="<spring:message code="admin.label.add"/>"
					class="button"> <input onclick="location.href='list.do'"
					type="button" value="<spring:message code="admin.label.refresh"/>" class="button" /></td>
			</tr>
		</tbody>
		</table>
	</div>
	
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="customer.label.name"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="customer.label.code"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="customer.label.status"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="customer.label.phone"/></span></td>
						<td width="150" height=28 class=biaoti><span
							class="searchzone"><spring:message code="customer.label.email"/></span></td>
						<td width="150" height=28 class=biaoti><span
							class="searchzone"><spring:message code="customer.label.address"/></span></td>
						<td class=biaoti width=50><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${customers}" var="customer" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'" id="customer${customer.id}">
							<td class=content>&nbsp;</td>
							<td class=content>${customer.name}</td>
							<td class=content>${customer.code}</td>
							<td class=content>
								<c:if test="${customer.status==1}"><spring:message code="admin.label.normal"/></c:if>
				    			<c:if test="${customer.status==2}"><spring:message code="admin.label.unnormal"/></c:if>
							</td>
							<td class=content>${customer.phone}</td>
							<td class=content>${customer.email}</td>
							<td class=content>${customer.address}</td>
							<td class=content id="opt_${customer.id}">
							<a href="javascript:edit(${customer.id})"><spring:message code="admin.label.edit"/></a>
							&nbsp;&nbsp;<a href="javascript:DelRow(${customer.id})"><spring:message code="admin.label.delete"/></a></td>
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
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<script language="javascript" type="text/javascript">
		function edit(id){
			location.href="init.do?id="+id;
		}
		function DelRow(idx) {
			if(confirm($.i18n.prop('confirm'))){
			    var data = {
					id : idx
				};
				$.post("delete.do", data, function(result) {
					if (result > 0) //成功 
					{
						alert($.i18n.prop('opSucc'));
						$("#customer" + idx).remove();
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
