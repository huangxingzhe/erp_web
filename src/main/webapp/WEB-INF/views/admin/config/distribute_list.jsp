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
<form action="list.do" method="post">
	<div class=searchzone>
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td align=right colspan=3>
				<c:if test="${add!=null}">
				<input onclick="javascript:location.href='distributeInit.do'" type="button" value="<spring:message code="admin.label.add"/>" class="button"> 
				</c:if>	
				</td>
			</tr>
		</tbody>
		</table>
	</div>
	</form>
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">员工</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">项目</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">倍数</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">提成比例</span></td>
						<td class=biaoti width=50><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${emppros}" var="emppro" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="emppro${emppro.id}">
							<td class=content>&nbsp;</td>
							<td class=content>${emppro.employeeName}</td>
							<td class=content>${emppro.projectName}</td>
							<td class=content>${emppro.times}</td>
							<td class=content>${emppro.cut}</td>
							<td class=content id="opt_${emppro.id}">
							<c:if test="${update!=null}">
							<a href="javascript:edit(${emppro.id})"><spring:message code="admin.label.edit"/></a>
							</c:if>
							<c:if test="${delete!=null}">
								&nbsp;&nbsp;<a href="javascript:DelRow(${emppro.id})"><spring:message code="admin.label.delete"/></a>
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
			location.href="distributeInit.do?id="+id;
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
				$.post("distributeDelete.do", data, function(result) {
					if (result > 0) //成功 
					{
						alert($.i18n.prop('opSucc'));
						$("#emppro" + idx).remove();
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
