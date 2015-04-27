<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../js/getdate/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/language.js"></script>
<script language="javascript" type="text/javascript">
	function edit(id){
		location.href="init.do?id="+id;
	}
	function detail(cusId){
		$("#cus"+cusId).toggle();
	}
	function getStatusName(statusName,process,clss){
		var pro='<div class="proce '+clss+'">'+
			'<ul><li class="tx1">&nbsp;</li></ul>'+
		'</div>';
		var html='<div class="node wait">'+
		'<ul>'+
		'<li class="tx1">&nbsp;</li>'+
		'<li class="tx2">'+statusName+'</li>'+
		'<li id="track_time_0" class="tx3">&nbsp;</li>'+
	    '</ul></div>';
	    if(process){
	    	 html=pro+html;
	    }
	    return html;
	}
</script>
</head>

<body>
<form id="form" action="query.do" method="post">
	<div class=searchzone>
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
	  <td height="30" class="tx-c"><spring:message code="order.customer.cusOrderNo"/></td>
      <td><input name="orderCode" type="text" value="${orderCode}" maxlength="11" id="orderCode" class="dtext" /></td>
      <c:if test="${sessionScope.session_login_admin_roleid==1|| sessionScope.session_login_admin_roleid==3}">
	      <td height="30" class="tx-c"><spring:message code="order.customer.cusNo"/></td>
	      <td><input name="cusNo" type="text" value="${cusNo}" maxlength="11" id="cusNo" class="dtext" /></td>
	      <td class="tx-c"><spring:message code="order.customer.cusName"/></td>
	      <td>
	      	<input name="cusName" type="text" value="${cusName}" maxlength="11" id="cusName" class="dtext" />
		  </td>
	  </c:if>
	  <c:if test="${sessionScope.session_login_admin_roleid!=1&&sessionScope.session_login_admin_roleid!=3}">
	      <td height="30" class="tx-c" colspan="4">&nbsp;</td>
	  </c:if>
	  <td colspan="6" style="text-align:center;"><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
    </tr>
  </table>
		</div>
	</form>
	<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="25" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusOrderNo"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusNo"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusName"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.createTime"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.goodsName"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.num"/></span></td>
						<td class=biaoti width=150><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${orderCustomers}" var="customer" varStatus="st">
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="order${order.id}">
							<td height=25 class=content>${st.index+1}</td>
							<td class=content>${customer.orderCode}</td>
							<td class=content>${customer.cusNo}</td>
							<td class=content>${customer.cusName}</td>
							<td class=content><fmt:formatDate value="${customer.order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class=content>${customer.order.goodsName}</td>
							<td class=content>${customer.sendNum}</td>
							<td class=content>
								<a href="javascript:detail(${customer.id})"><spring:message code="admin.label.query"/></a>
								<c:if test="${sessionScope.session_login_admin_roleid==1}">
								&nbsp;&nbsp;
								<a href="javascript:edit(${customer.order.id})"><spring:message code="admin.label.edit"/></a>
								</c:if>
							</td>
						</tr>
						<tr style="display:none" id="cus${customer.id}">
							<td class=content colspan="8">
							<div id="process${customer.id}" class="process">
								<script> 
									var status="";
									var cusId = ${customer.id};
								</script>
			<div class="node ready">
				<ul>
					<li class="tx1">&nbsp;</li>
					<li class="tx2"><spring:message code="order.label.query.peddingsend"/></li>
					<li id="track_time_0" class="tx3">
					<fmt:formatDate value="${customer.order.createTime}" pattern="yyyy-MM-dd"/> <br>
					<fmt:formatDate value="${customer.order.createTime}" pattern="HH:mm:ss"/>
					</li>
				</ul>
			</div>
			<c:forEach items="${customer.times}" var="time" varStatus="st2">
			<script> 
				status+="${time.status}"+",";
			</script>
				<c:if test="${time.status==2}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.sendtoborder"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
					
				</c:if>
				<c:if test="${time.status==3}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.arriveborder"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
					
				</c:if>
				<c:if test="${time.status==4}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.hadget"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
					
				</c:if>
				<c:if test="${time.status==5}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.sendtohn"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
				</c:if>
			<c:if test="${time.status==6}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.sendtohcm"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
				</c:if>
				<c:if test="${time.status==7}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.goodsinware"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
				</c:if>
				<c:if test="${time.status==8}">
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.customergetgoods"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
				</c:if>
				<c:if test="${time.status==9}">
					<script> 
						status+="10"+",";
					</script>
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.getmoney"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
					<div class="proce ready">
						<ul><li class="tx1">&nbsp;</li></ul>
					</div>
					<div class="node ready">
						<ul>
							<li class="tx1">&nbsp;</li>
							<li class="tx2"><spring:message code="order.label.query.finish"/></li>
							<li id="track_time_0" class="tx3">
							<fmt:formatDate value="${time.finishTime}" pattern="yyyy-MM-dd"/> <br>
							<fmt:formatDate value="${time.finishTime}" pattern="HH:mm:ss"/>
							</li>
						</ul>
					</div>
				</c:if>
			</c:forEach>
			<script> 
				var allstatus="";
				var isHN = ${customer.order.goalAddr};//1河内 2胡志明
				if(isHN==1){
					allstatus ="2,3,4,5,7,8,9,10";
				}else{
					allstatus = "2,3,4,6,7,8,9,10";
				}
				var unstatus = new Array();
                 if(status==""){
                 	unstatus = allstatus.split(",");
                 }else{
                 	var st=allstatus.split(",");
                 	var index = 0;
                 	for(var i=0;i<st.length;i++){
                 		if(status.indexOf(""+st[i])==-1){
                 			unstatus[index++] =st[i];
                 		}
                 	}
                 }
                var statusName="";
				var process=true;
				var clss='wait';
				for(var i=0;i<unstatus.length;i++){
					if(i==0){
						clss='doing';
					}else{
						clss='wait';
					}
					process=true;
					if(unstatus[i]==2){
						statusName = '<spring:message code="order.label.query.sendtoborder"/>';
					}else if(unstatus[i]==3){
						statusName = '<spring:message code="order.label.query.arriveborder"/>';
					}else if(unstatus[i]==4){
						statusName = '<spring:message code="order.label.query.hadget"/>';
					}else if(unstatus[i]==5){
						statusName = '<spring:message code="order.label.query.sendtohn"/>';
					}else if(unstatus[i]==6){
						statusName = '<spring:message code="order.label.query.sendtohcm"/>';
					}else if(unstatus[i]==7){
						statusName = '<spring:message code="order.label.query.goodsinware"/>';
					}else if(unstatus[i]==8){
						statusName = '<spring:message code="order.label.query.customergetgoods"/>';
					}else if(unstatus[i]==9){
						statusName = '<spring:message code="order.label.query.getmoney"/>';
					}else if(unstatus[i]==10){
						statusName = '<spring:message code="order.label.query.finish"/>';
					}
					$("#process"+cusId).append(getStatusName(statusName,process,clss));
				}
                      
			</script>
							</div>	
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="productImg" style="display: none; top: 127px; left: 681px;"></div>
	<br/>
	<br/>
	


</body>
</html>
