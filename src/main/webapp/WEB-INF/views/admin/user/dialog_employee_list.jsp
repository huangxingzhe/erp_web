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
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript">
        $(document).ready(function () {
            window.parent.loadingHide("loadImg", "dialogFrame");
        });
</script>
</head>

<body>
   <form action="dialog.do" method="post">
   <input type="hidden" value="6" name="pageCount" id="keyword"/>
	<div class=searchzone>
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td>
					搜索词：
					<select name="type" id="type">
						<option value="" >全部</option>
			    		<option value="1" <c:if test="${type==1}">selected</c:if>>名称</option>
			    		<option value="2" <c:if test="${type==2}">selected</c:if>>电话</option>
			    	</select>
			    	<input type="text" value="${keyword}" name="keyword" id="keyword"/>
			    	<input type="submit" value="查询" class="button" />
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
						<td width="20%" height=20 class=biaoti style="padding:0xp 0px;">名称</td>
						<td width="40%" height=20 class=biaoti>电话</td>
					</tr>
					<c:forEach items="${employees}" var="employee" >
						<tr onclick="parent.window.selectItem('salesMan','${employee.id}','${employee.phone}','${employee.name}')" style="cursor:pointer;"
						bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="good${good.id}">
							<td class=content>${employee.name}</td>
							<td class=content>${employee.phone}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="pagelist" style="padding-top:2px;">
				${page.pageStr}
			</div>
		</div>
	<br/>
	<br/>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>


</body>
</html>
