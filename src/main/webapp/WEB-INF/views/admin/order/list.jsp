<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../js/getdate/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
<script type="text/javascript" src="../../js/jquery.min.js"></script>

</head>

<body>
<form id="form" action="list.do" method="post">
	<div class=searchzone>
	<input type="hidden" name="status" value="${status}">
	<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
      <td height="30" class="tx-c"><spring:message code="order.customer.cusNo"/></td>
      <td><input name="cusNo" type="text" value="${cusNo}" maxlength="11" id="cusNo" class="dtext" /></td>
	  <td height="30" class="tx-c"><spring:message code="order.customer.cusOrderNo"/></td>
      <td><input name="orderCode" type="text" value="${orderCode}" maxlength="11" id="orderCode" class="dtext" /></td>
       <td  height="30" class="tx-c"><spring:message code="order.label.payNo"/></td>
      <td><input name="payNo" type="text" value="${payNo}" maxlength="11" id="payNo" class="dtext" /></td>
    </tr>
    <tr>
      <td  height="30" class="tx-c"><spring:message code="order.label.logisticsOrder"/></td>
      <td><input name="logisticsOrder" type="text" value="${logisticsOrder}" maxlength="11" id="logisticsOrder" class="dtext" /></td>
      <td  height="30" class="tx-c"><spring:message code="order.label.logisticsName"/></td>
      <td><input name="logisticsName" type="text" value="${logisticsName}" maxlength="11" id="logisticsName" class="dtext" /></td>
      <td class="tx-c"><spring:message code="order.label.goodsName"/></td>
      <td>
      	<select name="goodsName" id="goodsName" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
	    	<c:forEach items="${goodss}" var="goods">
	   			<option label="${goods.name}" value="${goods.name}" 
	   				<c:if test="${goods.name==goodsName}">selected</c:if> >
	   			</option>
	   		</c:forEach>
   		</select>
	  </td> 
    </tr>
    <tr>
     
	  <td height="30" class="tx-c"><spring:message code="order.label.providerName"/></td>
      <td >
      	<select name="providerName" id="providerName" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
    		<c:forEach items="${providers}" var="provider">
    			<option label="${provider.name}" value="${provider.name}" 
    				<c:if test="${provider.name==providerName}">selected</c:if> >
    			</option>
    		</c:forEach>
    	</select>
      </td>
         <td  class="tx-c"><spring:message code="order.label.payTime"/></td>
      <td colspan="3">
      	<input name="startPayTime" type="text" id="startPayTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${startPayTime}" readonly=true style="width:150px;" />
      	TO
      	<input name="endPayTime" type="text" id="endPayTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${endPayTime}" readonly=true style="width:150px;" />
	  </td>
    </tr>
    <tr>
      <td colspan="8" style="text-align:center;"><input type="submit" value="<spring:message code="admin.label.query"/> " class="button"></td>
    </tr>
  </table>
		</div>
	</form>
	<div class=searchzone>
	<table height=30 cellspacing=0 cellpadding=0 width="100%" border=0>
		<tbody>
			<tr>
				<td align=right colspan=3><input
					onclick="javascript:location.href='init.do'" type="button" value="<spring:message code="admin.label.add"/>"
					class="button"> <input onclick="location.href='list.do?status=${status}'"
					type="button" value="<spring:message code="admin.label.refresh"/>" class="button" />
					<input onclick="exportXLS();"
					type="button" value="<spring:message code="admin.label.export"/>" class="button" />
					</td>
			</tr>
		</tbody>
		</table>
	</div>
	
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<tr class=list>
						<td width="25" height=28 class=biaoti><span
							class="searchzone">&nbsp;</span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.payNo"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.customer.cusName"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.providerName"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.goodsName"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.payTime"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone">
							<c:if test="${status==1}">
								<spring:message code="order.label.createTime"/>
							</c:if>
							<c:if test="${status==2}">
								<spring:message code="order.label.sendTime"/>
							</c:if>
							<c:if test="${status==3}">
								<spring:message code="order.label.boderTime"/>
							</c:if>
							<c:if test="${status==4}">
								<spring:message code="order.label.arriveTime"/>
							</c:if>
							<c:if test="${status==5}">
								<spring:message code="order.label.getTime"/>
							</c:if>
							<c:if test="${status==6}">
								<spring:message code="order.label.getTime"/>
							</c:if>
							<c:if test="${status==7}">
								<spring:message code="order.label.inWareTime"/>
							</c:if>
							<c:if test="${status==8}">
									<spring:message code="order.label.customerTime"/>
							</c:if>
							<c:if test="${status==9}">
								<spring:message code="order.label.moneyTime"/>
							</c:if>
							</span></td>
						<td width="70" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.days"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.goodsPic"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.borderAddr"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.goalAddr"/></span></td>
						<td width="50" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.num"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.amount"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.receiveMoney"/></span></td>
						<td width="100" height=28 class=biaoti><span
							class="searchzone"><spring:message code="order.label.profit"/></span></td>
						<td class=biaoti width=150><span class="searchzone">
							<spring:message code="admin.label.op"/>
						</span></td>
					</tr>
					<c:forEach items="${orders}" var="order" varStatus="st">
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#f2f9fd'" onmouseout="this.bgColor='#FFFFFF'" id="order${order.id}">
							<td height=25 class=content>${st.index+1}</td>
							<td class=content>${order.payNo}</td>
							<td class=content >
								<script>
									var name ="";
									var oId = ${order.id};
								</script>
								<c:forEach items="${order.oCusList}" var="ocus" varStatus="ot">
									<script> 
										name+="${ocus.cusName} | ";
									</script>
									<c:if test="${ot.index<3}">
										${ocus.cusName}<br>
									</c:if>
									<c:if test="${ot.index>2 && ot.last}">
										<span title="" id="cusName${order.id}">...</span>
										<script> 
											$("#cusName"+oId).attr("title",name);
										</script>
									</c:if>
								</c:forEach>
							</td>
							<td class=content width=100>${order.providerName}</td>
							<td class=content>${order.goodsName}</td>
							<td class=content>${fn:substring(order.payTime, 0, 19)}</td>
							<td class=content title="<spring:message code="order.label.createTime"/>:<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"><fmt:formatDate value="${order.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class=content>${order.days}<spring:message code="order.label.date"/></td>
							<td class=content><img src="showPhoto.do?path=${order.picUrl}" width="26" height="26" border="0" id="preImg" onmouseover="showImg(this,event);" onmouseout="hideImg();"></td>
							<td class=content>
								<c:if test="${order.borderAddr==1}"><spring:message code="order.label.border.dongxing"/></c:if>
								<c:if test="${order.borderAddr==2}"><spring:message code="order.label.border.pingxiang"/></c:if>
							</td>
							<td class=content>
								<c:if test="${order.goalAddr==1}"><spring:message code="order.label.goal.hn"/></c:if>
								<c:if test="${order.goalAddr==2}"><spring:message code="order.label.goal.hcm"/></c:if>
							</td>
							<td class=content>${order.num}</td>
							<td class=content title="<spring:message code="order.label.cnFare"/>:${order.cnFare}&nbsp;<spring:message code="order.label.vnFare"/>:${order.vnFare}&nbsp;<spring:message code="order.label.fee"/>:${order.fee}"">
								<fmt:formatNumber type="number" pattern="￥.00" value="${order.amount}" />
							</td>
							<td class=content>
								<fmt:formatNumber type="number" pattern="￥.00" value="${order.receiveMoney}" />
							</td>
							<td class=content>
								<fmt:formatNumber type="percent" value="${order.profit}" />
							</td>
							<td id="opt_${order.id}" class=content>
							<a href="javascript:detail(${order.id},${order.status})"><spring:message code="admin.label.detail"/></a>
								<c:if test="${order.status==1}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
											<br>
										<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.sendToBorder"/></a>
									</c:if>
									
								</c:if>
								<c:if test="${order.status==2}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
									<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.arrivedBorder"/></a>
									</c:if>
								</c:if>
								<c:if test="${order.status==3}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
									<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.hadGet"/></a>
									</c:if>
								</c:if>
								<c:if test="${order.status==4}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
										<c:if test="${order.goalAddr==1}">
											<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.sendToHN"/></a>
										</c:if>
										<c:if test="${order.goalAddr==2}">
											<a href="javascript:update(${order.id},${order.status+1})"><spring:message code="order.label.status.sendToHCM"/></a>
										</c:if>
									</c:if>
								</c:if>
								<c:if test="${order.status==5}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
										<a href="javascript:update(${order.id},${order.status+1})"><spring:message code="order.label.status.goodsWare"/></a>
									</c:if>
								</c:if>
								<c:if test="${order.status==6}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
										<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.goodsWare"/></a>
									</c:if>
								</c:if>
								<c:if test="${order.status==7}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
										<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.receive"/></a>
									</c:if>
								</c:if>
								<c:if test="${order.status==8}">
									<c:if test="${sessionScope.session_login_admin_roleid==1}">
										<a href="javascript:edit(${order.id})"><spring:message code="admin.label.edit"/></a>
										<a href="javascript:DelRow(${order.id})"><spring:message code="admin.label.delete"/></a>
										<br>
										<a href="javascript:update(${order.id},${order.status})"><spring:message code="order.label.status.getMoney"/></a>
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="11" height=20 class=total style="text-align:left;"><spring:message code="admin.label.pagecount"/>：</td>
						<td height=20 class=total>${nums}</td>
						<td height=20 class=total>￥${amounts}</td>
						<td height=20 class=total>￥${receiveMoney}</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="11" height=20 class=total style="text-align:left;"><spring:message code="admin.label.totalcount"/>：</td>
						<td height=20 class=total>${totalNums}</td>
						<td height=20 class=total>￥${totalAmounts}</td>
						<td height=20 class=total>￥${totalReceiveMoney}</td>
						<td height=20 class=total>&nbsp;</td>
						<td height=20 class=total>&nbsp;</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class=piliang>
			<div style="float:left;">
		    </div> 
			<div id="pagelist">
				${page.pageStr}
			</div>
		</div>
		<div id="productImg" style="display: none; top: 127px; left: 681px;"></div>
	<br/>
	<br/>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<script language="javascript" type="text/javascript">
		function edit(id){
			location.href="init.do?id="+id;
		}
		
		function detail(id){
			location.href="init.do?id="+id+"&type=detail";
		}
		
		 $(function(){
		        jQuery.i18n.properties({
		            name : 'strings', //资源文件名称
		            path : '../../js/i18n/', //资源文件路径
		            mode : 'map', //用Map的方式使用资源文件中的值
		            language :curlang ,
		            callback : function() {//加载成功后设置显示内容
		            }
		        });
		 });
		function update(id,status){
   			if(confirm($.i18n.prop('submit'))){
   				var data = {
   						id : id,
   						status:status
   					};
   					$.post("updateStatus.do", data, function(result) {
   						if (result =="success") //成功 
   						{
   							alert($.i18n.prop('opSucc'));
   							//$("#order" + id).remove();
   							top.document.getElementById("menu").src = './getMenusById.do?id=8&type=nojump';
   							location.href="list.do?status="+${status};
   							//设置关闭弹出层
   						} else {
   							alert($.i18n.prop('opFail')+"error:" + result);
   						}
   					});
   			}
   			
   		}
   		function DelRow(idx) {
   			if(confirm($.i18n.prop('confirm'))){
   			    var data = {
   					id : idx
   				};
   				$.post("delete.do", data, function(result) {
   					if (result > 0) //成功 
   					{
   						alert($.i18n.prop('opSucc'));
   						top.document.getElementById("menu").src = './getMenusById.do?id=8&type=nojump';
   						location.href="list.do?status="+${status};
   						//设置关闭弹出层
   					} else {
   						alert($.i18n.prop('opFail')+"error:" + result);
   					}
   				});
   			}
   		}
   		
   		function exportXLS(){
	   		 $("#form").attr("action","export.do");
	   		 $("#form").submit();
   		}
   		function showImg(obj, event) {
   		    var pImg = document.getElementById("productImg");
   		    var src = obj.src;
   		    var leftPx = getOffsetLeft(obj) + 38;
   		    var topPx = getOffsetTop(obj) - 40;
   		    if (topPx > 300) {
   		        topPx = 300;
   		    }
   		    event = event || window.event;
   		    pImg.style.display = "block";
   		    pImg.innerHTML = '<img src="' + src + '" />';
   		    pImg.style.top = topPx + "px";
   		    pImg.style.left = leftPx + "px";
   		}
   		function hideImg() {
   		    var pImg = document.getElementById("productImg");
   		    pImg.innerHTML = "";
   		    pImg.style.display = "none";
   		}

   		function getOffsetLeft(o) {
   		    var left = 0;
   		    while (o != null && o != document.body) {
   		        left += o.offsetLeft;
   		        o = o.offsetParent;
   		    }
   		    return left;
   		}

   		function getOffsetTop(o) {
   		    var top = 0;
   		    while (o != null && o != document.body) {
   		        top += o.offsetTop;
   		        o = o.offsetParent;
   		    }
   		    return top;
   		}
	</script>


</body>
</html>
