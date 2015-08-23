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
</head>

<body>
	<form id="form" action="list.do" method="post">
	<input type="hidden" name="menuId" value="${menuId}">
	<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
      <td height="30" class="tx-c"><spring:message code="fee.label.payNo"/></td>
      <td>	<input name="payNo" value="${payNo}" id="payNo"/> </td>
      <td height="30" class="tx-c"><spring:message code="fee.label.payAccount"/></td>
      <td><input name="payAccount" value="${payAccount}" id="payAccount"/> </td>
      <td height="30" class="tx-c"><spring:message code="fee.label.receiveUser"/></td>
      <td><input name="receiveUser" value="${receiveUser}" id="receiveUser"/> </td>
    </tr>
    <tr>
      <td height="30" class="tx-c"><spring:message code="fee.label.startDate"/></td>
      <td>	<input name="startDate" type="text" id="startDate" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${startDate}" readonly=true style="width:150px;" />
      </td>
       <td height="30" class="tx-c"><spring:message code="fee.label.endDate"/></td>
       <td><input name="endDate" type="text" id="endDate" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${endDate}" readonly=true style="width:150px;" />
      </td>
	  <td colspan="2" style="text-align:center;"><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
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
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.payNo"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.payAccount"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.amount"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.payTime"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.receiveUser"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.type"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="fee.label.userName"/></span></td>
						<td class=biaoti width=50><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${fees}" var="fee" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="fee${fee.id}">
							<td class=content>&nbsp;</td>
							<td class=content>${fee.payNo}</td>
							<td class=content>${fee.payAccount}</td>
							<td class=content>${fee.amount}</td>
							<td class=content>${fn:substring(fee.payTime, 0, 19)}</td>
							<td class=content>${fee.receiveUser}</td>
							<td class=content>
								<c:if test="${fee.type==1}"><spring:message code="fee.label.fare"/></c:if>
								<c:if test="${fee.type==2}"><spring:message code="fee.label.tel"/></c:if>
								<c:if test="${fee.type==3}"><spring:message code="fee.label.fee"/></c:if>
								<c:if test="${fee.type==4}"><spring:message code="fee.label.sample"/></c:if>
								<c:if test="${fee.type==5}"><spring:message code="fee.label.cash"/></c:if>
								<c:if test="${fee.type==6}"><spring:message code="fee.label.other"/></c:if>
							</td>
							<td class=content>${fee.userName}</td>
							<td class=content id="opt_${fee.id}">
							<c:if test="${update!=null}">
							&nbsp;&nbsp;<a href="javascript:edit(${fee.id})"><spring:message code="admin.label.edit"/></a>
							</c:if>
							<c:if test="${delete!=null}">
							&nbsp;&nbsp;<a href="javascript:DelRow(${fee.id})"><spring:message code="admin.label.delete"/></a>
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
		function detail(id){
			location.href="detail.do?id="+id;
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
						$("#fee" + idx).remove();
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
