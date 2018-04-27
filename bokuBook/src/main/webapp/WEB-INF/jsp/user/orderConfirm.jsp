<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			</div>
		</fieldset>
	</div>
</body>
</html>