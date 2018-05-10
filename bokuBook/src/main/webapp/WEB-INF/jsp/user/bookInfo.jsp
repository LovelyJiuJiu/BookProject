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
<title>--书籍信息--</title>
<link rel="icon" type="image/x-icon" href="image/favicon.ico" />  
<link rel="stylesheet" href="css/bookInfo.css">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/global.js"></script>
<script>
	$(document).ready(function() {
		
		function accMul(arg1,arg2) {
			var m=0,
				s1=arg1.toString(),
				s2=arg2.toString();
			try{
				m+=s1.split(".")[1].length
			} catch(e) {
				console.log(e);
			}
			try{
				m+=s2.split(".")[1].length
			} catch(e) {
				console.log(e);
			}
			return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
		}
		
		var ImgHrefElements = document.getElementsByName("ImgHref");
        for(var i=0;i<ImgHrefElements.length;i++){
    		if (!ImgHrefElements[i].value) {
    			var id = "#Img" +i ;
    			$(id).attr('src', "image/deafultPhoto.jpg");
    		}
        }

		layui.use('form', function() {
			var form = layui.form;
			form.on('submit(add-reply-btn)', function(data) {
				var currentUser="<%=session.getAttribute("currentUser")%>";
				if (currentUser == "null") {
					alert("请先登录");
					return false;
				} else{
					addReply(data.field);
					return false;
				}
			})
			return false;
		});
		
		var bookId = ${book.id};
		var bookName = $('.bookTitle').text();
		var bookImage = $('.bookImage img').attr('name');
		var bookPrice = $('.price span#bookAmount').text();
		var bookNumber = $('#bookNum').val();
		var bookTotalPrice = bookPrice * bookNumber;
		
		$("#bookNum").keypress(function(b) {
			var keyCode = b.keyCode ? b.keyCode : b.charCode;
			if (keyCode != 0 && (keyCode < 48 || keyCode > 57) && keyCode != 8 && keyCode != 37 && keyCode != 39) {
				return false;
			} else {
				return true;
			}
		}).keyup(function(e) {
			var keyCode = e.keyCode ? e.keyCode : e.charCode;
			console.log(keyCode);
			if (keyCode != 8) {
				var numVal = parseInt($("#bookNum").val()) || 0;
				numVal = numVal < 1 ? 1 : numVal;
				$("#bookNum").val(numVal);
				bookNumber = numVal;
				bookTotalPrice = accMul(bookNumber, bookPrice);
			}
		}).blur(function() {
			var numVal = parseInt($("#bookNum").val()) || 0;
			numVal = numVal < 1 ? 1 : numVal;
			$("#bookNum").val(numVal);
			bookNumber = numVal;
			bookTotalPrice = accMul(bookNumber, bookPrice);
		});
		
		//增加
		$("#add").click(function() {
			var num = parseInt($("#bookNum").val()) || 0;
			$("#bookNum").val(num + 1);
			bookNumber = num + 1;
			bookTotalPrice = accMul(bookNumber, bookPrice);
		});
		
		//减少
		$("#sub").click(function() {
			var num = parseInt($("#bookNum").val()) || 0;
			num = num - 1;
			num = num < 1 ? 1 : num;
			$("#bookNum").val(num);
			bookNumber = num;
			bookTotalPrice = accMul(bookNumber, bookPrice);
		});
		
		$('#bookNum').on('input propertychange', function () {
			bookNumber = $(this).val();
			bookTotalPrice = accMul(bookNumber, bookPrice);
			layer.msg(bookNumber);
		});
		
		$('#buy').on('click', function () {
			$.ajax({
				url : 'order/purchse-at-time',
				async : true,
				dataType : 'json',
				data : {
					id: bookId,
					bookName: bookName,
					bookInfo: bookImage,
					price: bookPrice,
					number: bookNumber,
					totalPrice: bookTotalPrice
				},
				success : function(data) {
					if(data.result == 0) {
	 					layer.msg('订单提交成功(ﾉ´▽｀)ﾉ♪', {time: 2000}, function () {
	 						window.location.href = '/book/order/orderConfirm?orderId=' + data.orderId;
						});
					} else if (data.result === 1){
						layer.msg('订单提交出错( Ĭ ^ Ĭ )');
					} else if (data.result === 2) {
						layer.msg('你还没有登录( Ĭ ^ Ĭ )');
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
		});
		
		$('#addToCart').on('click', function () {
			$.ajax({
				url : 'cart/addBookToCart',
				async : true,
				dataType : 'json',
				data : {
					id: bookId,
					bookName: bookName,
					bookInfo: bookImage,
					price: bookPrice,
					number: bookNumber,
					totalPrice: bookTotalPrice
				},
				success : function(data) {
					if(data.result == 1) {
						$('#num').text(data.cartSize);
	 					layer.msg('商品已加入购物车(ﾉ´▽｀)ﾉ♪');
					} else if (data.result === 2) {
						layer.msg('你还没有登录( Ĭ ^ Ĭ )');
					} else {
						layer.msg('加入购物车时出错( Ĭ ^ Ĭ )');
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
		});
	});

 	function addReply(data) {
 		var search = window.location.search;
 		search = search.charAt(search.length-1);
		$.ajax({
			url : 'book/addReply',
			async : true,
			dataType : 'json',
			data : {
				id: search,
				replycontents: data.replycontents
			},
			success : function(data) {
				if(data.result == 1) {
 					window.location.href = "book/bookInfo?id="+search;;
				}else{
					alert("评论失败，请重试");
				}
			},
			error : function(err) {
				console.log(err);
			}
		}); 
		
	}

</script>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="bookInfoContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="headContainer">
			<div class="leftContainer">
				<div class="bookImage">
					<img src="image/${book.bookImage}" alt="${book.bookname}"
						title="${book.bookname}" name="${book.bookImage}"/>
				</div>
			</div>

			<div class="rightContainer">
				<div class="bookTitle">${book.bookname}</div>
				<div class="bookContent">${book.bookAuthor}</div>
				<div class="moreChoice">
					<div class="price">
						<span class="book-price">单价 </span>
						<span class="book-price-num">￥<span id="bookAmount">${book.bookPrice }</span></span>
					</div>
					<label class="num">数量 </label>
					<div class="bookNum">
						<a id="sub" href="javascript:void(0);">-</a> <input type="text"
							value="1" id="bookNum" class="book-number-style"> <a
							id="add" href="javascript:void(0);">+</a>
					</div>
					<div class="readBook layui-btn layui-btn-danger layui-btn-radius" id="buy">立即购买</div>
					<div class="purchse layui-btn layui-btn-radius" id="addToCart">加入购物车</div>
				</div>

				<div class=" layui-collapse" lay-filter="collapseFilter">
					<div class="layui-colla-item">
						<h2 class="layui-colla-title">简介</h2>
						<div class="summary layui-colla-content layui-show">${book.bookIntroduction}
						</div>
					</div>
				</div>

			</div>
		</div>
		<div class="footerContainer">
			<span class="footerLContainer">评论区</span> <i class="layui-icon"
				style="font-size: 30px; color: #fa7a20;">&#xe642;</i>
			<hr class="layui-bg-orange">
			<div class="commentContent">
				<c:forEach items="${userReplyList}" var="userReply"
					varStatus="status">
					<div class="oneComment">
						<div class="userImg">
							<img id="Img${status.index}" alt=""
								src="image/${userReply.imgName}"> <input name="ImgHref"
								type="hidden" value="${userReply.imgName}">
						</div>
						<div class="otherContent">
							<span class="userName">${userReply.username}</span> <span
								class="replyDate">${userReply.dateStr}</span> <span
								class="commentNumber">${status.index+1}楼</span>
						</div>
						<div class="commentInfo">${userReply.replycontents}</div>
					</div>
				</c:forEach>
			</div>

			<div class="writeCommentTitle">编写我的评论:</div>
			<form class="layui-form" lay-filter="addReply">
				<textarea name="replycontents" required lay-verify="required"
					placeholder="我也来说两句......" class="layui-textarea writeComment"></textarea>
				<button class="submitComment layui-btn layui-btn-radius" lay-submit
					lay-filter="add-reply-btn">发表</button>
			</form>
		</div>


	</div>
</body>
