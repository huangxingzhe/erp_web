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
<link href="../../css/dialog.css" type=text/css rel=stylesheet>
<link href="../../js/getdate/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<LINK href="http://res.gm.17188.com/oss_files/jquery-ui-1.9.1.custom.css" rel="stylesheet" type="text/css">    
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
<script type="text/javascript" src="../../js/language.js"></script>
<script type="text/javascript"src="../../js/interface.js" ></script> 
<script>
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
<jsp:include page="/WEB-INF/views/admin/order/image_upload.html" />
<form name="form" id="form" action="add.do" method="post">
<c:if test="${order.id>0}">
<input type="hidden" name="id" value="${order.id}" id="orderId">
<input type="hidden" name="status" value="${order.status}" id="status">
<input type="hidden" name="createTime" value="${order.createTime}" id="createTime">
<input type="hidden" name="oldAmount" value="${order.amount}" id="oldAmount">
<input type="hidden" name="oldFee" value="${order.fee}" id="oldFee">
<input type="hidden" name="oldFundsId" value="${order.fundsId}" id="oldFundsId">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${order==null||order.id==0}"><spring:message code="order.label.add"/></c:if>
<c:if test="${order.id>0}"><spring:message code="order.label.update"/></c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.providerName"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input type="hidden" name="providerId" id="providerId" value="${order.providerId}" />
    	<input name="providerName" value="${order.providerName}" id="providerName" readonly="readonly" onclick="showDialog(this,'供货商','../provider/dialog.do',25,100,2);"/>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsName"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input type="hidden" name="goodsId" id="goodsId" value="${order.goodsId}" />
   		<input name="goodsName" value="${order.goodsName}" id="goodsName" title="" readonly="readonly" onclick="showDialog(this,'产品名称','../goods/dialog.do',25,100,2);"/>
    </td>
  </tr>
  <tr>
  	<td class=title_bg  height=30><spring:message code="order.label.payNo"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="payNo" value="${order.payNo}" id="payNo"/>
    </td>
    <td class=title_bg  height=30><spring:message code="order.label.payTime"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="payTime" type="text" id="payTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="${order.payTime}" readonly=true style="width:150px;" />
    </td>
  </tr>
   <tr>
  	<td class=title_bg  height=30><spring:message code="order.label.amount"/>(RMB)：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="amount" value="<fmt:formatNumber value="${order.amount}" type="currency"  pattern="#,#00.00#"/>" id="amount" onblur="formatMoney(this)"  />
    </td>
    <td class=title_bg  height=30><spring:message code="order.label.fundsName"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<select name="fundsId" id="fundsId" style="width:160px;" onchange="selectAccount()">
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<c:forEach items="${funds}" var="fund">
    			<option label="${fund.name}" value="${fund.id}" 
    				<c:if test="${fund.id==order.fundsId}">selected</c:if>>
    			</option>
    		</c:forEach>
   		</select>
   		<span id="overMoney" name=""></span>
    </td>
  </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.fee"/>(RMB)：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="fee" value="<fmt:formatNumber value="${order.fee}" type="currency"  pattern="#,#00.00#"/>" id="fee"  onblur="formatMoney(this)"   />
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsMoney"/>(RMB)：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="goodsMoney" value="<fmt:formatNumber value="${order.goodsMoney}" type="currency"  pattern="#,#00.00#"/> " id="goodsMoney" onblur="calVND(this,'exchangeRate')"  />
    </td>
  </tr>
  <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.exchangeRate"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="exchangeRate" value="${order.exchangeRate}" id="exchangeRate" onblur="calVND(this,'goodsMoney')"  />
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.vnMoney"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnMoney" value="<fmt:formatNumber value="${order.vnMoney}" type="currency"   pattern="#,#00.00#"/>" id="vnMoney" onblur="formatMoney(this)"   />
    </td>
  </tr>
  <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.receiveMoney"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="receiveMoney" value="<fmt:formatNumber value="${order.receiveMoney}" type="currency"  pattern="#,#00.00#"/>" id="receiveMoney" onblur="calBalance(this)"/>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.balance"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="balance" value="<fmt:formatNumber value="${order.balance}" type="currency"   pattern="#,#00.00#"/>" id="balance" onblur="formatMoney(this)"  />
    </td>
  </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.logisticsName"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="logisticsName" value="${order.logisticsName}" id="logisticsName"/>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.logisticsOrder"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="logisticsOrder" value="${order.logisticsOrder}" id="logisticsOrder"/>
    	&nbsp;&nbsp;<c:if test="${order.id>0}"><a href="javascript:queryKuaidi('logisticsOrder')">查看</a></c:if>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.borderAddr"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="borderAddr" id="borderAddr" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<option value="1" <c:if test="${order.borderAddr==1}">selected</c:if>>
   			<spring:message code="order.label.border.dongxing"/></option>
   			<option value="2" <c:if test="${order.borderAddr==2}">selected</c:if>>
   			<spring:message code="order.label.border.pingxiang"/></option>
   		</select>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goalAddr"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="goalAddr" id="goalAddr" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
	    	<option value="1" <c:if test="${order.goalAddr==1}">selected</c:if>>
   			<spring:message code="order.label.goal.hn"/></option>
   			<option value="2" <c:if test="${order.goalAddr==2}">selected</c:if>>
   			<spring:message code="order.label.goal.hcm"/></option>
   			<option value="3" <c:if test="${order.goalAddr==3}">selected</c:if>>
   			<spring:message code="order.label.goal.manjie"/></option>
   		</select>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.receiveUser"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="receiveUser" value="${order.receiveUser}" id="receiveUser"/>
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.cnReceiverPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="cnReceiverPhone" value="${order.cnReceiverPhone}" id="cnReceiverPhone"/>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.borderLogistics"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="borderLogistics" value="${order.borderLogistics}" id="borderLogistics"/>
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.borderPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="borderPhone" value="${order.borderPhone}" id="borderPhone"/>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.cnFare"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="cnFare" value="${order.cnFare}" id="cnFare" onblur="isPriceNumber(this)"   />
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.vnFare" />：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnFare" value="${order.vnFare}" id="vnFare"  onblur="isPriceNumber(this)" />
    </td>
   </tr>
   <tr>
    <td class=title_bg  height=30><spring:message code="order.label.num"/>：</td>
    <td height=30 style="padding-left:10px;" colspan="3">
    	<input name="num" value="${order.num}" id="num"/>
    </td>
   </tr>
   <tr>
    <td class=title_bg  height=30><spring:message code="order.label.salesMan"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input type="hidden" name="empId"  value="${order.empId}" id="empId"/>
    	<input name="salesMan" value="${order.salesMan}" id="salesMan" readonly="readonly" onclick="showEmployee(this)"/>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.makeOrderUser"/>：</td>
    <td height=30 style="padding-left:10px;">
     	<c:if test="${order.id>0}">
    	<input name="userId" value="${order.userId}" id="userId" readonly="readonly"/>
    	</c:if>
    	<c:if test="${order==null||order.id==0}">
    	<input name="userId" value="${sessionScope.session_login_admin_name}" id="userId" readonly="readonly"/>
    	</c:if>
    </td>
   </tr>
    <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.getGoodsUser"/>：</td>
     <td height=30 style="padding-left:10px;">
    	<input name="getGoodsUser" value="${order.getGoodsUser}" id="getGoodsUser"/>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.vnReceiverPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnReceiverPhone" value="${order.vnReceiverPhone}" id="vnReceiverPhone"/>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsPic"/>：</td>
    <td height=120 style="padding-left:10px;">
    	<div id="ufc1">
    		<input type="file" name="file" id="uploadFile1" />
    		<input type="hidden" name="picUrl" id="picUrl1" value="${order.picUrl}"/>
    	</div>
        <div id="errormess1">
        </div>
    	<input type="button" value="上传" onclick="upload('${order.picUrl}',1);"  class="button"/>
    	<div>
			<img src="showPhoto.do?path=${order.picUrl}" width="100" height="100" border="0" id="preImg1">
    	</div>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.packagePic"/>：</td>
    <td height=120 style="padding-left:10px;">
    	<div id="ufc2">
    		<input type="file" name="file" id="uploadFile2" />
    		<input type="hidden" name="packageUrl" id="picUrl2" value="${order.packageUrl}"/>
    	</div>
        <div id="errormess2">
        </div>
    	<input type="button" value="上传" onclick="upload('${order.packageUrl}',2);"  class="button"/>
    	<div>
			<img src="showPhoto.do?path=${order.packageUrl}" width="100" height="100" border="0" id="preImg2">
    	</div>
    </td>
   </tr>
   <c:if test="${status<0}">
    <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.offerDate"/>：</td>
     <td height=30 style="padding-left:10px;">
    	<input name="offerDate" type="text" id="offerDate" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="${order.offerDate}" readonly=true style="width:150px;" />
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.offerType"/>：</td>
     <td height=30 style="padding-left:10px;" >
    	<input name="offerType" value="${order.offerType}" id="offerType" width="300"/>
    </td>
   </tr>
    </c:if>
   <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.productUrl"/>：</td>
     <td height=30 style="padding-left:10px;" >
    	<input name="productUrl" value="${order.productUrl}" id="productUrl" width="300"/>
    </td>
      <td class=title_bg  width=100 height=30><spring:message code="order.label.mark"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<textarea rows="5" cols="40" name="mark">${order.mark}</textarea>
    </td>
   </tr>
   <tr>
   	<td colspan="6"><hr size=1 style="border-top: 1px #cde6ff solid;"></td>
   </tr>
   <tr>
   	<td colspan="4">
   <div style="margin-left:20px;"><input class="button" type="button" value="<spring:message code="order.add.customer"/>" onclick="addCus();"/></div>
	<table cellspacing=0 cellpadding=2 width="60%" align=left border=0 id="order_cus" style="margin-left:20px;">
	  <tr>
		<td width="15%" height=28><spring:message code="order.customer.cusName"/></td>
		<td width="15%" height=28><spring:message code="order.customer.cusOrderNo"/></td>
		<td width="15%" height=28><spring:message code="order.label.amount"/></td>
		<td width="15%" height=28><spring:message code="order.customer.SendNum"/></td>
		<td width="15%" height=28><spring:message code="order.customer.ReceiveNum"/></td>
	  </tr>
	  <c:forEach items="${orderCustomers}" var="customer" varStatus="status">
	   		<input type="hidden" name="ocIds" value="${customer.id}">
	   		<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'">
			    <td height=30>
			    	<input type="hidden" name="cusIds" value="${customer.cusId}"/>
			    	<input type="text" name="cuss" value="${customer.cusNo}--${customer.cusName}" readonly="readonly" onclick="showCustomer(this)"/>
			    </td>
			    <td height=30><input type="text" name="orderCodes" value="${customer.orderCode}"></td>
			    <td height=30><input type="text" name="amounts" value="${customer.amount}" style="width:60px;text-align:center;"  onblur="isPriceNumber(this)"></td>
			    <td height=30><input type="text" name="sendNums" style="width:40px;text-align:center;" value="${customer.sendNum}" onkeyup="checknum(this)" onblur="checknum(this)"></td>
			    <td height=30><input type="text" name="realNums" style="width:40px;text-align:center;" value="${customer.realNum}" onkeyup="checknum(this)" onblur="checknum(this)"></td>
			    <td height=30><input type="button"  class="button" onclick="del(this)" value="<spring:message code="admin.label.delete"/>"></td>
			 </tr>
	   	</c:forEach>
   	</table>
   	</td>
   </tr>
   <c:if test="${order.id>0}">
   <tr>
   	<td colspan="6">
   		<div id="process" class="process" style="width:100%;text-align:left;padding-left:20px;">
			<script> 
				var status="";
			</script>
			<div class="node ready">
				<ul>
					<li class="tx1">&nbsp;</li>
					<li class="tx2"><spring:message code="order.label.query.peddingsend"/></li>
					<li id="track_time_0" class="tx3">
					<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd"/> <br>
					<fmt:formatDate value="${order.createTime}" pattern="HH:mm:ss"/>
					</li>
				</ul>
			</div>
			<c:forEach items="${order.times}" var="time" varStatus="st2">
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
				</c:if>
			</c:forEach>
			<script> 
				var allstatus="";
				var isHN = ${order.goalAddr};//1河内 2胡志明
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
					
					$("#process").append(getStatusName(statusName,process,clss));
				}
                      
			</script>
		</div>	
   	</td>
   </tr>
   </c:if>
   </tbody>
