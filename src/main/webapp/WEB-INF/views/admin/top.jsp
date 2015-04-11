<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %> 
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Top</title>
<link href="../css/css_top.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.sitelink table{float:left}
label{ float:left; 
height:20px; line-height:20px;/* display:block;width:65px;*/
border:#1684bf 1px solid;
border-right:0px;
}
.lang{
	border:#1684bf 1px solid;
	border-left:0px;
	float:left;			
	height:22px;
	line-height:22px
	/*BEHAVIOR: url('/css/selectBox.htc');*/
}
</style>

</head>
<body>
<div class="topnav">
	<div class="sitenav">
		<div class="welcome">
			<spring:message code="admin.top.hello"/>：<span class="username">${session_login_admin_account}</span>
            <a href="<%=basePath%>/customer/user/editPass.do" target="main"><spring:message code="admin.top.updatepass"/></a>
			<a href="../login/logout.do" target="_parent"><spring:message code="admin.top.logout"/></a>
			<select id="selLang" onchange="changeLang(this.value)">
				<option value="zh">简体中文</option>
				<option value="en">English</option>
				<option value="vi">Tiếng Việt</option>
			</select>
		</div>
		<div class="resize">
		<a href="javascript:ChangeMenu(-1)"><img src='../images/frame-l.gif' border='0' alt="减小左框架"></a>
	    <a href="javascript:ChangeMenu(0)"><img src='../images/frame_on.gif' border='0' alt="隐藏/显示左框架"></a>
	    <a href="javascript:ChangeMenu(1)" title=""><img src='../images/frame-r.gif' border='0' alt="增大左框架"></a>
    </div>
	</div>
	<div class="leftnav">
		<ul>
			<li class="navleft"></li>
			<c:forEach items="${menus}" var="menu" varStatus="status">
				<li id="d${status.index+1}"><a href="javascript:OpenMenu('${menu.id}','','',${status.index+1})">${menu.name}</a></li>
			</c:forEach>
			<li class="navright"></li>
		</ul>
	</div>
</div>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/menu.js"></script>
<script>
	var cl = getCookie("clientlanguage");
    $("#selLang").val(cl);
   	function changeLang(value){
   		if(value==undefined || value==''){
   			return;
   		}
		$.ajax({
			type:'post',
			url:'changeLang.do',
			data: "lang=" +value,//要发送的数据
			dataType:'json',
			success:function(result){
				if("success"==result){
					window.parent.location.reload();
					//window.location.href="index.do";
				}
	         }
		});
   		
   	}
    function getCookie(name){
        var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
        if(arr != null) { return unescape(arr[2]);} else{  return null; }
      }
   </script>
</body>
</html>
