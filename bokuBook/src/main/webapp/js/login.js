layui.use('form', function() {
	var form = layui.form;

	form.on('submit(login-btn)', function(data) {
		login(data.field);
		return false;
	});
});

function backToHome() {
	window.location.href = "bookMain";
}

function goToRegister() {
	window.location.href = "user/register";
	return false;
}

function login(data) {
	alert(JSON.stringify(data));
	$.ajax({
		url : 'user/login-submit',
		async : true,
		type : 'POST',
		dataType : 'json',
		data : {
			username : data.username,
			password : data.password,
			rememberMe : data.rmbme
		},
		success : function(data) {
			if (data.result === 1) {
				window.location.href = "bookMain";
			} else if (data.result === 0) {
				layer.msg('用户名或密码错误');
			}
		},
		error : function(err) {
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
	var userName = decodeURI(getCookie("username"));
	var password = decodeURI(getCookie("password"));
	$('input[name=username]').val(userName);
	$('input[name=password]').val(password);
});
