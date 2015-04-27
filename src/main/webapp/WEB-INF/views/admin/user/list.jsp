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
	<form id="form2" action="list.do" method="post">
	<input type="hidden" name="menuId" value="${menuId}">
		<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
      <td width="9%" height="30" class="tx-c">账号</td>
      <td width="37%"><input name="account" type="text" value="${account}" maxlength="11" id="account" class="dtext" /></td>
      <td width="16%">&nbsp;</td>
      <td width="11%" class="tx-c">状态</td>
      <td>
      	<input name="status" type="text" value="${status}" maxlength="11" id="status" class="dtext" />
	</td>
    </tr>
    <tr>
      <td height="30" class="tx-c">手机</td>
      <td><input name="phone" type="text" value="${phone}" maxlength="11" id="phone" class="dtext" /></td>
      <td>&nbsp;</td>
      <td class="tx-c">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    
    <tr>
      <td height="40" class="tx-c">&nbsp;</td>
      <td>&nbsp;</td>
      <td><input type="submit" value=" 查  询  " class="button"></td>
      <td class="tx-c">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
		</div>
		</form>
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td class=biaoti width=29>选择</td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">账号</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">姓名</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">状态</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">手机</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">日期</span></td>
						<td class=biaoti width=100><span class="searchzone">操作</span></td>
					</tr>
					<c:forEach items="${users}" var="user" >
					<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="user${user.id}">
						<td class=content><input type="checkbox"  value="${user.id}" name="ids"></td>
						<td class=content>${user.account}</td>
						<td class=content>${user.name}</td>
						<td class=content><c:if test="${user.status==1}">正常</c:if><c:if test="${user.status==0}">冻结</c:if></td>
						<td class=content>${user.phone}</td>
						<td class=content><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td class=content id="opt_${user.id}">
						<c:if test="${update!=null}">
						<a href="javascript:edit(${user.id})">修改</a>
						</c:if>
						<c:if test="${delete!=null}">
 						&nbsp;&nbsp;<a href="javascript:DelRow(${user.id})">删除</a>
 						</c:if>
 						<c:if test="${bind!=null}">
						&nbsp;&nbsp;<a href="javascript:bindRole(${user.id})">分配角色</a>
						</c:if>
						</td>
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
		
		function bindRole(id){
			window.location.href="bindRole.do?id="+id;
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
							location.href="list.do";
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
