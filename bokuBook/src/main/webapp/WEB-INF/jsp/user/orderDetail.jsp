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
<title>--订单详情--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/orderConfirm.css">
</head>
<body>
	<div class="layui-container">
		<fieldset class="layui-elem-field layui-field-title">
			<legend class="titleContent">订单详情</legend>
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
					<div>订单创建时间：<fmt:formatDate value="${order.submitTime }"  type="both" /></div>
					<c:if test="${order.status != 3 && order.status != 0}">
						<div style="margin-top: 8px;">订单支付时间：<fmt:formatDate value="${order.payTime }"  type="both" /></div>
					</c:if>
					<div style="height: 32px; line-height: 32px;">
						<span>订单总金额：<b style="font-size: 17px; color: #fa7a20;">${order.price }</b> 元</span>
						<c:if test="${type != 'admin' }">
							<button class="layui-btn layui-btn-radius layui-btn-danger" id="goToCartPage" style="float: right; height: 32px; margin-right: 5px; margin-bottom: 5px;">返回购物车</button>
						</c:if>
						<c:if test="${type == 'admin' }">
							<h2 style="float: right; color: #fa7a20; height: 32px; margin-right: 5px; margin-bottom: 5px;">
								<c:if test="${order.status == 0 }">
									订单待支付
								</c:if>
								<c:if test="${order.status == 1 }">
									订单已支付
								</c:if>
								<c:if test="${order.status == 2 }">
									订单已发货
								</c:if>
								<c:if test="${order.status == 3 }">
									订单已取消
								</c:if>
							</h2>
						</c:if>
					</div>
				</div>
			</div>
		</fieldset>
	</div>
	<input type="hidden" id="orderStatusNum" value="${order.status }" />
</body>
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script>
$(function () {
	layui.use('layer', function(){
		layer = layui.layer;
		if ($('#orderStatusNum').val() === '3') {
			layer.alert('该订单已被用户取消', {icon: 0, title: '注意', offset: '260px', area: '260px'});
		}
		$('#goToCartPage').on('click', function () {
			layer.msg('返回购物车中.....', {time: 1500}, function () {
					window.location.href = 'user/cartPage';
			});
			
		});
	});
});
</script>
</html>