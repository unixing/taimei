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
		<div class="login-input" id='login_input'>
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
						<div class='login_captcha' id='login_captcha'>验证码登录</div>	
						<div class="login-operation-forgot">忘记密码？</div>
					</div>
					<div class="login-input-login-bth correct">登录</div>
					<div class="login-input-login-register">没有账号？立即注册</div>
				</div>
			</div>
		</div>
		<div class="login-pasBack" id='login_validation'>
			<div class="login-pasBack-change">
				<div class="login-pasBack-validation">账号验证</div>
				<div class="login-pasBack-del login_del" title="返回登录">&#xe64e;</div>
			</div>
			<div class="login-pasBack-cont">
				<div class="login-pasBack-lo">
					<div class="login-pasBack-tipUser" id='login_tip5'></div>
					<div class="login-pasBack-userName">
						<input type="text" placeholder="请输入手机号码" id='login_phone' maxlength="11">
					</div>
					<div class="login-pasBack-import">
						<div class="login-pasBack-import-val">
							<input type="text" placeholder="请输入短信验证码" id="login-pasBack-import-val">
						</div>
						<div id="login-pasBack-val">获取验证码</div>
					</div>
					<div class="login-pasBack-next">
						<div class="login-pasBack-nextOne" id='login_next'>下一步</div>
						<div class="login-pasBack-nextOr login_del">取消</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mobile-bind" id='mobile-bind'>
	        <div class="cPBoxItm-title">
	            <div></div>
	        </div>
	        <div class="changeSuccessful">
	            <img src="./js/js1/vue_two/dist/setSucc.png"/>
	            <p>操作成功</p>
	            <p>马上跳转到主页...</p>
	        </div>
    	</div>
		<div class="login-pasBack login_create" id='login_create'>
			<div class="login-pasBack-change">
				<div class="login-pasBack-validation"></div>
				<div class="login-pasBack-del login_del" title="返回登录">&#xe64e;</div>
			</div>
			<div class="login-pasBack-cont">
				<div class="login-pasBack-lo">
					<div class="login-pasBack-tipUser login_createN">
						<span>创建用户名</span><span id='login_createN0' class="login-pasBack-tipValidation-err"><span>&#xe64a;<span id='login_createN0t'></span></span></span>
					</div>
					<div class="login-pasBack-userName">
						<input type="text" placeholder="用户名不能包含特殊字符" id='login_careat_nextU'>
					</div>
					<div class="login-pasBack-tipValidation">
						<span>创建密码</span><span id='login_createN1' class="login-pasBack-tipValidation-err"><span>&#xe64a;<span id='login_createN1t'></span></span></span>
					</div>
					<div class="login-pasBack-import">
						<div class="login-pasBack-import-val login_createW">
							<input type="text" placeholder="支持6-20位字母加数字非特殊符号" id="login_careat_nextP">
						</div>
					</div>
					<div class="login-pasBack-next login_createN">
						<div class="login-pasBack-nextOne" id='login_careat_next'>下一步</div>
						<div class="login-pasBack-nextOr login_del">取消</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 管理员登录验证 -->
		<div class="login-pasBack" id='login_administrator'>
			<div class="login-pasBack-change">
				<div class="login-pasBack-validation">账号激活</div>
				<div class="login-pasBack-del login_del" title="返回登录">&#xe64e;</div>
			</div>
			<div class="login-pasBack-cont">
				<div class="login-pasBack-lo">
					<div class="login-pasBack-tipUser login_admin_tip">请输入绑定的手机号码<span class='login_tips'><span id='login_tip6'></span></span></div>
					<div class="login-pasBack-userName">
						<input type="text" placeholder="请输入手机号码" id='login_administrator_phone' maxlength="11">
					</div>
					<div class="login-pasBack-next">
						<div class="login-pasBack-nextOne" id='login_administrator_next'>下一步</div>
						<div class="login-pasBack-nextOr login_del">取消</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 管理员登录验证短信 -->
		<div class="login-pasBack" id='login_administrator_note'>
			<div class="login-pasBack-change">
				<div class="login-pasBack-validation">用户验证</div>
				<div class="login-pasBack-del login_del" title="返回登录">&#xe64e;</div>
			</div>
			<div class="login-pasBack-tipUser login_admin_tip"><span class='login_tips'><span id='login_tip7'></span></span></div>
			<div class="login-pasBack-cont">
				<div class="login-pasBack-lo">
					<div class="login-pasBack-import">
						<div class="login-pasBack-import-val">
							<input type="text" placeholder="请输入短信验证码" id="login_administrator_note_val">
						</div>
						<div id="login_administrator_pasBackval">获取验证码</div>
					</div>
					<div class="login-pasBack-next">
						<div class="login-pasBack-nextOne" id='login_administrator_note_next'>下一步</div>
						<div class="login-pasBack-nextOr login_del">取消</div>
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
	<script src="/indexSource/login_captcha.js"></script>
</body>
</html>