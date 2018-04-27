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
<script src="js/adminMain.js"></script>
<script type="text/html" id="operation">
	<a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>
</head>
<body>
	<div class="adminMainContainer">
		<div class="leftContainer">
			<ul class="layui-nav layui-nav-tree layui-nav-side layui-bg-cyan"  lay-filter="test">
				 <li class="top-item layui-nav-item layui-nav-itemed">
				 	<a href="javascript:;">用户管理</a>
				 	    <dl class="layui-nav-child">
      						<dd><a class="choose" href="admin/userListPage" target="userList">查看用户</a></dd>
    					</dl>
				 </li>
				 <li class="layui-nav-item">
				 	<a href="javascript:;">书籍管理</a>
				 	    <dl class="layui-nav-child">
      						<dd><a href="javascript:;">查看书籍</a></dd>
      						<dd><a href="javascript:;">添加书籍</a></dd>
    					</dl>
				 </li>
				 <li class="layui-nav-item">
				 	<a href="javascript:;">订单管理</a>
				 	    <dl class="layui-nav-child">
      						<dd><a href="javascript:;">查看订单</a></dd>
      						<dd><a href="javascript:;">处理订单</a></dd>
    					</dl>
				 </li>
				 <li class="layui-nav-item">
				 	<a id="adminLogout" href="javascript:;">退出</a>
				 </li>			
			</ul>
		</div>		
		<div class="rightContainer">
			<table id="userTable" lay-filter="userList"></table>
			<div class="footerContainer">
				<span>2018 @博库阅读</span>
			</div>
		</div>	
	</div>

<!-- <iframe id="userList" name="userList" frameborder="0"></iframe>  -->
</body>
</html>