</table>
</div>
<div class=adminsubmit><input class="button" id="submit" type="submit" value="<spring:message code="admin.label.submit"/>" />  
<input class="button" type="button" value="<spring:message code="admin.label.return"/>" onclick="javascript:location.href='list.do?status=${order.status}'"/> 
</div>
</div>
</form>
<div id="customer"  style="display: none;">
	<input type="hidden" name="cusIds" value=""/>
	<input name="cuss" value="" readonly="readonly" onclick="showCustomer(this)"/>
</div>
<div id="queryContext" class="mt10px hidden relative" style="z-index: 4; display: none;">
    <span class="qr-sf hidden" id="sfQr" style="display: none;"></span>
    <div class="result-top"><span class="col1">时间</span><span class="col2">地点和跟踪进度</span></div>
    <table id="queryResult2" class="result-info2" cellspacing="0">
    <tbody>
    </tbody>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    </table>
</div>
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/jquery-ui.min.js"></script> 
	<script type="text/javascript" src="../../js/kuaidi.js"></script>

	<script type="text/javascript">
	  function showCustomer(obj){
		  //var left = getOffsetLeft(obj);
		  var topPx = getOffsetTop(obj)-300;
		  showDialog(obj,'产品名称','../customer/dialog.do',topPx,100,2);
	  }
	  function showEmployee(obj){
		  var topPx = getOffsetTop(obj)-300;
		  showDialog(obj,'业务员','../employee/dialog.do',topPx,100,2);
	  }
	  $(function(){
	        jQuery.i18n.properties({
	            name : 'strings', //资源文件名称
	            path : '../../js/i18n/', //资源文件路径
	            mode : 'map', //用Map的方式使用资源文件中的值
	            language :curlang ,
	            callback : function() {//加载成功后设置显示内容
	            	jQuery("#form").validate({
	        			rules: {
	        				payNo:"required",
	        				payTime:"required",
	        				amount:"required",
	        				num:{required: true,digits:true},
	        				providerName:"required",
	        				goodsName:"required",
	        				logisticsName:"required",
	        				receiveUser:"required",
	        				borderAddr:"required",
	        				goalAddr:"required",
	        				fundsId:"required",
	        				salesMan:"required"
	        			},
	        			messages: {
	        				payNo: $.i18n.prop('isNotEmpty'),
	        				payTime: $.i18n.prop('isNotEmpty'),
	        				amount: $.i18n.prop('isNotEmpty'),
	        				num: {required:$.i18n.prop('isNotEmpty'),digits:$.i18n.prop('digits')},
	        				providerName: $.i18n.prop('isNotEmpty'),
	        				goodsName: $.i18n.prop('isNotEmpty'),
	        				logisticsName: $.i18n.prop('isNotEmpty'),
	        				receiveUser: $.i18n.prop('isNotEmpty'),
	        				borderAddr: $.i18n.prop('isNotEmpty'),
	        				goalAddr: $.i18n.prop('isNotEmpty'),
	        				fundsId: $.i18n.prop('isNotEmpty'),
	        				salesMan: $.i18n.prop('isNotEmpty')
	        			},
	        			submitHandler: function(form) {
	        				var orderId = $("#orderId").val();
							if(orderId==undefined ||orderId ==""){
								var overMoney = $("#overMoney").attr("name");
	        					var amount = $("#amount").val().replace(new RegExp(/(,)/g),'');
	        					if(parseFloat(amount) > parseFloat(overMoney)){
									alert("账号余额不能小于采购金额！");
									$("#overMoney").html("");
									$("#fundsId").val("");
									return ;
	        					}
							}
	        				$("#submit").attr("disabled", true); 
	        				checkMoney('amount');
	        				checkMoney('cnFare');
	        				checkMoney('vnFare');
	        				checkMoney('fee');
	        				checkMoney('receiveMoney');
	        				checkMoney('balance');
	        				checkMoney('vnMoney');
	        				checkMoney('exchangeRate');
	        				checkMoney('goodsMoney');
	        				jQuery(form).ajaxSubmit({  
	        	                type:"post",  //提交方式  
	        	                dataType:"json", //数据类型  
	        	                url:"add.do",
	        	                success:function(data){ //提交成功的回调函数  
	        	                    if(data==1){
	        	                    	alert( $.i18n.prop('opSucc'));
	        	                    	top.document.getElementById("menu").src = './getMenusById.do?id=8&type=nojump';
	        	                    	location.href="list.do?status=${order.status}";
	        	                    }else if(data==2){
	        	                    	alert( $.i18n.prop('customerinfo_error'));
	        	                    	$("#submit").attr("disabled", false); 
	        	                    }else{
	        	                    	alert( $.i18n.prop('opFail'));
	        	                    	$("#submit").attr("disabled", false); 
	        	                    }
	        	                }  
	        	            });
	        			}
	        		});
	            		
	            }
	        });
	        
	      /*   var $psDialog = $("#add");
	        var dialogOpts = {
	            title: $.i18n.prop('add_customer'),
	            autoOpen: false,
	            width: 400,
	            height: 250,
	            modal: true,
	            overlay: {
	                backgroundColor: '#000',
	                opacity: 0.5
	            },
	            buttons: {
	            	OK:function(){
	                    $(this).dialog('close');
	                },
	                Close: function () {
	                    $(this).dialog('close');
	                }
	            }
	        };

	        $("#add").dialog(dialogOpts);
	       
	         $('#addCus').click(function () {
	            $psDialog.dialog('open');
	        }); */

	    });  
		
	 function checkMoney(id){
		 var obj = $("#"+id);
		 var val = $.trim(obj.val());
			if(val==''){
				obj.val(0.00);
			}else{
				val = val.replace(new RegExp(/(,)/g),'');
				obj.val(val);
			}
	 }
	 var index = 0;
	 function addCus(){
		 var cus = $("#customer").html();
		 var html = '<tr>'+
		    '<td height=30>'+cus+'</td>'+
		    '<td height=30><input type="text"  name="orderCodes"></td>'+
		    '<td height=30><input type="text"  name="amounts" style="width:60px;text-align:center;"  onblur="isPriceNumber(this)"></td>'+
		    '<td height=30><input type="text" name="sendNums" style="width:40px;text-align:center;" onkeyup="checknum(this)" onblur="checknum(this)"></td>'+
		    '<td height=30><input type="text" name="realNums" style="width:40px;text-align:center;" onkeyup="checknum(this)" onblur="checknum(this)"></td>'+
		    '<td height=30><input type="button"  class="button" onclick="del(this)" value="<spring:message code="admin.label.delete"/>"></td>'+
		    '</tr>';
		 $("#order_cus").append(html);
		 index ++;
	 }
	 
	 function del(obj){
		 $(obj).parent().parent().remove();
		 index --;
	 }
	 //计算应收越南盾
	 function calVND(obj,id){
		 var re=/(?=(?!\b)(\d{3})+$)/g; //分割数字 1,000
		 var objVal =$(obj).val();
		 objVal = objVal.replace(new RegExp(/(,)/g),'');
		 var flag = isNaN(objVal);
		 if(!flag){
			 var val =$("#"+id).val();
			 val = val.replace(new RegExp(/(,)/g),'');
			 if(objVal!='' && val!=''){
				 var vn = objVal * val;
				 $("#vnMoney").val(vn);
			 }
		 }
		 //obj.value = objVal.replace(re,",");
		 //$("#vnMoney").val($("#vnMoney").val().replace(re,","));
		 obj.value = formatCurrency(objVal);
		 $("#vnMoney").val(formatCurrency($("#vnMoney").val()));
	 }
	 function calBalance(obj){
		 var re=/(?=(?!\b)(\d{3})+$)/g; //分割数字 1,000
		 var objVal = $(obj).val();//已收定金
		 objVal = objVal.replace(new RegExp(/(,)/g),'');
		 var flag = isNaN(objVal);
		 if(!flag){
			 var val =$("#vnMoney").val();
			 val = val.replace(new RegExp(/(,)/g),'');
			 if(objVal!='' && val!=''){
				 var vn = val-objVal;
				 $("#balance").val(vn);
			 }
		 }
		 //obj.value = objVal.replace(re,",");
		 //$("#balance").val($("#balance").val().replace(re,","));
		 obj.value = formatCurrency(objVal);
		 $("#balance").val(formatCurrency($("#balance").val()));
	 }
	 function getPayNo(obj){
		 var payType = $(obj).attr("title");
		 var data={
				 payType:payType
			 };
		 $.getJSON("getMaxPayNo.do", data, function(result) {
				if (result !="0"){
					$("#payNo").val(result);
				}
		 }); 
	 }
	 function selectAccount(){
		 var fundsId = $("#fundsId").val();
		 if(fundsId==''){
			 return;
		 }
		 var data={
				 id:fundsId
			 };
		 $.getJSON("../funds/getOverMoney.do", data, function(result) {
				if (result !=""){
					$("#overMoney").html("￥"+result);
					$("#overMoney").attr("name",result);
					var amount = $("#amount").val().replace(new RegExp(/(,)/g),'');;
					if(parseFloat(amount)>0 && parseFloat(amount) > parseFloat(result)){
						alert("账号余额不能小于采购金额！");
						$("#overMoney").html("");
						$("#fundsId").val("");
					}
					
				}
		 }); 
	 }
	</script>

</body>
</html>
