<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %> 
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="../images/favicon.ico"/>

<title>ThaiGiang Manager System</title>
<style type="text/css">
<!--
*{
	padding:0px;
	margin:0px;
	font-family:Verdana, Arial, Helvetica, sans-serif;
}
body {
	margin: 0px;
	font-size:12px;
}
input{
	vertical-align:middle;
}
img{
	border:none;
	vertical-align:middle;
}
a{
	color:#2366A8;
	text-decoration: none;
}
a:hover{
	color:#2366A8;
	text-decoration:underline;
}
.main{
	width:640px;
	margin:120px auto 0px;
	background:#FFF;
	padding-bottom:10px;
}

.main .title{
	width:600px;
	height:50px;
	margin:0px auto;
	background:url(../images/login_toptitle.jpg) -10px 0px no-repeat;
	text-indent:326px;
	line-height:46px;
	font-size:14px;
	letter-spacing:2px;
	color:#F60;
	font-weight:bold;
}

.main .login{
	width:630px;
	margin:20px auto 0px;
	overflow:hidden;
}
.main .login .inputbox{
	width:230px;
	float:right;
	background-image: url(../images/login_input_hr.gif);
	background-repeat: no-repeat;
	background-position: left center;
	padding-left: 20px;
	padding-top:20px;
	padding-right:20px;
}
.main .login .inputbox dl{
	height:40px;
	padding-button:12px;
	clear:both;
}
.main .login .inputbox dl dt{
	float:left;
	width:50px;
	height:25px;
	line-height:25px;
	text-align:right;
	padding-right: 5px;
}
.main .login .inputbox dl dd{
	width:160px;
	float:left;
	padding-top:1px;
}
.main .login .inputbox dl dd input{
	font-size:12px;
	border:1px solid #dcdcdc;
	height: 18px;
	line-height: 18px;
	padding-right: 2px;
	padding-left: 2px;
	background-image: url(../images/login_input_bg.gif);
	background-repeat: no-repeat;
	background-position: left top;
}
.main   .login   .inputbox   dl   .input  {
	padding-top:30px;
	width:57px;
	height:23px;
	background:url(../images/login_submit.gif) no-repeat;
	border:none;
	cursor:pointer;
}


.main .login .butbox{
	float:left;
	width:300px;
	padding-left:50px;
}
.main .login .butbox dl{
	
}
.main .login .butbox dl dt{
	height:130px;
	background-repeat: no-repeat;
}
.main .login .butbox dl dd{
	height:21px;
	line-height:21px;
}



.main .msg{
	clear:both;
	line-height:20px;
	border:1px solid #DCDCDC;
	color:#888;
	margin-left: 55px;
	background-color: #FFFFFF;
	padding-right: 2px;
	padding-left: 2px;
	width: 130px;
	margin-bottom: 3px;
}
.contact{
	width:640px;
	text-align:center;
	font-size:10px;
	margin-top: 150px;
	margin-right: auto;
	margin-bottom: 10px;
	margin-left: auto;
}
.copyright{
	width:640px;
	text-align:center;
	font-size:10px;
	color:#999999;
	margin-top: 20px;
	margin-right: auto;
	margin-bottom: 10px;
	margin-left: auto;
}
.copyright a{
	font-weight:bold;
	color:#F63;
	text-decoration:none;
}
.copyright a:hover{
	color:#000;
}
-->
</style>
<script type="text/javascript" language="javascript">
<!--
	window.onload = function (){
		var txtUserName = document.getElementById("username");
		var txtPassword = document.getElementById("password");
		changeimg();
		var username = readCookie("username");
		if(username!="")
		{
		txtUserName.value = username;
		txtPassword.focus();
		}
		else	txtUserName.focus();
		document.getElementById("code").value = "";
	}
function changeimg(){document.getElementById('SeedImg').src='../inc/checkcode.asp?'+Math.random();}
function writeCookie(name, value, hours){
  var expire = "";
  if(hours != null)  {
    expire = new Date((new Date()).getTime() + hours * 3600000);
    expire = "; expires=" + expire.toGMTString();
  }
  document.cookie = name + "=" + escape(value) + expire;

}
function readCookie(name){
  var cookieValue = "";
  var search = name + "=";
  if(document.cookie.length > 0) { 
    offset = document.cookie.indexOf(search);
    if (offset != -1)  { 
      offset += search.length;
      end = document.cookie.indexOf(";", offset);
      if (end == -1) end = document.cookie.length;
      cookieValue = unescape(document.cookie.substring(offset, end))
    }
  }
  return cookieValue;
}


-->
</script>
</head>
<body>
	<div class="main">
		<div class="login">
		<form method="post" action="login.do" id="form" name="form">
            <div class="inputbox">
				<dl>
					<dt>用户名：</dt>
					<dd><input type="text"  id="account" name="account" size="20" value="" maxlength="20" onfocus="this.style.borderColor='#239fe3'" onblur="this.style.borderColor='#dcdcdc'" />
					</dd>
				</dl>
				<dl>
					<dt>密码：</dt>
					<dd><input type="password" id="password" maxlength="20" name="password" value="" size="20" onfocus="this.style.borderColor='#239fe3'" onblur="this.style.borderColor='#dcdcdc'" />
					</dd>
				</dl>
				<!-- 
				<dl>
					<dt>验证码：</dt>
					<dd><input type="text" id="code" name="code"   size="10" maxlength="4" onfocus="this.style.borderColor='#239fe3'" onblur="this.style.borderColor='#dcdcdc'" /><img src="../inc/checkcode.asp" id="SeedImg" align="absmiddle" style="cursor:pointer;" border="0" alt="点我刷新" title="点我刷新" onclick="changeimg()" />
					 
					</dd>
				</dl>		
				 -->		              		
		        <dl>
				  <dt>&nbsp;</dt>
					<dd>
					  <input name="submit" type="submit" value="" id="submit" class="input" />
		  	</dd>
				</dl>
            </div>
            <div class="butbox">
            <dl>
				<dt style="background-image: url(../images/logo.jpg)"></dt>
			  </dl>
			</div>
		</form>
        <div style="clear:both"></div>
	  </div>
	</div>
	<div class="contact">
		Liên hệ：0962634222   &nbsp;&nbsp; EMAIL：thaigiangvietnam@gmail.com
	</div>
	<div class="copyright">
		Copyright © 2010 - 2015 ThaiGiang. All Rights Reserved
	</div>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../js/jquery.form.js"></script>
	<script type="text/javascript">
	jQuery(function() {
		var v = jQuery("#form").validate({
			rules: {
				account:"required",
				password:"required"
			},
			messages: {
				account: "&nbsp;&nbsp;请填写登录账号",
				password:"&nbsp;&nbsp;请填写登录密码"
			},
			submitHandler: function(form) {
				$("#submit").attr("disabled", true); 
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	location.href="../admin/index.do";
	                    }else if(data==2 || data==3){
	                    	$("#submit").attr("disabled", false); 
	                    	alert("登录账号或密码不正确!");
	                    }else if(data ==4){
	                    	alert("IP地址错误，请联系管理员!");
	                    	$("#submit").attr("disabled", false); 
	                    }else{
	                    	$("#submit").attr("disabled", false); 
	                    	alert("系统错误，请尝试再登录!");
	                    }
	                }  
	            });
			}
		});
		
	});
	</script>
</body>
</html>
