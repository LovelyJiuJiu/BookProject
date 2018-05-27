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
<base href=${path } />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--书籍分类--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/classification.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/global.js"></script>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="typeTopContainer">
			<form class="layui-form" style="position: relative;">
				<div class="layui-form-item price">
					<label class="layui-form-label">价格区间</label>
					<div class="layui-inline">
					    <div class="layui-input-inline" style="width: 100px;">
					      <input type="text" name="price_min" value="1" lay-verify="bookPrice" class="layui-input">
					    </div>
					    <div class="layui-form-mid">-</div>
					    <div class="layui-input-inline" style="width: 100px;">
					      <input type="text" name="price_max" value="50" lay-verify="bookPrice" class="layui-input">
					    </div>
					  </div>
				</div>
				<div class="layui-form-item type">
					<label class="layui-form-label">书籍类别</label>
					<div class="layui-input-block">
						<c:forEach items="${typeList}" var="type" varStatus="status">
							<c:if test="${type.id == 1 }">
								<input type="radio" name="type" value="${type.id}" title="${type.typename}" checked>
							</c:if>
							
							<c:if test="${type.id != 1 }">
								<input type="radio" name="type" value="${type.id}" title="${type.typename}">
							</c:if>
						</c:forEach>
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">排序规则</label>
					<div class="layui-input-block">
						<input type="radio" name="order" value="hot" title="热门" checked> 
						<input type="radio" name="order" value="new" title="最新" >
					</div>
				</div>
			
				<button class="layui-btn" lay-submit lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
			</form>
		</div>
		<div class="typeMainContainer">
			<ul class="oneRow">
			</ul>
		</div>
		<div class="scroll-top">
			<i class="layui-icon">&#xe604;</i>
			<p>顶部</p>
		</div>
	</div>
<script>
$(document).ready(function() {
	var data ={price_min: "1", price_max: "50", type: "1", order: "hot"};
	goToSearch(data);
})

  

layui.use('form', function() {
	var form = layui.form;
	form.on('submit(search)', function(data) {
		var data = data.field;

		if(parseInt(data.price_max) <= parseInt(data.price_min)) {
			layer.msg("书籍价格区间不对");
			return false;
		}
		 goToSearch(data);
		return false;
	});
	
	form.verify({
		bookPrice : [ /^\d+(\.\d+)?$/, '书籍价格只能为数字' ],
	})
});



function goToSearch(data) {
 	$.ajax({
		url : 'book/search',
		async : true,
		type : 'POST',
		dataType : 'json',
		data : {
			order : data.order,
			type: data.type,
			priceMin : data.price_min,
			priceMax : data.price_max
		},
		success : function(data) {
			if(data.bookList.length==0) {
				layer.msg("未找到匹配您要求的图书，请更改查询条件");
			} else{
				$(".oneRow").empty();  
				for (var i = 0; i < data.bookList.length; i++) {  
					var book=data.bookList[i];
					var tsr="";
					tsr+="<li>";
					tsr+="<a href='book/bookInfo?id=" +book.id+"'"+ " target='_blank'><img src='image/"+book.bookImage +"'"+"></a>";
					tsr+="<div class='bookMation'><h3><a href='book/bookInfo?id='" +book.id+ " target='_blank'>"+book.bookname+"</a></h3>";
					tsr+="<span class='BookAuthor'>作者："+book.bookAuthor+"</span> ";
					tsr+="<span class='BookPrice'>价格："+book.bookPrice+"</span> ";
					tsr+="</div>";
					tsr+="</li>";
					$(".oneRow").append(tsr);
				}	
			}
		
		},
		error : function(err) {
			console.log(err);
		}
	});
}

</script>
</body>
