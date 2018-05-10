<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href=${path } />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${keyWord }_搜索详情</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/serachBookList.css">
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="search">
			<div class="search-title">
				共<span class="num">${pageInfo.total }</span>条<em>${keyWord}</em>相关的搜索结果
			</div>
			<ul class="search-list">
				<c:forEach items="${pageInfo.list }" var="item">
					<li class="search-list-item">
						<div class="book">
							<div class="cover">
								<a href="/book/book/bookInfo?id=${item.id }" target="_blank"><img
									src="image/${item.bookImage}"
									alt="${item.bookname }"></a>
							</div>
						</div>
						<div class="info">
							<div class="wrap">
								<a href="/book/book/bookInfo?id=${item.id }" target="_blank">${item.bookname }</a>
								<div class="author">
									<span>${item.bookAuthor}</span>
								</div>
								<p class="desc" title="${item.bookIntroduction }">${item.bookIntroduction }</p>
							</div>
							<div class="book-price">
								¥ ${item.bookPrice }
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
			<li class="search-list-item template">
				<div class="book">
					<div class="cover">
						<a href="" hidefocus="hidefocus"
							target="_blank"><img src=""alt=""></a>
					</div>
				</div>
				<div class="info">
					<div class="wrap">
						<a href="" hidefocus="hidefocus"
							target="_blank"></a>
						<div class="author">
							<span></span>
						</div>
						<p class="desc" title=""></p>
					</div>
					<div class="book-price"></div>
				</div>
			</li>
			<div class="pagination" id="pagination">
			</div>
		</div>
	</div>
	<div class="scroll-top">
		<i class="layui-icon">&#xe604;</i>
		<p>顶部</p>
	</div>
	<input type="hidden" id="currPage" value="${pageInfo.pageNum }" />
	<input type="hidden" id="currLimit" value="${pageInfo.pageSize }" />
	<script src="jquery/jquery-2.2.4.min.js"></script>
	<script src="layui/layui.js"></script>
	<script src="js/global.js"></script>
	<script>
	var page = $('#currPage').val(), limitPrePage = $('#currLimit').val();
	
	function reloadPage(data){
		
		data.list.forEach(function(value,index,array){
			var temp = $(".template").clone();
			var bookPrice = array[index].bookPrice.toString();
			if (bookPrice.indexOf('.') === -1) {
				bookPrice += '.0';
			}
			temp.removeClass("template");
			
			var base="/book/book/bookInfo?id=";
			
			temp.find(".cover a").attr("href", base+array[index].id);
			temp.find(".wrap a").attr("href", base+array[index].id);
			temp.find(".wrap a").text(array[index].bookname);
			temp.find(".cover img").attr("src", 'image/'+array[index].bookImage);
			temp.find(".cover img").attr("alt", array[index].bookname);
			
			temp.find('.desc').text(array[index].bookIntroduction);
			temp.find('.desc').attr("title", array[index].bookIntroduction);
			temp.find(".author").text(array[index].bookAuthor);
			temp.find(".book-price").text('¥ ' + bookPrice);
			$(".search-list").append(temp);
		});
	}
	
	layui.use('laypage', function(){
		function searchBookAsync (currentPage, limit) {
			var title = $('title').text();
			var keyWord = title.substring(0, title.indexOf('_'));
			
			$.ajax({
				url: 'search-xhr',
				dataType : 'json',
				type: 'POST',
				data:{keyword: keyWord, page: currentPage, limit: limit},
			    success: function (data) { 
			    	console.log(data);
			    	$(".search-list").empty();
			    	reloadPage(data);
			    	history.pushState({page: page, limit: limitPrePage}, null, "/book/search?keyword=" + keyWord + "&page=" + currentPage + "&limit=" 
			    		+ limit);
			    	page = currentPage;
			    	limitPrePage = limit;
			    }		
			  });
		}
		
		window.addEventListener('popstate', function(e){
			location.reload();
		});
		
		var laypage = layui.laypage;
		
  		laypage.render({
		    elem: 'pagination' 
		    ,count: $('span.num').text()
		    ,theme:'#a6978a'
		    ,limit: $('#currLimit').val()
		    ,curr: $('#currPage').val()
		    ,limits: [1,5,10]
		    ,layout: ['prev', 'page', 'next', 'count', 'limit', 'skip']
		    ,jump: function(obj, first){
		    	console.log(obj);
		    	
		    	if (!first) {
		    		searchBookAsync(obj.curr, obj.limit);
		    	}
		    }
	  });
	});
	</script>
</body>
</html>