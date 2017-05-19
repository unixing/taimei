var searchJson={};
//默认参数
var pcname="p-number";   //人数-柱状图
var piename="combined";   //人数-饼图
var legentArray = [];
var pcArray = [];
var pcOldArray = [];
var pcFit = [];
var pcGrp = [];
var pcOldFit = [];
var pcOldGrp = [];
var pieArray = [];
var weekDataArray = [];
var weekDay = ['星期一','星期二','星期三','星期四','星期五','星期六','星期日'];
var airLine = parent.supData.lane;
var airports = parent.airportMap;
var airFltNbr = parent.supData.flight;
var flts = "";
if(typeof(airFltNbr)!="undefined"){
	flts = airFltNbr.split('/');
}
if(typeof(airLine)=="undefined"){
	airLine = "";
}
var flight = "";
var currentWeekDate = '';
if(flts.length>=2){
	flight = flts[0]+"/"+flts[0].substring(0,4)+flts[1];
}
$(function(){
	$("._set-query").click(function(e){
		e.stopPropagation(); //屏蔽事件冒泡
		send();
	}) ;
	$(".c-selectCity ").on("input",function(){
		 getFlt_Nbr();
	}) ;
	/*********************************************请求数据********************************************/
	if(airLine!=null&&airLine!=""&&airLine!='undefined'&&airLine!="="&&airLine!="=="){
		var cds = airLine.split("=");
//		var dateFrt = new Date().format('yyyy-MM-dd');
//		$(".time-line").before("<div class='choose'> <h3 class='choose-title'>销售报表</h3> <div class='choose-set'> <div> <div class='choose-font-top choose-year-top'>&#xe61e;</div> <div class='choose-time achieve-year'>"+dateFrt.split('-')[0]+"</div> <div class='choose-font-bottom choose-year-bottom'>&#xe61e;</div> </div> <div>年 </div> <div> <div class='choose-font-top choose-month-top'>&#xe61e;</div> <div class='choose-time achieve-month'>"+parseInt(dateFrt.split('-')[1])+"</div> <div class='choose-font-bottom choose-month-bottom'>&#xe61e;</div> </div> </div> </div> <div class='calendar'></div>");
//		addE(dateFrt);
		//解绑click事件---start
		$('.choose-year-top').unbind('click');
		$('.choose-year-bottom').unbind('click');
		$('.choose-month-top').unbind('click');
		$('.choose-month-bottom').unbind('click');
		//解绑click事件---end
		//默认选中当前日期所在周==开始
//		$('.list').parent().children().each(function(){
//        	$(this).addClass('set-border');
//        });
//		$('.set-border').css('outline','none');
		//默认选中当前日期所在周==结束
		if(flight!=""){
			$('#goFltNbr').text(flts[0]);
			if(flts[1].length==2){
				//$("#flt_nbr_Count").html('<option>'+flts[0]+'/'+flts[0].substring(0,4)+flts[1]+'</option>');
				$('#backFltNbr').text(flts[0].substring(0,4)+flts[1]);
			}else{
				//$("#flt_nbr_Count").html('<option>'+flts[0]+'/'+flts[0].substring(0,5)+flts[1]+'</option>');
				$('#backFltNbr').text(flts[0].substring(0,5)+flts[1]);
			}
		}
		var flt_nbr_Count = flight;
		if(cds.length==3){
			$.ajax({
				url:'/restful/getExchangereprot',
				type:'get',
				dataType : 'jsonp',
				data:{
					dpt_AirPt_Cd :airports[cds[0]].iata,
		        	Arrv_Airpt_Cd:airports[cds[2]].iata,
		        	pas_stp:airports[cds[1]].iata,
		        	flt_nbr_Count:flt_nbr_Count
				},
				async:false,
				success:function(data){
					if(data!=null&&data.success!=null){
						if($(".change-line-o").hasClass("change-line-o2")){
							$(".change-line-o").removeClass("change-line-o2");
							$(".change-line").removeClass("change-line2");
						};
						if(typeof(data.success.Pas_stp_code)=="undefined"){
							$(".change-line-o").addClass("change-line-o2");
							$(".change-line").addClass("change-line2");
						}
			    		$('#cityChoice').val(data.success.Dpt_AirPt_Cd);
			    		$('#cityChoice3').val(data.success.Pas_stp);
			    		$('#cityChoice2').val(data.success.Arrv_Airpt_Cd);
			    		var dptabbr = data.success.Dpt_AirPt_Cd + "-" + data.success.Dpt_AirPt_Cd_code;
						var pstabbr = data.success.Pas_stp + "-" + data.success.Pas_stp_code;
						var arrabbr = data.success.Arrv_Airpt_Cd + "-" + data.success.Arrv_Airpt_Cd_code;
						$('#cityChoice').attr("abbr",dptabbr);
						$('#cityChoice3').attr("abbr",pstabbr);
						$('#cityChoice2').attr("abbr",arrabbr);
						$('#departureItia').text(data.success.Dpt_AirPt_Cd_code);
						$('#departureCity').text(data.success.Dpt_AirPt_Cd);
						$('#passItia').text(data.success.Pas_stp_code);
						$('#passCity').text(data.success.Pas_stp);
						$('#arriveItia').text(data.success.Arrv_Airpt_Cd_code);
						$('#arriveCity').text(data.success.Arrv_Airpt_Cd);
						getFlt_Nbr();
					}
				}
			});
		}else{
			$.ajax({
				url:'/restful/getExchangereprot',
				type:'get',
				dataType : 'jsonp',
				data:{
					dpt_AirPt_Cd :airports[cds[0]].iata,
		        	Arrv_Airpt_Cd:airports[cds[1]].iata,
		        	flt_nbr_Count:flt_nbr_Count
				},
				async:false,
				success:function(data){
					if(data!=null&&data.success!=null){
						if($(".change-line-o").hasClass("change-line-o2")){
							$(".change-line-o").removeClass("change-line-o2");
							$(".change-line").removeClass("change-line2");
						};
						if(typeof(data.success.Pas_stp_code)=="undefined"){
							$(".change-line-o").addClass("change-line-o2");
							$(".change-line").addClass("change-line2");
						}
						$('#cityChoice').val(data.success.Dpt_AirPt_Cd);
			    		$('#cityChoice2').val(data.success.Arrv_Airpt_Cd);
			    		var dptabbr = data.success.Dpt_AirPt_Cd + "-" + data.success.Dpt_AirPt_Cd_code;
						var arrabbr = data.success.Arrv_Airpt_Cd + "-" + data.success.Arrv_Airpt_Cd_code;
						$('#cityChoice').attr("abbr",dptabbr);
						$('#cityChoice2').attr("abbr",arrabbr);
						$('.change-line-o').css('display','none');
						$('#departureItia').text(data.success.Dpt_AirPt_Cd_code);
						$('#departureCity').text(data.success.Dpt_AirPt_Cd);
						$('#arriveItia').text(data.success.Arrv_Airpt_Cd_code);
						$('#arriveCity').text(data.success.Arrv_Airpt_Cd);
						getFlt_Nbr();
					}
				}
			});
		}
	}
	getDates($('.checkFlt').text(),1);
    send();
/***********************************************canvas区域************************************/
    /***各种封装****/
	$('.checkBtn').on('click',function(){
		$('.checkBtn').each(function(){
			$(this).removeClass('checkFlt');
		});
		$(this).addClass('checkFlt').css({"background-color":"#5a7aa9","color":"white"}).siblings().css({"background-color":"#e0dedf","color":"black"});
        send($(this).text());
	});
    $(window).resize(function(){
        mid();
    });
    changeCK();
    changew();
    /*日历控件*/
    $("body").on("click",".hasData",function(){
    	$('.set-border').css('outline','1px solid #f5f5f5');
    	$('.set-border').removeClass('set-border');
        $(this).parent().children().each(function(){
        	$(this).addClass('set-border');
        });
        currentWeekDate = $('.achieve-year').text()+'-'+$('.achieve-month').text()+'-'+$(this).text();
        $('.set-border').css('outline','none');
        $('.checkFlt').removeClass('checkFlt');
    	$('#income-set .checkBtn:nth-child(2)').addClass('checkFlt');
        send($('.checkFlt').text());
    });
    var objs={
        back:function(){
        	getFlt_Nbr();
        }
    };
    oub = objs;
    airControl(".selectCity",objs);
});
function getDates(flt,type){
	var dpt_AirPt_Cd = $('#cityChoice').val();
	if(dpt_AirPt_Cd!=''){
		dpt_AirPt_Cd = airports[dpt_AirPt_Cd].iata;
	}
	var Arrv_Airpt_Cd = $('#cityChoice2').val();
	if(Arrv_Airpt_Cd!=''){
		Arrv_Airpt_Cd = airports[Arrv_Airpt_Cd].iata;
	}
	var pas_stp = $('#cityChoice3').val();
	if(pas_stp!=''){
		pas_stp = airports[pas_stp].iata;
	}
	var flt_nbr_Count = flt;
	if(typeof(flt)=='undefined'||flt=='往返'){
		flt_nbr_Count = $('._set-list-title').text();
		if(flt_nbr_Count==null||flt_nbr_Count==''){
			$('.this-month').each(function(){
				for(var i=0;i<100;i++){
					$(this).removeClass('hasData');
				}
			});
			return;
		}
	}
	var exceptionData = 'no';
	//判断异常数据是否选中
	if($('#exceptionData').is(':checked')==true){
		exceptionData = 'on';
	}
	var month = '';
	if(type==1){
		if($('.achieve-year').text()!=''&&$('.achieve-month').text()!=''){
			month = $('.achieve-year').text()+'-'+(parseInt($('.achieve-month').text())>9?$('.achieve-month').text():'0'+$('.achieve-month').text());
		}
	}
	$.ajax({
		url:'/getDates',
		type:'post',
		data:{
			dpt_AirPt_Cd :dpt_AirPt_Cd,
        	Arrv_Airpt_Cd:Arrv_Airpt_Cd,
        	pas_stp:pas_stp,
        	month:month,
        	flt_nbr_Count:flt_nbr_Count,
        	isIncludeExceptionData:exceptionData
		},
		async:false,
		success:function(data){
			if(data!=null){
				if(typeof(data.month)=='undefined'){
					if(data.list!=null&&data.list.length>0){
						var currentMonth = currentWeekDate.split('-');
						var month = $('.achieve-year').text()+'-'+$('.achieve-month').text();
						if(month==currentMonth[0]+'-'+currentMonth[1]){
							$('.this-month').each(function(){
								for(var i=0;i<data.list.length;i++){
									if(parseInt($(this).text())==data.list[i]){
										$(this).addClass('hasData');
										if(data.list[i]==parseInt(currentMonth[2])){//当前选择的一周
											$(this).parent().children().each(function(){
									        	$(this).addClass('set-border');
									        });
											$('.set-border').css('outline','none');
										}
									}
								}
							});
						}else{
							$('.this-month').each(function(){
								for(var i=0;i<data.list.length;i++){
									if(parseInt($(this).text())==data.list[i]){
										$(this).addClass('hasData');
									}
								}
							});
						}
					}
				}else{
					if(data.month!=null){
						if(data.list!=null&&data.list.length>0){
							//去掉原有日历控件-start
							$('.choose').remove();
							$('.calendar').remove();
							//去掉原有日历控件-end
							var month=data.month.split('-');
							$(".time-line").before("<div class='choose'>" +
									//"<h3 class='choose-title'>销售报表</h3>" +
									"<div class='choose-set'>" +
									"<div>" +
									"<div class='choose-font-top choose-year-top'>&#xe663;</div>" +
									"<div class='choose-time achieve-year'>"+month[0]+"</div>" +
									"<div class='choose-font-bottom choose-year-bottom'>&#xe664;</div>" +
									"</div>" +
									"<div>年 </div>" +
									"<div>" +
									"<div class='choose-font-top choose-month-top'>&#xe663;</div>" +
									"<div class='choose-time achieve-month'>"+parseInt(month[1])+"</div>" +
									"<div class='choose-font-bottom choose-month-bottom'>&#xe664;</div>" +
									"</div>" +
									"</div>" +
									"</div>" +
									"<div class='calendar'></div>");
							addE(data.month);
							$('.this-month').each(function(){
								for(var i=0;i<data.list.length;i++){
									if(parseInt($(this).text())==data.list[i]){
										$(this).addClass('hasData');
										if(i==data.list.length-1){//当前月有数据的最后一天
											currentWeekDate = month[0]+'-'+parseInt(month[1])+'-'+data.list[i];
											$(this).parent().children().each(function(){
									        	$(this).addClass('set-border');
									        });
											$('.set-border').css('outline','none');
										}
									}
								}
							});
						}
					}else{
						alert('当前条件下没有数据');
					}
				}
			}else{
				alert('服务器异常，请稍后再试');
			}
		}
	});
}
function changeFltNbr(){
	var flt_nbr_Count = $('._set-list-title').html();
	flt_nbr_Count = flt_nbr_Count.split('/');
	$('#goFltNbr').text(flt_nbr_Count[0]);
	$('#backFltNbr').text(flt_nbr_Count[1]);
}
function getFlt_Nbr(){
	var dpt_AirPt_Cd = typeof(airports[$('#cityChoice').val()])=='undefined'?'':airports[$('#cityChoice').val()].iata;
	var pas_stp = typeof(airports[$('#cityChoice3').val()])=='undefined'?'':airports[$('#cityChoice3').val()].iata;
	var arrv_Airpt_Cd = typeof(airports[$('#cityChoice2').val()])=='undefined'?'':airports[$('#cityChoice2').val()].iata;
	if(searchJson.dpt_AirPt_Cd!=dpt_AirPt_Cd||pas_stp!=searchJson.pas_stp||arrv_Airpt_Cd!=searchJson.arrv_Airpt_Cd){
		searchJson.dpt_AirPt_Cd = dpt_AirPt_Cd;
		searchJson.pas_stp = pas_stp;
		searchJson.arrv_Airpt_Cd = arrv_Airpt_Cd;
	}else{
		return;
	}
//	searchJson.dpt_AirPt_Cd = typeof(airports[$('#cityChoice').val()])=='undefined'?'':airports[$('#cityChoice').val()].iata;
//	searchJson.pas_stp = typeof(airports[$('#cityChoice3').val()])=='undefined'?'':airports[$('#cityChoice3').val()].iata;
//	searchJson.arrv_Airpt_Cd = typeof(airports[$('#cityChoice2').val()])=='undefined'?'':airports[$('#cityChoice2').val()].iata;
	//表示只查询航线下的航班号的标识。
	searchJson.isFltAir = "true";
	$.ajax({
        type:'post',
        url:'getHbh',//请求数据的地址	
        data:getairCode(searchJson),
        async:false,
        success:function(data){
        	var dats = new Array();
            if(data!=null&&data.list!=null&&data.list.length>0){
            	for(var index in data.list){
                	dats.push(data.list[index]);
                }
            }
            var list={
        	        data:dats, //st节点集合
        	        summary:"false", //是否包含往返 true包含false不包含
        	        name:"._set-list-set",  //添加list节点
        	        cleName:".sr-box",   //取消绑定事件函数节点
        	        flyNbr :flight,
        	        fun:function(){
        	        	var flt_nbr_Count = $('._set-list-title').html();
        	        	flt_nbr_Count = flt_nbr_Count.split('/');
        	        	$('#goFltNbr').text(flt_nbr_Count[0]);
        	        	$('#backFltNbr').text(flt_nbr_Count[1]);
        	        	$('.checkFlt').removeClass('checkFlt');
        	        	$('#income-set .checkBtn:nth-child(2)').addClass('checkFlt');
        	        	getDates($('.checkFlt').text(),2);
        	        	send($('.checkFlt').text());
        	        }
        	    };
        	setChoose(list);
        }
    });
}
function send(flt){
	var dpt_AirPt_Cdtemp = $('#cityChoice').val();
	var pas_stptemp = $('#cityChoice3').val();
	var arrv_Airpt_Cdtemp = $('#cityChoice2').val();
	var flt_nbr_Counttemp = $('._set-list-title').text();
	//关闭所有选择框
	$(".sr-box-body-chart").removeClass("muhu");
	$(".reportErr").css("display","none");
	$(".time-line").css("display","block");
	$(".c-selectCity").nextAll().remove();
	$("._set-allList").css({"display":"none"});
	var dpt_AirPt_Cd = $('#cityChoice').val();
	if(dpt_AirPt_Cd!=''){
		dpt_AirPt_Cd = airports[dpt_AirPt_Cd].iata;
	}else{
		alert('请选择起始机场');
		$(".sr-box-body-chart").addClass("muhu");
		$(".reportErr").css("display","block");
		$(".time-line").css("display","none");
		getDates($('.checkFlt').text(),2);
		return;
	}
	var Arrv_Airpt_Cd = $('#cityChoice2').val();
	if(Arrv_Airpt_Cd!=''){
		Arrv_Airpt_Cd = airports[Arrv_Airpt_Cd].iata;
	}else{
		alert('请选择到达机场');
		$(".sr-box-body-chart").addClass("muhu");
		$(".reportErr").css("display","block");
		$(".time-line").css("display","none");
		getDates($('.checkFlt').text(),2);
		return;
	}
	//查询条件联动
	
	var object = parent.supData;
	if(pas_stptemp!=""){
		object.lane =dpt_AirPt_Cdtemp + "=" + pas_stptemp + "=" + arrv_Airpt_Cdtemp ;
	}else{
		object.lane =dpt_AirPt_Cdtemp + "=" + arrv_Airpt_Cdtemp ;
	}
	if(flt_nbr_Counttemp!=""){
		var flttemp = flt_nbr_Counttemp.split("/");
		var ff = flttemp[0]+"/"+flttemp[1].substring(flttemp[1].length-2,flttemp[1].length);
		object.flight = ff;
	}
	var pas_stp = $('#cityChoice3').val();
	if(pas_stp!=''){
		pas_stp = airports[pas_stp].iata;
	}
	var flt_nbr_Count = flt;
	if(typeof(flt)=='undefined'||flt=='往返'){
		flt_nbr_Count = $('._set-list-title').text();
		if(flt_nbr_Count==null||flt_nbr_Count==''){
			alert("没有对应的航班号！");
			$(".sr-box-body-chart").addClass("muhu");
    		$(".reportErr").css("display","block");
    		$(".time-line").css("display","none");
    		getDates($('.checkFlt').text(),2);
			return;
		}
		//默认选中往返
        $("#income-set").find("li").eq(0).css("background-color","rgb(224, 222, 223)");
        $("#income-set").find("li").eq(1).css("background-color","rgb(90, 122, 169)");
        $("#income-set").find("li").eq(2).css("background-color","rgb(224, 222, 223)");
        $("#income-set").find("li").eq(0).css("color","black");
        $("#income-set").find("li").eq(1).css("color","white");
        $("#income-set").find("li").eq(2).css("color","black");
	}
	var exceptionData = 'no';
	//判断异常数据是否选中
	if($('#exceptionData').is(':checked')==true){
		exceptionData = 'on';
	}
	var start = 0;
	var  end =0;
	$('.set-border').each(function(e){
		var millisecond = new Date($(this).attr('abbr')).getTime();
		if(start == 0){
			start = millisecond;
		}else if(start>millisecond){
			start = millisecond;
		}
		if(end == 0){
			end = millisecond;
		}else if(end < millisecond){
			end = millisecond;
		}
	});
	var firstDay = '';
	var lastDay = '';
	firstDay = new Date(start).format("yyyy-MM-dd");
	lastDay = new Date(end).format("yyyy-MM-dd");
	
	//获取页面参数
	$.ajax({
        type:'get',
        url : '/restful/getWeekReportDataNew',
        dataType : 'jsonp',
        data:{
        	dpt_AirPt_Cd :dpt_AirPt_Cd,
        	Arrv_Airpt_Cd:Arrv_Airpt_Cd,
        	pas_stp:pas_stp,
        	flt_nbr_Count:flt_nbr_Count,
        	startTime:firstDay,
        	endTime:lastDay,
        	isIncludeExceptionData:exceptionData
        },
        success : function(data) {
            if(data){
            	//判定航班号组成，构造航线
            	if(flt_nbr_Count.indexOf('/')>-1){
            		fakeCss('.change-line-o:before,.change-line-l::before{content:"\\e683"}');
            	}else{
            		//取单一航班号最后一位数
            		var lastChar = flt_nbr_Count.substring(flt_nbr_Count.length-1);
            		//奇数为去程，偶数为返程
            		if(parseInt(lastChar)%2==0){
            			fakeCss('.change-line-o:before,.change-line-l::before{content:"\\e697"}');
            		}else{
            			fakeCss('.change-line-o:before,.change-line-l::before{content:"\\e698"}');
            		}
            	}
            	if(data.success.goNum!=""&&data.success.backNum!=""){
            		$('#goFltNbr').text(data.success.goNum);
                	$('#backFltNbr').text(data.success.backNum);
            	}
                saveData=data;
                mid(data);
                if(data.success.map.hbys=="0.00"){
                	$(".sr-box-body-chart").addClass("muhu");
            		$(".reportErr").css("display","block");
            		$(".time-line").css("display","none");
            		getDates($('.checkFlt').text(),2);
                }
            }
        },
        error : function() {

        }
    });
}
function fakeCss(t){
	s=document.createElement('style');
	s.innerText=t;
	document.body.appendChild(s);
}
function mid(data){//控制函数
	if(data!=null&&data.success.map!=null){
		$('#weekIncome').text((typeof(data.success.map.hbys)=='undefined'||data.success.map.hbys==null||data.success.map.hbys=='')?0.00:$.digitization(data.success.map.hbys));
		$('#hourIncome').text((typeof(data.success.map.xsys)=='undefined'||data.success.map.xsys==null||data.success.map.xsys=='')?0.00:$.digitization(data.success.map.xsys));
		$('#raskIncome').text((typeof(data.success.map.zgl)=='undefined'||data.success.map.zgl==null||data.success.map.zgl=='')?0.00:data.success.map.zgl);
		$('#weekAvgPlf').text((typeof(data.success.map.kzl)=='undefined'||data.success.map.kzl==null||data.success.map.kzl=='')?0.00+'%':data.success.map.kzl+'%');
		$('#weekAvgDis').text((typeof(data.success.map.zk)=='undefined'||data.success.map.zk==null||data.success.map.zk=='')?0.00+'%':data.success.map.zk+'%');
		$("#weekTotalPC").text($.digitization(((typeof(data.success.map.skzrs)=='undefined'||data.success.map.skzrs==null||data.success.map.skzrs=='')?0:parseInt(data.success.map.skzrs))+((typeof(data.success.map.stzrs)=='undefined'||data.success.map.stzrs==null||data.success.map.stzrs=='')?0:parseInt(data.success.map.stzrs))));
//		$('.bc').text('计划班次：'+((typeof(data.success.planClass)=='undefined'||data.success.planClass==null||data.success.planClass=='')?0:$.digitization(data.success.planClass))+'班/实际班次：'+((typeof(data.success.executiveClass)=='undefined'||data.success.executiveClass==null||data.success.executiveClass=='')?0:$.digitization(data.success.executiveClass))+'班');
		$('.bc').text('实际班次：'+((typeof(data.success.executiveClass)=='undefined'||data.success.executiveClass==null||data.success.executiveClass=='')?0:$.digitization(data.success.executiveClass))+'班');
		legentArray = [];
		var incomeArray = [];
		var plfArray = [];
		var disArray = [];
		pcArray = [];
		var hourIncomeArray = [];
		var raskArray = [];
		var incomeOldArray = [];
		var plfOldArray = [];
		var disOldArray = [];
		pcOldArray = [];
		pcFit = [];
		pcGrp = [];
		pcOldFit = [];
		pcOldGrp = [];
		weekDataArray = [];
		pieArray = [(typeof(data.success.map.stzrs)=='undefined'||data.success.map.stzrs==null||data.success.map.stzrs=='')?0:parseInt(data.success.map.stzrs),(typeof(data.success.map.skzrs)=='undefined'||data.success.map.skzrs==null||data.success.map.skzrs=='')?0:parseInt(data.success.map.skzrs)];
		var showContentArray = new Map();
		if(data.success.map.data!=null){
			for(var key in data.success.map.data){
				var axis = key;
				var axises = axis.split('-');
        		legentArray.push(axises[1]+'\n'+weekDay[parseInt(axises[0])-1]);
        		var obj = data.success.map.data[key];
        		showContentArray[axises[1]+'\n'+weekDay[parseInt(axises[0])-1]] = '航班营收：'+$.digitization(obj.hbys)+'<br/>小时营收：'+$.digitization(obj.xssr)+'<br/>座公里收入：'+obj.set_Ktr_Ine;
        		incomeArray.push(parseFloat(obj.hbys).toFixed(2));
        		hourIncomeArray.push(obj.xssr);
        		raskArray.push(obj.set_Ktr_Ine);
        		plfArray.push(parseFloat(obj.pjkzl).toFixed(2));
        		disArray.push(parseFloat(obj.avg_Dct).toFixed(2));
        		pcFit.push(parseInt(obj.wak_tol_Nbr));
        		pcGrp.push(parseInt(obj.grp_Nbr));
        		weekDataArray[axises[1]] = [parseInt(obj.grp_Nbr),parseInt(obj.wak_tol_Nbr)];
        		pcArray.push(parseInt(obj.grp_Nbr)+parseInt(obj.wak_tol_Nbr));
        	}
			if(data.success.map.olddata!=null){
				for(var key in data.success.map.olddata){
					var obj = data.success.map.olddata[key];
					incomeOldArray.push(parseFloat(obj.hbys).toFixed(2));
					plfOldArray.push(parseFloat(obj.pjkzl).toFixed(2));
					disOldArray.push(parseFloat(obj.avg_Dct).toFixed(2));
					pcOldFit.push(parseInt(obj.wak_tol_Nbr));
					pcOldGrp.push(parseInt(obj.grp_Nbr));
					pcOldArray.push(parseInt(obj.grp_Nbr)+parseInt(obj.wak_tol_Nbr));
				}
			}else{
				for(var i=0; i<raskArray.length;i++){
					incomeOldArray.push(parseFloat(0).toFixed(2));
					plfOldArray.push(parseFloat(0).toFixed(2));
					disOldArray.push(parseFloat(0).toFixed(2));
					pcOldFit.push(parseFloat(0).toFixed(2));
					pcOldGrp.push(parseFloat(0).toFixed(2));
					pcOldArray.push(parseFloat(0).toFixed(2));
				}
			}
            var name="income"; //收入信息
            theNewCurve(name,legentArray,incomeArray,incomeOldArray,showContentArray);
            var name="avg_set_ine"; //综合客座率
            theCurve(name,legentArray,plfArray,plfOldArray);
            var name="person_dct"; //平均折扣
            theCurve(name,legentArray,disArray,disOldArray);
            weekThourthReport(pcname,legentArray,pcArray,pcOldArray);
            weekFivthReport(piename,pieArray);
            changew();  //重新计算大小
		}else{
			var name="income"; //收入信息
            theNewCurve(name,legentArray,incomeArray,incomeOldArray,showContentArray);
            var name="avg_set_ine"; //综合客座率
            theCurve(name,legentArray,plfArray,plfOldArray);
            var name="person_dct"; //平均折扣
            theCurve(name,legentArray,disArray,disOldArray);
//            var name="p-number";   //人数-柱状图
            weekThourthReport(pcname,legentArray,pcArray,pcOldArray);
//            var name="combined";   //人数-饼图
            weekFivthReport(piename,pieArray);
		}
	}
}
/**********************绘图函数*********echarts******************/
/*均线图*/
function theCurve(name,axisArray,info,oldinfo){
	
    var dom = document.getElementById(name);
    var myChart = echarts.init(dom);
    option = {
        grid: {
            left: '4%',
            right: '20%',
            bottom: '5%',
            containLabel: true
        },
        tooltip : {
            trigger: 'axis',
            formatter:function(params){
            	if(typeof(params.length)=='number'){
            		return typeof(params[0].value)=='undefined'?'':params[0].value+'%';
            	}else{
            		return params.name+':'+params.value+'%';
            	}
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        calculable : true,
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: axisArray,
            silent:true,
            axisLine:{
                show:true,
                lineStyle:{
                    color:"#2e416c"
                }
            },
            splitLine:{
                show:true,
                lineStyle:{
                    color:"#304b76",
                    opacity:0.6
                }
            },
            axisLabel:{
           	 	interval:0,
	           	 textStyle:{
	                 color:"white"
	             }
           }
        },
        yAxis : [
            {
                type : 'value',
                axisLine:{
                    show:false,
                    onZero:false
                },
                axisLabel:{
                    show:false
                },
                splitLine:{
                    show:false
                },
                axisTick:{
                    show:false
                }
            }
        ],
        series : [
            {
                name: "本周",
                type: 'line',
                smooth:true,
                label: {
                    normal: {
                        show: false,
                        position: 'top'
                    }
                },
                symbol:'circle',
                symbolSize:'10',
                lineStyle: {
                    normal: {
                        width: 4,
                        color: '#d85332'
                    }
                },
                data: info,
                markLine: {
                    data: [
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: '本周平均',
                                    color:"#d85332"
                                }
                            },
                            lineStyle:{
                                normal:{
                                    color:"#d95330"
                                }
                            }
                        }
                    ]
                }
            },
            {
                name: "上周",
                type: 'line',
                smooth:true,
                label: {
                    normal: {
                        show: false,
                        position: 'top'
                    }
                },
                symbol:'circle',
                symbolSize:'0',
                lineStyle: {
                    normal: {
                        width: 0,
                        color: '#bd5741'
                    }
                },
                data: oldinfo,
                markLine: {
                    data: [
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: ''
                                }
                            }},
                            {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: '上周平均'
                                }
                            },
                            lineStyle:{
                                normal:{
                                    color:"#87c4e1"
                                }
                            }
                        }
                    ]
                }
            }
        ]
    };
    myChart.setOption(option,true);
};

