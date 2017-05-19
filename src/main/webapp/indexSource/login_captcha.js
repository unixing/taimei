
var filter = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;   //手机格式
var re=/^([\u4E00-\u9FA5]|\w)*$/;    //特殊字符
var rep=/^(?!\D+$)(?![^a-zA-Z]+$)\S{6,20}$/;      //6-20位数字加字母
var ti=1;

$('.login_del').on('click',function(){
	$('#login_input').css({'display':'block'});
	$('#login_validation').css({'display':'none'});
	$('#login_create').css({'display':'none'});
	$('#login_administrator').css({'display':'none'});
	$('#login_administrator_note').css({'display':'none'});
})
$('#login_captcha').on('click',function(){
	$('#login_input').css({'display':'none'});
	$('#login_validation').css({'display':'block'});
	$('#login_create').css({'display':'none'});
})
var login_phone='';
$("#login-pasBack-val").on('click',function(){
	login_phone=$('#login_phone').val();
	if(login_phone==''){
		$('#login_tip5').text('手机号码不能为空');
		setTimeout(function(){
			$('#login_tip5').text('');
		},1500)
	}else if(filter.test(login_phone)){
		if(ti<=1){
			$.ajax({
				url:'/getLoginSmCode',
				type:'post',
				dataType:'json',
				data:{
					mobile:login_phone
				},
				success:function(data){
					if(data.opResult==0){
						ti=60;
						var time=function(){
							if(ti>1){
								ti--;
								$("#login-pasBack-val").text(ti+'s'+'后发送');
								if(ti!=0){
									setTimeout(function(){time();},1000);
								}
							}else{
								$("#login-pasBack-val").text('发送验证码');
							};
						};
						time();
					}else if(data.opResult==5){
						
					}else{
						$('#login_tip5').text('你的手机号码没有权限注册');
						setTimeout(function(){
							$('#login_tip5').text('');
						},1500);
					}
				}
			});
		}
	}else{
		$('#login_tip5').text('手机号码格式有错');
		setTimeout(function(){
			$('#login_tip5').text('');
		},1500)
	}
})

$("#login_next").on('click',function(){
	if(login_phone!=''&&$("#login-pasBack-import-val").val()!=''){
		$.ajax({
			url:'/bindPhoneOrValidCode',
			type:'post',
			dataType:'json',
			data:{
				mobile:login_phone,
				validCode:$("#login-pasBack-import-val").val()
			},
			success:function(data){
				if(data.opResult=='0'){
					$('#login_validation').css({'display':'none'});
					$('#login_create').css({'display':'block'});
				}else{
					$('#login_tip5').text('验证码错误');
					setTimeout(function(){
						$('#login_tip5').text('');
					},1500)
				}
			}
		});
	}else if(login_phone==''){
		$('#login_tip5').text('手机号码不能为空');
		setTimeout(function(){
			$('#login_tip5').text('');
		},1500)	
	}else if(login_phone==''){
		$('#login_tip5').text('手机验证码不能为空');
		setTimeout(function(){
			$('#login_tip5').text('');
		},1500)	
	}
})

$('#login_careat_next').on('click',function(){
	var uesr=$('#login_careat_nextU').val();
	var pas=$('#login_careat_nextP').val();
	if(uesr==''){
		$('#login_createN0t').text('账号不能为空');
		$('#login_createN0').css({'display':'inline-block'});
		setTimeout(function(){
			$('#login_createN0').css({'display':'inline-block'});
		},1500)
	}else if(!re.test(uesr)){
		$('#login_createN0t').text('账号格式错误');
		$('#login_createN0').css({'display':'inline-block'});
		setTimeout(function(){
			
		},1500)
	}else if(pas==''){
		$('#login_createN1t').text('密码不能为空');
		$('#login_createN1').css({'display':'inline-block'});
		setTimeout(function(){
			$('#login_createN1').css({'display':'inline-block'});
		},1500)
	}else if(!rep.test(pas)){
		$('#login_createN1t').text('密码格式错误');
		$('#login_createN1').css({'display':'inline-block'});
	}else{
		$.ajax({
			url:'/createNamdAndPwd',
			type:'post',
			dataType:'json',
			data:{
				userName:uesr,
				password:pas,
			},
			success:function(data){
				if(data.success){
					$('#login_create').css({'display':'none'});
					$('#mobile-bind').css({'display':'block'});
					setTimeout(function(){
						window.location.href="/indexd"; 
					},1500)
				}else{
					alert('创建失败')
				}
			}
		});
	} 
	setTimeout(function(){
		$('#login_createN0').css({'display':'none'});
		$('#login_createN1').css({'display':'none'});
		$('#login_createN0t').text('');
		$('#login_createN1t').text('');
	},1500)
})

/* 管理员验证  */

$("#login_administrator_next").on("click",function(){
	var adminPhone=$("#login_administrator_phone").val();
	if(adminPhone==""||adminPhone==undefined){
		$("#login_tip6").html("<span style='font-family:icon'>&#xe64a;</span>手机号码不能为空");
		setTimeout(function(){
			$('#login_tip6').text('');
		},1500)	
	}else if(!filter.test(adminPhone)){
		$("#login_tip6").html("<span style='font-family:icon'>&#xe64a;</span>手机号码格式错误");
		setTimeout(function(){
			$('#login_tip6').text('');
		},1500)	
	}else{
		$.ajax({
			url:'/validPhone',
			type:'post',
			dataType:'json',
			data:{
				mobile:adminPhone
			},
			success:function(data){
				login_phone=adminPhone;
				if(data.opResult=='0'){
					$('#login_administrator').css({'display':'none'});
					$('#login_administrator_note').css({'display':'block'});
				}else{
					alert('验证失败')
				}
			}
		});
	}
})

/* 管理员获取验证码  */
$('#login_administrator_pasBackval').on('click',function(){
	if(ti<=1){
		$.ajax({
			url:'/getValidCode',
			type:'post',
			dataType:'json',
			data:{
				mobile:login_phone
			},
			success:function(data){
				if(data.opResult==0){
					ti=60;
					var time=function(){
						if(ti>1){
							ti--;
							$("#login_administrator_pasBackval").text(ti+'s'+'后发送');
							if(ti!=0){
								setTimeout(function(){time();},1000);
							}
						}else{
							$("#login_administrator_pasBackval").text('发送验证码');
						};
					};
					time();
				}else if(data.opResult==5){
					$('#login_tip7').text('获取验证码错误，请重新获取');
					setTimeout(function(){
						$('#login_tip7').text('');
					},1500);
				}
			}
		});
	}
})

$("#login_administrator_note_next").on("click",function(){
	var code =$("#login_administrator_note_val").val();
	if($(code!=""&&code!=undefined)){
		$.ajax({
			url:'/bindPhoneOrValidCode',
			type:'post',
			dataType:'json',
			data:{
				mobile:login_phone,
				validCode:code
			},
			success:function(data){
				if(data["opResult"]=='0'){
					login();
                }else{
                	$(".login-input-login-err").html("<span>&#xe64a;</span>你输入的验证码错误")
                }
			}
		})
	}
})