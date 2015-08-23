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
</head>
<body>

<form name="form" id="form" action="add.do" method="post">
<c:if test="${money.id>0}">
<input type="hidden" name="id" value="${money.id}" id="moneyId">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${money==null||money.id==0}"><spring:message code="money.label.add"/></c:if>
<c:if test="${money.id>0}"><spring:message code="money.label.update"/></c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  
  <tr>
    <td align=middle height=30><spring:message code="money.label.rent"/></td>
    <td height=30>
    	<input name="yearMonth" type="text" id="month" class="dtime" 
    	onfocus="WdatePicker({dateFmt:'yyyy-MM'});" value="<fmt:formatDate value="${money.month}" pattern="yyyy-MM"/>" 
    	style="width:150px;" />
    </td>
     <td align=middle height=30><spring:message code="money.label.rent"/></td>
    <td height=30>
    	<input name="rent" value="<fmt:formatNumber value="${money.rent}" type="currency"  pattern="#,#00.00#"/>" id="rent" onblur="formatMoney(this)" />
    </td>
  </tr>
  <tr>
  	 <td align=middle width=100 height=30><spring:message code="money.label.salary"/></td>
    <td height=30>
    	<input name="salary" value="<fmt:formatNumber value="${money.salary}" type="currency"  pattern="#,#00.00#"/>" id="salary" onblur="formatMoney(this)" />
    </td>
  	<td align=middle width=100 height=30><spring:message code="money.label.safe"/></td>
    <td height=30>
    	<input name="safe" value="<fmt:formatNumber value="${money.safe}" type="currency"  pattern="#,#00.00#"/>" id="safe" onblur="formatMoney(this)" />
    </td>
    
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="money.label.water"/></td>
    <td height=30>
    	<input name="water" value="<fmt:formatNumber value="${money.water}" type="currency"  pattern="#,#00.00#"/>" id="water" onblur="formatMoney(this)" />
    </td>
    <td align=middle width=100 height=30><spring:message code="money.label.tel"/></td>
    <td height=30>
    	<input name="tel" value="<fmt:formatNumber value="${money.tel}" type="currency"  pattern="#,#00.00#"/>" id="tel" onblur="formatMoney(this)" />
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="money.label.ext"/></td>
    <td height=30>
    	<input name="ext" value="<fmt:formatNumber value="${money.ext}" type="currency"  pattern="#,#00.00#"/>" id=ext onblur="formatMoney(this)" />
    </td>
    <td align=middle width=100 height=30><spring:message code="money.label.mark"/></td>
    <td height=30 >
    	<textarea rows="5" cols="40" name="mark"></textarea>
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
	        				month:"required"
	        			},
	        			messages: {
	        				month: $.i18n.prop('请填写年月份')
	        			},
	        			submitHandler: function(form) {
	        				checkMoney('rent');
	        				checkMoney('salary');
	        				checkMoney('safe');
	        				checkMoney('water');
	        				checkMoney('tel');
	        				checkMoney('ext');
	        				jQuery(form).ajaxSubmit({  
	        	                type:"post",  //提交方式  
	        	                dataType:"json", //数据类型  
	        	                url:"add.do",
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
	</script>

</body>
</html>
