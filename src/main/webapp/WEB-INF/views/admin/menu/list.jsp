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
</head>

<body>
<form id="form" action="updatePosition.do" method="post">
	<div class=searchzone>
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td align=right colspan=3><input
					onclick="javascript:location.href='init.do'" type="button" value="添加菜单"
					class="button"> <input onclick="location.href='list.do'"
					type="button" value="刷新" class="button" /><input class="button" type="submit" value="更新排序" /></td>
			</tr>
		</tbody>
		</table>
	</div>
	
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="10" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">菜单名称</span></td>
						<td width="150" height=28 class=biaoti><span
							class="searchzone">菜单URL</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">排序</span></td>
						<td class=biaoti width=50><span class="searchzone">操作</span></td>
					</tr>
					<c:forEach items="${menus}" var="menu" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="menu${menu.id}">
							<td class=content2>&nbsp;</td>
							<input type="hidden" name="menuIds" value="${menu.id}">
							<td class=content2><strong>${menu.name}</strong></td>
							<td class=content2>&nbsp;</td>
							<td class=content2><input type="text" name="positions" value="${menu.position}" style="width:20px;text-align:center;"></td>
							<td class=content2 id="opt_${menu.id}"><a href="javascript:edit(${menu.id})">修改</a>&nbsp;&nbsp;<a href="javascript:DelRow(${menu.id})">删除</a></td>
						</tr>
						<c:forEach items="${menu.childs}" var="child" >
							<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'" id="menu${child.id}">
							<td class=content2>&nbsp;</td>
							<input type="hidden" name="menuIds" value="${child.id}">
							<td class=content2>&nbsp;&nbsp;&nbsp;&nbsp;${child.name}</td>
							<td class=content2>${child.url}</td>
							<td class=content2><input type="text" name="positions" value="${child.position}" style="width:20px;text-align:center;"></td>
							<td class=content2 id="opt_${child.id}"><a href="javascript:edit(${child.id})">修改</a>&nbsp;&nbsp;<a href="javascript:DelRow(${child.id})">删除</a></td>
							</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class=piliang>
			<div style="float:left;">
				 
		    </div> 
		</div>
	
	<br/>
	<br/>
	</form>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script language="javascript" type="text/javascript">
		function edit(id){
			location.href="init.do?id="+id;
		}

		function DelRow(idx) {
			if(confirm("确定要删除吗?")){
			    var data = {
					id : idx,
				};
				$.post("delete.do", data, function(result) {
					if (result > 0) //成功 
					{
						alert("删除成功!");
						$("#menu" + idx).remove();
						//设置关闭弹出层
					} else {
						alert("操作失败!error:" + result);
					}
				});
			}
		}
		
	 $(function() {  
	        $("#form").submit(function(){  
	            $(this).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("更新排序成功!");
	                    }else{
	                    	alert("更新错误，请重新尝试!");
	                    }
	                }  
	            });  
	            return false; //不刷新页面  
	        });  
	    });  
	</script>


</body>
</html>
