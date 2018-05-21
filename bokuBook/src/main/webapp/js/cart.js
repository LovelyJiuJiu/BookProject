Date.prototype.format = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}

function numAdd(num1, num2) {  
    var baseNum, baseNum1, baseNum2;  
    try {  
        baseNum1 = num1.toString().split(".")[1].length;  
    } catch (e) {  
        baseNum1 = 0;  
    }  
    try {  
        baseNum2 = num2.toString().split(".")[1].length;  
    } catch (e) {  
        baseNum2 = 0;  
    }  
    baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));  
    return (num1 * baseNum + num2 * baseNum) / baseNum;  
}

function numSub(num1, num2) {  
    var baseNum, baseNum1, baseNum2;  
    var precision;
    try {  
        baseNum1 = num1.toString().split(".")[1].length;  
    } catch (e) {  
        baseNum1 = 0;  
    }  
    try {  
        baseNum2 = num2.toString().split(".")[1].length;  
    } catch (e) {  
        baseNum2 = 0;  
    }  
    baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));  
    precision = (baseNum1 >= baseNum2) ? baseNum1 : baseNum2;  
    return ((num1 * baseNum - num2 * baseNum) / baseNum).toFixed(precision);  
}

function getContextPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0,index+1);
    return result;
}
function deleteBook(id) {
  $.ajax({
		url: 'cart/deleteBook',
		contentType: 'application/json;charset=utf-8',
		dataType : 'json',
		data:{id: id},
	    success: function (data) { 
	        if(data.result == 1) {
	        	layer.msg('删除成功');
	        	window.location.href = getContextPath() + "/user/cartPage";
	        } else{
	        	layer.msg('删除失败');
	        }
	    }		
	  }) 
	
}


layui.use(['element', 'table'], function(){
	  var table = layui.table;
	  
	  var element = layui.element;
	  element.on('tab(cartAndOrder)', function(data){
		  if(data.index == 1) {
			  $("#cart").removeClass("layui-show");		
			  table.render({
				    elem: '#orderTable'
				    ,height: 500
				    ,url: 'order/getOrderList'
				    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
					,limits:[1,5,10,15]
				    ,page: true
				    ,cols: [[
				       {field: 'id'}
				      ,{field: 'orderNo', title: '订单号', width:300}
				      ,{field: 'price', title: '订单金额', width:120}
				      ,{field: 'submitTime', title: '订单提交时间', width: 200, templet: '#orderDate'}	
				      ,{field: 'orderStatus', title: '订单状态', width: 150, templet: '#checkOrderStatus'}	
				      ,{field: 'operation', title: '操作', templet: '#orderToolBar'}	
				    ]]
			  	  ,done: function(res, curr, count){
				  	$("[data-field='id']").css('display','none');
			  	  }
			  });
		  }
	  });

	  //第一个实例
	  table.render({
	    elem: '#cartTable'
	    ,height: 500
	    ,url: 'user/cart' //数据接口
	    ,limit:5 //这里控制的是选择多少条默认显示的 不是实际显示的
	    ,limits:[1,5,10,15]
	    ,page: true //开启分页
	    ,id: 'cT'
	    ,cols: [[ //表头
	      {checkbox: true, fixed: true}
	      ,{field: 'id'}
	      ,{field: 'bookName', title: '书籍名称', width:260, templet: '<div><a href="/book/book/bookInfo?id={{d.id}}" target="_blank">{{d.bookName}}</a></div>'}
		  ,{field: 'bookInfo', title: '展示图片', width: 200,toolbar:"#img"}	
	      ,{field: 'price', title: '单价', width:100}
	      ,{field: 'number', title: '数量', width:100} 
	      ,{field: 'totalPrice', title: '金额', width: 100}
	      ,{field: 'operation', title: '操作', toolbar:"#operation"}
	    ]]
	  ,done: function(res, curr, count){
		  $("[data-field='id']").css('display','none');
		  $("div.cart-amount").remove();
		  $("div.layui-table-page").append("<div class='cart-amount'><span>合计: ￥</span><span id='amount'>0</span></div>");
		  $("div.layui-table-page").append("<button class='layui-btn layui-btn-radius layui-btn-danger cart-submit'>去结算</button>");
		  $("button.cart-submit").on('click', function () {
			  var checkStatus = table.checkStatus('cT');
			  var data = checkStatus.data;
			  console.log(data);
			  if (data.length === 0) {
				  layer.msg('你还没有选择要买的书嘞く(＾_・)ゝ');
				  return;
			  }
			  orderSubmit(data);
		  });
	  }
	  });
	  addEvent(table);
	  
});

function cancelOrder(id, tr) {
	
	$.ajax({
		url: 'order/cancelOrder',
		dataType : 'json',
		type:'POST',
		data:{id: id},
	    success: function (data) { 
	        if(data.result === 0) {
	        	layer.msg('订单取消成功');
	        	tr.find('a.del').remove();
	        	tr.find('td[data-field="orderStatus"] div').text('订单取消');
	        	tr.find('a.pay').removeAttr('lay-event').addClass('layui-btn-disabled btn-disable').html('订单已取消');
	        } else if (data.result === 2){
	        	layer.msg('未登录');
	        } else {
	        	layer.msg('取消订单失败');
	        }
	    }		
	  });
}

function addEvent(table) {
	//监听删除按钮  
	table.on('tool(cartInfo)', function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;
		if (layEvent === 'del') {
			deleteBook(obj.data.id);
		}
	});
	
	table.on('tool(orderInfo)', function(obj) {
		console.log(obj);
		var data = obj.data;
		var layEvent = obj.event;
		if (layEvent === 'del') {
			layer.confirm('确定取消订单 ?', {icon: 3, title:'提示'}, function(index) {
				layer.close(index);
				cancelOrder(data.id, obj.tr);
			});
		} else if (layEvent === 'show') {
			window.open('/book/order/orderDetail?orderId=' + data.id);
		} else if (layEvent === 'pay') {
			window.open('/book/order/orderConfirm?orderId=' + data.id);
		}
	});
	
	table.on('checkbox(cartInfo)', function(obj) {
		console.log(obj);
		var totalPrice = $('div.cart-amount span#amount');
		if (obj.type === 'all') {
			var checkStatus = table.checkStatus('cT');
			if (obj.checked) {
				var price = 0;
				checkStatus.data.forEach(function (item, index) {
					price = numAdd(price, item.totalPrice);
				});
				totalPrice.text(price);
			} else {
				totalPrice.text(0);
			}
		} else if (obj.type === 'one') {
			if (obj.checked) {
				totalPrice.text(numAdd(totalPrice.text(), obj.data.totalPrice));
			} else {
				totalPrice.text(numSub(totalPrice.text(), obj.data.totalPrice));
			}
		}
	});

}