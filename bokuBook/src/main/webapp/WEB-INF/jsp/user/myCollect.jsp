<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" href="css/myCollect.css">
<title>--我的收藏--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/global.js"></script>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="mainContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="headContainer">
			<i class="layui-icon" style="font-size: 30px; color: #fa7a20; margin-left: 30px; color:red;">&#xe658;</i> 
			<span>收藏榜单</span>
			<hr class="layui-bg-red"> 
		</div>
		<div class="mainContent">
			<div class="titleContent">
				<span class="index">排名</span>
				<span class="bookName">书名</span>
				<span class="author">作者</span>
				<span class="price">价格</span>
			</div>
			<div class="bookList">
				<c:forEach items="${bookList}" var="book" varStatus="status">
					<div class="oneBookContainer">
						<span class="index">${status.index+1}</span>
					    <span class="bookName"><a href="book/bookInfo?id=${book.id}" title="" target="_blank">${book.bookname}</a></span>
						<span class="author">${book.bookAuthor}</span>
						<span class="price">￥${book.bookPrice}</span> 
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="scroll-top">
			<i class="layui-icon">&#xe604;</i>
			<p>顶部</p>
		</div>
	</div>
</body>
</html> 