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
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/adminMain.js"></script>
<script type="text/html" id="img">
	{{# if (!d.imgName) { }}
		<img name="img" class="photo" src="image/deafultPhoto.jpg">
	{{# } else { }}
    	<img name="img" class="photo" src=image/{{d.imgName}}>
	{{# } }}
</script>
<script>
function hideAllIframes() {
  $('.hideIframs').css('display', "none");
  $('.rightContainer').css('display', "block");
}

//show this one ifram and hide other ifram, userList
function hideOtherAndShowIt(id) {
	  $('.hideIframs').css('display', "none");
	  $('.rightContainer').css('display', "none");	  
	  document.getElementById(id).style.display="block";
}

</script>
</head>
<body>
	<div id="test" class="adminMainContainer">
		<div class="leftContainer">
			<ul class="layui-nav layui-nav-tree layui-nav-side layui-bg-cyan"  lay-filter="test">
				 <li class="top-item layui-nav-item layui-nav-itemed">
				 	<a href="javascript:;">用户管理</a>
				 	    <dl class="layui-nav-child">
      						<dd id="choose"><a onclick="hideAllIframes()" href="javascript:;">查看用户</a></dd>
    					</dl>
				 </li>
				 <li class="layui-nav-item">
				 	<a href="javascript:;">书籍管理</a>
				 	    <dl class="layui-nav-child">
      						<dd><a onclick="hideOtherAndShowIt('bookList'); return true;" href="admin/bookListPage" target="bookList">查看书籍</a></dd>
      						<dd><a onclick="hideOtherAndShowIt('addBook'); return true;" href="admin/addBookPage" target="addBook">添加书籍</a></dd>
    					</dl>
				 </li>
				 <li class="layui-nav-item">
				 	<a onclick="hideOtherAndShowIt('orderList'); return true;" href="admin/orderListPage" target="orderList">订单管理</a>
				 </li>
				 <li class="layui-nav-item">
				 	<a id="adminLogout" href="javascript:;">退出</a>
				 </li>			
			</ul>
		</div>		
		<div class="rightContainer">
			<table id="userTable" lay-filter="userList"></table>
		</div>
		
		<iframe class="hideIframs" id="bookList" name="bookList" frameborder="0"></iframe>
		<iframe class="hideIframs" id="addBook" name="addBook" frameborder="0"></iframe>	
		<iframe class="hideIframs" id="orderList" name="orderList" frameborder="0"></iframe>	
		<iframe class="hideIframs" id="checkOrder" name="checkOrder" frameborder="0"></iframe> 
		<div class="footerContainer">
			<span>2018 @博库阅读</span>
		</div>
	</div>
			


</body>
</html>