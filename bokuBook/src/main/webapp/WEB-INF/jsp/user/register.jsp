<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("path", basePath);
%>
<base href="${path }"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/register.css">
<link rel="stylesheet" href="css/home.css">
<title>--用户注册--</title>
</head>
<body>
	<div class="registerContainer">
		<div class="formContent">
			<div class="title">博库阅读</div>
			<div class="iconContent" onclick="backToHome();">
				<i class="layui-icon">&#xe68e;</i>  
			</div>
			<form class="layui-form">
				<div class="layui-form-item">
					<span class="layui-form-label">用户名:</span>
					<div class="layui-input-block">
						<input type="text" name="username" lay-verify="required"
							placeholder="请输入用户名" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<span class="layui-form-label">邮箱:</span>
					<div class="layui-input-block">
						<input type="text" name="email"
							lay-verify="required|email" placeholder="请输入邮箱" autocomplete="off"
							class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<span class="layui-form-label">密码:</span>
					<div class="layui-input-block">
						<input type="password" name="password"
							lay-verify="required" placeholder="请输入密码" autocomplete="off"
							class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<span class="layui-form-label">确认密码:</span>
					<div class="layui-input-block">
						<input type="password" name="password"
							lay-verify="required" placeholder="请再次输入密码" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">个人简介：</label>
					<div class="layui-input-block">
						<textarea name="desc" placeholder="请输入个人简介内容......" class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="buttonCombination">
					<button class="layui-btn layui-btn-radius layui-btn-warm" lay-submit id="regSub" lay-filter="register-btn">注册</button>
				</div>
			</form>
		</div>
	</div>
	<script src="jquery/jquery-2.2.4.min.js"></script>
	<script src="layui/layui.js"></script>
	<script src="js/register.js"></script>
</body>
</html>