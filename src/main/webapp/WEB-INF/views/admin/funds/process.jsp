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
<form id="form" action="process.do" method="post">
	<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
      <td height="30" class="tx-c"><spring:message code="funds.label.name"/></td>
      <td><input name="fundsName" type="text" value="${fundsName}" maxlength="11" id="fundsName" class="dtext" /></td>
	  <td height="30" class="tx-c"><spring:message code="funds.label.type"/></td>
      <td>
      	<select name="type" id="type" style="width:160px;">
      		<option value=""><spring:message code="admin.label.select"/></option>
    		<option value="1" <c:if test="${type==1}">selected</c:if>><spring:message code="funds.label.type.income"/></option>
    		<option value="3" <c:if test="${type==3}">selected</c:if>><spring:message code="funds.label.type.outcome"/></option>
    		<option value="2" <c:if test="${type==2}">selected</c:if>><spring:message code="funds.label.type.borrowin"/></option>
    		<option value="4" <c:if test="${type==4}">selected</c:if>><spring:message code="funds.label.type.borrowout"/></option>
    	</select>
      </td>
    </tr>
    <tr>
      <td  height="30" class="tx-c"><spring:message code="order.label.providerName"/></td>
      <td>
      	<select name="providerName" id="providerName" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
    		<c:forEach items="${providers}" var="provider">
    			<option label="${provider.name}" value="${provider.name}" 
    				<c:if test="${provider.name==providerName}">selected</c:if> >
    			</option>
    		</c:forEach>
    	</select>
      
      </td>
   	  <td  class="tx-c"><spring:message code="funds.label.createTime"/></td>
      <td>
      	<input name="startTime" type="text" id="startTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${startTime}" readonly=true style="width:150px;" />
      	TO
      	<input name="endTime" type="text" id="endTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${endTime}" readonly=true style="width:150px;" />
	  </td>
    </tr>
    <tr>
      <td colspan="8" style="text-align:center;"><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
    </tr>
  </table>
		</div>
	</form>
	<div class=searchzone>
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td align=right colspan=3><input onclick="location.href='list.do'"
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
							class="searchzone"><spring:message code="funds.label.createTime"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="funds.label.name"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="funds.label.receiveUser"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="funds.label.transAmount"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="funds.label.overMoney"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="funds.label.mark"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="funds.label.userId"/></span></td>
					</tr>
					<c:forEach items="${process}" var="pro" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="fund${fund.id}">
							<td class=content>&nbsp;</td>
							<td class=content><fmt:formatDate value="${pro.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class=content>${pro.fundsName}</td>
							<td class=content>${pro.receiveUser}</td>
							<td class=content>
				    			<c:if test="${pro.type==1||pro.type==2}">
				    				+<fmt:formatNumber pattern="#,##0.00#" value="${pro.amount}" />
				    			</c:if>
				    			<c:if test="${pro.type==3||pro.type==4}">
				    				-<fmt:formatNumber pattern="#,##0.00#" value="${pro.amount}" />
				    			</c:if>
							</td>
							<td class=content><fmt:formatNumber pattern="#,##0.00#" value="${pro.balance}" /></td>
							<td class=content>${pro.mark}</td>
							<td class=content>${pro.userId}</td>
						</tr>
					</c:forEach>
					<tr>
						<td height=20 class=total style="text-align:left;" colspan="4"><spring:message code="admin.label.pagecount"/>：</td>
						<td height=20 class=total><fmt:formatNumber value="${money}" pattern="#,#00.00#"/></td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
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
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<script language="javascript" type="text/javascript">
		function edit(id){
			location.href="init.do?id="+id;
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
						$("#fund" + idx).remove();
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
