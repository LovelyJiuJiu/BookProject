<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>--书城首页--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/bookMain.css">
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="layui-carousel" id="test1">
			<div carousel-item>
				<div>
					<a href="/book/book/bookInfo?id=9" target="_blank"> <img alt="图片" src="image/how.png" title="半小时漫画世界史" />
					</a>
				</div>
				<div>
					<a href="/book/book/bookInfo?id=10" target="_blank"> <img alt="图片" src="image/yw.png" title="萤王" />
					</a>
				</div>
				<div>
					<a href="/book/book/bookInfo?id=11" target="_blank"> <img alt="图片" src="image/firstPlayer.png" title="头号玩家" />
					</a>
				</div>
				<div>
					<a href="/book/book/bookInfo?id=12" target="_blank"> <img alt="图片" src="image/tnd.png" title="听你的" />
					</a>
				</div>
			</div>
		</div>
		<div class="newBookTitle">新书榜</div>
		<div class="new-book">
			<s class="sign"></s>

			<c:forEach items="${newBooks}" var="book" varStatus="status">
				<c:if test="${ status.index == 0}">
					<div class="rightContainer">
						<h3 class="newBookName">
							<a href="book/bookInfo?id=${book.id}" title="" target="_blank">${book.bookname}</a>
						</h3>
						<p class="newBookAuthor">作者：${book.bookAuthor}</p>
						<div class="newBookIntroduce">${book.bookIntroduction}</div>
						<div class="newBookImg">
							<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
								target="_blank"> <img alt="" src="image/${book.bookImage}">
							</a>
						</div>
					</div>
				</c:if>

				<div class="leftContainer">
					<c:if test="${ status.index == 1 || status.index == 3}">
						<div class="firstLeft">
							<div class="leftImg">
								<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
									target="_blank"> <img alt="" src="image/${book.bookImage}">
								</a>
							</div>
							<div class="leftBookName">
								<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
									target="_blank">${book.bookname}</a>
							</div>
							<div class="leftBookAuthor">作者：${book.bookAuthor}</div>
						</div>
					</c:if>
					<c:if test="${ status.index == 2 || status.index == 4}">
						<div class="secondLeft">
							<div class="leftImg">
								<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
									target="_blank"> <img alt="" src="image/${book.bookImage}">
								</a>
							</div>
							<div class="leftBookName">
								<a href="" title="${book.bookname}" target="_blank">${book.bookname}</a>
							</div>
							<div class="leftBookAuthor">作者：${book.bookAuthor}</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>

		<div class="newBookTitle">畅销榜</div>
		<div class="hot-book">
			<s class="sign"></s>
			<c:forEach items="${hotBooks}" var="book" varStatus="status">
				<c:if test="${ status.index == 0}">
					<div class="rightContainer">
						<h3 class="newBookName">
							<a href="book/bookInfo?id=${book.id}" title="" target="_blank">${book.bookname}</a>
						</h3>
						<p class="newBookAuthor">作者：${book.bookAuthor}</p>
						<div class="newBookIntroduce">${book.bookIntroduction}</div>
						<div class="newBookImg">
							<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
								target="_blank"> <img alt="" src="image/${book.bookImage}">
							</a>
						</div>
					</div>
				</c:if>

				<div class="leftContainer">
					<c:if test="${ status.index == 1 || status.index == 3}">
						<div class="firstLeft">
							<div class="leftImg">
								<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
									target="_blank"> <img alt="" src="image/${book.bookImage}">
								</a>
							</div>
							<div class="leftBookName">
								<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
									target="_blank">${book.bookname}</a>
							</div>
							<div class="leftBookAuthor">作者：${book.bookAuthor}</div>
						</div>
					</c:if>
					<c:if test="${ status.index == 2 || status.index == 4}">
						<div class="secondLeft">
							<div class="leftImg">
								<a href="book/bookInfo?id=${book.id}" title="${book.bookname}"
									target="_blank"> <img alt="" src="image/${book.bookImage}">
								</a>
							</div>
							<div class="leftBookName">
								<a href="" title="${book.bookname}" target="_blank">${book.bookname}</a>
							</div>
							<div class="leftBookAuthor">作者：${book.bookAuthor}</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
		<p class="footer">2018 @Online Book Store All Rights Reserved</p>
	</div>
	<div class="scroll-top">
		<i class="layui-icon">&#xe604;</i>
		<p>顶部</p>
	</div>
	
	<script src="jquery/jquery-2.2.4.min.js"></script>
	<script src="layui/layui.js"></script>
	<script src="js/global.js"></script>
	<script>
		layui.use('carousel', function() {
			var carousel = layui.carousel;
			//建造实例
			carousel.render({
				elem : '#test1',
				width : '100%', //设置容器宽度
				height : '320px',
				arrow : 'hover', //始终显示箭头
				anim : 'fade'
			});
		});
	</script>

</body>
</html>