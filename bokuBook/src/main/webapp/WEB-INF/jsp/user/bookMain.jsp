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
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
	<div class="layui-container">
		<div class="layui-carousel" id="test1">
			<div carousel-item>
				<div>条目1</div>
				<div>条目2</div>
				<div>条目3</div>
				<div>条目4</div>
				<div>条目5</div>
			</div>
	</div>
	</div>

	<script>
		layui.use('carousel', function() {
			var carousel = layui.carousel;
			//建造实例
			carousel.render({
				elem : '#test1',
				width : '100%',  //设置容器宽度
				arrow : 'hover',  //始终显示箭头
				anim: 'fade'
			});
		});
	</script>

</body>
</html>