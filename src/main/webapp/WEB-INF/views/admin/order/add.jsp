<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../js/getdate/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<LINK href="http://res.gm.17188.com/oss_files/jquery-ui-1.9.1.custom.css" rel="stylesheet" type="text/css">    
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
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
<div class=namezone><c:if test="${order==null||order.id==0}"><spring:message code="order.label.add"/></c:if>
<c:if test="${order.id>0}"><spring:message code="order.label.update"/></c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
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
  	<td class=title_bg  height=30><spring:message code="order.label.amount"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="amount" value="${order.amount}" id="amount"/>
    </td>
    <td class=title_bg  height=30><spring:message code="order.label.num"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="num" value="${order.num}" id="num"/>
    </td>
  </tr>
  <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.providerName"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="providerName" id="providerName" style="width:153px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
    		<c:forEach items="${providers}" var="provider">
    			<option label="${provider.name}" value="${provider.name}" 
    				<c:if test="${provider.name==order.providerName}">selected</c:if> >
    			</option>
    		</c:forEach>
    	</select>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsName"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="goodsName" id="goodsName" style="width:153px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
	    	<c:forEach items="${goodss}" var="goods">
	   			<option label="${goods.name}" value="${goods.name}" 
	   				<c:if test="${goods.name==order.goodsName}">selected</c:if> >
	   			</option>
	   		</c:forEach>
   		</select>
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
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.borderAddr"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="borderAddr" id="borderAddr" style="width:153px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<option value="1" <c:if test="${order.borderAddr==1}">selected</c:if>>
   			<spring:message code="order.label.border.dongxing"/></option>
   			<option value="2" <c:if test="${order.borderAddr==2}">selected</c:if>>
   			<spring:message code="order.label.border.pingxiang"/></option>
   		</select>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goalAddr"/>：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="goalAddr" id="goalAddr" style="width:153px;">
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
    	<input name="receiveUser" value="${order.receiveUser}" id="receiveUser"/>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.receiveMoney"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="receiveMoney" value="${order.receiveMoney}" id="receiveMoney"/>
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
    	<input name="cnFare" value="${order.cnFare}" id="cnFare"/>
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.vnFare"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnFare" value="${order.vnFare}" id="vnFare"/>
    </td>
   </tr>
   <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.cnReceiverPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="cnReceiverPhone" value="${order.cnReceiverPhone}" id="cnReceiverPhone"/>
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.vnReceiverPhone"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnReceiverPhone" value="${order.vnReceiverPhone}" id="vnReceiverPhone"/>
    </td>
   </tr>
    <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.getGoodsUser"/>：</td>
     <td height=30 style="padding-left:10px;" colspan="3">
    	<input name="getGoodsUser" value="${order.getGoodsUser}" id="getGoodsUser"/>
    </td>
    
   </tr>
   <tr>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.mark"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<textarea rows="5" cols="40" name="mark">${order.mark}</textarea>
    </td>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.goodsPic"/>：</td>
    <td height=120 style="padding-left:10px;">
    	<div id="ufc1">
    		<input type="file" name="file" id="uploadFile" />
    		<input type="hidden" name="picUrl" id="picUrl" value="${order.picUrl}"/>
    	</div>
        <div id="errormess">
        </div>
    	<input type="button" value="上传" onclick="upload();"  class="button"/>
    	<div>
			<img src="showPhoto.do?path=${order.picUrl}" width="100" height="100" border="0" id="preImg">
    	</div>
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
			    	<select name="cusNos">
						<option value=""><spring:message code="admin.label.select"/></option>
						<c:forEach items="${customers}" var="cus" varStatus="status">
							<option value="${cus.code}#${cus.name}" <c:if test="${customer.cusNo==cus.code}">selected</c:if> >${cus.code}--${cus.name}</option>
						</c:forEach>
					</select>
			    </td>
			    <td height=30><input type="text" name="orderCodes" value="${customer.orderCode}"></td>
			    <td height=30><input type="text" name="amounts" value="${customer.amount}" style="width:60px;text-align:center;"></td>
			    <td height=30><input type="text" name="sendNums" style="width:40px;text-align:center;" value="${customer.sendNum}"></td>
			    <td height=30><input type="text" name="realNums" style="width:40px;text-align:center;" value="${customer.realNum}"></td>
			    <td height=30><input type="button"  class="button" onclick="del(this)" value="<spring:message code="admin.label.delete"/>"></td>
			 </tr>
	   	</c:forEach>
   	</table>
   	</td>
   </tr>
   
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
	
	<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" src="../../js/language.js"></script>
	<!-- <script type="text/javascript" src="../../js/jquery-ui.min.js"></script> -->

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
		
	 var index = 0;
	 function addCus(){
		 var cus = $("#customer").html();
		 var html = '<tr>'+
		    '<td height=30>'+cus+'</td>'+
		    '<td height=30><input type="text"  name="orderCodes"></td>'+
		    '<td height=30><input type="text"  name="amounts" style="width:60px;text-align:center;"></td>'+
		    '<td height=30><input type="text" name="sendNums" style="width:40px;text-align:center;"></td>'+
		    '<td height=30><input type="text" name="realNums" style="width:40px;text-align:center;"></td>'+
		    '<td height=30><input type="button"  class="button" onclick="del(this)" value="<spring:message code="admin.label.delete"/>"></td>'+
		    '</tr>';
		 $("#order_cus").append(html);
		 index ++;
	 }
	 
	 function del(obj){
		 $(obj).parent().parent().remove();
		 index --;
	 }
	</script>

</body>
</html>
