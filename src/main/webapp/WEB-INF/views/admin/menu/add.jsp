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
<c:if test="${menu.id>0}">
<input type="hidden" name="id" value="${menu.id}" id="menuId">
<input type="hidden" name="level" value="${menu.level}">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${menu==null||menu.id==0}">添加菜单</c:if>
<c:if test="${menu.id>0}">修改菜单</c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30>所属菜单</td>
    <td height=30>
    	<select name="pid" >
    		<option value="0">顶级菜单</option>
    		<c:forEach items="${menus}" var="me">
    			<option label="${me.name}" value="${me.id}" <c:if test="${me.id==menu.pid}">selected</c:if> ></option>
    		</c:forEach>
    	</select>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>菜单名称</td>
    <td height=30>
    	<input name="name" value="${menu.name}" id="name"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>菜单URL</td>
    <td height=30>
    	<input name="url" value="${menu.url}" id="url"/>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30>排序</td>
    <td height=30>
    	<input name="position" value="${menu.position}" id="position"/>
   </tr>
   </tbody>
</table>
</div>
<div class=adminsubmit><input class="button" type="submit" value="提交" />  
<input class="button" type="button" value="返回" onclick="javascript:location.href='list.do'"/> 
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
				name:"required",
				position:{
					required:true,
					digits:true}
			},
			messages: {
				name: "请填写菜单名称",
				position:{
					required:"请填写排序号",
					digits:"请填写整数"
				}
			},
			submitHandler: function(form) {
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("操作成功!");
	                    	var menuId = $("#menuId").val();
	                    	if(menuId == undefined||menuId==''){
	                    		$("#name").val("");
		                    	$("#url").val("");
		                    	$("#position").val("");
	                    	}else{
	                    		location.href="list.do";
	                    	}
	                    	
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
