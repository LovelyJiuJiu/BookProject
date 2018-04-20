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
<base href=${path } />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/accessCountPage.css">
<title>--浏览榜单--</title>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/accessCountPage.js"></script>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="mainContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="headContainer">
			<i class="layui-icon" style="font-size: 30px; color: #fa7a20; margin-left: 30px;">&#xe756;</i> 
			<span>浏览榜单</span>
			<hr class="layui-bg-red"> 
		</div>
		<div class="mainContent">
			<div class="titleContent">
				<span class="index">排名</span>
				<span class="bookName">书名</span>
				<span class="author">作者</span>
				<span class="type">分类</span>
				<span class="accessCount">浏览次数</span>			
			</div>
			<div class="bookList">
				<div class="oneBookContainer">
					<span class="index">1</span>
				    <span class="bookName">第一本书</span>
					<span class="author">张苡弦</span>
					<span class="type">文学类</span> 
					<span class="accessCount">10000</span>
				</div>
				<div class="oneBookContainer">
					<span class="index">1</span>
				    <span class="bookName">第一本书</span>
					<span class="author">张苡弦</span>
					<span class="type">文学类</span> 
					<span class="accessCount">10000</span>
				</div>
				<div class="oneBookContainer">
					<span class="index">1</span>
				    <span class="bookName">第一本书</span>
					<span class="author">张苡弦</span>
					<span class="type">文学类</span> 
					<span class="accessCount">10000</span>
				</div>
			</div>
			<div class="goBackTop">
			    <i class="layui-icon" id="btn"  style="font-size: 40px; color: #fa7a20;">&#xe604;</i>
			</div>

		
		</div>
	
	
	
	</div>
</body>
</html> 