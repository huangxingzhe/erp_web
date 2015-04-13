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
	<form id="form2" action="list.do" method="post">
		<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
      <td width="9%" height="30" class="tx-c">账号:</td>
      <td width="37%"><input name="account" type="text" value="${account}" maxlength="11" id="account" class="dtext" /></td>
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
						<td width="100" height=28 class=biaoti><span
							class="searchzone">上次登录IP</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">本次登录IP</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">上次登录时间</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">本次登录时间</span></td>
						<td width="100" height=28 class=biaoti><span
						class="searchzone">登录次数</span></td>
					</tr>
					<c:forEach items="${logs}" var="log" varStatus="st">
					<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="user${user.id}">
						<td class=content>${st.index+1}</td>
						<td class=content>${log.account}</td>
						<td class=content>${log.lastIp}</td>
						<td class=content>${log.updateIp}</td>
						<td class=content><fmt:formatDate value="${log.lastTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td class=content><fmt:formatDate value="${log.updateTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td class=content>${log.num}</td>
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
