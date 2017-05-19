if(parent.supData.linFlag != "0"){
	delete parent.supData.flight;
}
var airLine = parent.supData.lane;
var airports = parent.airportMap;
var airFltNbr = parent.supData.flight;
var oldTime = "";
var information={};
var searchJson = {};
var flts = '';
if(typeof(airFltNbr)!='undefined'){
	flts = airFltNbr.split('/');
}
var flight = '';
if(flts.length>=2){
	flight = flts[0]+"/"+flts[0].substring(0,4)+flts[1];
}else{
	flight = "汇总";
}

$(function(){
	parent.supData.linFlag = "1"; 
//	changeDate('startEndDate');
	var objj = parent.supData;
	if(typeof(objj.isIncloudPasstp)!="undefined"){
		if(objj.isIncloudPasstp=="on"){
			$('#isIncludePasDpt').attr('checked',true);
		}
	}
	$("._set-query").click(function(e){
		e.stopPropagation(); //屏蔽事件冒泡
		send();
	}) ;
	$("#isIncludePasDpt").change(function(e){
		getFlt_Nbr();
	}) ;
	oldTime = $('#startEndDate').val();
	$("body").on("click","button",function(e){
		if($(this).hasClass("btn-success")){
			getFlt_Nbr();
		}
	}) ;
	setTimeout(function(){
		$('#startEndDate').daterangepicker(null, function(start, end, label) {});
	},1500);
	if(airLine!=null&&airLine!=""&&typeof(airLine)!='undefined'){
		var flt = parent.supData.flt;
		var cds = airLine.split("=");
		if('1'==flt){
//			$('#isIncludePasDpt').attr('checked',true);
			var dptabbr = cds[0] + "-" + airports[cds[0]].iata;
			var arrabbr = cds[1] + "-" + airports[cds[1]].iata;
			$('#cityChoice').attr("abbr",dptabbr);
			$('#cityChoice2').attr("abbr",arrabbr);
			$('#cityChoice').val(cds[0]);
			$('#cityChoice2').val(cds[1]);
		}else{
			if(cds.length==3){
				var dptabbr = cds[0] + "-" + airports[cds[0]].iata;
				var pstabbr = cds[1] + "-" + airports[cds[1]].iata;
				var arrabbr = cds[2] + "-" + airports[cds[2]].iata;
				$('#cityChoice').attr("abbr",dptabbr);
				$('#cityChoice3').attr("abbr",pstabbr);
				$('#cityChoice2').attr("abbr",arrabbr);
				$('#cityChoice').val(cds[0]);
				$('#cityChoice3').val(cds[1]);
				$('#cityChoice2').val(cds[2]);
				//变灰经停
				$('#divpas').addClass("_checkOp");
				$('#isIncludePasDpt').attr("disabled","disabled");
			}else{
				var dptabbr = cds[0] + "-" + airports[cds[0]].iata;
				var arrabbr = cds[1] + "-" + airports[cds[1]].iata;
				$('#cityChoice').attr("abbr",dptabbr);
				$('#cityChoice2').attr("abbr",arrabbr);
				$('#cityChoice').val(cds[0]);
				$('#cityChoice2').val(cds[1]);
			}
		}
	}
    $("._customers-nav").on("click","div",function(){
    	//2017-4-12	后面判断表格视窗关闭   --long
        if($(this).hasClass("_customers-nav-a") && $("._customers-box").css('display')!='none'){
            $(this).addClass("_set").siblings().removeClass("_set");
            var name=$(this).children().children().eq(0).text()+"-"+$(this).children().children().eq(2).text();
            draw(name);
            bar1(name);
            bar2(name,"total");
        }
        else{
        	return false;
        }
    });
    $('body').on('click','#isIncludePasDpt',function(){
//    	if($('#isIncludePasDpt').is(':checked')==true){
//    		getFlt_Nbr();
//    	}
    });
    var objs={
            back:function(){
        	if($('#cityChoice3').val()==""){
        		$('#divpas').removeClass("_checkOp");
        		$('#isIncludePasDpt').removeAttr("disabled");
        	}else{
        		$('#divpas').addClass("_checkOp");
				$('#isIncludePasDpt').attr("disabled","disabled");
        	}
        	getFlt_Nbr();
        }
    };
    oub = objs;
    airControl(".selectCity",objs);
    //判断是否从菜单进入功能页面--start
    if(parent.supData.flag==1){
    	parent.supData.flag=0;
    	return;
    }
    //判断是否从菜单进入功能页面--end
    var dpt_AirPt_Cd = typeof(airports[$('#cityChoice').val()])=='undefined'?'':airports[$('#cityChoice').val()].iata;
	var pas_stp = typeof(airports[$('#cityChoice3').val()])=='undefined'?'':airports[$('#cityChoice3').val()].iata;
	var arrv_Airpt_Cd = typeof(airports[$('#cityChoice2').val()])=='undefined'?'':airports[$('#cityChoice2').val()].iata;
	var isIncludePasDpt = "";
	if($('#isIncludePasDpt').is(':checked')==true){
		isIncludePasDpt = 'on';
	}
    setTimeout(function () {
    	$.ajax({
    	    type:'get',
    	    url : '/restful/getCustomerNewDate',
    	    data:{
    	    	dpt_AirPt_Cd :dpt_AirPt_Cd,
            	Arrv_Airpt_Cd: arrv_Airpt_Cd,
            	pas_stp:pas_stp,
            	isIncludePasDpt:isIncludePasDpt
    	    },
    	    dataType : 'jsonp',
    	    success : function(data) {
    	    	var date = data.success.newDate;
    	    	changeDate('startEndDate',date);
    	    	getFlt_Nbr();
    	    	send();
    	    }
    	});
    }, 500);
    addBar(".sr-box","._customers-box","._customers-box-c");
});
function getFlt_Nbr(){
	var dpt_AirPt_Cd = typeof(airports[$('#cityChoice').val()])=='undefined'?'':airports[$('#cityChoice').val()].iata;
	var pas_stp = typeof(airports[$('#cityChoice3').val()])=='undefined'?'':airports[$('#cityChoice3').val()].iata;
	var arrv_Airpt_Cd = typeof(airports[$('#cityChoice2').val()])=='undefined'?'':airports[$('#cityChoice2').val()].iata;
	var startEndDate = $('#startEndDate').val();
	if(searchJson.dpt_AirPt_Cd!=dpt_AirPt_Cd||pas_stp!=searchJson.pas_stp||arrv_Airpt_Cd!=searchJson.arrv_Airpt_Cd||oldTime!=startEndDate){
		searchJson.dpt_AirPt_Cd = dpt_AirPt_Cd;
		searchJson.pas_stp = pas_stp;
		searchJson.arrv_Airpt_Cd = arrv_Airpt_Cd;
	}else{
		return;
	}
	var time = $('#startEndDate').val().split(' - ');
	if(time==null||time.length==0){
		alert('请选择起止日期');
		return;
	}
	var lcl_Dpt_Tm = time[0];
	var lcl_Arrv_Tm = time[1];
	if(time.length!=2||
			checkDate(lcl_Dpt_Tm)==false||
			checkDate(lcl_Arrv_Tm)==false||
			(new Date(lcl_Dpt_Tm).getTime()-new Date(lcl_Arrv_Tm).getTime()>0)||
			(new Date(lcl_Arrv_Tm).getTime()-new Date(new Date().format('yyyy-MM-dd')).getTime()>0)){
	}
	var isIncludePasDpt = '';
	if($('#isIncludePasDpt').is(':checked')==true){
		isIncludePasDpt = 'on';
	}
	$.ajax({
        type:'post',
        url:'/getFltNbrList',//请求数据的地址	
        data:{
        	dpt_AirPt_Cd:dpt_AirPt_Cd,
        	arrv_Airpt_Cd:arrv_Airpt_Cd,
        	pas_stp:pas_stp,
        	lcl_Dpt_Tm:lcl_Dpt_Tm,
        	lcl_Arrv_Tm:lcl_Arrv_Tm,
        	isIncludePasDpt:isIncludePasDpt
        },
        async:false,
        success:function(data){
        	var dats = new Array();
            if(data!=null&&data.length>0){
            	for(var index in data){
                	dats.push(data[index]);
                }
            }
            var list={
    	        data:dats, //st节点集合
    	        summary:"true", //是否包含往返 true包含false不包含
    	        name:"._set-list-set",  //添加list节点
    	        cleName:".sr-box",   //取消绑定事件函数节点
    	        flyNbr :flight,
    	        fun:function(){
    	        }
    	    };
    	    setChoose(list);
        }
    });
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
/*测各种块大小*/
function infer(name){
	var infer=[];
	infer.push(parseFloat($(name).css("width").split("px")[0]));
	infer.push(parseFloat($(name).css("height").split("px")[0]));
	infer.push(parseFloat($(name).css("margin-top").split("px")[0]));
	infer.push(parseFloat($(name).css("left").split("px")[0]));
	infer.push(parseFloat($(name).css("top").split("px")[0]));
	return infer;
}
function reset(){
	$("._customers").css({"height":(infer(".sr-box")[1]-infer(".sr-box-head")[1]+"px")});
//	$("._customers-box").css({"width":(infer("._customers")[0]-infer("._customers-nav")[0]-infer(".sr-box-body-date")[0]-5)});
	$("._customers-box").css({"width":(infer("._customers")[0]-infer("._customers-nav")[0]-5)});
	
	//修改高度	2017-4-13 long
	let a =100 / $("._customers-nav-a").length;
	$("._customers-nav-a").css("height",a+"%");
/*	if($("._customers-nav-a").length==1){
		$("._customers-nav-a").css("height","100%");
	}else if($("._customers-nav-a").length==2){
		$("._customers-nav-a").css("height","50%");
	};
	var height=infer("._customers")[1]/2;
	$("#sample1").css({"height":height});
	$("#sample2").css({"height":height});
	$(".sample").css({"height":height});*/
	
}


/*ech*/
function draw(name){
	var dom = document.getElementById("sample1");
	var myChart = echarts.init(dom);
	
	/*绘制热点图map*/
	let a=JSON.stringify(information[name]);
	drawheatmap(a);
	/*改为前10*/
	information[name].cityName.length = information[name].cityName.length>10?10:information[name].cityName.length;
	information[name].people.length = information[name].people.length>10?10:information[name].people.length;	
	//information[name].cityName.length=10;
	//information[name].people.length=10;
	var option = {
			title: {
				text: "国内客源分布",
				left:'5%',
				top:'5%',
				textStyle:{
					color:"white",
					fontWeight:"normal"
				}
			},
			color: ['#3398DB'],
			tooltip : {
				trigger: 'axis',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				},
				show : true,
	            borderColor:'#7ebde8',
	            borderWidth:1
			},
			grid: {
				left: '3%',
				right: '4%',
				bottom: '7%',
				containLabel: true
			},
			xAxis : [
			         {
			        	 type : 'category',
			        	 data : information[name].cityName,
			        	 axisTick: {
			        		 alignWithLabel: true
			        	 },
			        	 axisLabel:{
			        		 interval:0,
			        		 rotate:45,
			        		 margin:10,
			        		 textStyle:{
			        			 color:"white"
			        		 }, 
			        		 formatter:function(params){
			        			 return params.substr(0,4);
			                 }
			        	 },
			        	 splitLine: {
			        		 show:true,
			        		 lineStyle:{
			        			 color:"#1b2c4c"
			        		 }
			        	 }
			         }
			         ],
			         yAxis : [
			                  {
			                	  type : 'value',
			                	  splitLine: {
			                		  show:false,
			                		  lineStyle:{
			                			  color:"#1b2c4c"
			                		  }
			                	  },
			                	  axisLabel:{
			                		  textStyle:{
			                			  color:"white"
			                		  }
			                	  }
			                  }
			                  ],
			                  series : [
			                            {
			                            	name:'人数',
			                            	type:'bar',
			                            	barWidth: '30%',
			                            	itemStyle: {
			                            		normal: {
			                            			color: new echarts.graphic.LinearGradient(
			                            					0, 0, 0, 1,
			                            					[
			                            					 {offset: 0, color: '#7ebce9'},
			                            					 {offset: 0.5, color: '#7fbce9'},
			                            					 {offset: 1, color: '#7fbce9'}
			                            					 ]
			                            			)
			                            		},
			                            	/*	emphasis: {
			                            			color: new echarts.graphic.LinearGradient(
			                            					0, 0, 0, 1,
			                            					[
			                            					 {offset: 0, color: '#4b5cb6'},
			                            					 {offset: 0.5, color: '#5076bf'},
			                            					 {offset: 1, color: '#5896c7'}
			                            					 ]
			                            			)
			                            		}*/
			                            	},
			                            	data:information[name].people
			                            }
			                            ]
	};
	myChart.setOption(option,true);

	
	drawlevel(name,information[name].cityName[0]);
	myChart.on("mouseover",function(params){
		drawlevel(name,params.name);
	});
}
function drawlevel(CityN,levelN){
	var data=[];
	var name=[];
	
	/*改为前10*/
	let biga = information[CityN].province[levelN].fr.length;
	biga=biga>10?10:biga;
	//information[CityN].province[levelN].fr.length = information[CityN].province[levelN].fr.length>10?10:information[CityN].province[levelN].fr.length;
	for(var i=0; i<biga;i++){
		data.push(information[CityN].province[levelN].fr[i][1]);
		name.push(information[CityN].province[levelN].fr[i][0]);
	}
	var dom = document.getElementById("sample2");
	var myChart = echarts.init(dom);
	var option = {
			title: {
				text: levelN+"客源分布",
				left:'5%',
				top:'5%',
				textStyle:{
					color:"white",
					fontWeight:"normal"
				}
			},
			color: ['#3398DB'],
			tooltip : {
				trigger: 'axis',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				},
				show : true,
				borderColor:'#7ebde8',
	            borderWidth:1
				
			},
			grid: {
				left: '3%',
				right: '4%',
				bottom: '7%',
				containLabel: true
			},
			xAxis : [
			         {
			        	 type : 'category',
			        	 data :name ,
			        	 axisTick: {
			        		 alignWithLabel: true
			        	 },
			        	 axisLabel:{
			        		 interval:0,
			        		 rotate:45,
			        		 margin:10,
			        		 textStyle:{
			        			 color:"white"
			        		 },
			        		 formatter:function(params){
			        			 return params.substr(0,4);
			                 }
			        	 },
			        	 splitLine: {
			        		 show:true,
			        		 lineStyle:{
			        			 color:"#1b2c4c"
			        		 }
			        	 }
			         }
			         ],
	         yAxis : [
	                  {
	                	  type : 'value',
	                	  splitLine: {
	                		  show:false,
	                		  lineStyle:{
	                			  color:"#1b2c4c"
	                		  }
	                	  },
	                	  axisLabel:{
	                		  textStyle:{
	                			  color:"white"
	                		  }
	                	  }
	                  }
	                  ],
              series : [
                        {
                        	name:'人数',
                        	type:'bar',
                        	barWidth: '30%',
                        	itemStyle: {
                        		normal: {
                        			color: new echarts.graphic.LinearGradient(
                        					0, 0, 0, 1,
                        					[
                        					 {offset: 0, color: '#7ebce9'},
                        					 {offset: 0.5, color: '#7fbce9'},
                        					 {offset: 1, color: '#7fbce9'}
                        					 ]
                        			)
                        		},
                        	/*	emphasis: {
                        			color: new echarts.graphic.LinearGradient(
                        					0, 0, 0, 1,
                        					[
                        					 {offset: 0, color: '#4b5cb6'},
                        					 {offset: 0.5, color: '#5076bf'},
                        					 {offset: 1, color: '#5896c7'}
                        					 ]
                        			)
                        		}*/
                        	},
                        	label:{
                        		position:'top'
                        	},
                        	data:data
                        }
                        ]
	};
	myChart.setOption(option,true);
	
}

