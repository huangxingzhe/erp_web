<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
<script type="text/javascript"src="../../js/interface.js" ></script> 
<script type="text/javascript" src="../../js/language.js"></script>
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../css/dialog.css" type=text/css rel=stylesheet>
</head>
<body>

<form name="form" id="form" action="add.do" method="post">
<c:if test="${rate.id>0}">
<input type="hidden" name="id" value="${rate.id}" id="rateId">
<input type="hidden" name="status" value="${rate.status}" id="status">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${rate==null||rate.id==0}">添加产品提成</c:if>
<c:if test="${rate.id>0}">更新产品提成</c:if></div>
<div class=tablezone>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
   <tr>
    <td align=middle height=30>产品名称</td>
    <td height=30>
    	<input type="hidden"  name="goodsId" value="${rate.goodsId}"  />
    	<input  name="goodsName" value="${rate.goodsName}" id="goodsName" readonly="readonly" onclick="showDialog(this,'产品名称','../goods/dialog.do',25,100,2);"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>计算方法</td>
    <td height=30>
    	<select name="type" id="type">
    		<option value="1" <c:if test="${rate.type==1}">selected</c:if>>
    			按折扣</option>
    		<option value="2" <c:if test="${rate.type==2}">selected</c:if>>
    			按数量</option>
    	</select>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>计算内容</td>
    <td height=30>
    	<input name="discount" value="${rate.discount}" id="discount"/> &nbsp;格式：6.1折或者1000-2000
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30>提成比率</td>
    <td height=30>
    	<input name="rate" value="${rate.rate}" id="rate"/> &nbsp;格式：0.2%
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
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript" src="../../js/jquery.i18n.properties-min-1.0.9.js"></script>
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
	        				name: $.i18n.prop('rate_name'),
	        				code: $.i18n.prop('rate_code'),
	        				type: $.i18n.prop('rate_type')
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
