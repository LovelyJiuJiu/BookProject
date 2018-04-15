<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href=${path } />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--用户信息--</title>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/userInfo.css">
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/home.css">
<script src="jquery/jquery-2.2.4.min.js"></script>
<script src="layui/layui.js"></script>
<script src="js/global.js"></script>
<script>
$(document).ready(function() { 
	if (!$('#imgName').val()) {
		$('#uploadImg2').attr('src', "image/deafultPhoto.jpg"); 
		$('#uploadImg').attr('src', "image/deafultPhoto.jpg"); 
	} else {
		$('#uploadImg2').attr('src', "image/" + $('#imgName').val()); 
		$('#uploadImg').attr('src', "image/" + $('#imgName').val()); 
	}
	
	$('#editPassword').css('display', "none");	
	
	$('#editPwd').on('click', function () {
		$('#rightContainer').css('display', "none");
		$('#editPassword').css('display', "block");		
	});
	
	$('#editInfo').on('click', function () {
		$('#rightContainer').css('display', "block");
		$('#editPassword').css('display', "none");		
	});
	
	$("#oldPassword").blur(function(){
		$('#newPassword').attr('disabled',true);
		$('#newPassword2').attr('disabled',true);
		checkPassword();
	});
	
})


function checkPassword() {
	$.ajax({ 
		url : 'user/checkPassword',		
		dataType : 'json',
		data: {
			password: $('input[name=oldPassword]').val(),
	    },
	    success : function(data) {
	    	if (data.result === 1) {
				layer.msg('密码匹配，请输入新密码');
				$('#newPassword').attr('disabled',false);
				$('#newPassword2').attr('disabled',false);
			} else {
				layer.msg('密码错误，请再次输入');
				$('input[name=oldPassword]').val("");
			}
	    }
	})
	
}

function updatePassword() {
	$.ajax({ 
		url : 'user/updatePassword',		
		dataType : 'json',
		data: {
			password: $('input[name=newPassword]').val(),
	    },
	    success : function(data) {
	    	if (data.result === 1) {
				layer.msg('修改成功');
				window.location.href="user/login"
			} else {
				layer.msg('修改失败');
			}
	    }
	});	
}


