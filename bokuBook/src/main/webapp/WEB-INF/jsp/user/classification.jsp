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
<title>--书籍分类--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/classification.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/global.js"></script>
<script>
layui.use('form', function() {
	var form = layui.form;

	// 监听提交
	form.on('submit(register-btn)', function(data) {
	});
	
});
</script>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		
		<div class="typeTopContainer">
			<form class="layui-form typeForm" style="position: relative;">
				<div class="layui-form-item">
					<label class="layui-form-label">价格区间</label>
					<div class="layui-input-block">
						<select id="bookType" name="bookType" lay-verify="required">
							<option>请选择</option>
							<option value="1">1~20</option>
							<option value="2">20~40</option>
							<option value="3">40~60</option>
							<option value="4">60~80</option>
							<option value="5">80~100</option>
							<option value="6">100以上</option>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">书籍类别</label>
					<div class="layui-input-block">
						<c:forEach items="${typeList}" var="type" varStatus="status">
							<input type="checkbox" name="like[write]"
								title="${type.typename}">
						</c:forEach>
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">单选框</label>
					<div class="layui-input-block">
						<input type="radio" name="sex" value="按热度" title="" checked> 
						<input type="radio" name="sex" value="" title="女" >
					</div>
				</div>



			</form>
		</div>
		<div class="typeMainContainer">
		
		
		</div>
	</div>
</body>
