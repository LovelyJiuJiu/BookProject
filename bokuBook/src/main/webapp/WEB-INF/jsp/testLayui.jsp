<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>table模块快速使用</title>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>

</head>
<body>
	
 
<table id="table" align='center' border='1' cellspacing='0'>
    <tr>
        <td>id</td>
        <td>name</td>
    </tr>
    
    <c:forEach items="${page.list}" var="c" varStatus="st">
        <tr class="testTr">
            <td>${c.id}</td>
            <td>${c.name}</td>
              
        </tr> 
    </c:forEach>
    <tr class="template">
            <td class="id"></td>
            <td class="name"></td>
              
    </tr>
    </table>
    <div class="layui-container" style="text-align: center;">
    	<div id="demo"></div>
    </div>
	
	<input type="hidden" id="count" value="${page.total }" />
	<input type="hidden" id="curr" value="${page.pageNum }" />
	<input type="hidden" id="limit" value="${page.pageSize }" />
<script src="js/layuiTest.js"></script>
</body>
</html>