function bar1(cityN){
	var dom = document.getElementById("sample3");
	var myChart = echarts.init(dom);
	var option = {
			title: [{
				text: "男女比例",
				left:'10%',
				top:'8%',
				textStyle:{
					color:"white",
					fontWeight:"normal"
				}
			}
			],
			tooltip: {
				trigger: 'item',
	            borderColor:'#7ebde8',
	            borderWidth:1,
				formatter: "{a} <br/>{b}: {d}% ({c}人)"
			},
			legend: {
				orient: 'vertical',
				x: '80%',
				y:"15%",
				data:['男','女'],
				textStyle:{
					color:"white"
				}
			},
			series: [
			         {
			        	 name:'比例',
			        	 type:'pie',
			        	 selectedMode: 'single',
			        	 radius: [0, '50%'],
			        	 label: {
			        		 normal: {
			        			 show:false,
			        			 position: 'inner'
			        		 }
			        	 },
			        	 labelLine: {
			        		 normal: {
			        			 show: false
			        		 }
			        	 },
			        	 data:[
			        	       {value:information[cityN].age.total.count[0], name:'男',itemStyle:{normal:{color:"#204e7f"}}},
			        	       {value:information[cityN].age.total.count[1], name:'女',itemStyle:{normal:{color:"#5479a3"}}}
			        	       ]
			         }
			         ]
	};
	myChart.setOption(option,true);
	myChart.on("click",function(params){
		if(params.name=="男"){
			if(params.data.selected==true){
				bar2(cityN,"man");
			}else {
				bar2(cityN,"total");
			}
		}else if(params.name=="女"){
			if(params.data.selected==true){
				bar2(cityN,"woman");
			}else {
				bar2(cityN,"total");
			}
		}
	});
}
function bar2(cityN,sex){
	var dataN=information[cityN].age.lineName;
	var dataV=[];
	for(var i=0;i<information[cityN].age[sex].line.length;i++){
		dataV.push({value:information[cityN].age[sex].line[i],name:information[cityN].age.lineName[i]});
	}
	var dom = document.getElementById("sample4");
	var myChart = echarts.init(dom);
	var option = {
			title: [{
				text: "年龄层次比例",
				left:'10%',
				top:'8%',
				textStyle:{
					color:"white",
					fontWeight:"normal"
				}
			}
			],
			tooltip: {
				trigger: 'item',
	            borderColor:'#7ebde8',
	            borderWidth:1,
				formatter: "{a} <br/>{b}: {d}% ({c}人)"
			},
			legend: {
				orient: 'vertical',
				x: '78%',
				y:"15%",
				data:dataN,
				textStyle:{
					color:"white"
				}
			},
			series: [
			         {
			        	 name:'年龄层次比例',
			        	 type:'pie',
			        	 selectedMode: 'single',
			        	 radius: [0, '50%'],
			        	 label: {
			        		 normal: {
			        			 show:false,
			        			 position: 'inner'
			        		 }
			        	 },
			        	 labelLine: {
			        		 normal: {
			        			 show: false
			        		 }
			        	 },
			        	 data:dataV
			         }
			         ]
	};
	myChart.setOption(option,true);
};
function addNav(){
	$("._customers-nav").html('');
	var el="";
	for(var key in information){
		el+="<div class='_customers-nav-a'> <div> <span>"+key.split("-")[0]+"</span> <span>&#xe676;</span> <span>"+key.split("-")[1]+"</span> </div> </div>";
	}
	$("._customers-nav").html(el);
}
function controller(){
	addNav();
	reset();//算大小
	$("._customers-nav-a").eq(0).click();
}
var DATE_FORMAT = /^[0-9]{4}-[0-1]?[0-9]{1}-[0-3]?[0-9]{1}$/;
function checkDate(date){
var result = false;
 if(DATE_FORMAT.test(date)){
   result = true;
  }
 return result;
}
function send(){
//    getFlt_Nbr();
	//关闭所有选择框
	$(".c-selectCity ").on("input",function(){
		 getFlt_Nbr();
	}) ;
	$(".c-selectCity").nextAll().remove();
	$("._set-allList").css({"display":"none"});
	$('.opensright').css('display','none');
	var dpt_AirPt_Cd = $('#cityChoice').val();
	if(dpt_AirPt_Cd==null||dpt_AirPt_Cd==''){
		$("._customers").addClass("muhu");
		$(".err").css("display","block");
		alert('请选择起始机场');
		return;
	}
	var arrv_Airpt_Cd = $('#cityChoice2').val();
	if(arrv_Airpt_Cd==null||arrv_Airpt_Cd==''){
		$("._customers").addClass("muhu");
		$(".err").css("display","block");
		alert('请选择到达机场');
		return;
	}
	
	//查询条件联动
	var dpt_AirPt_Cdtemp = $('#cityChoice').val();
	var pas_stptemp = $('#cityChoice3').val();
	var arrv_Airpt_Cdtemp = $('#cityChoice2').val();
	var object = parent.supData;
	if(pas_stptemp!=""){
		object.lane =dpt_AirPt_Cdtemp + "=" + pas_stptemp + "=" + arrv_Airpt_Cdtemp ;
	}else{
		object.lane =dpt_AirPt_Cdtemp + "=" + arrv_Airpt_Cdtemp ;
	}
	if($('#isIncludePasDpt').is(':checked')==true){
		object.isIncloudPasstp = 'on';
	}else{
		delete object.isIncloudPasstp;
	}
	var pas_stp = $('#cityChoice3').val();
	var time = $('#startEndDate').val().split(' - ');
	if($('#startEndDate').val()==""||time==null||time.length==0){
		$("._customers").addClass("muhu");
		$(".err").css("display","block");
		alert('请选择起止日期');
		return;
	}
	var lcl_Dpt_Tm = time[0];
	var lcl_Arrv_Tm = time[1];
	if(time.length!=2||
			checkDate(lcl_Dpt_Tm)==false||
			checkDate(lcl_Arrv_Tm)==false||
			(new Date(lcl_Dpt_Tm).getTime()-new Date(lcl_Arrv_Tm).getTime()>0)||
			(new Date(lcl_Arrv_Tm).getTime()-new Date(new Date().format('yyyy-MM-dd')).getTime()>0)){
		$("._customers").addClass("muhu");
		$(".err").css("display","block");
		alert('结束日期不能大于当前日期！');
		return;
	}
	if(pas_stp!=''){
		if(dpt_AirPt_Cd==arrv_Airpt_Cd||dpt_AirPt_Cd==pas_stp||arrv_Airpt_Cd==pas_stp){
			$("._customers").addClass("muhu");
			$(".err").css("display","block");
//			alert('该航线不存在');
			return;
		}
	}else{
		if(dpt_AirPt_Cd==arrv_Airpt_Cd){
			$("._customers").addClass("muhu");
			$(".err").css("display","block");
//			alert('该航线不存在');
			return;
		}
	}
	var flt_nbr =$('._set-list-title').html();
	if(flt_nbr==null||flt_nbr==''){
		$("._customers").addClass("muhu");
		$(".err").css("display","block");
//		alert('没有相关航班号，请重新选择');
		return;
	}
	
	var isIncludePasDpt = '';
	if($('#isIncludePasDpt').is(':checked')==true){
		isIncludePasDpt = 'on';
	}
	
    $.ajax({    	
        url: '/getAllSourceDistriData',
        type: 'post',
        dataType: 'json',
        async:false,
        data:{
        	//dpt_AirPt_Cd:airports[dpt_AirPt_Cd].iata,
        	//arrv_Airpt_Cd:airports[arrv_Airpt_Cd].iata,
        	dpt_AirPt_Cd:airports[arrv_Airpt_Cd].iata,
        	arrv_Airpt_Cd:airports[dpt_AirPt_Cd].iata,
        	pas_stp:pas_stp==""?'':airports[pas_stp].iata,
        	flt_nbr:flt_nbr,
        	lcl_Dpt_Tm:lcl_Dpt_Tm,
        	lcl_Arrv_Tm:lcl_Arrv_Tm,
        	isIncludePasDpt:isIncludePasDpt
        }
    })
    .done(function(data) {
    	$("._customers").removeClass("muhu");
		$(".err").css("display","none");
    	information = {};
    	var flage = false;
    	if(data!=null&&data.length>0){
    		information={};
    		for(var i=0;i<data.length;i++){
    			if(data[i].dataMap!=null){
    			flage = true;
    			var segment = new Map();
    			var obj = data[i];
    			if(obj!=null){
    				var provinceMap = new Map();
            		var age = {};
            		var people = [];
            		var cityName = [];
            		var dataMap = obj.dataMap;
            		if(dataMap!=null){            			
            			for(var key in dataMap){
            				cityName.push(key);
            				var o= dataMap[key];
            				var provice = {};
            				if(o!=null&&o.length>0){
            					var zr=0;
            					var fr = [];
            					for(var j=0;j<o.length;j++){
            						var frArray =[];
            						zr+=o[j].number;
            						frArray.push(o[j].city);
            						frArray.push(o[j].number);
            						frArray.push(o[j].city_x);
            						frArray.push(o[j].city_y);            						
            						fr.push(frArray);
            					}
            					people.push(zr);
            					provice.zr = zr;
            					provice.fr = fr;
            				}
            				provinceMap[key] = provice;
            			}
            		}
            		var peopleStruct = obj.peopleStruct;
            		if(peopleStruct!=null){
            			var totalWomen = 0;
            			var totalMan = 0;
            			var totalline = [];
            			var total = {};
            			var totalcount = [];
            			var man = {};
            			var woman = {};
            			var manline = [];
            			var womanline = [];
            			var lineName = [];
            			for(var key in peopleStruct){
            				lineName.push(key);
            				var o = peopleStruct[key];
            				var mancount = o['男'];
            				var womancount = o['女'];
            				totalline.push(mancount+womancount);
            				manline.push(mancount);
            				womanline.push(womancount);
            				totalWomen+=womancount;
            				totalMan+=mancount;
            			}
            			totalcount.push(totalMan);
            			totalcount.push(totalWomen);
            			total.count=totalcount;
            			total.line=totalline;
            			man.line=manline;
            			woman.line=womanline;
            			age.man = man;
            			age.woman = woman;
            			age.total = total;
            			age.lineName = lineName;
            		}
            		segment.province = provinceMap;
            		segment.age = age;
            		segment.people =people;
            		segment.cityName =cityName;
    			}
    			
    			
    			
    			
    			
    			
    			
    			//自己根据后台逻辑装载航线该显示的分段---后台逻辑变了，这里肯定要变（与顺序逻辑一一对应的）
    			var airportName = parent.airportMap[parent.airportCode].aptChaNam;
    			//console.log(parent.airportMap);
    			//console.log(segment);
    			if(i==0){
    				if(pas_stp==null||pas_stp==''){
    					if(airportName==dpt_AirPt_Cd){
    						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
    					}
    					if(airportName==arrv_Airpt_Cd){
    						information[arrv_Airpt_Cd+'-'+dpt_AirPt_Cd] = segment;
    					}
    					if(airportName!=arrv_Airpt_Cd&&airportName!=dpt_AirPt_Cd){
    						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
    					}
    				}
    					if(airportName!=arrv_Airpt_Cd&&airportName!=dpt_AirPt_Cd){
    						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
    					}
    				}else{
    					if(airportName==dpt_AirPt_Cd){
    						information[dpt_AirPt_Cd+'-'+pas_stp] = segment;
    					}
    					if(airportName==pas_stp){
    						information[pas_stp+'-'+dpt_AirPt_Cd] = segment;
    					}
    					if(airportName==arrv_Airpt_Cd){
    						information[arrv_Airpt_Cd+'-'+dpt_AirPt_Cd] = segment;
    					}
    				}
    			}else if(i==1){
					if(airportName==dpt_AirPt_Cd){
						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
					}
					if(airportName==pas_stp){
						information[pas_stp+'-'+arrv_Airpt_Cd] = segment;
					}
					if(airportName==arrv_Airpt_Cd){
						information[arrv_Airpt_Cd+'-'+pas_stp] = segment;
					}
    			}

    		}
			if(flage){
				controller();
			}
    		}
        else{
//        		alert('当前起止日期内没有相关数据，请重新选择起止日期');
        		$("._customers").addClass("muhu");
        		$(".err").css("display","block");
        		flage = true;
        	}

    	if(!flage){
//    		alert('当前起止日期内没有相关数据，请重新选择起止日期');
    		$("._customers").addClass("muhu");
    		$(".err").css("display","block");
		}
    })
    .fail(function() {
        console.log("error");
    })
    
    
    
    
    
/*	$.ajax({
        type:'post',       
        url:'http://192.168.18.182/getAllSourceDistriData',
        data:{
        	//dpt_AirPt_Cd:airports[dpt_AirPt_Cd].iata,
        	//arrv_Airpt_Cd:airports[arrv_Airpt_Cd].iata,
        	dpt_AirPt_Cd:airports[arrv_Airpt_Cd].iata,
        	arrv_Airpt_Cd:airports[dpt_AirPt_Cd].iata,
        	pas_stp:pas_stp==""?'':airports[pas_stp].iata,
        	flt_nbr:flt_nbr,
        	lcl_Dpt_Tm:lcl_Dpt_Tm,
        	lcl_Arrv_Tm:lcl_Arrv_Tm,
        	isIncludePasDpt:isIncludePasDpt
        },
        dataType : 'json',
        async:false,
        success:function(data){
        	//console.log(data);
        	$("._customers").removeClass("muhu");
			$(".err").css("display","none");
        	information = {};
        	var flage = false;
        	if(data!=null&&data.length>0){
        		information={};
        		for(var i=0;i<data.length;i++){
        			if(data[i].dataMap!=null){
        			flage = true;
        			var segment = new Map();
        			var obj = data[i];
        			if(obj!=null){
        				var provinceMap = new Map();
                		var age = {};
                		var people = [];
                		var cityName = [];
                		var dataMap = obj.dataMap;
                		if(dataMap!=null){
                			for(var key in dataMap){
                				cityName.push(key);
                				var o= dataMap[key];
                				var provice = {};
                				if(o!=null&&o.length>0){
                					var zr=0;
                					var fr = [];
                					for(var j=0;j<o.length;j++){
                						var frArray =[];
                						zr+=o[j].number;
                						frArray.push(o[j].city);
                						frArray.push(o[j].number);
                						fr.push(frArray);
                					}
                					people.push(zr);
                					provice.zr = zr;
                					provice.fr = fr;
                				}
                				provinceMap[key] = provice;
                			}
                		}
                		var peopleStruct = obj.peopleStruct;
                		if(peopleStruct!=null){
                			var totalWomen = 0;
                			var totalMan = 0;
                			var totalline = [];
                			var total = {};
                			var totalcount = [];
                			var man = {};
                			var woman = {};
                			var manline = [];
                			var womanline = [];
                			var lineName = [];
                			for(var key in peopleStruct){
                				lineName.push(key);
                				var o = peopleStruct[key];
                				var mancount = o['男'];
                				var womancount = o['女'];
                				totalline.push(mancount+womancount);
                				manline.push(mancount);
                				womanline.push(womancount);
                				totalWomen+=womancount;
                				totalMan+=mancount;
                			}
                			totalcount.push(totalMan);
                			totalcount.push(totalWomen);
                			total.count=totalcount;
                			total.line=totalline;
                			man.line=manline;
                			woman.line=womanline;
                			age.man = man;
                			age.woman = woman;
                			age.total = total;
                			age.lineName = lineName;
                		}
                		segment.province = provinceMap;
                		segment.age = age;
                		segment.people =people;
                		segment.cityName =cityName;
        			}
        			//自己根据后台逻辑装载航线该显示的分段---后台逻辑变了，这里肯定要变（与顺序逻辑一一对应的）
        			var airportName = parent.airportMap[parent.airportCode].aptChaNam;
        			//console.log(parent.airportMap);
        			//console.log(segment);
        			if(i==0){
        				if(pas_stp==null||pas_stp==''){
        					if(airportName==dpt_AirPt_Cd){
        						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
        					}
        					if(airportName==arrv_Airpt_Cd){
        						information[arrv_Airpt_Cd+'-'+dpt_AirPt_Cd] = segment;
        					}
        					if(airportName!=arrv_Airpt_Cd&&airportName!=dpt_AirPt_Cd){
        						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
        					}
        				}
        					if(airportName!=arrv_Airpt_Cd&&airportName!=dpt_AirPt_Cd){
        						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
        					}
        				}else{
        					if(airportName==dpt_AirPt_Cd){
        						information[dpt_AirPt_Cd+'-'+pas_stp] = segment;
        					}
        					if(airportName==pas_stp){
        						information[pas_stp+'-'+dpt_AirPt_Cd] = segment;
        					}
        					if(airportName==arrv_Airpt_Cd){
        						information[arrv_Airpt_Cd+'-'+dpt_AirPt_Cd] = segment;
        					}
        				}
        			}else if(i==1){
    					if(airportName==dpt_AirPt_Cd){
    						information[dpt_AirPt_Cd+'-'+arrv_Airpt_Cd] = segment;
    					}
    					if(airportName==pas_stp){
    						information[pas_stp+'-'+arrv_Airpt_Cd] = segment;
    					}
    					if(airportName==arrv_Airpt_Cd){
    						information[arrv_Airpt_Cd+'-'+pas_stp] = segment;
    					}
        			}

        		}
    			if(flage){
    				controller();
    			}
        		}
	        else{
	//        		alert('当前起止日期内没有相关数据，请重新选择起止日期');
	        		$("._customers").addClass("muhu");
	        		$(".err").css("display","block");
	        		flage = true;
	        	}

        	if(!flage){
//        		alert('当前起止日期内没有相关数据，请重新选择起止日期');
        		$("._customers").addClass("muhu");
        		$(".err").css("display","block");
			}
        	}
        	
        
        
        
        
        
    });*/
	 addBar(".sr-box","._customers-box","._customers-box-c");
	 $("._customers-box-c").css("top","0px");
	 $("._bar-box").css("right","30px");
	 
}
$(window).resize(function(){
	reset();//算大小
	$("._customers-nav-a").eq(0).click();
});
/*滚动条*/
//add();
function add(){
	if($("#yj-scroll").length==0){
		$("._customers").append("<div id='yj-scroll'></div>");
	}
//	$("#yj-scroll").css({"border-radius":"2px","cursor":"pointer","position":"absolute","width":"8px","right":"309px","top":"0px","z-index":"999","height":"100px","background-color":"#79b2df"});
	$("#yj-scroll").css({"border-radius":"2px","cursor":"pointer","position":"absolute","width":"8px","right":"49px","top":"0px","z-index":"999","height":"100px","background-color":"#79b2df"});
	var rol="._customers";
	var sol="#yj-scroll";
	var bbox="._customers-box";
	var BoxH=infer(rol)[1];
	var conH=infer("#sample1")[1]*3;
	$('body').on("mousewheel",sol,function(e,delta){
		if(delta=="1") {//上滑
			$(bbox).css({"top":"+="+15+"px"});
			if(infer(bbox)[4]>=0){
				$(bbox).css({"top":"0px"});
			}
			var T=infer(bbox)[4]*(infer(rol)[1]-infer(sol)[1])/(infer(rol)[1]-conH);
			$("#yj-scroll").css("top",T+"px");
		}else { //下滑
			$(bbox).css({"top":"-="+15+"px"});
			if(infer(bbox)[4]<=-(conH-BoxH)){
				$(bbox).css({"top":-(conH-BoxH)+"px"});
			}
			var T=infer(bbox)[4]*(infer(rol)[1]-infer(sol)[1])/(infer(rol)[1]-conH);
			$("#yj-scroll").css("top",T+"px");
		}
	});
	$(rol).on("mousedown",sol,function(b){
		var H=b.screenY;
		var ct=infer("#yj-scroll")[4];
		$(".sr-box").mousemove(function(e){
			var top= e.screenY;
			if(H>top){
				var tops=ct-Math.abs(H-top);
				if(tops<=0){
					$("#yj-scroll").css("top","0px");
				}else {
					$("#yj-scroll").css("top",tops+"px");
				}
				var T=infer(sol)[4]*(conH-infer(rol)[1])/(infer(rol)[1]-infer(sol)[1]);
				$("._customers-box").css("top",T+"px");
			}else {
				var tops=ct+Math.abs(H-top);
				if(tops>=(infer(rol)[1]-infer("#yj-scroll")[1])){
					$("#yj-scroll").css("top",(infer(rol)[1]-infer("#yj-scroll")[1])+"px");
				}else {
					$("#yj-scroll").css("top",tops+"px");
				}
				var T=-infer(sol)[4]*(conH-infer(rol)[1])/(infer(rol)[1]-infer(sol)[1]);
				$("._customers-box").css("top",T+"px");
			}
		});
	});
	$(rol).on("mouseup",function(){
		$(".sr-box").unbind("mousemove");
	});
}
function changeDate(id,date){
	// 参数表示在当前日期下要增加的天数  
	var d = new Date(date); 
 	d.setDate(d.getDate()-30); 
 	var month=d.getMonth()+1; 
 	var day = d.getDate(); 
    if (month < 10) {  
        month = '0' + month;  
    }
    if (day < 10) {  
        day = '0' + day;  
    }
    $('#'+id).val(d.getFullYear() +'-'+ month +'-'+ day +' - '+ date);
}





