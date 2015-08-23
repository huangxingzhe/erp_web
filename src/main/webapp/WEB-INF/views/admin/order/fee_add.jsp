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
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
</head>
<body>

<form name="form" id="form" action="add.do" method="post">
<c:if test="${fee.id>0}">
<input type="hidden" name="id" value="${fee.id}" id="feeId">
<input type="hidden" name="oldAmount" value="${fee.amount}" id="oldAmount">
<input type="hidden" name="oldFundsId" value="${fee.fundsId}" id="oldFundsId">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${fee==null||fee.id==0}"><spring:message code="fee.label.add"/></c:if>
<c:if test="${fee.id>0}"><spring:message code="fee.label.update"/></c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30><spring:message code="fee.label.payNo"/></td>
    <td height=30>
    	<input name="payNo" value="${fee.payNo}" id="payNo"/>
    </td>
    <td align=middle width=100 height=30><spring:message code="fee.label.payTime"/></td>
    <td height=30>
    	<input name="payTime" value="${fee.payTime}" id="payTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"/>
    </td>
   </tr>
   <tr>
   	<td align=middle width=100 height=30><spring:message code="fee.label.type"/></td>
    <td height=30>
    	<select name="type" id="type" style="width:160px;">
    		<option value=""><spring:message code="admin.label.select"/></option>
    		<option value="1" <c:if test="${fee.type==1}">selected</c:if>><spring:message code="fee.label.fare"/></option><!-- 运费费 -->
    		<option value="2" <c:if test="${fee.type==2}">selected</c:if>><spring:message code="fee.label.tel"/></option><!-- 话费 -->
    		<option value="3" <c:if test="${fee.type==3}">selected</c:if>><spring:message code="fee.label.fee"/></option><!-- 手续费 -->
    		<option value="4" <c:if test="${fee.type==4}">selected</c:if>><spring:message code="fee.label.sample"/></option><!-- 样品 -->
    		<option value="5" <c:if test="${fee.type==5}">selected</c:if>><spring:message code="fee.label.cash"/></option><!-- 取现 -->
    		<option value="7" <c:if test="${fee.type==7}">selected</c:if>><spring:message code="fee.label.travel"/></option><!-- 差旅费 -->
    		<option value="6" <c:if test="${fee.type==6}">selected</c:if>><spring:message code="fee.label.other"/></option><!-- 其他 -->
   		</select>
    </td>
    <td align=middle width=100 height=30><spring:message code="fee.label.payAccount"/></td>
    <td height=30>
    	<select name="fundsId" id="fundsId" style="width:160px;" onchange="selectAccount()">
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<c:forEach items="${funds}" var="fund">
    			<option label="${fund.name}" value="${fund.id}" 
    				<c:if test="${fund.id==fee.fundsId}">selected</c:if>>
    			</option>
    		</c:forEach>
   		</select>
   		<span id="overMoney"></span>
    </td>
   </tr>
   <tr>
   	<td align=middle width=100 height=30><spring:message code="fee.label.receiveUser"/></td>
    <td height=30>
    	<input name="receiveUser" value="${fee.receiveUser}" id="receiveUser" />
    </td>
   	<td align=middle width=100 height=30><spring:message code="fee.label.amount" /></td>
    <td height=30>
    	<input name="amount" value="${fee.amount}" id="amount"  onblur="isPriceNumber(this)"/>
    </td>
   </tr>
     <tr>
    <td align=middle width=100 height=30><spring:message code="fee.label.mark"/></td>
    <td height=30 colspan="3">
    	<textarea rows="5" cols="40" name="mark">${fee.mark}</textarea>
    </td>
   </tr>
   </tbody>
</table>
</div>
<div class=adminsubmit><input class="button" type="submit" value="<spring:message code="admin.label.submit"/>" />  
<input class="button" type="button" value="<spring:message code="admin.label.return"/>" onclick="javascript:location.href='list.do'"/> 
</div>
</div>
</form>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
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
	            	var v = jQuery("#form").validate({
	        			rules: {
	        				payNo:"required",
	        				amount:"required",
	        				type:"required",
	        				payAccount:"required"
	        			},
	        			messages: {
	        				payNo: $.i18n.prop('付款单号不能为空'),
	        				amount: $.i18n.prop('金额不能为空'),
	        				type: $.i18n.prop('付款类型不能为空'),
	        				payAccount: $.i18n.prop('付款账号不能为空')
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
					}
			 }); 
		 }
	</script>

</body>
</html>
