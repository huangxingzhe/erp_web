<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>menu</title>
<link href="../css/css_menu.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
%>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript">
var menuId=0;
function gotoUrl(url,id){
	 parent.document.getElementById("main").src = ".."+url;
     document.getElementById("m"+id).className = 'thisclass';
     if(menuId>0 && menuId!=id) document.getElementById("m"+menuId).className = '';
     menuId = id;
}
</script>
</head>

<body>
<div class="menu">
<!-- Item 1 Strat -->
<dl>
<dt><a href="###"  target="_self">${menu.name}</a></dt>
    <dd id="items${menu.id}" style="display:block;">
        <ul>
        	<c:forEach items="${menus}" var="me" varStatus="status">
        		<c:if test="${status.index==0}">
        			<c:if test="${type!='nojump'}">
        				<script>top.document.getElementById("main").src = "<%=basePath%>${me.url}"</script>
        			</c:if>
        			<li id="m${me.id}"><a href="javascript:void(0)" target='main' onclick="gotoUrl('${me.url}','${me.id}')">${me.name}</a></li>
        		</c:if>
        		<c:if test="${status.index>0}">
        			<li id="m${me.id}"><a href="javascript:void(0)" target='main' onclick="gotoUrl('${me.url}','${me.id}')" id="s${status.index}">${me.name}</a></li>
        		</c:if>
				
			</c:forEach>
        </ul>
    </dd>
    
</dl><!-- Item 1 End -->

</div>
<script>
	var orderMenuId = ${menu.id};
	//8 表示订单管理
	if(orderMenuId!=null && orderMenuId !=undefined && orderMenuId ==8){
		$.getJSON("../admin/order/queryCount.do",function(data){
			for(var key in data){
			    $("#"+key).append('<span style="color:red;">('+data[key]+')</span>');
			}
		});
	}
</script>
</body>
</html>
