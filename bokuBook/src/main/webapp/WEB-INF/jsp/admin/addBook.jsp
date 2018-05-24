<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href="${path }" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/adminMain.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--增加书籍--</title>
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/adminMain.js"></script>
<script>
$(document).ready(function() {
	$('#uploadImg').attr('src', 'image/deafultBook.jpg');
	$('#QRImg').attr('src', 'image/QR/deafultQR.png');
	$("#uploadImg").attr({title: "默认书籍图片"});		
	getBookType();
})


function getBookType() {
	$.ajax({
		url :'admin/typeList',
		dataType : 'json',
		data : {},
		success : function(data) {			
			var typeList = data.typeList;
			if (typeList.length != 0) {
				for(var i=0; i<typeList.length; i++) {
					$("#bookType").append("<option value="+typeList[i].id+">"+typeList[i].typename+"</option>");
				}
			}
		}
	})
}

layui.use('form', function() {
	var form = layui.form;
	form.on('submit(add-book-btn)', function(data) {
			checkBookTypeSelected();
			addBook();
		return false;
	});	
	form.verify({
		bookPrice : [ /^\d+(\.\d+)?$/, '书籍价格只能为数字' ],
	})
})

function checkBookTypeSelected() {
	if(isNaN($('#bookType').val())) {
		layer.msg('请选择书籍类型');
	}	
}

function addBook() {
	$.ajax({
		url : 'admin/addBook',
		dataType : 'json',
		type : 'POST',
		data : {
			bookname:$('input[name=bookname]').val(),
			bookAuthor:$('input[name=bookAuthor]').val(),
			bookIntroduction :$('#bookIntr').val(),
			bookPrice :$('input[name=bookPrice]').val(),
			typeId : $('#bookType').val(),		
			bookImage: $('#photoUrl').val(),
			bookQr: $('#photoQR').val()
		},
		success : function(data) {
			if (data.code === 1) {
				layer.msg('添加书籍成功', {
					time : 2000
				}, function() {
					location.reload(); 
				});			
			} else {
				console.log(data);
			}
		},
		error : function(err) {
			console.log(err);
		}
	})	
}


layui.use('upload', function() {
	var $ = layui.jquery, upload = layui.upload;

	// 普通图片上传
	var uploadInst = upload.render({
		elem : '#uploadPic',
		url : 'admin/uploadBookImg',
		 before: function(obj) {
			obj.preview(function(index, file, result) {
				$('#uploadImg').attr('src', result); // 图片链接（base64）
			});
		},
		done : function(res) {
			if(res.code == 1) {
				$('#photoUrl').val(res.imgName);
			}
		}
	})
	
		var uploadInst = upload.render({
		elem : '#uploadQR',
		url : 'admin/uploadBookQR',
		 before: function(obj) {
			obj.preview(function(index, file, result) {
				$('#QRImg').attr('src', result); // 图片链接（base64）
			});
		},
		done : function(res) {
			if(res.code == 1) {
				$('#photoQR').val(res.imgName);
			}
		}
	})
	
	
})

</script>
</head>
<body>
	<div class="addBookContainer">
 		<form class="layui-form" lay-filter="addBook" style="position: relative;">
			<div class="layui-form-item bookImg">
				<img class="layui-upload-img" id="uploadImg">
			</div>
			<input type="hidden" name="photoUrl" id="photoUrl"/>
			<button type="button" class="layui-btn layui-btn-radius" id="uploadPic">上传图片</button>
			
 			<div class="layui-form-item bookQR">
				<img class="layui-upload-img" id="QRImg">
			</div>
			<input type="hidden" name="photoQR" id="photoQR"/>
			<button type="button" class="layui-btn layui-btn-radius" id="uploadQR">上传书籍二维码</button>
			
			<div class="layui-form-item">
				<label class="layui-form-label">书籍名称</label>
				<div class="layui-input-block">
					<input type="text" name="bookname" required lay-verify="required"
						placeholder="请输入书籍名称" autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">作者</label>
				<div class="layui-input-block">
					<input type="text" name="bookAuthor" required lay-verify="required"
						placeholder="请输入作者" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">书籍简介</label>
				<div class="layui-input-block">
					<textarea id="bookIntr" name="bookIntroduction" placeholder="请输入书籍简介" class="layui-textarea"></textarea>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">价格</label>
				<div class="layui-input-block">
					<input type="text" name="bookPrice" required lay-verify="required|bookPrice"
						placeholder="请输入书籍价格" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">书籍类别</label>
				<div class="layui-input-block">
					<select id="bookType" name="bookType" lay-verify="required">
						<option>请选择</option>
					</select>
				</div>
			</div>
			<button class="layui-btn layui-btn-radius" lay-submit
				id="add-book-btn" lay-filter="add-book-btn">添加</button>
		</form>
	</div>
</body>
</html>