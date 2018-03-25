$(function() {
	var count = $("#count").val();
	var currentPage = $("#curr").val();
	var pageSize = $("#limit").val();
	window.onpopstate = function(event) {
		$("#demo").empty();
		$.ajax({
			url : 'getInfo',
			async : true,
			type : 'POST',
			dataType : 'json',
			data : {
				page : event.state.currentPage,
				limit :event.state.pageSize
			},
			success : function(data) {
				$("#table tr.testTr").remove();
				console.log(data.list);
				$.each(data.list, function(index, item) {
					var tr = $(".template").clone();
					tr.show();
					tr.removeClass("template");
					tr.addClass('testTr');
					tr.find(".id").text(item.id);
					tr.find(".name").text(item.name);
					$("#table").append(tr);
				});
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	
	layui.use('laypage', function() {
		var laypage = layui.laypage;

		laypage.render({
			elem : 'demo',
			count : count,
			curr : currentPage,
			limit : pageSize,
			layout : [ 'prev', 'page', 'next', 'count', 'limit', 'skip' ],
			limits : [ 5, 10 ],
			jump : function(obj, first) {
				console.log(obj);

				if (!first) {
					$.ajax({
						url : 'getInfo',
						async : true,
						type : 'POST',
						dataType : 'json',
						data : {
							page : obj.curr,
							limit : obj.limit
						},
						success : function(data) {
							$("#table tr.testTr").remove();
							console.log(data.list);
							$.each(data.list, function(index, item) {
								var tr = $(".template").clone();
								tr.show();
								tr.removeClass("template");
								tr.addClass('testTr');
								tr.find(".id").text(item.id);
								tr.find(".name").text(item.name);
								$("#table").append(tr);
							});

							window.history.pushState({currentPage: currentPage, pageSize: pageSize}, null,
									"getInfo?page=" + obj.curr + "&limit="
											+ obj.limit);
							currentPage = obj.curr;
							pageSize = obj.limit;
						},
						error : function(err) {
							console.log(err);
						}
					});
				}
			}
		});
		$("#demo").empty();
		laypage.render({
			elem : 'demo',
			count : count,
			curr : currentPage,
			limit : pageSize,
			layout : [ 'prev', 'page', 'next', 'count', 'limit', 'skip' ],
			limits : [ 5, 10 ],
			jump : function(obj, first) {
				console.log(obj);

				if (!first) {
					$.ajax({
						url : 'getInfo',
						async : true,
						type : 'POST',
						dataType : 'json',
						data : {
							page : obj.curr,
							limit : obj.limit
						},
						success : function(data) {
							$("#table tr.testTr").remove();
							console.log(data.list);
							$.each(data.list, function(index, item) {
								var tr = $(".template").clone();
								tr.show();
								tr.removeClass("template");
								tr.addClass('testTr');
								tr.find(".id").text(item.id);
								tr.find(".name").text(item.name);
								$("#table").append(tr);
							});

							window.history.pushState({currentPage: currentPage, pageSize: pageSize}, null,
									"getInfo?page=" + obj.curr + "&limit="
											+ obj.limit);
							currentPage = obj.curr;
							pageSize = obj.limit;
						},
						error : function(err) {
							console.log(err);
						}
					});
				}
			}
		});
	});

})

