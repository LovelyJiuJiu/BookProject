<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
</script>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
	<div class="bookInfoContainer">
		<div class="headContainer">
			<div class="leftContainer">
				<div class="bookImage">
					<img src="image/firstBook.jpg" alt="图片" title="标题" />
				</div>
			</div>

			<div class="rightContainer">
				<div class="bookTitle">你期待的美好在路上</div>
				<div class="bookContent">作者：张苡弦 字数：7.9万字</div>
				<div class="price"></div>
				<div class="moreChoice">
					<div class="readBook layui-btn layui-btn-radius">在线阅读</div>
					<div class="purchse layui-btn layui-btn-danger layui-btn-radius">立即购买</div>
				</div>

				<div class="summary layui-collapse" lay-filter="collapseFilter">
					<div class="layui-colla-item">
						<h2 class="layui-colla-title">简介</h2>
						<div class="layui-colla-content layui-show">1和大多数正常成长起来的孩子一样，作者张苡弦从小就是个“乖孩子”，
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
				<div class="oneComment">
					<div class="commentNumber">1楼</div>
					<span class="userName">白日梦</span>
					<div class="commentInfo">当初这本小说吸引我的是啥?医学，对，因为我现在在学习医学，有意无意的就想了解一下和医学有关的方面。可是故事的情节讲其推向了爱情，而且结尾的时候很罗曼蒂克，让我觉得，故事的整个架构都很空，没有小说吸引人的地方，落入了俗套。不过除生死之外，再无大事。</div>
				</div>
				<div class="oneComment">
					<div class="commentNumber">2楼</div>
					<span class="userName">白日梦</span>
					<div class="commentInfo">当初这本小说吸引我的是啥?医学，对，因为我现在在学习医学，有意无意的就想了解一下和医学有关的方面。可是故事的情节讲其推向了爱情，而且结尾的时候很罗曼蒂克，让我觉得，故事的整个架构都很空，没有小说吸引人的地方，落入了俗套。不过除生死之外，再无大事。</div>
				</div>
			</div>
			<div class="writeCommentTitle">编写我的评论:</div>
			<textarea name="" required lay-verify="required" placeholder="我也来说两句......" class="layui-textarea writeComment"></textarea>
			<div class="submitComment layui-btn layui-btn-danger layui-btn-radius">发表</div>
		</div>


	</div>
</body>
