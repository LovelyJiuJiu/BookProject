<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="ico-header">
	<div class="layui-container">
		<a class="common-logo" href=""> <img alt="web-logo"
			src="image/web-logo.png" title="博库书城">
		</a>
		<div class="search-input">
			<input type="text" name="keyWords" id="keyWords"
				placeholder="搜索书名..." autocomplete="off" class="layui-input">
			<i class="layui-icon search-btn">&#xe615;</i>
		</div>
	</div>
</div>
<!-- 导航栏 -->
<div class="layui-container">
	<ul class="layui-nav nav-color" lay-filter="">
		<li class="layui-nav-item"><a href="">最新活动</a></li>
		<li class="layui-nav-item layui-this"><a href="">产品</a></li>
		<li class="layui-nav-item"><a href="">大数据</a></li>
		<li class="layui-nav-item"><a href="javascript:;">解决方案</a>
			<dl class="layui-nav-child">
				<!-- 二级菜单 -->
				<dd>
					<a href="">移动模块</a>
				</dd>
				<dd>
					<a href="">后台模版</a>
				</dd>
				<dd>
					<a href="">电商平台</a>
				</dd>
			</dl></li>
		<li class="layui-nav-item"><a href="">社区</a></li>
	</ul>
</div>