/*均线图*/
function theNewCurve(name,axisArray,info,oldinfo,content){
	
    var dom = document.getElementById(name);
    var myChart = echarts.init(dom);
    option = {
        grid: {
            left: '4%',
            right: '20%',
            bottom: '5%',
            containLabel: true
        },
        tooltip : {
            trigger: 'axis',
            formatter:function(params){
            	if(typeof(params.length)=='number'){
            		return content[params[0].name];
            	}else{
            		return params.name+':'+$.digitization(params.value);
            	}
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        calculable : true,
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: axisArray,
            silent:true,
            axisLine:{
                show:true,
                lineStyle:{
                    color:"#2e416c"
                }
            },
            splitLine:{
                show:true,
                lineStyle:{
                    color:"#304b76",
                    opacity:0.6
                }
            },
            axisLabel:{
           	 	interval:0,
	           	textStyle:{
	                 color:"white"
	            }
           }
        },
        yAxis : [
            {
                type : 'value',
                axisLine:{
                    show:false,
                    onZero:false
                },
                axisLabel:{
                    show:false
                },
                splitLine:{
                    show:false
                },
                axisTick:{
                    show:false
                }
            }
        ],
        series : [
            {
                name: "本周",
                type: 'line',
                smooth:true,
                label: {
                    normal: {
                        show: false,
                        position: 'top'
                    }
                },
                symbol:'circle',
                symbolSize:'10',
                lineStyle: {
                    normal: {
                        width: 4,
                        color: '#d85332'
                    }
                },
                data: info,
                markLine: {
                    data: [
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: '本周平均',
                                    color:"#d85332"
                                }
                            },
                            lineStyle:{
                                normal:{
                                    color:"#d95330"
                                }
                            }
                        }
                    ]
                }
            },
            {
                name: "上周均班",
                type: 'line',
                smooth:true,
                label: {
                    normal: {
                        show: false,
                        position: 'top'
                    }
                },
                symbol:'circle',
                symbolSize:'0',
                lineStyle: {
                    normal: {
                        width: 0,
                        color: '#bd5741'
                    }
                },
                data: oldinfo,
                markLine: {
                    data: [
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: ''
                                }
                            }},
                            {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: '上周平均'
                                }
                            },
                            lineStyle:{
                                normal:{
                                    color:"#87c4e1"
                                }
                            }
                        }
                    ]
                }
            }
        ]
    };
    myChart.setOption(option,true);
};