//伸缩栏

var cus_rotate_flag=0;
$(".cus-closechart").click(function(){
	cus_rotate_flag+=180;
	$('.cus-closechart span').css('transform','rotate('+ cus_rotate_flag +'deg)');
	if($("._customers-box").css('display')=='none'){
		$("._customers-box").show('fast');
		$("._customers").animate({width:'55%'});
	}
	else{
		$("._customers").animate({width:'88px'});
		$("._customers-box").hide('fast');
	}
})






//绘制背景热图


function drawheatmap(mapdata){
	mapdata=JSON.parse(mapdata);
	//console.log(mapdata);
	var myChart = echarts.init(document.getElementById('cus_heatmap'));	
    var heylong=[];
    var hmax=0;	//获取max
    $.each(mapdata.province,function(i,el){
    	$.each(el.fr,function(ii,ell){
    		//console.log(ell);
        	heylong.push({name:ell[0],value:[ell[2],ell[3],ell[1]]});
        	if(ell[1]>hmax)hmax=ell[1];
        })    	
    })
    var l_flitxt1=$("#cityChoice").val();
    var l_flitxt2=$("#cityChoice2").val();
    var l_time='日期：'+$("#startEndDate").val();
    l_flitxt = l_flitxt1+ '-'+ l_flitxt2+'客源分布';
    
    
    
    //热点图样式设置
    var option = {
    	    backgroundColor: '#404a59',
    	    title: {
    	    	show:false,
    	        text: l_flitxt,
    	        left: 'center',
    	        textStyle: {
    	            color: '#fff'
    	        },
    	        subtext:l_time
    
    	    },
    	    backgroundColor: '#404a59',
    	    visualMap: {
    	    	show: true,
    	        min: 0,
    	        max: hmax/10,
    	        right:'5%',
    	        bottom:'5%',
    	        calculable: false,
    	        text:[hmax,"0"],
    	        formatter:'{a}',
    	        hoverLink:false,
    	        itemWidth:15,
    	        align:'right',
    	        color: ['#d56928','#da7400','#eba013','#f8c311'],
    	        textStyle: {
    	            color: '#fff'
    	        },
    	        align:'right'    	        
    	    },
    	    tooltip: {
    	        trigger: 'item',
    	        formatter: function (params) {
    	            return params.name + ' 客量: ' + params.value[2];
    	        }
    	    },
    	    geo: {
    	        map: 'world',
    	        label: {
    	            emphasis: {
    	                show: false
    	            }
    	        },
    	        itemStyle: {
    	            normal: {
    	                areaColor: '#22324f',
    	                borderColor: '#0a1c3b',
    	                borderWidth:1,
    	                borderType:'solid'
    	                
    	            },
    	            emphasis: {
    	                areaColor: '#22324f'
    	            }
    	        },
  		        center:[104.37,34.13],
  		        zoom:5,  	
            	//center:["110.47","32.40"],
            	color:"red",
            	roam:"move",	        
    	    },
    	    series: [{
    	        name: 'AQI',
    	        type: 'heatmap',
    	        symbolSize:18,
    	        coordinateSystem: 'geo',
                large: true,
                largeThreshold: 200,
    	        data: heylong,
   	       	    symbolSize:13, 
   	            // 设置混合模式为叠加
   	            blendMode: 'lighter',   	                           
                itemStyle: {                	
                   emphasis: {
                       borderColor: '#fdc671',
                       borderWidth: 1
                   }
                },
                label:{
                	narmal:{
                		show:true
                	},
                	emphasis:{
                		show:true
                	}
                },
                markArea:{
                	label:{
                		normal:{
                			show:true
                		},
                		emphasis:{
                			show:true
                		}
                	}
                }
    	    }]
    	};

    myChart.setOption(option);
    $('.cus-closechart').show();
}








