<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href="${path }" />
<link rel="stylesheet" href="css/global.css">
</head>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<div class="common-header">
		<div class="layui-container">
			<span class="welcome-text">欢迎光临博库书城</span>
			<ul class="header-direct">
				<c:choose>
					<c:when test="${currentUser != null}">
						<li>
					    	<div id="currentUser">${currentUser.username}</div>
						</li>
						<div class="current-user-list">
							<div class="nav"></div>
							<ul class="">
								<li class="editUserInfo" id="editUserInfo">查看个人信息</li>
								<li class="dropdown-divider"></li>
						    	<li class="logout" id="userLogout">退 出</li>
						    </ul>
					    </div>
					</c:when>
					<c:otherwise>
						<li>
							<a href="user/login">
								登录
							</a>
							/
							<a href="user/register">
								注册
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				<li class="separate">|</li>
				<li class="cart">
				<c:choose>
					<c:when test="${currentUser != null}">
						<c:set var="href" value="user/cart" />
					</c:when>
					<c:otherwise>
						<c:set var="href" value="user/login" />
					</c:otherwise>
				</c:choose>
				<a href="${href }">
					<i class="layui-icon">&#xe657;</i>
						购物车
					<span class="layui-badge layui-bg-orange">0</span>
				</a>
					
				</li>
			</ul>
		</div>
	</div>