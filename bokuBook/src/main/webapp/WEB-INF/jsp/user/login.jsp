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
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/home.css">
<script src="layui/layui.js"></script>
<script src="jquery/jquery-2.2.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--登录--</title>
<script>
	layui.use('form', function() {
		var form = layui.form;
	});
</script>
</head>
<body>

	<div class="loginContainer">
		<div class="formContetn">
			<div class="title">博库阅读</div>
			<form class="layui-form" action="">
				<div class="layui-form-item">
					<span class="layui-form-label">用户名:</span>
					<div class="layui-input-block">
						<input type="text" name="title" required lay-verify="required"
							placeholder="请输入用户名" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<span class="layui-form-label">密码:</span>
					<div class="layui-input-block">
						<input type="password" name="password" required
							lay-verify="required" placeholder="请输入密码" autocomplete="off"
							class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">记住我</label>
					<div class="layui-input-block">
						<input type="checkbox" name="switch" lay-skin="switch">
					</div>
				</div>
				<div class="buttonCombination">
					<button class="layui-btn layui-btn-radius layui-btn-warm" lay-submit>登录</button>
					<button class="layui-btn layui-btn-radius" lay-submit>注册</button>
				</div>

			</form>
		</div>
	</div>
</body>
</html>