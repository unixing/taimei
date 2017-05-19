<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>登录</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/indexSource/login.css" rel="stylesheet">
<!-- 底部公告 3-9更新 -->
<link href="/indexSource/index-foot.css" rel="stylesheet">
<link href="/indexSource/reset.css" rel="stylesheet">
<script src="/indexSource/jquery1.8.3.js"></script>
</head>
<body>
	<!-- <div id="version">版本号:2.2.14.1218_beta</div>  -->
	<div class="login-collection-box">
		<div class="login-input">
			<div class="login-input-change">
				<div class="login-input-login">密码登录</div>
				<div class="login-input-switch" title="微信扫码登录"></div>
			</div>
			<div class="login-input-cont">
				<div class="login-input-lo">
					<div class="login-input-login-err"></div>
					<div class="login-input-login-box">
						<div class="login-input-login-box-nus login-input-login-box-list">
							<input type="text" placeholder="输入账号或者手机号" id="log-user">
						</div>
						<div class="login-input-login-box-pas login-input-login-box-list">
							<input type="password" placeholder="输入密码" autocomplete="off"
								id="log-pas">
						</div>
					</div>
					<div class="login-input-login-operation">
						<div class="login-operation-remember">
							<input type="checkbox" id="login-checkbox"> <label
								for="login-checkbox" id="remember">&#xe643;</label> <span>记住密码</span>
						</div>
						<div class="login-operation-forgot">忘记账号和密码？</div>
					</div>
					<div class="login-input-login-bth correct">登录</div>
					<div class="login-input-login-register">没有账号？立即注册</div>
				</div>
			</div>
		</div>
		<div class="login-pasBack">
			<div class="login-pasBack-change">
				<div class="login-pasBack-validation">用户验证</div>
				<div class="login-pasBack-del" title="返回登录">&#xe64e;</div>
			</div>
			<div class="login-pasBack-cont">
				<div class="login-pasBack-lo">
					<div class="login-pasBack-tipUser">请输入你需要重置密码的账户</div>
					<div class="login-pasBack-userName">
						<input type="text" placeholder="账户名">
					</div>
					<div class="login-pasBack-tipValidation">
						<span>请输入验证码</span><span class="login-pasBack-tipValidation-err"><span>&#xe64a;</span>验证码有误，请从新输入</span>
					</div>
					<div class="login-pasBack-import">
						<div class="login-pasBack-import-val">
							<input type="text" placeholder="账户名"
								id="login-pasBack-import-val">
							<div id="login-pasBack-import-T">&#xe649;</div>
						</div>
						<div id="login-pasBack-val">验证码框</div>
					</div>
					<div class="login-pasBack-next">
						<div class="login-pasBack-nextOne">下一步</div>
						<div class="login-pasBack-nextOr">取消</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部公告 3-9更新 -->
	<div id="foot">
		
		<div id="ver-table">
			<ul id="ver-list">
			</ul>
			<p class="ver-txt">
			</p>
			<!--翻页按钮-->
			<div id="tabNvi">
				<a id= "pg_up" href="javascript:void(0)"><span class="pg-up"></span></a>
				<a id= "pg_down" href="javascript:void(0)"><span class="pg-down"></span></a>
			</div>
		</div>
		&copy;2016 数聚空港 成都太美航空技术有限公司 
		<span class="foot-link"><a href="www.taimei.com">关于我们</a> </span>
		<span class="foot-link"><a id="onTable" href="javascript:void(null)">版本公告</a></span>
		<div id="version">版本号:2.2.14.1218_beta</div> 
	</div>
	<script src="/indexSource/login.js"></script>
	<script src="/indexSource/index-foot.js"></script>
</body>
</html>