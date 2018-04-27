$(document).ready(function() {
	if (!$('#imgName').val()) {
		$('#uploadImg2').attr('src', "image/deafultPhoto.jpg");
		$('#uploadImg').attr('src', "image/deafultPhoto.jpg");
	} else {
		$('#uploadImg2').attr('src', "image/" + $('#imgName').val());
		$('#uploadImg').attr('src', "image/" + $('#imgName').val());
	}
	addTitleToImg();
	
	$('#editPassword').css('display', "none");

	$('#editPwd').on('click', function() {
		$('#rightContainer').css('display', "none");
		$('#editPassword').css('display', "block");
	});

	$('#editInfo').on('click', function() {
		$('#rightContainer').css('display', "block");
		$('#editPassword').css('display', "none");
	});

	$("#oldPassword").blur(function() {
		$('#newPassword').attr('disabled', true);
		$('#newPassword2').attr('disabled', true);
		checkPassword();
	});

	$('#desc').val($('#briefIntroduction').val());
})

function addTitleToImg() {
	if ("deafultPhoto.jpg" == $('#imgName').val()) {
		$("#uploadImg").attr({title: "默认头像，请上传个人头像"});		
	}	
}

function checkPassword() {
	$.ajax({
		url : 'user/checkPassword',
		dataType : 'json',
		data : {
			password : $('input[name=oldPassword]').val(),
		},
		success : function(data) {
			if (data.result === 1) {
				layer.msg('密码匹配，请输入新密码');
				$('#newPassword').attr('disabled', false);
				$('#newPassword2').attr('disabled', false);
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
		data : {
			password : $('input[name=newPassword]').val(),
		},
		success : function(data) {
			if (data.result === 1) {
				layer.msg('修改成功, 请重新登录', {
					time : 2000
				}, function() {
					window.location.href = 'bookMain';
				});
			} else {
				layer.msg('修改失败');
			}
		}
	});
}

function editProfileWithoutImg() {
	$.ajax({
		url : 'user/editProfileWithoutImg',
		async : true,
		type : 'POST',
		dataType : 'json',
		data : {
			id : $('#userId').val(),
			username : $('input[name=username]').val(),
			email : $('input[name=email]').val(),
			briefIntroduction : $('#desc').val()
		},
		success : function(data) {
			if (data.code === 0) {
				layer.msg('修改成功, 请重新登录', {
					time : 2000
				}, function() {
					window.location.href = 'bookMain';
				});
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
		console.log(data.field);// 提交头像+基本信息
		if (!$('#photoUrl').val()) {
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
		password : [ /^(?=.*[a-z])(?=.*\d)[^]{8,16}$/i, '密码应为字母和数字的组合，且不少于8位' ],
	})

});

layui.use('upload', function() {
	var $ = layui.jquery, upload = layui.upload;

	// 普通图片上传
	var uploadInst = upload.render({
		elem : '#uploadPic',
		url : 'user/editProfileWithImg',
		auto : false,
		bindAction : '#edit-basic-btn',
		choose : function(obj) {
			// 预读本地文件示例，不支持ie8
			obj.preview(function(index, file, result) {
				$('#uploadImg').attr('src', result); // 图片链接（base64）
				$('#uploadImg2').attr('src', result);// 显示右边小图片
				$('#photoUrl').val(file.name);
			});
		},
		data : {
			id : function() {
				return $('#userId').val();
			},
			username : function() {
				return $('input[name=username]').val();
			},
			email : function() {
				return $('input[name=email]').val();
			},
			briefIntroduction : function() {
				return $('#desc').val();
			}
		},
		done : function(res) {
			// 如果上传失败
			if (res.code !== 0) {
				return layer.msg('修改失败');
			} else {
				layer.msg('修改成功, 请重新登录', {
					time : 2000
				}, function() {
					window.location.href = 'bookMain';
				});
			}

		},
		error : function(err) {
			console.log(err);
			// 演示失败状态，并实现重传
			/*
			 * var uploadHelpText = $('#uploadHelpText'); uploadHelpText.html('<span
			 * style="color: #FF5722;">上传失败</span> <a class="layui-btn
			 * layui-btn-mini demo-reload">重试</a>');
			 * uploadHelpText.find('.demo-reload').on('click', function(){
			 * uploadInst.upload(); });
			 */
		}
	});
});