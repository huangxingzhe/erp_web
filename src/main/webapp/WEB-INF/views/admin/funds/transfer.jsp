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

<form name="form" id="form" action="transferMoney.do" method="post">
<input type="hidden" name="outFundsId" value="${fund.id}" id="outFundsId">

<div class=formzone>
<div class=namezone>
<spring:message code="funds.label.updateMoney"/></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle height=30><spring:message code="funds.label.transferOut"/></td>
    <td height=30>
    	<input name="outName" value="${fund.name}" id="outName" readonly="readonly"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30><spring:message code="funds.label.transferIn"/></td>
    <td height=30>
    	<select name="inFundsId" id="inFundsId" style="width:160px;" onchange="selectAccount()">
    		<option value=""><spring:message code="admin.label.select"/></option>
   			<c:forEach items="${funds}" var="f">
   			<c:if test="${fund.id!=f.id}">
    			<option label="${f.name}" value="${f.id}"></option>
    		</c:if>
    		</c:forEach>
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
	        				inFundsId:"required"
	        			},
	        			messages: {
	        				money: $.i18n.prop('money'),
	        				inFundsId: $.i18n.prop('请选择转入账号')
	        			},
	        			submitHandler: function(form) {
	        				jQuery(form).ajaxSubmit({  
	        	                type:"post",  //提交方式  
	        	                dataType:"json", //数据类型  
	        	                url:"transferMoney.do",
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
