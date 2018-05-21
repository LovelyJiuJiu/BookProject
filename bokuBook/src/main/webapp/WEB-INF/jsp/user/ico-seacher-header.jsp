<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
	String rPath = request.getRequestURI();
	rPath = rPath.substring(rPath.lastIndexOf("/") + 1);
	pageContext.setAttribute("rPath", rPath);
%>
<base href=${path }/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<div class="ico-header">
	<div class="v-align">
		<a class="common-logo" href=""> <img alt="web-logo"
			src="image/web-logo.png" title="博库书城">
		</a>
		<div class="search-input">
			<input type="text" name="keyWords" id="keyWords"
				placeholder="搜索书名..." autocomplete="off" class="layui-input">
			<i class="layui-icon search-btn">&#xe615;</i>
		</div>
		<div class="suggestion-list">
			<ul>
				<li><a class="list-item" href="javascript:void(0)"
					hidefocus="hidefocus"><span>谁说江湖好</span></a></li>
				<li><a class="list-item" href="javascript:void(0)"
					hidefocus="hidefocus"><span>谁说你不能坚持</span></a></li>
				<li><a class="list-item" href="javascript:void(0)"
					hidefocus="hidefocus"><span>谁说80/90不靠谱</span></a></li>
				<li><a class="list-item" href="javascript:void(0)"
					hidefocus="hidefocus"><span>谁说大象不能跳舞？</span></a></li>
				<li><a class="list-item" href="javascript:void(0)"
					hidefocus="hidefocus"><span>谁说现实不是梦境</span></a></li>
			</ul>
		</div>
	</div>
</div>

<!-- 导航栏 -->
<div>
	<ul class="layui-nav nav-color" lay-filter="">
		<c:if test="${rPath == 'bookMain.jsp' }">
			<li class="layui-nav-item layui-this"><a href="/book/user/bookMain">首页</a></li>
		</c:if>
		<c:if test="${rPath != 'bookMain.jsp' }">
			<li class="layui-nav-item"><a href="/book/user/bookMain">首页</a></li>
		</c:if>
		<c:if test="${rPath != 'salesCountPage.jsp' }">
			<li class="layui-nav-item"><a href="/book/book/salesCountPage">销量排行</a></li>
		</c:if>
		<c:if test="${rPath == 'salesCountPage.jsp' }">
			<li class="layui-nav-item layui-this"><a href="/book/book/salesCountPage">销量排行</a></li>
		</c:if>
	</ul>
</div>
