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
<link href="../../js/getdate/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>

</head>
<body>

<form name="form" id="form" action="add.do" method="post" >
<c:if test="${user.id>0}">
<input type="hidden" name="id" value="${user.id}">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${user==null||user.id==0}">添加用户</c:if>
<c:if test="${user.id>0}">修改用户</c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <c:if test="${customerId==-1}">
  	<tr>
	    <td align=middle width=100 height=30>所属客户</td>
	    <td height=30>
	  		<select name="customerId">
	  			<option value="-1">系统管理员</option>
	  			<c:forEach items="${customers}" var="customer">
	  				<option label="${customer.name}" value="${customer.id}" <c:if test="${customer.id==user.customerId}">selected</c:if> />
	  			</c:forEach>
	  		</select>
		</td>
	</tr>
  </c:if>
  <tr>
    <td align=middle width=100 height=30>账号名称</td>
    <td height=30>
    	<input name="account" value="${user.account}"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>密码</td>
    <td height=30>
    	<input name="password" type="password" value=""/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>真实名称</td>
    <td height=30>
    	<input name="name" value="${user.name}"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>手机号码</td>
    <td height=30>
    	<input name="phone" value="${user.phone}"/>
    </td>
  </tr>
   <tr>
    <td align=middle width=100 height=30>邮箱</td>
    <td height=30>
    	<input name="cardNo" value="${user.email}"/>
   </tr>
    <tr>
    <td align=middle width=100 height=30>状态</td>
    <td height=30>
    	<input name="status" type="radio" value="1" <c:if test="${user.status==1}">checked</c:if><c:if test="${user==null||user.id==0}">checked</c:if> />正常
    	<input name="status" type="radio" value="0" <c:if test="${user.status==0}">checked</c:if>/>冻结
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
				account:"required",
				phone: {
					required:true,
					minlength:11,
					maxlength:11
				},
				email:{email:true}
			},
			messages: {
				account: "请填写账号名称",
				phone: {
					required:"请填写手机号",
					maxlength:"请填写正确的手机号",
					minlength:"请填写正确的手机号"
				},
				email:{
					email:"请填写正确的邮箱"
				}
			},
			submitHandler: function(form) {
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("操作成功!");
	                    	location.href="list.do";
	                    }else if(data==2){
	                    	alert("该账号已存在!");
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
