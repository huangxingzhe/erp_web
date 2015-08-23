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
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
<script type="text/javascript"src="../../js/interface.js" ></script> 
<script type="text/javascript" src="../../js/language.js"></script>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../css/dialog.css" type=text/css rel=stylesheet>
</head>

<body>
<form action="list.do" method="post">
	<div class=searchzone>
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td>
					产品名称：
					<input type="hidden"  name="goodsId" value="${goodsId}"  />
					<input type="text" name="goodsName" value="${goodsName}" id="goodsName" readonly="readonly" onclick="showDialog(this,'产品名称','../goods/dialog.do',25,100,2);"/>
					<input type="submit" value="查询" class="button" />
				</td>
				<td align="right">
					<c:if test="${add!=null}">
						<input onclick="javascript:location.href='init.do'" type="button" value="<spring:message code="admin.label.add"/>" class="button"> 
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
							class="searchzone">产品名称</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">计算方法</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">计算范围</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">提成比率</span></td>
						<td class=biaoti width=50><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${rates}" var="rate" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="rate${rate.id}">
							<td class=content>&nbsp;</td>
							<td class=content>${rate.goodsName}</td>
							<td class=content>
								<c:if test="${rate.type==1}">按折扣</c:if>
				    			<c:if test="${rate.type==2}">按数量</c:if>
							</td>
							<td class=content>${rate.discount}</td>
							<td class=content>${rate.rate}</td>
							<td class=content id="opt_${rate.id}">
							<c:if test="${update!=null}">
							<a href="javascript:edit(${rate.id})"><spring:message code="admin.label.edit"/></a>
							</c:if>
							<c:if test="${delete!=null}">
							&nbsp;&nbsp;<a href="javascript:DelRow(${rate.id})"><spring:message code="admin.label.delete"/></a>
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
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
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
						$("#rate" + idx).remove();
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
