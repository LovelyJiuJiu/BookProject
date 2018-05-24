<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("path", basePath);
%>
<base href="${path }" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<link rel="stylesheet" href="css/adminMain.css">
<meta http-equiv="X-UA-Compatible" content="IE=9">
<title>--主页管理--</title>
<script src="jquery/jquery-2.2.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="layui/layui.js"></script>
</head>
<body>
	<div class="title">该年份营业额</div>
	<canvas id="myChart" width="700" height="500"></canvas>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	getData();
})
function getData() {
 	var barData={};  
 	barData.labels=[];  
 	barData.datasets=[];  
 	var temData={};  
 	temData.data=[];  
 	$.ajax({
		url : 'admin/getSaleInfo',
		async : true,
		dataType : 'json',
		success : function(result) {
			
			barData.labels = result.labels;
			temData.data = result.data;
			barData.datasets.push(temData); //封装一个规定格式的barData。  
			showChart(barData);
		},
		error : function(err) {
			console.log(err);
		}
	}); 
}
  
function showChart(barData) {
	var ctx  = document.getElementById("myChart").getContext('2d');
	myChart = new Chart(ctx,{
		type: 'bar',
		data:barData,
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true  //从0开始
	                }
	            }],
                xAxes:[{
                    //轴标题
                    scaleLabel:{
                        display:true,
                        labelString:'月份',
                        fontColor:'#666'
                    },
                    //网格显示
                    gridLines:{
                        display:false
                    },
                }]
	        },
	        legend: {
	            display: false,
	        }
	    }
	});
}
  
</script>
</html>