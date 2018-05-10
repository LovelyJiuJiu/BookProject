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
	<script>
	function orderSubmit (data) {
		var userId = ${currentUser.id };
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

	</script>
	<script src="js/cart.js"></script>
	<script type="text/html" id="img">
    	<div><img class="cart-img" src="image/{{d.bookInfo}}"></div>
	</script>
	<script type="text/html" id="operation">
		<a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-mini" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
	</script>
	
	<script type="text/html" id="orderDate">

		{{#  
  			var fn = function(){
    			return new Date(d.submitTime).format("yyyy-MM-dd hh:mm:ss");
  			}; 
		}}

		{{ fn() }}
	</script>
	
	<script type="text/html" id="checkOrderStatus">
		{{# if (d.status === 0) { }}
			待支付
		{{#  } else if(d.status === 1) { }}
			已支付
		{{#  } else if(d.status === 2) { }}
			已发货
		{{#  } else if(d.status === 3) { }}
			订单取消
		{{#  } }}
	</script>
	
	<script type="text/html" id="orderToolBar">
		{{# if (d.status === 0) { }}
			<a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-sm pay" lay-event="pay"><i class="layui-icon">&#xe62f;</i>支付订单</a>
			<a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-sm del" lay-event="del"><i class="layui-icon">&#xe640;</i>取消订单</a>
		{{#  } else if(d.status === 1 || d.status === 2) { }}
			<a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-sm" lay-event="show"><i class="layui-icon">&#xe60b;</i>查看订单</a>
		{{#  } else if(d.status === 3) { }}
			<a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-sm layui-btn-disabled btn-disable">订单已取消</a>
		{{#  } }}
	</script>
</body>
