<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>home</title>
<link href="../../images/style.css" type=text/css rel=stylesheet>
</head>

<body>
	<div class=searchzone>
		<table height=35 cellspacing=0 cellpadding=0 width="100%" border=0>
			<tr>
		      <td width="9%" height="30" class="tx-c">当前分配菜单角色：<font color="red">${role.name}</font></td>
		      <td width="37%">&nbsp;</td>
		    </tr>
	    </table>
	</div>
	<form id="form" action="addRoleMenu.do" method="post">
		<input name="id" value="${role.id}" type="hidden"/>
		<div class=listzone>
			<table cellspacing=0 cellpadding=3 width="100%" align=center border=0>
				<tbody>
					<c:forEach items="${menus}" var="menu" >
						<tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'" >
							<td class=biaoti style="text-align:left;border:0px;"><input type="checkbox"  value="${menu.id}" name="menuIds" id="menu${menu.id}" <c:if test="${menu.checked!=null}">checked</c:if>><strong>${menu.name}</strong></td>
						</tr>
						<tr bgcolor="#FFFFFF" >
							<td height="40">
								<c:forEach items="${menu.childs}" var="child" varStatus="st">
								<%-- 	<input type="checkbox"  value="${child.id}" name="menuIds" class="checkbox" <c:if test="${child.checked!=null}">checked</c:if> id="menu${child.id}">
									<span style="width:150px;padding:5px;">${child.name}</span>
									<c:if test="${(st.index+1)%5==0}"><br/></c:if> --%>
									
									<div class="subItem">
										<!--内层Repeater-->

										<div class="subItem2">
											<span class="q01"><input
												id="repParent_ctl01_repSubItem_ctl00_chkPw" type="checkbox"
												name="repParent$ctl01$repSubItem$ctl00$chkPw"
												checked="checked" onclick="fnUnCheck(this);"><label
												for="repParent_ctl01_repSubItem_ctl00_chkPw">流水账</label></span>
										</div>
										<div class="subPriDiv" id="q01DIV" onmouseover="delayHide();"
											onmouseout="hideMe(this)"></div>

										<div class="subItem2">
											<span class="q02"><input
												id="repParent_ctl01_repSubItem_ctl01_chkPw" type="checkbox"
												name="repParent$ctl01$repSubItem$ctl01$chkPw"
												checked="checked" onclick="fnUnCheck(this);"><label
												for="repParent_ctl01_repSubItem_ctl01_chkPw">日常收款</label></span><span
												class="subBtn" onclick="showSubDiv(this,'q02DIV');">&nbsp;&nbsp;子权限</span>
										</div>



										<!--内层Repeater结束-->
									</div>
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class=adminsubmit><input class="button" type="submit" value="提交" />  
			<input class="button" type="button" value="返回" onclick="history.go(-1)"/> 
		</div>
	</form>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../../js/jquery.form.js"></script>
	<script type="text/javascript">
	jQuery(function() {
		var v = jQuery("#form").validate({
			rules: {
				menuIds:"required"
			},
			messages: {
				menuIds: "请选择菜单"
			},
			errorPlacement: function(error, element) { //指定错误信息位置 
				if (element.is(':radio') || element.is(':checkbox')) { //如果是radio或checkbox 
					var eid = element.attr('name'); //获取元素的name属性 
					error.appendTo(element.parent()); //将错误信息添加当前元素的父结点后面 
					} else { 
					error.insertAfter(element); 
				} 
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
	                    	alert("请选择菜单!");
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
