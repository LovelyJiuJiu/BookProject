layui.use('form', function() {
	var form = layui.form;

	form.on('submit(login-btn)', function(data) {
		$('#icon').css('display', "block");
		login(data.field);
		return false;
	});
});

layui.use('element', function(){
	var element = layui.element;
});

function login(data) {
	$.ajax({
		url : 'admin/login-submit',
		async : true,
		type : 'POST',
		dataType : 'json',
		data : {
			adminUsername : data.username,
			adminPassword : data.password,
			rememberMe : data.rmbme
		},
		success : function(data) {
			$('#icon').css('display', "none");
			if (data.result === 1) {
				window.location.href = "admin/adminMain";
			} else if (data.result === 0) {
				layer.msg('用户名或密码错误');
				$('input[name=username]').val("");
				$('input[name=password]').val("");
				$(".layui-form-switch").removeClass("layui-form-onswitch");
			}
		},
		error : function(err) {
			$('#icon').css('display', "none");
			console.log(err);
		}
	});
}

function getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i].trim();
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}

$(function() {
	var adminUsername = decodeURIComponent(getCookie("adminUsername"));
	var adminPassword = decodeURIComponent(getCookie("adminPassword"));
	$('input[name=username]').val(adminUsername);
	$('input[name=password]').val(adminPassword);
	$('#icon').css('display', "none");
});
