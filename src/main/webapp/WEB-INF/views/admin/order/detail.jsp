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
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
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
</c:if>
<div class=formzone>
<div class=namezone><spring:message code="admin.label.query"/></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
  	<td class=title_bg  height=30><spring:message code="order.label.payNo"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="payNo" value="${order.payNo}" id="payNo" readonly="readonly"/>
    </td>
    <td class=title_bg  height=30><spring:message code="order.label.payTime"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="payTime" type="text" id="payTime" class="dtime" readonly="readonly"  value="${order.payTime}" style="width:150px;" />
    </td>
  </tr>
  
   <tr>
  	<td class=title_bg  height=30><spring:message code="order.label.amount"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="amount" value="${order.amount}" id="amount" readonly="readonly" />
    </td>
    <td class=title_bg  height=30><spring:message code="order.label.num"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="num" value="${order.num}" id="num" readonly="readonly" />
    </td>
  </tr>
  <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.providerName"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="providerName" value="${order.providerName}" id="providerName" readonly="readonly" />
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsName"/>：</td>
    <td height=30 style="padding-left:10px;">
   		<input name="goodsName" value="${order.goodsName}" id="goodsName" readonly="readonly" />
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.logisticsName"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="logisticsName" value="${order.logisticsName}" id="logisticsName" readonly="readonly" />
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.logisticsOrder"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="logisticsOrder" value="${order.logisticsOrder}" id="logisticsOrder" readonly="readonly" />
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.borderAddr"/>：</td>
    <td height=30 style="padding-left:12px;">
    	
    	<select name="borderAddr" id="borderAddr" style="width:153px;" disabled="disabled" >
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<option value="1" <c:if test="${order.borderAddr==1}">selected</c:if>>
   			<spring:message code="order.label.border.dongxing"/></option>
   			<option value="2" <c:if test="${order.borderAddr==2}">selected</c:if>>
   			<spring:message code="order.label.border.pingxiang"/></option>
   		</select>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goalAddr"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="goalAddr" id="goalAddr" style="width:153px;" disabled="disabled">
    		<option value=""><spring:message code="admin.label.select"/></option>
	    	<option value="1" <c:if test="${order.goalAddr==1}">selected</c:if>>
   			<spring:message code="order.label.goal.hn"/></option>
   			<option value="2" <c:if test="${order.goalAddr==2}">selected</c:if>>
   			<spring:message code="order.label.goal.hcm"/></option>
   		</select>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.receiveUser"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="receiveUser" value="${order.receiveUser}" id="receiveUser" readonly="readonly" />
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.receiveMoney"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="receiveMoney" value="${order.receiveMoney}" id="receiveMoney" readonly="readonly" />
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.borderLogistics"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="borderLogistics" value="${order.borderLogistics}" id="borderLogistics" readonly="readonly" />
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.borderPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="borderPhone" value="${order.borderPhone}" id="borderPhone" readonly="readonly" />
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.cnFare"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="cnFare" value="${order.cnFare}" id="cnFare" readonly="readonly" />
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.vnFare"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnFare" value="${order.vnFare}" id="vnFare" readonly="readonly" />
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.cnReceiverPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="cnReceiverPhone" value="${order.cnReceiverPhone}" id="cnReceiverPhone" readonly="readonly" />
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.vnReceiverPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnReceiverPhone" value="${order.vnReceiverPhone}" id="vnReceiverPhone" readonly="readonly" />
    </td>
   </tr>
    <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.getGoodsUser"/>：</td>
     <td height=30 style="padding-left:10px;" colspan="3">
    	<input name="getGoodsUser" value="${order.getGoodsUser}" id="getGoodsUser" readonly="readonly" />
    </td>
    
   </tr>
   <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.mark"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<textarea rows="5" cols="40" name="mark" readonly="readonly" >${order.mark}</textarea>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsPic"/>：</td>
    <td height=120 style="padding-left:10px;">
		<img src="showPhoto.do?path=${order.picUrl}" width="100" height="100" border="0" id="preImg">
    </td>
   </tr>
   
   <tr>
   	<td colspan="6"><hr size=1 style="border-top: 1px #cde6ff solid;"></td>
   </tr>
   <tr>
   <td colspan="4">
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
			    	<input type="hidden" name="cusNos" value="${customer.cusNo}#${customer.cusName}">
			    	${customer.cusName}
			    </td>
			    <td height=30><input type="hidden" name="orderCodes" value="${customer.orderCode}">${customer.orderCode}</td>
			    <td height=30><input type="hidden" name="amounts" value="${customer.amount}">${customer.amount}</td>
			    <td height=30><input type="hidden" name="sendNums" style="width:40px;text-align:center;" value="${customer.sendNum}">${customer.sendNum}</td>
			    <td height=30><input type="text" name="realNums" style="width:40px;text-align:center;" value="${customer.realNum}"></td>
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
<div class=adminsubmit><input class="button" type="submit" value="<spring:message code="admin.label.submit"/>" />  
<input class="button" type="button" value="<spring:message code="admin.label.return"/>" onclick="javascript:location.href='list.do?status=${order.status}'"/> 
</div>
</div>
</form>

<div id="customer"  style="display: none;">
	<select name="cusNos">
		<option value=""><spring:message code="admin.label.select"/></option>
		<c:forEach items="${customers}" var="customer" varStatus="status">
			<option value="${customer.code}#${customer.name}">${customer.code}--${customer.name}</option>
		</c:forEach>
	</select>
</div>
	
	
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>

	<script type="text/javascript">
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
	        				num:"required",
	        				providerName:"required",
	        				goodsName:"required",
	        				logisticsName:"required",
	        				receiveUser:"required",
	        				borderAddr:"required",
	        				goalAddr:"required"
	        			},
	        			messages: {
	        				payNo: $.i18n.prop('isNotEmpty'),
	        				payTime: $.i18n.prop('isNotEmpty'),
	        				amount: $.i18n.prop('isNotEmpty'),
	        				num: $.i18n.prop('isNotEmpty'),
	        				providerName: $.i18n.prop('isNotEmpty'),
	        				goodsName: $.i18n.prop('isNotEmpty'),
	        				logisticsName: $.i18n.prop('isNotEmpty'),
	        				receiveUser: $.i18n.prop('isNotEmpty'),
	        				borderAddr: $.i18n.prop('isNotEmpty'),
	        				goalAddr: $.i18n.prop('isNotEmpty')
	        			},
	        			submitHandler: function(form) {
	        				jQuery(form).ajaxSubmit({  
	        	                type:"post",  //提交方式  
	        	                dataType:"json", //数据类型  
	        	                url:"add.do",
	        	                success:function(data){ //提交成功的回调函数  
	        	                    if(data==1){
	        	                    	alert( $.i18n.prop('opSucc'));
	        	                    	location.href="list.do";
	        	                    }else{
	        	                    	alert( $.i18n.prop('opFail'));
	        	                    }
	        	                }  
	        	            });
	        			}
	        		});
	            		
	            }
	        });
	        

	    });  
		
	</script>

</body>
</html>
