<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="../images/favicon.ico"/>
<title>ThaiGiang Manager System</title>
</head>
	<frameset rows="63,*" cols="*" frameborder="no" border="0" framespacing="0">
		<frame src="top.do" name="topFrame" id="topFrame" scrolling="no" noresize />
		<frameset cols="176,*" name="bodyFrame" id="bodyFrame" frameborder="no" border="0" framespacing="0"  >
			<frame src="menu.do" name="menu" id="menu" scrolling="auto" noresize />
			<frame src="right.do" name="main" id="main" scrolling="auto" noresize />
			
		</frameset>
	</frameset>
	
</html>
<DIV class=menu style="FLOAT: right" onClick="document.location.href ='logout.do'">退出</DIV>
<DIV id="changepass" class=menu style="FLOAT: right" onClick="document.getElementById('mainframe').src=''">修改密码</DIV>
     
  	<TR vAlign=top>
    <TD>
    <iframe src="right.do"  id=mainframe name=mainframe marginHeight=0  frameBorder=0 width="100%" scrolling=none height="100%"></iframe>
   </TD></TR>
   </TBODY>
   </TABLE>   
