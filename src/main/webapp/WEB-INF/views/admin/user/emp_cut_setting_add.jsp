<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"  %>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
<link href="../../css/dialog.css" type=text/css rel=stylesheet>
<script type="text/javascript"src="../../js/jquery-1.8.0.min.js" ></script> 
<script type="text/javascript" src="../../js/language.js"></script>
<script type="text/javascript"src="../../js/interface.js" ></script> 

</head>
<body>

<form name="form" id="form" action="add.do" method="post" >
<input type="hidden" id="goods_rate" value="test">
<c:if test="${setting.id>0}">
<input type="hidden" name="id" value="${setting.id}">
</c:if>
<div class=formzone>
<div class=namezone>设置业务员提成</div>
<div class=tablezone>
<div class=noticediv id=notice></div>
<table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
  <tbody>
  <tr>
    <td align=middle width=100 height=30>业务员</td>
    <td height=30>
    	<input type="hidden"  name="empId" value="${setting.empId}"  />
    	<input  name="salesMan" value="${setting.empName}" id="salesMan" readonly="readonly" onclick="showDialog(this,'业务员','../employee/dialog.do',25,100,2);"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>客户</td>
    <td height=30>
    	<input type="hidden" name="cusId" value="${setting.cusId}"/>
    	<input type="hidden" name="cusIdTest" value=""/>
		<input name="cusName" id="cusName" value="${setting.cusName}" readonly="readonly" onclick="showDialog(this,'产品名称','../customer/dialog.do',25,100,2);"/>
    </td>
  </tr>
  <tr>
    <td align=middle height=30>产品名称</td>
    <td height=30>
    	<input type="hidden" name="goodsId" value="${setting.goodsId}"/>
		<input name="goodsName" value="${setting.goodsName}" id="goodsName" title="" readonly="readonly" onclick="showDialog(this,'产品名称','../goods/dialog.do',25,100,2);"/>
    </td>
  </tr>
  <tr>
    <td align=middle width=100 height=30>提成率</td>
    <td height=30>
    	<select name="rateId" id="rateId">
    		<c:forEach items="${rates}" var="ra">
    		<option value="${ra.id}" <c:if test="${ra.id==setting.rateId}">selected</c:if>>${ra.discount}--${ra.rate}</option>
    		</c:forEach>
    	</select>
    </td>
   </tr>
   <tr>
    <td align=middle width=100 height=30>备注</td>
    <td height=30>
    	<textarea rows="5" cols="40" name="mark"></textarea>
    </td>
  </tr>
   </tbody>
</table>
</div>
<div class=adminsubmit><input class="button" type="submit" value="提交" />  
<input class="button" type="button" value="返回" onclick="history.go(-1)"/> 
</div>
</div>
</form>

	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript">
	jQuery(function() {
		var v = jQuery("#form").validate({
			rules: {
				salesMan:"required",
				cusName:"required",
				goodsName:"required",
				rateId:"required"
			},
			messages: {
				salesMan:"业务员不能为空",
				cusName:"客户不能为空",
				goodsName:"产品不能为空",
				rateId:"提成比不能为空"
			},
			submitHandler: function(form) {
				jQuery(form).ajaxSubmit({  
	                type:"post",  //提交方式  
	                dataType:"json", //数据类型  
	                success:function(data){ //提交成功的回调函数  
	                    if(data==1){
	                    	alert("操作成功!");
	                    	location.href="list.do";
	                    }else if(data==2){
	                    	alert("该业务员已存在相同客户和提成设置");
	                    }else{
	                    	alert("操作错误，请重新提交尝试!");
	                    }
	                }  
	            });
			}
		});
		
	});
	</script>

</body>
</html>
