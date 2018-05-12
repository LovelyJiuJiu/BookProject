<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("path", basePath);
%>
<base href="${path }"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--确认订单--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/orderConfirm.css">
</head>
<body>
	<div class="layui-container">
		<fieldset class="layui-elem-field layui-field-title">
			<legend class="titleContent">确认订单</legend>
			<div>
				<ul style="margin-top: 10px;">
					<li style="display: inline; font-size: 14px;padding-left: 29px;text-align: center;">图片</li>
					<li style="display: inline;font-size: 14px; margin-left: 170px; text-align: center;" >书名</li>
					<li style="display: inline;font-size: 14px;margin-left: 174px;">单价</li>
					<li style="display: inline;font-size: 14px; margin-left: 175px;">数量</li>
					<li style="position: absolute;right: 18px;font-size: 14px; top: 36px;">总计</li>
				</ul>
			</div>
			<div>
				<ul class="order-list">
					<c:forEach var="orderItem" items="${orderDetail }">
						<li class="item">
							<div class="book-pic">
								<a href="/book/book/bookInfo?id=${orderItem.id }">
									<img alt="${orderItem.bookName }" src="image/${orderItem.bookInfo }" >
								</a>
							</div>
							<div class="book-name">
								<a href="/book/book/bookInfo?id=${orderItem.id }">${orderItem.bookName }</a>
							</div>
							<div class="book-single-price">
								<b>￥${orderItem.price }</b>
							</div>
							<div class="book-count">
								<span>x ${orderItem.number }</span>
							</div>
							<div class="book-total-price">
								<b>￥${orderItem.totalPrice }</b>
							</div>
						</li>
					</c:forEach>
				</ul>
				<div style="margin-top: 60px; font-size: 13px;">
					<span>订单创建时间：<fmt:formatDate value="${order.submitTime }"  type="both" /></span>
					<div style="height: 32px; line-height: 32px;">
						<span >订单总金额：<b style="font-size: 17px; color: #fa7a20;">${order.price }</b> 元</span>
						<button class="layui-btn layui-btn-radius layui-btn-danger" id="cancelBtn" style="float: right; height: 32px; margin-right: 5px; margin-bottom: 5px;">犹豫一下</button>
						<button class="layui-btn layui-btn-radius layui-btn-danger" id="payBtn" style="float: right; height: 32px; margin-right: 5px; margin-bottom: 5px;">确认支付</button>
					</div>
				</div>
			</div>
		</fieldset>
	</div>
</body>
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script>
	$(function () {
		layui.use('layer', function(){
			layer = layui.layer;
			
			$('#payBtn').on('click', function () {
				var orderId = ${order.id};
				$.ajax({
					url : 'order/orderPay',
					async : true,
					type : 'POST',
					dataType : 'json',
					data : {
						id: orderId,
					},
					success : function(data) {
						if(data.result == 0) {
		 					layer.msg('支付成功(ﾉ´▽｀)ﾉ♪', {time: 2000}, function () {
		 						window.location.href = '/book/order/orderDetail?orderId=' + orderId;
							});
						} else if (data.result === 1){
							layer.msg('订单支付出错( Ĭ ^ Ĭ ) ' + data.msg);
						} else if (data.result === 2) {
							layer.msg('你还没有登录( Ĭ ^ Ĭ )');
						}
					},
					error : function(err) {
						console.log(err);
					}
				});
			});
			
			$('#cancelBtn').on('click', function () {
					layer.msg('返回购物车,可在我的订单界面查看此订单', {time: 2000}, function () {
 						window.location.href = 'user/cartPage';
					});
				
			})
			
			
		});
	});
</script>
</html>