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
	<div class=searchzone>
		<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
			<tr>
		      <td width="9%" height="30" class="tx-c">当前用户：<font color="red">${user.account}</font></td>
		      <td width="37%">&nbsp;</td>
		    </tr>
	    </table>
	</div>
	<form id="form" action="addUserRole.do" method="post">
		<input name="id" value="${user.id}" type="hidden"/>
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td height=30 class=biaoti><span
							class="searchzone">角色名称</span></td>
					</tr>
					<c:forEach items="${roles}" var="role" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'" >
							<td height="30"><input type="checkbox"  value="${role.id}" name="roleIds" id="role${role.id}" <c:if test="${role.checked!=null}">checked</c:if>>
							<strong>${role.name}</strong></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class=adminsubmit><input class="button" type="submit" value="提交" />  
			<input class="button" type="button" value="返回" onclick="history.go(-1)"/> 
		</div>
	</form>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript">
	jQuery(function() {
		var v = jQuery("#form").validate({
			rules: {
				roleIds:"required"
			},
			messages: {
				roleIds: "请选择角色"
			},
			errorPlacement: function(error, element) { //指定错误信息位置 
				if (element.is(':radio') || element.is(':checkbox')) { //如果是radio或checkbox 
					var eid = element.attr('name'); //获取元素的name属性 
					error.appendTo(element.parent()); //将错误信息添加当前元素的父结点后面 
					} else { 
					error.insertAfter(element); 
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
