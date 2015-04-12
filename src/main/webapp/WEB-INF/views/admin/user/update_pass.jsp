<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
</head>
<body>

<form name="form" id="form" action="updatePass.do" method="post" >
<c:if test="${user.id>0}">
<input type="hidden" name="id" value="${user.id}">
</c:if>
<div class=formzone>
<div class=namezone>修改密码</div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30>旧密码</td>
    <td height=30>
    	<input type="password" name="password" value=""/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>新密码</td>
    <td height=30>
    	<input type="password" name="newPass"  value="" id="newPass"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>确认密码</td>
    <td height=30>
    	<input  type="password" name="rePass" value=""/>
    </td>
  </tr>
   </tbody>
</table>
</div>
<div class=adminsubmit><input class="button" type="submit" value="提交" />  
<input class="button" type="button" value="返回" onclick="history.go(-1)"/> 
</div>
</div>
</form>

	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript">
	jQuery(function() {
		var v = jQuery("#form").validate({
			rules: {
				 password: {
				    required: true
				 },
				 newPass: {
					    required: true,
					    minlength: 6
				 },
				 rePass: {
				    required: true,
				    minlength: 6,
				    equalTo: "#newPass"
				 }
			},
			messages: {
				 password: {
				    required: "请输入旧密码"
				   },
				 newPass: {
					    required: "请输入新密码",
					    minlength: jQuery.format("密码不能小于{0}个字 符")
					},
				 rePass: {
				    required: "请输入确认密码",
				    minlength: "确认密码不能小于6个字符",
				    equalTo: "两次输入密码不一致"
				   }
			},
			submitHandler: function(form) {
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("操作成功!");
	                    	//location.href="list.do";
	                    }else{
	                    	alert("操作错误，请重新提交尝试!");
	                    }
	                }  
	            });
			}
		});
		
	});
	</script>

</body>
</html>
