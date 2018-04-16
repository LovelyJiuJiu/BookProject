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
<link rel="stylesheet" href="css/cart.css">
<title>--购物车--</title>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="cartInfoContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
 		<table id="cartTable" lay-filter="cartInfo"></table>
	</div>
	<script src="jquery/jquery-2.2.4.min.js"></script>
	<script src="layui/layui.js"></script>
	<script src="js/global.js"></script>
	<script type="text/html" id="operation">
		<a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
	</script>
	<script>


/* $.ajax({
	url: 'user/register',
	contentType: 'application/json;charset=utf-8',
	data:'{"page": 1, "limit": 5}',
    success: function (data) { 
        alert("get data");
    }		
}) */

layui.use('table', function(){
	  var table = layui.table;
	  
	  //第一个实例
	  table.render({
	    elem: '#cartTable'
	    ,height: 500
	    ,url: 'user/cart' //数据接口
	    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
	    ,limits:[5,10,15]
	    ,page: true //开启分页
	    ,cols: [[ //表头
	      {checkbox: true, fixed: true}
	      ,{field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'bookName', title: '书籍名称', width:100}
	      ,{field: 'bookInfo', title: '书籍信息', width:400}
	      ,{field: 'price', title: '单价', width:80, sort: true}
	      ,{field: 'number', title: '数量', width:80} 
	      ,{field: 'totalPrice', title: '金额', width: 80, sort: true}
	      ,{field: 'operation', title: '操作', toolbar:"#operation"}
	    ]]
	  });
	  addEvent(table);

});

function addEvent(table) {
	//监听删除按钮  
	table.on('tool(cartInfo)', function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;
		if (layEvent === 'del') {
			alert("del?");
		}
	});
	
	table.on('checkbox(cartInfo)', function(obj) {
		alert(obj.data.id);
	});

}
</script>
</body>
