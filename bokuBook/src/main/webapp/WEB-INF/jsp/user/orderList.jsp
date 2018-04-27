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
<title>--我的订单--</title>
</head>
<body>
	<c:if test="${msg != null }">
		<h3>${msg }</h3>
	</c:if>
	<c:if test="${orderList != null }">
		<h3>${orderList }</h3>
	</c:if>
</body>
</html>