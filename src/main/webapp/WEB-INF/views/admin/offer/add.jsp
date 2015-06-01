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
<c:if test="${offer.id>0}">
<input type="hidden" name="id" value="${offer.id}" id="offerId">
</c:if>
<div class=formzone>
<div class=namezone><c:if test="${offer==null||offer.id==0}"><spring:message code="offer.label.add"/></c:if>
<c:if test="${offer.id>0}"><spring:message code="offer.label.update"/></c:if></div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30><spring:message code="offer.label.productCN"/></td>
    <td height=30>
    	<input name="productCN" value="${offer.productCN}" id="productCN"/>
    </td>
    <td align=middle width=100 height=30><spring:message code="offer.label.productVN"/></td>
    <td height=30>
    	<input name="productVN" value="${offer.productVN}" id="productVN"/>
    </td>
   </tr>
   <tr>
   	<td align=middle width=100 height=30><spring:message code="offer.label.price"/></td>
    <td height=30>
    	<input name="price" value="${offer.price}" id="price"  onblur="isPriceNumber(this)"/>
    </td>
    <td align=middle width=100 height=30><spring:message code="offer.label.discount"/></td>
    <td height=30>
    	<input name="discount" value="${offer.discount}" id="discount"/>
    </td>
   </tr>
   <tr>
   	<td align=middle width=100 height=30><spring:message code="offer.label.fee" /></td>
    <td height=30>
    	<input name="fee" value="${offer.fee}" id="fee"  onblur="isPriceNumber(this)"/>
    </td>
    <td align=middle width=100 height=30><spring:message code="offer.label.profit"/></td>
    <td height=30>
    	<input name="profit" value="${offer.profit}" id="profit"/>
    </td>
   </tr>
    <tr>
    <td align=middle height=30><spring:message code="offer.label.format"/></td>
    <td height=30>
    	<input name="format" value="${offer.format}" id="format"/>
    </td>
    <td align=middle height=30><spring:message code="offer.label.customerName"/></td>
    <td height=30>
    	<input name="customerName" value="${offer.customerName}" id="customerName"/>
    </td>
    
  </tr>
  <tr>
    <td align=middle height=30><spring:message code="offer.label.customerEmail"/></td>
    <td height=30>
    	<input name="customerEmail" value="${offer.customerEmail}" id="customerEmail"/>
    </td>
    <td align=middle height=30><spring:message code="offer.label.customerPhone"/></td>
    <td height=30>
    	<input name="customerPhone" value="${offer.customerPhone}" id="customerPhone"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30><spring:message code="offer.label.providerName"/></td>
    <td height=30>
    	<input name="providerName" value="${offer.providerName}" id="providerName"/>
    </td>
    <td align=middle height=30><spring:message code="offer.label.providerPhone"/></td>
    <td height=30>
    	<input name="providerPhone" value="${offer.providerPhone}" id="providerPhone"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30><spring:message code="offer.label.providerUrl"/></td>
    <td height=30>
    	<input name="providerUrl" value="${offer.providerUrl}" id="providerUrl"/>
    </td>
    <td align=middle height=30><spring:message code="offer.label.providerAddr"/></td>
    <td height=30>
    	<input name="providerAddr" value="${offer.providerAddr}" id="providerAddr"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30><spring:message code="offer.label.providerUser"/></td>
    <td height=30>
    	<input name="providerUser" value="${offer.providerUser}" id="providerUser"/>
    </td>
   <td align=middle width=100 height=30><spring:message code="offer.label.mark"/></td>
    <td height=30>
    	<textarea rows="5" cols="40" name="mark">${offer.mark}</textarea>
  	</td>
  </tr>
  <tr>
    
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
	        				customerName:"required",
	        				discount:"required"
	        			},
	        			messages: {
	        				customerName: $.i18n.prop('客户名称不能为空'),
	        				discount: $.i18n.prop('折扣不能为空')
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
