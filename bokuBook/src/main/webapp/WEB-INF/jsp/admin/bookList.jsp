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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--查看书籍--</title>
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/adminMain.js"></script>
<script>
layui.use('table', function(){
	  var table = layui.table;

	  //第一个实例
	  table.render({
	    elem: '#bookListTable'
	    ,height: 550
	    ,url: 'admin/bookList' //数据接口
	    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
	    ,limits:[1,5,10,15]
	    ,page: true //开启分页
	    ,cols: [[ //表头
	      {checkbox: true, fixed: true}
	      ,{field: 'bookname', title: '书籍名称', width:130}
		  ,{field: 'bookImage', title: '展示图片', width: 250,templet:'<div><img src="image/{{d.bookImage}}"></div>'}      
	      ,{field: 'bookAuthor', title: '作者', width:100}
		  ,{field: 'bookPrice', title: '单价', width:100, sort:true}
	      ,{field: 'bookIntroduction', title: '简介'} 
	    ]]
	  ,done: function(res, curr, count){
	  }
	  });
});
</script>
</head>
<body>
	<div class="bookListContainer">
 		<table id="bookListTable" lay-filter="bookList"></table>
	</div>
</body>
</html>