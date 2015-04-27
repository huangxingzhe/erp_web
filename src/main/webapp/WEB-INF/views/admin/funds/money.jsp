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
</head>
<body>

<form name="form" id="form" action="updateMoney.do" method="post">
<input type="hidden" name="id" value="${funds.id}" id="fundsId">

<div class=formzone>
<div class=namezone>
<spring:message code="funds.label.update"/></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle height=30><spring:message code="funds.label.name"/></td>
    <td height=30>
    	<input name="name" value="${funds.name}" id="name" readonly="readonly"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30><spring:message code="funds.label.account"/></td>
    <td height=30>
    	<input name="account" value="${funds.account}" id="account" readonly="readonly"/>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="funds.label.address"/></td>
    <td height=30>
    	<input name="address" value="${funds.address}" id="address" readonly="readonly"/>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="funds.label.status"/></td>
    <td height=30>
    	<c:if test="${funds.status==1}"><spring:message code="admin.label.normal"/></c:if>
    	<c:if test="${funds.status==2}"><spring:message code="admin.label.unnormal"/></c:if>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="funds.label.type"/></td>
    <td height=30>
    	<select name="type" id="type" style="width:160px;">
      		<option value=""><spring:message code="admin.label.select"/></option>
    		<option value="1" <c:if test="${type==1}">selected</c:if>><spring:message code="funds.label.type.income"/></option>
    		<option value="3" <c:if test="${type==3}">selected</c:if>><spring:message code="funds.label.type.outcome"/></option>
    		<option value="2" <c:if test="${type==2}">selected</c:if>><spring:message code="funds.label.type.borrowin"/></option>
    		<option value="4" <c:if test="${type==4}">selected</c:if>><spring:message code="funds.label.type.borrowout"/></option>
    	</select>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="funds.label.money"/></td>
    <td height=30>
    	<input name="money" value="" id="money"  onblur="isPriceNumber(this)"/>
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
	        				money:"required",
	        				type:"required"
	        			},
	        			messages: {
	        				money: $.i18n.prop('money'),
	        				type: $.i18n.prop('funds_type')
	        			},
	        			submitHandler: function(form) {
	        				jQuery(form).ajaxSubmit({  
	        	                type:"post",  //提交方式  
	        	                dataType:"json", //数据类型  
	        	                url:"updateMoney.do",
	        	                success:function(data){ //提交成功的回调函数  
	        	                    if(data==1){
	        	                    	alert( $.i18n.prop('opSucc'));
	        	                    	location.href="list.do";
	        	                    }else if(data==2){
	        	                    	alert($.i18n.prop('exist_code'));
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
