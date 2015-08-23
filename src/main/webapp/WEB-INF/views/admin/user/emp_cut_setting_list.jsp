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
<link href="../../css/dialog.css" type=text/css rel=stylesheet>
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
<script type="text/javascript" src="../../js/language.js"></script>
<script type="text/javascript"src="../../js/interface.js" ></script>
</head>

<body>
	<form id="form2" action="list.do" method="post">
	<input type="hidden" name="menuId" value="${menuId}">
	<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
    <tr>
     <td>
     	业务员：
     	<input type="hidden"  name="empId" value="${setting.empId}"  />
    	<input  name="salesMan" value="${setting.empName}" id="salesMan" readonly="readonly" onclick="showDialog(this,'业务员','../employee/dialog.do',25,100,2);"/>
     </td>
     <td>
     	客户名称：
     	<input type="hidden" name="cusId" value="${setting.cusId}"/>
    	<input type="hidden" name="cusIdTest" value=""/>
		<input name="cusName" id="cusName" value="${setting.cusName}" readonly="readonly" onclick="showDialog(this,'产品名称','../customer/dialog.do',25,100,2);"/>
     </td>
     <td>
     	产品名称：
     	<input type="hidden" name="goodsId" value="${setting.goodsId}"/>
		<input name="goodsName" value="${setting.goodsName}" id="goodsName" title="" readonly="readonly" onclick="showDialog(this,'产品名称','../goods/dialog.do',25,100,2);"/>
     </td>
      <td><input type="submit" value=" 查  询  " class="button"></td>
    </tr>
  </table>
		</div>
		</form>
		<div class=searchzone>
		<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
			<tbody>
				<tr>
					<td align=right colspan=3><input
						onclick="javascript:location.href='init.do'" type="button" value="添加"
						class="button"> <input onclick="location.href='list.do'"
						type="button" value="刷新" class="button" /></td>
				</tr>
			</tbody>
			</table>
		</div>
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td class=biaoti width=29>选择</td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">业务员</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">客户</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">产品</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">计算方法</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">计算范围</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">提成率</span></td>
						<td class=biaoti width=100><span class="searchzone">操作</span></td>
					</tr>
					<c:forEach items="${settings}" var="setting" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="setting${setting.id}">
							<td class=content><input type="checkbox"  value="${setting.id}" name="ids"></td>
							<td class=content>${setting.empName}</td>
							<td class=content>${setting.cusName}</td>
							<td class=content>${setting.goodsName}</td>
							<td class=content>
								<c:if test="${setting.type==1}">按折扣</c:if>
				    			<c:if test="${setting.type==2}">按数量</c:if>
							</td>
							<td class=content>${setting.discount}</td>
							<td class=content>${setting.rate}</td>
							<td class=content id="opt_${setting.id}">
							<c:if test="${update!=null}">
							<a href="javascript:edit(${setting.id})">修改</a>
							</c:if>
							<c:if test="${delete!=null}">
	 						&nbsp;&nbsp;<a href="javascript:DelRow(${setting.id})">删除</a>
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
						$("#setting" + idx).remove();
						//设置关闭弹出层
					} else {
						alert("操作失败!error:" + result);
					}
				});
			}
		}
		//分配项目
		function addProject(id){
			window.location.href="distributeProject.do?id="+id;
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
