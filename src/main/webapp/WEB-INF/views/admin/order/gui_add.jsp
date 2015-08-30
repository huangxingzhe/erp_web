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
  	<td class=title_bg  height=30>货柜编号：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="guiNo" value="${order.guiNo}" id="guiNo"/>
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
    <td class=title_bg  width=100 height=30><spring:message code="order.label.balance"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="balance" value="<fmt:formatNumber value="${order.balance}" type="currency"   pattern="#,#00.00#"/>" id="balance" onblur="formatMoney(this)"  />
    </td>
    <td class=title_bg  height=30><spring:message code="order.label.num"/>：</td>
    <td height=30 style="padding-left:10px;" colspan="3">
    	<input name="num" value="${order.num}" id="num"/>
    </td>
  </tr>
   <tr>
    <td class=title_bg  width=100 height=30>中国港口：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="cnPort" id="cnPort" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<option value="1" <c:if test="${order.cnPort==1}">selected</c:if>>广州</option>
   			<option value="2" <c:if test="${order.cnPort==2}">selected</c:if>>上海</option>
   			<option value="3" <c:if test="${order.cnPort==3}">selected</c:if>>宁波</option>
   		</select>
    </td>
    <td class=title_bg  width=100 height=30>越南港口：</td>
    <td height=30 style="padding-left:12px;">
    	<select name="vnPort" id="vnPort" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
	    	<option value="1" <c:if test="${order.vnPort==1}">selected</c:if>>海防港</option>
	    	<option value="2" <c:if test="${order.vnPort==2}">selected</c:if>>胡志明</option>
   		</select>
    </td>
   </tr>
  <%--  <tr>
    <td class=title_bg  width=100 height=30><spring:message code="order.label.cnFare"/>：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="cnFare" value="${order.cnFare}" id="cnFare" onblur="isPriceNumber(this)"   />
    </td>
     <td class=title_bg  width=100 height=30><spring:message code="order.label.vnFare" />：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="vnFare" value="${order.vnFare}" id="vnFare"  onblur="isPriceNumber(this)" />
    </td>
   </tr> --%>
    <tr>
    <td class=title_bg  width=100 height=30>装柜时间：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="onShipTime" value="${order.onShipTime}" id="onShipTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"  readonly=true style="width:150px;" />
    </td>
    <td class=title_bg  height=30>开船时间：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="startShipTime" value="${order.startShipTime}" id="startShipTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"  readonly=true style="width:150px;" />
    </td>
  </tr>
   <tr>
    <td class=title_bg  height=30>到港时间：</td>
    <td height=30 style="padding-left:10px;">
    	<input name="onPortTime" value="${order.onPortTime}" id="onPortTime" class="dtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" style="width:150px;" />
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
   </tr>
   <tr>
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
	<table cellspacing=0 cellpadding=2 width="100%" align=left border=0 id="order_cus" style="margin-left:20px;">
	  <tr>
		<td width="15%" height=28><spring:message code="order.customer.cusName"/></td>
		<td width="15%" height=28><spring:message code="order.customer.cusOrderNo"/></td>
		<td width="15%" height=28>合同编号</td>
		<td width="15%" height=28><spring:message code="order.label.amount"/></td>
		<td width="15%" height=28><spring:message code="order.customer.SendNum"/></td>
		<td width="15%" height=28><spring:message code="order.customer.ReceiveNum"/></td>
		<td width="15%" height=28>产品</td>
		<td width="15%" height=28>业务员</td>
		<td width="15%" height=28></td>
	  </tr>
	  <c:forEach items="${orderCustomers}" var="customer" varStatus="status">
	   		<input type="hidden" name="ocIds" value="${customer.id}">
	   		<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'">
			    <td height=30>
			    	<input type="hidden" name="cusIds" value="${customer.cusId}"/>
			    	<input type="text" name="cuss" value="${customer.cusNo}--${customer.cusName}" readonly="readonly" onclick="showCustomer(this)"/>
			    </td>
			    <td height=30><input type="text" name="orderCodes" value="${customer.orderCode}" style="width:70px;text-align:center;"></td>
			    <td height=30><input type="text" name="payNos" value="${customer.payNo}" style="width:70px;text-align:center;"></td>
			    <td height=30><input type="text" name="amounts" value="${customer.amount}" style="width:60px;text-align:center;"  onblur="isPriceNumber(this)"></td>
			    <td height=30><input type="text" name="sendNums" style="width:40px;text-align:center;" value="${customer.sendNum}" onkeyup="checknum(this)" onblur="checknum(this)"></td>
			    <td height=30><input type="text" name="realNums" style="width:40px;text-align:center;" value="${customer.realNum}" onkeyup="checknum(this)" onblur="checknum(this)"></td>
			    <td height=30><input type="text" name="goodsNos" value="${customer.goodsNo}" style="width:70px;text-align:center;"> </td>
			    <td height=30>
			    	<select name="empIds">
			    		<option value=""><spring:message code="admin.label.select"/></option>
			    		<c:forEach items="${employees}" var="emp">
			    		<option value="${emp.id}" <c:if test="${emp.id==customer.empId}">selected</c:if> >${emp.name}</option>
			    		</c:forEach>
			    	</select>
			    </td>
			    <td height=30><input type="button"  class="button" onclick="del(this)" value="<spring:message code="admin.label.delete"/>"></td>
			 </tr>
	   	</c:forEach>
   	</table>
   	</td>
   </tr>
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
	  $(function(){
	        jQuery.i18n.properties({
	            name : 'strings', //资源文件名称
	            path : '../../js/i18n/', //资源文件路径
	            mode : 'map', //用Map的方式使用资源文件中的值
	            language :curlang ,
	            callback : function() {//加载成功后设置显示内容
	            	jQuery("#form").validate({
	        			rules: {
	        				payTime:"required",
	        				amount:"required",
	        				num:{required: true,digits:true},
	        				providerName:"required",
	        				goodsName:"required",
	        				fundsId:"required",
	        				guiNo:"required",
	        				cnPort:"required",
	        				vnPort:"required",
	        				empIds:"required"
	        			},
	        			messages: {
	        				payTime: $.i18n.prop('isNotEmpty'),
	        				amount: $.i18n.prop('isNotEmpty'),
	        				num: {required:$.i18n.prop('isNotEmpty'),digits:$.i18n.prop('digits')},
	        				providerName: $.i18n.prop('isNotEmpty'),
	        				goodsName: $.i18n.prop('isNotEmpty'),
	        				fundsId: $.i18n.prop('isNotEmpty'),
	        				guiNo: $.i18n.prop('isNotEmpty'),
	        				cnPort: $.i18n.prop('isNotEmpty'),
	        				vnPort: $.i18n.prop('isNotEmpty'),
	        				empIds: $.i18n.prop('isNotEmpty')
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
	        	                    	top.document.getElementById("menu").src = './getMenusById.do?id=50&type=nojump';
	        	                    	location.href="list.do?orderType=1&status=${order.status}";
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
		    '<td height=30><input type="text"  name="orderCodes" style="width:70px;text-align:center;"></td>'+
		    '<td height=30><input type="text"  name="payNos" style="width:70px;text-align:center;"></td>'+
		    '<td height=30><input type="text"  name="amounts" style="width:60px;text-align:center;"  onblur="isPriceNumber(this)"></td>'+
		    '<td height=30><input type="text" name="sendNums" style="width:40px;text-align:center;" onkeyup="checknum(this)" onblur="checknum(this)"></td>'+
		    '<td height=30><input type="text" name="realNums" style="width:40px;text-align:center;" onkeyup="checknum(this)" onblur="checknum(this)"></td>'+
		    '<td height=30><input type="text"  name="goodsNos" style="width:70px;text-align:center;"></td>'+
		    '<td height=30>'+
		    '<select name="empIds">'+
	    		'<option value=""><spring:message code="admin.label.select"/></option>'+
	    		'<c:forEach items="${employees}" var="emp">'+
	    		'<option value="${emp.id}" <c:if test="${emp.id==customer.empId}">selected</c:if> >${emp.name}</option>'+
	    		'</c:forEach>'+
	    	'</select>'+
		    '</td>'+
		    '<td height=30><input type="button"  class="button" onclick="del(this)" value="<spring:message code="admin.label.delete"/>"></td>'+
		    '</tr>';
		 $("#order_cus").append(html);
		 index ++;
	 }
	 
	 function del(obj){
		 if(confirm('确定要删除？')){
			 $(obj).parent().parent().remove();
			 index --;
	 	 }
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
		 obj.value = formatCurrency(objVal);
		 $("#vnMoney").val(formatCurrency($("#vnMoney").val()));
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
