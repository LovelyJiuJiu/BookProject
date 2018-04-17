<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href=${path } />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bookInfo.css">
<title>--书籍信息--</title>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script>
	layui.use('element', function() {
		var element = layui.element();
		element.init();
	});
	
	$(document).ready(function() {
		if (!$('#ImgHref').val()) {
			$('#Img').attr('src', "image/deafultPhoto.jpg");
		}
	});
</script>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="bookInfoContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="headContainer">
			<div class="leftContainer">
				<div class="bookImage">
					<img src="image/${book.bookImage}" alt="${book.bookname}" title="${book.bookname}" />
				</div>
			</div>

			<div class="rightContainer">
				<div class="bookTitle"> ${book.bookname}</div>
				<div class="bookContent">${book.bookAuthor}</div>
				<div class="price"></div>
				<div class="moreChoice">
					<div class="readBook layui-btn layui-btn-radius">在线阅读</div>
					<div class="purchse layui-btn layui-btn-danger layui-btn-radius">立即购买</div>
				</div>

				<div class=" layui-collapse" lay-filter="collapseFilter">
					<div class="layui-colla-item">
						<h2 class="layui-colla-title">简介</h2>
						<div class="summary layui-colla-content layui-show">${book.bookIntroduction}
						</div>
					</div>
				</div>

			</div>
		</div>
		<div class="footerContainer">
			<span class="footerLContainer">评论区</span> <i class="layui-icon"
				style="font-size: 30px; color: #fa7a20;">&#xe642;</i>
			<hr class="layui-bg-orange">
			<div class="commentContent">
				<c:forEach items="${userReplyList}" var="userReply" varStatus="status">
					<div class="oneComment">
						<div class="userImg">
							<img id="Img" alt="" src="image/${userReply.imgName}">
							<input id="ImgHref" type="hidden" value="${userReply.imgName}"> 
						</div>
						<div class="otherContent">
							<span class="userName">${userReply.username}</span>
							<span class="replyDate">${userReply.replytime}</span> 
							<span class="commentNumber">${status.index+1}楼</span>
						</div>
						<div class="commentInfo">${userReply.replycontents}</div>
					</div>
				</c:forEach>
			</div>
			<div class="writeCommentTitle">编写我的评论:</div>
			<textarea name="" required lay-verify="required" placeholder="我也来说两句......" class="layui-textarea writeComment"></textarea>
			<div class="submitComment layui-btn layui-btn-danger layui-btn-radius">发表</div>
		</div>


	</div>
</body>
