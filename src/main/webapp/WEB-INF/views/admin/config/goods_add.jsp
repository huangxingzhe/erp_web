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

<form name="form" id="form" action="add.do" method="post">
<c:if test="${goods.id>0}">
<input type="hidden" name="id" value="${goods.id}" id="goodsId">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${goods==null||goods.id==0}"><spring:message code="goods.label.add"/></c:if>
<c:if test="${goods.id>0}"><spring:message code="goods.label.update"/></c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle height=30><spring:message code="goods.label.name"/></td>
    <td height=30>
    	<input name="name" value="${goods.name}" id="name"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30><spring:message code="goods.label.code"/></td>
    <td height=30>
    	<input name="code" value="${goods.code}" id="code"/>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="goods.label.type"/></td>
    <td height=30>
    	<input name="type" value="${goods.type}" id="type"/>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30><spring:message code="goods.label.status"/></td>
    <td height=30>
    	<select name="status" id="status">
    		<option value="1" <c:if test="${goods.status==1}">selected</c:if>>
    			<spring:message code="admin.label.normal"/></option>
    		<option value="2" <c:if test="${goods.status==2}">selected</c:if>>
    			<spring:message code="admin.label.unnormal"/></option>
    	</select>
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
	        				name:"required",
	        				code:"required",
	        				type:"required"
	        			},
	        			messages: {
	        				name: $.i18n.prop('goods_name'),
	        				code: $.i18n.prop('goods_code'),
	        				type: $.i18n.prop('goods_type')
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
