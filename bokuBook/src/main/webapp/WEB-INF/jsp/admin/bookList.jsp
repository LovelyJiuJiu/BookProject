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
<script type="text/html" id="img">
    <div><img class="photo" src=image/{{d.bookImage}}></div>
</script>
<script type="text/html" id="bookName">
    <a href="book/bookInfo?id={{d.id}}" target="_blank" title={{d.bookname}}>{{d.bookname}}</a>
</script>
<script type="text/html" id="operation1">
{{#  if(d.status == 0){ }}
	<a class="layui-btn twoBtns layui-btn-danger layui-btn-mini" lay-event="pull">下架</a>
    <a class="layui-btn twoBtns layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
{{# }}}
{{#  if(d.status == 1){ }}
	<a class="layui-btn oneBtn layui-btn-danger layui-btn-mini" lay-event="recover">恢复</a>
{{# }}}
{{#  if(d.status == 2){ }}
    <a class="layui-btn twoBtns layui-btn-danger layui-btn-mini" lay-event="put">上架</a>
    <a class="layui-btn twoBtns layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
{{# }}}
</script>

<script type="text/html" id="status">
{{#  if(d.status == 0){ }}
	<span>已上架</span>
{{# }}}
{{#  if(d.status == 1){ }}
	<span>已删除</span>
{{# }}}
{{#  if(d.status == 2){ }}
	<span>已下架</span>
{{# }}}
</script>

<script>
function addEvent(table) {
	table.on('tool(bookList)', function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;
		console.log(data.id);
		switch(layEvent) {
		case "del":
			changeStatus(data.id, 1);
			break;
		case "pull":
			changeStatus(data.id, 2);
			break;
		case "put":
			changeStatus(data.id, 0);
			break;
		case "recover":
			changeStatus(data.id, 0);
			break;
		}
		
	});		
}
function changeStatus(id,status) {
	$.ajax({
		url :'admin/changeStatus',
		dataType : 'json',
		data : {
			bookId: id,
			status:status			
		},
		success : function(data) {			
			if(data.code == 1) {
				layer.msg('修改书籍状态成功', {
					time : 2000
				}, function() {
					location.reload(); 
				});	
			}
		}
	})
	
	
}


layui.use('table', function(){
	var table = layui.table;
    table.render({
	    elem: '#bookListTable'
	    ,height: 550
	    ,url: 'admin/bookList' 
	    ,limit:5 
	    ,limits:[1,5,10,15]
	    ,page: true 
	    ,cols: [[
	      {checkbox: true, fixed: true}
	      ,{field: 'bookname', title: '书籍名称', width:130,toolbar:'#bookName'}
		  ,{field: 'bookImage', title: '展示图片', width: 200,toolbar:"#img"}      
	      ,{field: 'bookAuthor', title: '作者', width:100}
		  ,{field: 'bookPrice', title: '单价', width:100, sort:true}
	      ,{field: 'bookIntroduction', title: '简介'}
	      ,{field: 'status', title: '状态',toolbar:"#status"}
	      ,{field: 'operation', title: '操作', toolbar:"#operation1"}
	    ]]
	  ,done: function(res, curr, count){
		 /*  console.log(res); */
	  }
	});
    addEvent(table);
});
</script>
</head>
<body>
	<div class="bookListContainer">
 		<table id="bookListTable" lay-filter="bookList"></table>
	</div>
</body>
</html>