<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("path", basePath);
%>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<script src="layui/layui.js"></script>
<base href="${path }"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--登录--</title>
</head>
<body>
	<div class="loginContainer">
	
		<form action="">
			<div class="userNameContext">
				<span>userName:</span>
				<input name="userName" value="请输入用户名..."/>
			</div>
			
			<div class="passwordContext">
				<span>password:</span>
				<i class="layui-icon">&#xe612;</i> 
				<input name="password" type="password" />
			</div>
			
			
		</form>
	
	
	</div>
</body>
</html>