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
	<div class=searchzone>
		<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
			<tbody>
				<tr>
					<td align=right colspan=3><input
						onclick="javascript:location.href='init.do?id=0'" type="button" value="添加角色"
						class="button"> <input onclick="location.href='list.do'"
						type="button" value="刷新" class="button" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	<form id="form" action="deleteAll.do" method="post">
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td class=biaoti width=29>选择</td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">角色名称</span></td>
						<td class=biaoti width=50><span class="searchzone">操作</span></td>
					</tr>
					<c:forEach items="${roles}" var="role" >
					<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'" id="user${role.id}">
						<td class=content><input type="checkbox"  value="${user.id}" name="ids"></td>
						<td class=content>${role.name}</td>
						<td class=content id="opt_${role.id}"><a href="javascript:edit(${role.id})">修改</a>
						&nbsp;&nbsp;<a href="javascript:DelRow(${role.id})">删除</a>
						&nbsp;&nbsp;<a href="javascript:location.href='initRoleMenu.do?id=${role.id}'">分配菜单</a></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class=piliang>
			<div style="float:left;">
				<input onclick="selAll()" type="checkbox" value="1"
				name="SelAll"> 全选&nbsp; <input class="button" type="submit"
				value="删除"
				onclick="doDelAll();" />
		    </div> 
			<div id="pagelist">
				${page.pageStr}
			</div>
		</div>
	</form>

	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.popdiv.js"></script>
	<script type="text/javascript" src="../../js/comm.js"></script>
	<script language="javascript" type="text/javascript">
		function selAll(){
			var theForm = document.getElementById("form");
			for ( i = 0 ; i < theForm.elements.length ; i ++ ){
				if ( theForm.elements[i].type == "checkbox" && theForm.elements[i].name != "SelAll" )
				{
					theForm.elements[i].checked = ! theForm.elements[i].checked ;
				}
			}
		}
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
						$("#user" + idx).remove();
						//设置关闭弹出层
					} else {
						alert("操作失败!error:" + result);
					}
				});
			}
		}
		function doDelAll(){
			if(confirm("确定要删除所选的吗？")){
				var arr=document.getElementsByName("ids");
				var ids='';
				for(i=0;i<arr.length;i++){
				  if(arr[i].checked){
					  	if(i==arr.length-1){
					  		ids+=arr[i].value;
					  	}else{
					  		ids+=arr[i].value+",";
					  	}
				  }
				}
				if(ids ==''){
					alert("请选择要删除的记录!");
				}else{
					var data = {    
						ids : ids
					};
					$.post("deleteAll.do", data, function(result) {
						if (result =="1"){
							alert("删除成功!");
							//$("#form2").submit();
						} else {
							alert("操作失败!error:" + result);
						}
					});
				}
				
			}
			
		}
	</script>


</body>
</html>
