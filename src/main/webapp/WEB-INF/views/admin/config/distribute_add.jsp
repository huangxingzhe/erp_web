<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
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

<form name="form" id="form" action="distribute.do" method="post" >
<c:if test="${emppro.id>0}">
<input type="hidden" name="id" value="${emppro.id}">
</c:if>
<div class=formzone>
<div class=namezone>用户分配项目</div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30>员工</td>
    <td height=30>
    	<select name="employeeId" id="employeeId" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
    		<c:forEach items="${employees}" var="employee">
    			<option value="${employee.id}" <c:if test="${employee.id==emppro.employeeId}">selected</c:if>>${employee.name}</option>
    		</c:forEach>
    	</select>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>项目</td>
    <td height=30>
    	<select name="projectId" id="projectId" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
    		<c:forEach items="${projects}" var="project">
    			<option value="${project.id}" <c:if test="${project.id==emppro.projectId}">selected</c:if>>${project.name}</option>
    		</c:forEach>
    	</select>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>倍数</td>
    <td height=30>
    	<input name="times" value="${emppro.times}" id="times"/>
   </tr>
   <tr>
    <td align=middle width=100 height=30>提成比率</td>
    <td height=30>
    	<input name="cut" value="${emppro.cut}" id="cut"/>
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
				employeeId:"required",
				projectId:"required",
				times:{number:true},
				cut:{number:true}
			},
			messages: {
				employeeId: "请选择员工",
				projectId: "请选择项目",
				times:"请输入数字",
				cut:"请输入数字"
			},
			submitHandler: function(form) {
				checkMoney('salary');
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("操作成功!");
	                    	location.href="distributeList.do";
	                    }else if(data==2){
	                    	alert("该员工已分配过此项目!");
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
