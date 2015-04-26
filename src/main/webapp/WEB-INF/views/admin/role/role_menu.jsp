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
<style>
 .priviTitle
{
    display: block;
    border: solid 1px #cde6ff;
    background-color: #f2f9fd;
    padding: 5px 5px;
}
div.subItem
{
    overflow: hidden;
    padding: 5px 10px;
    zoom: 1;
}
div.subItem2
{
    display: inline-block;
    width: 165px;
    height: 25px;
    line-height: 25px;
    float: left;
    overflow: hidden;
}
.subPriDiv
{
    position: fixed;
    border: solid 1px #888;
    height: 200px;
    width: 120px;
    left: 10px;
    display: none;
    z-index: 500;
    background-color: #DEDEDE;
}
.subPriDiv span
{
    display: block;
    line-height: 16px;
    height: 16px;
    margin: 2px;
}
span.subBtn
{
    color: #1565AF;
    cursor: pointer;
}
</style>
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
						<%-- <tr bgcolor="#FFFFFF" onmouseover="this.bgColor='#CDE6FF'" onmouseout="this.bgColor='#FFFFFF'" >
							<td class=biaoti style="text-align:left;border:0px;"><input type="checkbox"  value="${menu.id}" name="menuIds" id="menu${menu.id}" <c:if test="${menu.checked!=null}">checked</c:if>><strong>${menu.name}</strong></td>
						</tr> --%>
						<tr bgcolor="#FFFFFF" >
							<td height="40">
								<%-- 	<input type="checkbox"  value="${child.id}" name="menuIds" class="checkbox" <c:if test="${child.checked!=null}">checked</c:if> id="menu${child.id}">
									<span style="width:150px;padding:5px;">${child.name}</span>
									<c:if test="${(st.index+1)%5==0}"><br/></c:if> --%>
								<div>
									<h4 class="priviTitle">${menu.name}<input id="" type="checkbox" name="menuIds" <c:if test="${menu.checked!=null}">checked</c:if>
									  onclick="fnCheckItem(this);"><label for="">全选</label></h4>
									<div class="subItem">
										<c:forEach items="${menu.childs}" var="child" varStatus="st">
										<div class="subItem2">
											<span class="q01"><input id="" type="checkbox" name="menuIds"
											<c:if test="${child.checked!=null}">checked</c:if> onclick="fnUnCheck(this);"><label for="">${child.name}</label></span>
											<span class="subBtn" onclick="showSubDiv(this,'q01DIV');">&nbsp;&nbsp;子权限</span>
										</div>
										<div class="subPriDiv" id="q01DIV" onmouseover="delayHide();" onmouseout="hideMe(this)">
											<span class="RVA"><input id="" type="checkbox" name="" checked="checked" onclick="setParentCheck(this,'q01');" />
											<label for="">添加日常收款</label></span>
										</div>
										</c:forEach>
									</div>
								</div>	
								
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
    //选择当前节点下所有子元素
    function fnCheckItem(obj) {
        //找到当前对象的父对象
        var div = obj.parentNode.parentNode;
        //找到checkbox
        var chks = div.getElementsByTagName("input");

        for (i = 0; i < chks.length; i++) {
            if (chks[i].type == 'checkbox') {
                chks[i].checked = obj.checked;
            }
        }
    }

    //去除当前元素的父元素的全选
    function fnUnCheck(obj) {
        var divID = obj.parentNode.className + "DIV";
        $.each($("#" + divID + " :checkbox"), function (i, o) {
            o.checked = obj.checked;
        });
    }
    function setParentCheck(obj, parentID) {
        if (obj.checked) {
            $.each($("." + parentID + " :checkbox"), function (i, o) {
                o.checked = obj.checked;
            });
        }
    }
    function showSubDiv(obj, id) {
        var xy = getAbsPoint(obj);
        var top = xy.Y - getScrollTop();
        document.getElementById(id).style.left = xy.X + "px";
        document.getElementById(id).style.top = top + "px";
        document.getElementById(id).style.display = "block";
    }
    var hideID = "";
    function delayHide(obj) {
        hideID = "";
    }
    function hideMe(obj) {
        hideID = obj.id;
        window.setTimeout("closeDiv();", 1);
    }
    function closeDiv() {
        if (hideID != "") {
            document.getElementById(hideID).style.display = "none";
        }
    }
    function getScrollTop() {
        var scrollPos = document.getElementById("bodyDIV").scrollTop;
        return scrollPos;
    } 

	</script>
</body>
</html>
