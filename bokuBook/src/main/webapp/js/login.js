layui.use('form', function() {
	var form = layui.form;

	form.on('submit(login-btn)', function(data) {
		$('#icon').css('display', "block");
		login(data.field);
		return false;
	});
});

function backToHome() {
	window.location.href = "user/bookMain";
}

function goToRegister() {
	window.location.href = getContextPath() +"/user/register";
	return false;
}

function login(data) {
//	alert(JSON.stringify(data));
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
			$('#icon').css('display', "none");
			if (data.result === 1) {
				window.location.href = getContextPath()+"/user/bookMain";
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

function getContextPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0,index+1);
    return result;
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
	var userName = decodeURIComponent(getCookie("username"));
	var password = decodeURIComponent(getCookie("password"));
	$('input[name=username]').val(userName);
	$('input[name=password]').val(password);	
	$('#icon').css('display', "none");
});
