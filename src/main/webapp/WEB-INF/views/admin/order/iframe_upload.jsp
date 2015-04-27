<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
<script src="../../js/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<input type="hidden" name="photo" id="pid" value="${picUrl}"/>
<script type="text/javascript">
var imgPath = $("#pid").val();
var imgSrc = parent.document.getElementById('preImg');
var phoObj = parent.document.getElementById('picUrl');
$(phoObj).val(imgPath);
$(imgSrc).attr("src",'showPhoto.do?path='+imgPath);
</script>
</body>
</html>

