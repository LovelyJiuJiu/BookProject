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
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<title>--购物车--</title>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/cart.css">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="cartInfoContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>

		<div class="layui-tab layui-tab-brief" lay-filter="cartAndOrder">
			<ul class="layui-tab-title">
				<li lay-id="cartTab" class="layui-this">购物车</li>
				<li lay-id="orderTab">我的订单</li>
			</ul>
			<div class="layui-tab-content">
				<div id="cart" class="layui-tab-item layui-show">
					<table id="cartTable" lay-filter="cartInfo"></table>
				</div>
				<div id="order" class="layui-tab-item">
					<table id="orderTable" lay-filter="orderInfo"></table>
				</div>
			</div>
		</div>

	</div>
	<script src="jquery/jquery-2.2.4.min.js"></script>
	<script src="layui/layui.js"></script>
	<script src="js/global.js"></script>
	<script type="text/html" id="img">
    	<div><img class="cart-img" src="image/{{d.bookInfo}}"></div>
	</script>
	<script type="text/html" id="operation">
		<a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-mini" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
	</script>
	<script>
		Date.prototype.format = function(fmt) { 
			var o = { 
				"M+" : this.getMonth()+1,                 
				"d+" : this.getDate(),                    
				"h+" : this.getHours(),                   
				"m+" : this.getMinutes(),                 
					"s+" : this.getSeconds(),                 
				"q+" : Math.floor((this.getMonth()+3)/3), 
				"S"  : this.getMilliseconds()             
		}; 
		if(/(y+)/.test(fmt)) {
    		fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
		}
		for(var k in o) {
			if(new RegExp("("+ k +")").test(fmt)){
	     		fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	 		}
		}
		return fmt; 
}
	</script>
	
	<script type="text/html" id="orderDate">

		{{#  
  			var fn = function(){
    			return new Date(d.submitTime).format("yyyy-MM-dd hh:mm:ss");
  			}; 
		}}

		{{ fn() }}
	</script>

	<script>
	
function getContextPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0,index+1);
    return result;
}
function deleteBook(id) {
  $.ajax({
		url: 'cart/deleteBook',
		contentType: 'application/json;charset=utf-8',
		dataType : 'json',
		data:{id: id},
	    success: function (data) { 
	        if(data.result == 1) {
	        	layer.msg('删除成功');
	        	window.location.href = getContextPath() + "/user/cartPage";
	        } else{
	        	layer.msg('删除失败');
	        }
	    }		
	  }) 
	
}


layui.use(['element', 'table'], function(){
	  var table = layui.table;
	  
	  var element = layui.element;
	  element.on('tab(cartAndOrder)', function(data){
		  if(data.index == 1) {
			  $("#cart").removeClass("layui-show");		
			  table.render({
				    elem: '#orderTable'
				    ,height: 500
				    ,url: 'order/getOrderList'
				    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
					,limits:[1,5,10,15]
				    ,page: true
				    ,cols: [[
				       {field: 'id'}
				      ,{field: 'orderNo', title: '订单号', width:260, templet: '<div><a href="/book/order/orderDetail?orderId={{d.id}}" target="_blank">{{d.orderNo}}</a></div>'}
				      ,{field: 'price', title: '订单金额', width:100}
				      ,{field: 'submitTime', title: '订单提交时间', width: 200, templet: '#orderDate'}	
				      ,{field: 'orderStatus', title: '订单状态'}	
				    ]]
			  	  ,done: function(res, curr, count){
				  	$("[data-field='id']").css('display','none');
			  	  }
			  });
		  }
	  });

	  //第一个实例
	  table.render({
	    elem: '#cartTable'
	    ,height: 500
	    ,url: 'user/cart' //数据接口
	    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
	    ,limits:[1,5,10,15]
	    ,page: true //开启分页
	    ,id: 'cT'
	    ,cols: [[ //表头
	      {checkbox: true, fixed: true}
	      ,{field: 'id'}
	      ,{field: 'bookName', title: '书籍名称', width:260, templet: '<div><a href="/book/book/bookInfo?id={{d.id}}" target="_blank">{{d.bookName}}</a></div>'}
		  ,{field: 'bookInfo', title: '展示图片', width: 200,toolbar:"#img"}	
	      ,{field: 'price', title: '单价', width:100}
	      ,{field: 'number', title: '数量', width:100} 
	      ,{field: 'totalPrice', title: '金额', width: 100}
	      ,{field: 'operation', title: '操作', toolbar:"#operation"}
	    ]]
	  ,done: function(res, curr, count){
		  $("[data-field='id']").css('display','none');
		  $("div.cart-amount").remove();
		  $("div.layui-table-page").append("<div class='cart-amount'><span>合计: ￥</span><span id='amount'>0</span></div>");
		  $("div.layui-table-page").append("<button class='layui-btn layui-btn-radius layui-btn-danger cart-submit'>去结算</button>");
		  $("button.cart-submit").on('click', function () {
			  var checkStatus = table.checkStatus('cT');
			  var data = checkStatus.data;
			  console.log(data);
			  if (data.length === 0) {
				  layer.msg('你还没有选择要买的书嘞く(＾_・)ゝ');
				  return;
			  }
			  orderSubmit(data);
		  });
	  }
	  });
	  addEvent(table);
	  
});
 
function orderSubmit (data) {
	var userId = ${currentUser.id};
	$.ajax({
		url : 'order/order-submit/' + userId,
		async : true,
		type : 'POST',
		dataType : 'json',
		data: JSON.stringify(data),
		contentType: 'application/json; charset=utf-8',
		success : function(data) {
			if (data.result === 0) {
				window.location.href = '/book/order/orderConfirm?orderId=' + data.orderId;
			} else if (data.result === 1) {
				layer.msg("服务器错误");
			} else if (data.result === 2) {
				layer.msg("拜托..  你还没有登录 (￣□￣；)");
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}

function addEvent(table) {
	//监听删除按钮  
	table.on('tool(cartInfo)', function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;
		if (layEvent === 'del') {
			deleteBook(obj.data.id);
		}
	});
	
	table.on('checkbox(cartInfo)', function(obj) {
		console.log(obj);
		var totalPrice = $('div.cart-amount span#amount');
		if (obj.type === 'all') {
			var checkStatus = table.checkStatus('cT');
			if (obj.checked) {
				var price = 0;
				checkStatus.data.forEach(function (item, index) {
					price += item.totalPrice;
				});
				totalPrice.text(price);
			} else {
				totalPrice.text(0);
			}
		} else if (obj.type === 'one') {
			if (obj.checked) {
				totalPrice.text(parseFloat(totalPrice.text()) + obj.data.totalPrice);
			} else {
				totalPrice.text(parseFloat(totalPrice.text()) - obj.data.totalPrice);
			}
		}
	});

}
</script>
</body>
