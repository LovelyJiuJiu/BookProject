<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href="${path }" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/adminMain.css">
<link rel="stylesheet" href="css/home.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--管理员主页--</title>
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script>

$(document).ready(function() {
	$('#adminLogout').on('click', function () {
		logout();
	});
});

function logout() {
	$.ajax({
		url : 'admin/logout',
		async : true,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			if (data.result === 1) {
				window.location.href = "admin/login";
			} else if (data.result === 0) {
				layer.msg("服务器错误");
			} else {
				layer.msg("拜托..  你还没有登录 (￣□￣；)");
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}
</script>
</head>
<body>
	<div class="adminMainContainer">
		<span id="adminLogout">退出</span>		
	</div>


</body>
</html>