
layui.use('table', function(){
	  var table = layui.table;

	  //第一个实例
	  table.render({
	    elem: '#userTable'
	    ,height: 500
	    ,url: 'admin/userList' //数据接口
	    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
	    ,limits:[1,5,10,15]
	    ,page: true //开启分页
	    ,cols: [[ //表头
	      {checkbox: true, fixed: true}
	      ,{field: 'id'}
	      ,{field: 'username', title: '用户名', width:130}
		  ,{field: 'imgName', title: '用户头像', width: 200,templet:'<div><img name="img" src="image/{{d.imgName}}"></div>'}
	      ,{field: 'email', title: '邮箱', width:180} 
		  ,{field: 'briefIntroduction', title: '主要介绍', width:180}
	      ,{field: 'operation', title: '操作', toolbar:"#operation"} 
	    ]]
	  ,done: function(res, curr, count){
		  $("[data-field='id']").css('display','none');
	  }
	  });
});

$(document).ready(function() {

	$('#adminLogout').on('click', function() {
			logout();
		});



	
		layui.use('element', function() {
			var element = layui.element;
			//监听导航点击
			element.on('nav(test)', function(elem) {
			console.log(elem);
/* 			alert(elem.text()); */
			});
		});

	});

	function logout() {
		$.ajax({
			url : 'admin/logout',
			async : true,
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				if (data.result === 1) {
					window.location.href = "admin/login";
				} else if (data.result === 0) {
					layer.msg("服务器错误");
				} else {
					layer.msg("拜托..  你还没有登录 (￣□￣；)");
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}