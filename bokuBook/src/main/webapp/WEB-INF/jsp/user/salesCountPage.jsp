
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("path", basePath);
 %>
<base href=${path } />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/salesCountPage.css">
<title>--浏览榜单--</title> 
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="layui/layui.js"></script>
<script src="js/global.js"></script>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="mainContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="headContainer">
			<i class="layui-icon"
				style="font-size: 25px; color: #fa7a20; margin-left: 30px;">&#xe756;</i>
			<span>热销榜单</span>
			<hr class="layui-bg-red">
		</div>
		<div class="mainContent">
			<div class="titleContent">
				<span class="index">排名</span>
				<span class="bookName">书名</span>
				<span class="author">作者</span>
				<span class="type">分类</span>
				<span class="price">售价</span>
				<span class="salesCount">销量</span>
			</div>
			<div class="bookList">
				<c:forEach items="${hotBookList}" var="book" varStatus="status">
					<div class="oneBookContainer">
						<span class="indexNum">${status.index+1}</span>
						<span class="bookName"><a href="book/bookInfo?id=${book.id}" title="" target="_blank">${book.bookname}</a></span>
						<span class="author">${book.bookAuthor}</span>
						<span class="type">${book.typename}</span>
						<span class="price">￥${book.bookPrice}</span>
						<span class="salesCount">${book.purchaseCount}</span>
					</div>
				</c:forEach>
			</div>
			<div class="scroll-top">
				<i class="layui-icon">&#xe604;</i>
				<p>顶部</p>
			</div>
		</div>

	</div>
</body>
</html>