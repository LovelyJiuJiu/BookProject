layui.use('form', function() {
	var form = layui.form;

	// 监听提交
	form.on('submit(register-btn)', function(data) {
		console.log(data);
		if ($('#password1').val() !== $('#password2').val()) {
			layer.msg('两次密码输入的不一致');
			return false;
		}
		console.log('ecex  ss');
		register(data.field);
		return false;
	});
	
	form.verify({ 
		password: [/^(?=.*[a-z])(?=.*\d)[^]{8,16}$/, '密码应为字母和数字的组合，且不少于8位'],
	})
});
function backToHome() {
	window.location.href = "bookMain";
}

function register(registerData) {
	$.ajax({
		url : 'user/register-submit',
		async : true,
		type : 'POST',
		dataType : 'json',
		data : {
			username : registerData.username,
			password : registerData.password,
			email : registerData.email,
			briefIntroduction : registerData.desc
		},
		success : function(data) {
			if (data.result === 1) {
				window.location.href = "bookMain";
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}

$(function() {
	$('#password2').on('blur', function () {
		if ($(this).val() !== $('#password1').val()) {
			layer.msg('两次密码输入的不一致');
		}
	});
});
