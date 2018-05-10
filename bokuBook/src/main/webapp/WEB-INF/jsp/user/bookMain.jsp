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
					<a href="#"> <img alt="图片" src="image/carousel-1.png"
						title="幽默与荒诞" />
					</a>
				</div>
				<div>
					<a href="#"> <img alt="图片" src="image/carousel-1.png"
						title="幽默与荒诞" />
					</a>
				</div>
				<div>
					<a href="#"> <img alt="图片" src="image/carousel-1.png"
						title="幽默与荒诞" />
					</a>
				</div>
				<div>
					<a href="#"> <img alt="图片" src="image/carousel-1.png"
						title="幽默与荒诞" />
					</a>
				</div>
				<div>
					<a href="#"> <img alt="图片" src="image/carousel-1.png"
						title="幽默与荒诞" />
					</a>
				</div>
			</div>
		</div>
		
		<div class="new-book">
			<div class="newBookTitle">新书榜</div>
			<div class="rightContainer">
				<h3 class="newBookName">
					<a href="" title="圈子不同，不必强融" target="_blank">圈子不同，不必强融</a>
				</h3>
				<p class="newBookAuthor">作者: 安德烈亚斯·安东诺普洛斯</p>
				<div class="newBookIntroduce">想加入这场暴风雨般席卷世界金融业的技术革命吗？《区块链：通往资产数字化之路》是你通往看似纷繁复杂的比特币世界的指南，它为你进入这个货币互联网世界提供了必要的知识。不管你是正在构建下一个杀手级应用，还是在投资一个初创企业，或者只是对技术好奇，这本实用的书都是必不可少的。
					比特币，一个成功的数字货币，虽然仍处于起步阶段，却已经带来了全球范围数十亿美元规模的经济效应。这种经济活动对任何有相关知识和热情的人都是开放的。《区块链：通往资产数字化之路》将为你提供必要的知识（不包括热情）。</div>
				<div class="newBookImg">
					<a href="book/bookInfo?id=4" title="圈子不同，不必强融" target="_blank">
						<img alt="" src="image/deafultPhoto.jpg">
					</a>
				</div>
			</div>
			<div class="leftContainer">
				<div class="">
					<div>
						<a href="" title="圈子不同，不必强融" target="_blank">圈子不同，不必强融</a>
					</div>
					<div>作者: 安德烈亚斯·安东诺普洛斯</div>
					<div class="">
						<a href="book/bookInfo?id=4" title="圈子不同，不必强融" target="_blank">
							<img alt="" src="image/j3TBcSvRst.jpg">
						</a>
					</div>
				</div>
				<div class="">
				
				
				
				</div>
			
			
			</div>
			
			
			
		</div>
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