function editProfileWithoutImg () {
	$.ajax({
		url : 'user/editProfileWithoutImg',
		async : true,
		type : 'POST',
		dataType : 'json',
		data: {
	    	username: $('input[name=username]').val(),
	    	email: $('input[name=email]').val(),
	    	briefIntroduction: $('input[name=desc]').val()
	    },
		success : function(data) {
			if (data.result === 0) {
				layer.msg('上传成功');
			} else {
				console.log(data);
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}

layui.use('form', function() {
	var form = layui.form;
	form.on('submit(edit-basic-btn)', function(data) {
		console.log(data.field);//提交头像+基本信息
		if (!$('input[name=file]').val()) {
			editProfileWithoutImg();
		}
		return false;
	});
	
	form.on('submit(edit-pwd-btn)', function(data) {		
		if ($('#newPassword').val() !== $('#newPassword2').val()) {
			layer.msg('两次密码输入的不一致');
			return false;
		}
		updatePassword();	
		return false;
	});
	
	form.verify({ 
		password: [/^(?=.*[a-z])(?=.*\d)[^]{8,16}$/i, '密码应为字母和数字的组合，且不少于8位'],
	})
	
});

layui.use('upload', function(){
	  var $ = layui.jquery
	  ,upload = layui.upload;
	  
	  //普通图片上传
	  var uploadInst = upload.render({
	    elem: '#uploadPic'
	    ,url: 'user/editProfileWithImg'
	    ,auto: false
	    ,bindAction: '#edit-basic-btn'
	    ,choose: function(obj){
	      //预读本地文件示例，不支持ie8
	      obj.preview(function(index, file, result){
	        $('#uploadImg').attr('src', result); //图片链接（base64）
	        $('#uploadImg2').attr('src', result);//显示右边小图片
	        $('#photoUrl').attr('value', file.name);
	      });
	    }
	    ,data: {
	    	username: $('input[name=username]').val(),
	    	email: $('input[name=email]').val(),
	    	briefIntroduction: $('input[name=desc]').val()
	    }
	    ,done: function(res){
	      //如果上传失败
	      if(res.code !== 0){
	      	  return layer.msg('上传失败');
	      } else {
	    	  return layer.msg('上传成功');
	      }
	      
	    }
	    ,error: function(err){
	    	console.log(err);
	      //演示失败状态，并实现重传
/*  	      var uploadHelpText = $('#uploadHelpText');
	      uploadHelpText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
	      uploadHelpText.find('.demo-reload').on('click', function(){
	      uploadInst.upload(); 
	      }); */
	    }
	  });
});
</script>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div class="userInfoContainer layui-container">
		<jsp:include page="./ico-seacher-header.jsp"></jsp:include>
		<div class="mainContainer">
			<fieldset class="layui-elem-field layui-field-title">
				<legend class="titleContent">编辑个人信息</legend>
			</fieldset>
			<div class="layui-upload leftContainer">
				<div class="layui-upload-list">
					<img class="layui-upload-img" id="uploadImg"> <input
						type="hidden" name="photoUrl" id="photoUrl" />
					<p id="uploadHelpText"></p>
				</div>
				<button type="button" class="layui-btn layui-btn-radius" id="editInfo">修改信息</button>
				<button type="button" class="layui-btn layui-btn-radius" id="editPwd">修改密码</button>
			</div>
			<form class="layui-form" lay-filter="basicInfo">
				<div class="rightContainer" id="rightContainer">
					<div class="edit-profile">
						<div class="layui-form-item  userImg">
							<img class="layui-upload-img" id="uploadImg2">						
						</div>
						<button type="button" class="layui-btn layui-btn-radius" id="uploadPic">编辑头像</button>
						<input type="hidden" name="photoUrl" id="photoUrl"/>
						<div class="layui-form-item">
							<span class="layui-form-label">用户名:</span>
							<div class="layui-input-block">
								<input type="text" value="${currentUser.username}"
									name="username" lay-verify="required" autocomplete="off"
									class="layui-input layui-input1">
							</div>
						</div>
						<div class="layui-form-item">
							<span class="layui-form-label">邮箱:</span>
							<div class="layui-input-block">
								<input type="text" value="${currentUser.email}" name="email" lay-verify="required|email"
									autocomplete="off" class="layui-input layui-input1">
							</div>
						</div>
						<div class="layui-form-item layui-form-text">
							<label class="layui-form-label">个人简介：</label>
							<div class="layui-input-block">
								<textarea name="desc" value="${currentUser.briefIntroduction}"
									class="layui-textarea layui-input1"></textarea>
							</div>
						</div>
						<div class="layui-form-item">
							<button class="layui-btn layui-btn-radius buttonCombination" lay-submit id="edit-basic-btn" lay-filter="edit-basic-btn">修改</button>
						</div>
					</div>
				</div>
					
			</form>
			<form class="layui-form" lay-filter="pwdInfo">
				<div class="editPassword" id="editPassword">
					<div class="itemContainer">
						<div class="layui-form-item">
							<span class="layui-form-label">原密码:</span>
							<div class="layui-input-block">
								<input type="password" name="oldPassword" id="oldPassword"
									lay-verify="required|password" placeholder="请输入密码"
									autocomplete="off" class="layui-input layui-input1">
							</div>
						</div>
						<div class="layui-form-item">
							<span class="layui-form-label">新密码:</span>
							<div class="layui-input-block">
								<input type="password" name="newPassword" id="newPassword"
									lay-verify="required|password" placeholder="请输入密码"
									autocomplete="off" class="layui-input layui-input1">
							</div>
						</div>
						<div class="layui-form-item">
							<span class="layui-form-label">确认密码:</span>
							<div class="layui-input-block">
								<input type="password" name="newPassword" id="newPassword2"
									lay-verify="required|password" placeholder="请再次输入密码"
									autocomplete="off" class="layui-input layui-input1">
							</div>
						</div>
						<button class="layui-btn layui-btn-radius" lay-submit
							id="edit-pwd-btn" lay-filter="edit-pwd-btn">修改</button>
					</div>
				</div>
			</form>
		</div>

	</div>
	<input type="hidden" id="imgName" value="${currentUser.imgName }"/>
</body>