/*柱状图*/
function weekThourthReport(id,axisArray,info,oldInfo){
    var dom = document.getElementById(id);
    //用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
    var myChart = echarts.init(dom);
    option = {
        grid: {
            left: '4%',
            right: '20%',
            bottom: '5%',
            containLabel: true
        },
        tooltip: {
            trigger: 'item',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            },
            formatter:function(params){
            	if(typeof(params.length)=='number'){
            		return $.digitization(params[0].value);
            	}else{
            		if("平均值"===params.name){
            			return params.name+':'+$.digitization(params.value);
            		}
            		return $.digitization(params.value)
            	}
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        toolbox: {
            show: false
        },
        xAxis:  {
            type: 'category',
            boundaryGap: false,
            data: axisArray,
            axisTick: {
                alignWithLabel: true
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#283d68'
                }
            },
            axisLabel:{
           	 	interval:0,
	           	textStyle:{
	                 color:"white"
	            }
           }
        },
        yAxis: {
            show:false,
            type: 'value',
            axisLabel: {
                formatter: '{value} °C',
	           	textStyle:{
	                 color:"white"
	            }
            }
        },
        series: [
            {
                name:'本周均班',
                type:'bar',
                stack:'total',
                label:{
                    normal:{
                        position:'top'
                    }
                },
                barWidth: 20,
                symbol:'circle',
	           	symbolSize:'10',
                itemStyle:{
                    normal:{
                        color:'#d85430',
                        label : {show: true, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                data:info,
                markLine: {
                    data: [
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: ''
                                }
                            }},
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: '  本周平均'
                                }
                            }}
                    ]
                }
            },
            {
                name: "上周均班",
                type: 'line',
                smooth:true,
                label: {
                    normal: {
                        show: false,
                        position: 'top'
                    }
                },
                symbol:'circle',
                symbolSize:'0',
                lineStyle: {
                    normal: {
                        width: 0,
                        color: '#bd5741'
                    }
                },
                data: oldInfo,
                markLine: {
                    data: [
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: ''
                                }
                            }},
                        {
                            type: 'average',
                            name: '平均值',
                            label: {
                                normal: {
                                    position: 'end',
                                    formatter: '  上周平均'
                                }
                            },
                            lineStyle:{
                                normal:{
                                    color:"#7ec0da"
                                }
                            }
                        }
                    ]
                }
            }
        ]
    };
    myChart.setOption(option,true);
    myChart.on("mouseover",function(parmes){
    	if(parmes.seriesName=="本周均班"&&parmes.name.indexOf('\n')>-1){
    		var key = parmes.name.split('\n')[0];
    		weekFivthReport(piename,weekDataArray[key]);
    	}
    });
    myChart.on("mouseout",function(parmes){
    	weekFivthReport(piename,pieArray);
    });
}
/*饼状图*/
function weekFivthReport(id,weekData){
	var pcData = [];
	pcData.push({value:weekData[0], name:'团队总人数',selected:true,itemStyle:{normal:{color:'#1470c5',}}});
	pcData.push({value:weekData[1], name:'散客总人数',itemStyle:{normal:{color:'#64c7d9',}}});
    var dom = document.getElementById(id);
    //用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
    var myChart = echarts.init(dom);
    myChart.option = {
        tooltip: {
            trigger: 'item',
            formatter:function(params){
            	return params.name+'：'+params.value;
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            orient: 'vertical',
            left:"55%",
            itemWidth:10,
            itemHeight:10,
            textStyle:{color:'#fff'},
            data:['团队总人数','散客总人数'],
            formatter:function(params){
                if(params=='团队总人数'){
                    return params+'\n'+$.digitization(weekData[0])+'人';
                }else{
                    return params+'\n'+$.digitization(weekData[1])+'人';
                }
            }
        },
        series: [
            {
                name:'访问来源',
                type:'pie',
                selectedMode: 'single',
                radius: [0, '70%'],
                center:["25%","50%"],
//                silent:true,
                label: {
                    normal: {
                    	show:false,
                        position: 'center',
//                        formatter:function(params){
//                            if(params.dataIndex==1){
//                                return '合计';
//                            }
//                            return "";
//                        },
                        textStyle:{
                            fontSize:'20',
                            color:'#6aa2bd'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data:pcData
            }
        ]
    };
    myChart.setOption(myChart.option,true);
    myChart.on("mouseover",function(parmes){
    	if(parmes.name=="团队总人数"){
    		weekThourthReport(pcname,legentArray,pcGrp,pcOldGrp);
    	}else{
    		weekThourthReport(pcname,legentArray,pcFit,pcOldFit);
    	}
    });
    myChart.on("mouseout",function(parmes){
    	myChart.option.series[0].data[0].selected=true;
    	myChart.setOption(myChart.option,true);
    	weekThourthReport(pcname,legentArray,pcArray,pcOldArray);
    });
}
/*测各种块大小*/
function infer(name){
    var infer=[];
    infer.push(parseFloat($(name).css("width").split("px")[0]));
    infer.push(parseFloat($(name).css("height").split("px")[0]));
    infer.push(parseFloat($(name).css("margin-top").split("px")[0]));
    infer.push(parseFloat($(name).css("left").split("px")[0]));
    return infer;
}
//计算iframe的高度
function changeCK(){
	$(".sr-box-body").css("height",infer('body')[1]-39);
}
function changew(){
    /*计算中间块大小*/
    var Lwidth=infer(".sr-box-body-report")[0];
    var Zwidth=infer(".sr-box")[0];
    var Rwidth=infer(".sr-box-body-date")[0];
    var Swidth=Zwidth-Lwidth-Rwidth-2;
    $(".sr-box-body-chart").css("width",Swidth+"px");
    /*计算绘图区域大小*/
    var Cheight=infer(".sr-box-body-chart-income")[1]-infer(".p-height")[1]-infer(".p-height")[2]-infer(".d-height")[1]-44;
    var Cwidth=infer(".graph-table")[0];
    $(".graph-table").css("height",Cheight);
    $("#income").attr({"width":Cwidth,"height":Cheight});
    $("#avg_set_ine").attr({"width":Cwidth,"height":Cheight});
    $("#person_dct").attr({"width":Cwidth,"height":Cheight});
	$("#person_avg").attr({"width":Cwidth,"height":Cheight});
}
function getairCode(searchJson){
	if(searchJson.dpt_AirPt_Cd!=""){
		searchJson.dpt_AirPt_Cd = airports[searchJson.dpt_AirPt_Cd].iata;
	}
	if(searchJson.pas_stp!=""){
		searchJson.pas_stp = airports[searchJson.pas_stp].iata;
	}
	if(searchJson.arrv_Airpt_Cd!=""){
		searchJson.arrv_Airpt_Cd = airports[searchJson.arrv_Airpt_Cd].iata;
	}
	return  searchJson;
}