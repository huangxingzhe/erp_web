<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
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
<c:if test="${employee.id>0}">
<input type="hidden" name="id" value="${employee.id}">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${employee==null||employee.id==0}">添加员工</c:if>
<c:if test="${employee.id>0}">修改员工</c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30>名称</td>
    <td height=30>
    	<input name="name" value="${employee.name}"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>手机</td>
    <td height=30>
    	<input name="phone" type="text" value="${employee.phone}"/>
    </td>
  </tr>
   <tr>
    <td align=middle width=100 height=30>邮箱</td>
    <td height=30>
    	<input name="email" value="${employee.email}"/>
   </tr>
   <tr>
    <td align=middle width=100 height=30>入职日期</td>
    <td height=30>
    	<input name="entryTime" type="text" id="entryTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="<fmt:formatDate value="${employee.entryDate}" pattern="yyyy-MM-dd"/>" readonly=true style="width:150px;" />
    </td>
  </tr>
   <tr>
    <td align=middle width=100 height=30>类型</td>
    <td height=30>
    	<select name="type" id="type">
    		<option value="1" <c:if test="${employee.type==1}">selected</c:if>>业务员</option>
    		<option value="2" <c:if test="${employee.type==2}">selected</c:if>>行政</option>
    	</select>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>薪资</td>
    <td height=30>
    	<input name="salary" id="salary" value="${employee.salary}" onblur="formatMoney(this)"/>
    </td>
  </tr>
    <tr>
    <td align=middle width=100 height=30>状态</td>
    <td height=30>
    	<input name="status" type="radio" value="1" <c:if test="${employee.status==1}">checked</c:if><c:if test="${employee==null||employee.id==0}">checked</c:if> />正常
    	<input name="status" type="radio" value="0" <c:if test="${employee.status==0}">checked</c:if>/>离职
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
	<script type="text/javascript" src="../../js/language.js"></script>
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript">
	jQuery(function() {
		var v = jQuery("#form").validate({
			rules: {
				name:"required"
			},
			messages: {
				name: "请填写员工名称"
			},
			submitHandler: function(form) {
				checkMoney('salary');
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("操作成功!");
	                    	location.href="list.do";
	                    }else if(data==2){
	                    	alert("该员工已存在!");
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
