
	layui.use('form', function() {
		var form = layui.form;
		
		//监听提交
		form.on('submit(register-btn)', function(data){
			console.log(data);
		   register(data.field);
		   return false;
		});
	});
	function backToHome() {
		window.location.href="bookMain";
	}
	
	function register(registerData) {
		$.ajax({
			url : 'user/register-submit',
			async : true,
			type : 'POST',
			dataType : 'json',
			data : {
				username: registerData.username,
				password: registerData.password,
				email: registerData.email,
				briefIntroduction: registerData.desc
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
