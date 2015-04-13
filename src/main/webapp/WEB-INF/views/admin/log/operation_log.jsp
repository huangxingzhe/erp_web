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
	<form id="form2" action="opLogList.do" method="post">
		<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
      <td  height="30" class="tx-c">账号:</td>
      <td><input name="account" type="text" value="${account}" maxlength="11" id="account" class="dtext" /></td>
       <td  height="30" class="tx-c">类型:</td>
      <td >
      	<select name="item" id="item">
      		<option value="">--选择类型--</option>
      		<option value="8" <c:if test="${item==8}">selected</c:if>>新增订单</option>
      		<option value="9" <c:if test="${item==9}">selected</c:if>>编辑订单</option>
      		<option value="1" <c:if test="${item==1}">selected</c:if>>操作确认发货</option>
      		<option value="2" <c:if test="${item==2}">selected</c:if>>操作确认到边界</option>
      		<option value="3" <c:if test="${item==3}">selected</c:if>>操作确认已提取</option>
      		<option value="4" <c:if test="${item==4}">selected</c:if>>操作确认发往河内</option>
      		<option value="5" <c:if test="${item==5}">selected</c:if>>操作确认发往胡志明</option>
      		<option value="6" <c:if test="${item==6}">selected</c:if>>操作确认客户已收货</option>
      		<option value="7" <c:if test="${item==7}">selected</c:if>>操作确认已收款</option>
      	</select>
      </td>
       <td  class="tx-c">登录时间:</td>
      <td>
      	<input name="startTime" type="text" id="startTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="${startTime}" readonly=true style="width:150px;" />
      	TO
      	<input name="endTime" type="text" id="endTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="${endTime}" readonly=true style="width:150px;" />
	  </td>
	  <td><input type="submit" value=" 查  询  " class="button"></td>
    </tr>
    
  </table>
		</div>
		</form>
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td class=biaoti width=29>&nbsp;</td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">账号</span></td>
						<td width="150" height=28 class=biaoti><span
							class="searchzone">操作类型</span></td>
						<td width="150" height=28 class=biaoti><span
							class="searchzone">操作时间</span></td>
						<td width="300" height=28 class=biaoti><span
							class="searchzone">操作内容</span></td>
					</tr>
					<c:forEach items="${logs}" var="log" varStatus="st">
					<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="user${user.id}">
						<td class=content>${st.index+1}</td>
						<td class=content>${log.account}</td>
						<td class=content>
					      		<c:if test="${log.item==8}">新增订单</c:if>
					      		<c:if test="${log.item==9}">编辑订单</c:if>
					      		<c:if test="${log.item==1}">操作确认发货</c:if>
					      		<c:if test="${log.item==2}">操作确认到边界</c:if>
					      		<c:if test="${log.item==3}">操作确认已提取</c:if>
					      		<c:if test="${log.item==4}">操作确认发往河内</c:if>
					      		<c:if test="${log.item==5}">操作确认发往胡志明</c:if>
					      		<c:if test="${log.item==6}">操作确认客户已收货</c:if>
					      		<c:if test="${log.item==7}">操作确认已收款</c:if>
						</td>
						<td class=content><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td class=content style="text-align:left;padding-left:5px;">${log.content}</td>
						
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class=piliang>
			<div id="pagelist">
				${page.pageStr}
			</div>
		</div>
</body>
</html>
