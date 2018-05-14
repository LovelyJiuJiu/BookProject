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
<title>--订单管理--</title>
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script type="text/html" id="img">
    <div style="text-align: center;"><img class="photo" src=image/{{d.bookImage}}></div>
</script>
<script type="text/html" id="bookName">
    <a href="book/bookInfo?id={{d.id}}" target="_blank" title={{d.bookname}}>{{d.bookname}}</a>
</script>
<script type="text/html" id="operation1">
{{#  if(d.status == 0 || d.status == 2 || d.status == 3){ }}
	<a class="order layui-btn layui-btn-radius  layui-btn-danger layui-btn-sm" lay-event="show">查看订单</a>
{{# }}}
{{#  if(d.status == 1){ }}
	<a class="order layui-btn layui-btn-radius layui-btn-danger layui-btn-sm" lay-event="confirm">发货</a>
{{# }}}
</script>

<script type="text/html" id="status">
{{#  if(d.status == 0){ }}
	<span>待支付</span>
{{# }}}
{{#  if(d.status == 1){ }}
	<span>已支付</span>
{{# }}}
{{#  if(d.status == 2){ }}
	<span>已发货</span>
{{# }}}
{{#  if(d.status == 3){ }}
	<span>已取消</span>
{{# }}}
</script>

<script>
Date.prototype.format = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}

function addEvent(table) {
	table.on('tool(orderList)', function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;
		console.log(data.id);
		switch(layEvent) {
		case "show":
			window.open('/book/admin/showOrderDetail?orderId=' + data.id);
			break;
		case "confirm":
			confirmOrder(data);
			break;
		}
		
	});		
}
function confirmOrder(data) {
	layer.confirm('发货订单号为 ' + data.orderNo + ' 的订单 ?', {icon: 3, title:'提示'}, function(index) {
		layer.close(index);
		$.ajax({
			url :'admin/confirmOrder',
			dataType : 'json',
			data : {
				orderId: data.id
			},
			success : function(data) {	
				if(data.result == 1) {
					layer.msg('订单发货成功', {
						time : 2000
					}, function() {
						location.reload(); 
					});	
				} else {
					layer.msg('订单发货失败');
				}
			}
		});
	});
}


layui.use('table', function(){
	var table = layui.table;
    table.render({
	    elem: '#orderListTable'
	    ,height: 550
	    ,url: 'admin/orderList' 
	    ,limit:5 
	    ,limits:[1,5,10,15]
	    ,page: true 
	    ,cols: [[
	      {field: 'orderNo', title: '订单号', width:230}
		  ,{field: 'price', title: '订单金额', width: 100}      
	      ,{field: 'userName', title: '下单用户', width:200}
		  ,{field: 'submitTime', title: '下单时间', width:160, toolbar: "#orderDate"}
	      ,{field: 'orderStatus', title: '订单状态',toolbar:"#status", width:120}
	      ,{field: 'operation', title: '操作', toolbar:"#operation1"}
	    ]]
	  ,done: function(res, curr, count){
		 /*  console.log(res); */
	  }
	});
    addEvent(table);
});
</script>

<script type="text/html" id="orderDate">

		{{#  
  			var fn = function(){
    			return new Date(d.submitTime).format("yyyy-MM-dd hh:mm:ss");
  			}; 
		}}

		{{ fn() }}
</script>

</head>
<body>
	<div class="orderListContainer">
 		<table id="orderListTable" lay-filter="orderList"></table>
	</div>
</body>
</html>