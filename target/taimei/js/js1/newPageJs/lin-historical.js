//请求数据
if(parent.supData.linFlag != "0"){
	delete parent.supData.flight;
}
var title = '';
var data1=null;
var data2=null;
var data3=null;
var data4=null;
var xArray = null;
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
var flight = '';
var searchJson = {};
if(flts.length>=2){
	var flttemp = parseInt(flts[0].substring(2,6))+1;
	flight =flts[0]+"/"+flts[0].substring(0,2)+flttemp;
}else{
	flight = "汇总";
}
$(function(){
//	changeDate('reservation');
	
	var objj = parent.supData;
	if(typeof(objj.isIncloudPasstp)!="undefined"){
		if(objj.isIncloudPasstp=="on"){
			$('#isIncloudPasstp').attr('checked',true);
		}
	}
	$("._set-query").click(function(e){
		e.stopPropagation(); //屏蔽事件冒泡
		send();
	}) ;
	
	setTimeout(function(){
		$('#reservation').daterangepicker(null, function(start, end, label) {});
	},1500);
	var objs={
        back:function(){
        	//判断是否有经停，并是否值灰含经停
        	if($('#cityChoice3').val()==""){
        		$('#divpas').removeClass("_checkOp");
        		$('#isIncloudPasstp').removeAttr("disabled");
        	}else{
        		$('#divpas').addClass("_checkOp");
				$('#isIncloudPasstp').attr("disabled","disabled");
        	}
        	getFlt_Nbr();
        }
    };
	 oub = objs;
    airControl(".selectCity",objs);
	if(parent.supData.linFlag == "0"){
		var divv = "<ul><li class='tltle-sel' title='销售报表'><a class='page-fun-change' href='/salesReport'>&#xe628;</a></li><li class='tltle-sel tltle-selI'>&#xe629;<span>航线历史收益统计</span></li><li class='tltle-sel' title='销售动态'><a class='page-fun-change' href='/buyTicketReport'>&#xe624;</a></li></li><li class='tltle-sel' title='销售数据'><a class='page-fun-change' href='/SalesData/accountCheck'>&#xe688;</a></li></ul>";
		$(".sr-box-head-classify").empty();
		$(".sr-box-head-classify").append(divv);
		if(typeof(flts[0])!="undefined"){
			$('#fltNbr').text(flts[0]+'/'+flts[0].substring(0,4)+flts[1]);
		}
	}
	if(airLine!=null&&airLine!=""&&typeof(airLine)!='undefined'&&airLine!="="&&airLine!="=="){
		var flt = parent.supData.flt;
		var cds = airLine.split("="); 
		if('1'==flt){
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
				$('#isIncloudPasstp').attr("disabled","disabled");
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
    /*各航段切换*/
    $(".lin-historical-body-navigation").on("click","div",function(){
        if($(this).hasClass("body-navigation-element")){
            if( !$(this).hasClass("set")){
                $(this).addClass("set").siblings().removeClass("set");
                if($(this).children().children().eq(1).text().length==1){
                    var num=$(this).children().children().eq(0).text()+"-"+$(this).children().children().eq(2).text();
                    direct(data1,num);
                    direct(data2,num);
                    mdirect(data3,num);
                    newMdirect(data4,num);
                }else{
                    IncomeFigure(data1);//初始化
                    newIncomeFigure(data2);//初始化
                    movements(data3);//初始化
                    newMovements(data4);//初始化
                }
            }
        }
    });
    //判断是否从菜单进入功能页面--start
    if(parent.supData.flag==1){
    	parent.supData.flag = 0;
    	return;
    }
    //判断是否从菜单进入功能页面--end
    getFlt_Nbr();
    setTimeout(function () {
    	var dpt_AirPt_Cd = $('#cityChoice').val();
    	var Arrv_Airpt_Cd = $('#cityChoice2').val();
    	var pas_stp = $('#cityChoice3').val();
    	if(pas_stp!=''){
    		pas_stp = airports[pas_stp].iata;
    	}
    	if(dpt_AirPt_Cd!=''){
    		dpt_AirPt_Cd = airports[dpt_AirPt_Cd].iata;
    	}
    	if(Arrv_Airpt_Cd!=''){
    		Arrv_Airpt_Cd = airports[Arrv_Airpt_Cd].iata;
    	}
    	var isIncloudPasstp = '';
    	if($('#isIncloudPasstp').is(':checked')==true){
    		isIncloudPasstp = 'on';
    	}
    	var exceptionData = '';
    	//判断异常数据是否选中
    	if($('#exceptionData').is(':checked')==true){
    		exceptionData = 'on';
    	}
    	var flt_nbr_Count =$('._set-list-title').html();
    	$.ajax({
    	    type:'get',
    	    url : '/restful/getAirportHistroyNewDate',
    	    data:{
    	    	dpt_AirPt_Cd :dpt_AirPt_Cd,
            	Arrv_Airpt_Cd: Arrv_Airpt_Cd,
            	pas_stp:pas_stp,
            	flt_nbr:flt_nbr_Count,
            	isIncludePasDpt:isIncloudPasstp,
            	isDayOrMonth:"day",
            	isIncludeExceptionData:exceptionData
    	    },
    	    dataType : 'jsonp',
    	    success : function(data) {
    	    	var date = data.success.newDate;
    	    	changeDate('reservation',date);
    	    	send();
    	    }
    	});
    }, 500);
});
function changeFltNbr(){
	$('#fltNbr').text($('._set-list-title').html());
}
function getfly(){
	 getFlt_Nbr();
}
function getFlt_Nbr(){
	var searchJson = new Object();
	var dpt_AirPt_Cd = typeof(airports[$('#cityChoice').val()])=='undefined'?'':airports[$('#cityChoice').val()].iata;
	var pas_stp = typeof(airports[$('#cityChoice3').val()])=='undefined'?'':airports[$('#cityChoice3').val()].iata;
	var arrv_Airpt_Cd = typeof(airports[$('#cityChoice2').val()])=='undefined'?'':airports[$('#cityChoice2').val()].iata;
	if((""!=dpt_AirPt_Cd&&arrv_Airpt_Cd!="")||pas_stp!=""){
		searchJson.dpt_AirPt_Cd = dpt_AirPt_Cd;
		searchJson.pas_stp = pas_stp;
		searchJson.arrv_Airpt_Cd = arrv_Airpt_Cd;
	}else{
		return;
	}
	if($('#isIncloudPasstp').is(':checked')==true){
		searchJson.isIncludePasDpt = 'on';
	}
	$.ajax({
        type:'post',
        url:'getHbh',//请求数据的地址	
        data:searchJson,
        success:function(data){
        	var dats = new Array();
            if(data!=null&&data.list!=null&&data.list.length>0){
            	for(var index in data.list){
                	dats.push(data.list[index]);
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
//        	    send();
        }
    });
}
window.onresize=function(){
    addElement();
};
function infer(name){
    var infer=[];
    infer.push(parseFloat($(name).css("width").split("px")[0]));
    infer.push(parseFloat($(name).css("height").split("px")[0]));
    infer.push(parseFloat($(name).css("margin-top").split("px")[0]));
    infer.push(parseFloat($(name).css("left").split("px")[0]));
    return infer;
}
/*图区*/
/*********************************1-2图***************************/
/*总共数据*/
function IncomeFigure(gather){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: [{
            text: gather.className[0],
            left:'4%',
            top:'8%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            }
        },
            {
                text: "散客"+gather.className[1]+"："+fmoney(gather.peoples[0],2),
                left:'20%',
                top:'85%',
                textStyle:{
                    color:"white",
                    fontWeight:"normal",
                    fontSize:14
                }
            },
            {
                text:  "团队"+gather.className[1]+"："+fmoney(gather.peoples[1],2),
                right:'20%',
                top:'85%',
                textStyle:{
                    color:"white",
                    fontWeight:"normal",
                    fontSize:14
                }
            }
        ],
        tooltip: {
            trigger: 'item',
//            formatter: "{b}<br/>{c} ({d}%)",
            formatter:function(param){
            	return param.name+"<br/>"+fmoney(param.value,2)+"("+param.percent+"%)";
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            orient: 'vertical',
            x: '70%',
            y:"15%",
            data:gather.selName,
            textStyle:{
                color:"white"
            }
        },
        series: [
            {
                name:'section',
                type:'pie',
                selectedMode: 'single',
                radius: [0, '30%'],
                label: {
                    normal: {
                        show:false,
                        position: 'center',
                        formatter: function(params){
                        	if(params.dataIndex==0){
                        		return '总收入占比';	
                        	}else{
                        		return '';
                        	}
                        },
                        textStyle: {
                            fontSize: '22',
                            fontWeight: 'bold',
                            color:'#B22222'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data:gather.segment
            },
            {
                name:'people',
                type:'pie',
                selectedMode: 'single',
                radius: ['40%', '55%'],
                data:[
                    {value:gather.peoples[1], name:'团队',itemStyle:{normal:{color:"#204e7f"}}},
                    {value:gather.peoples[0], name:'散客',itemStyle:{normal:{color:"#5479a3"}}}
                ]
            }
        ]
    };
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
//    var num=100;
//    var num1=100;
    myChart.on("mouseover",function(parmes){
        if(parmes.seriesName=="section"){
        	option.title[1].text="散客总收入："+fmoney(gather.pieceData[parmes.name][0],2);
        	option.title[2].text="团队总收入："+fmoney(gather.pieceData[parmes.name][1],2);
        	option.series[1].data[0].value=gather.pieceData[parmes.name][1];
        	option.series[1].data[1].value=gather.pieceData[parmes.name][0];
//            if(num==parmes.dataIndex){
//                option.title[1].text="散客总收入："+gather.peoples[0];
//                option.title[2].text="团队总收入："+gather.peoples[1];
//                option.series[1].data[0].value=gather.peoples[1];
//                option.series[1].data[1].value=gather.peoples[0];
//                num=100;
//            }else {
//                num=parmes.dataIndex;
//            }
        }else if(parmes.seriesName=='people'){
        	option.title[1].text="散客总收入："+fmoney(gather.peoples[0],2);
        	option.title[2].text="团队总收入："+fmoney(gather.peoples[1],2);
        	var currdata = [];
        	if(parmes.name=='团队'){
        		for(var i=0;i<gather.segment.length;i++){
        			currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][1]});
        		}
//        		option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '团队收入占比';}else{return '';}};
        	}else if(parmes.name=='散客'){
        		for(var i=0;i<gather.segment.length;i++){
        			currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][0]});
        		}
//        		option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '散客收入占比';}else{return '';}};
        	}
        	option.series[0].data=currdata;
//        	if(num1==parmes.dataIndex){
//                option.title[1].text="散客总收入："+gather.peoples[0];
//                option.title[2].text="团队总收入："+gather.peoples[1];
//                option.series[0].data=gather.segment;
//                option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '总收入占比';}else{return '';}};
//                num1=100;
//            }else {
//                num1=parmes.dataIndex;
//            }
        }
        myChart.setOption(option, true);
    });
    myChart.on("mouseout",function(parmes){
        if(parmes.seriesName=="section"){
        	option.title[1].text="散客总收入："+fmoney(gather.peoples[0],2);
        	option.title[2].text="团队总收入："+fmoney(gather.peoples[1],2);
        	option.series[1].data[0].value=gather.peoples[1];
        	option.series[1].data[1].value=gather.peoples[0];
//            if(num==parmes.dataIndex){
//                num=100;
//            }else {
//                option.title[1].text="散客总收入："+gather.pieceData[parmes.name][0];
//                option.title[2].text="团队总收入："+gather.pieceData[parmes.name][1];
//                option.series[1].data[0].value=gather.pieceData[parmes.name][1];
//                option.series[1].data[1].value=gather.pieceData[parmes.name][0];
//                num=parmes.dataIndex;
//            }
        }else if(parmes.seriesName=='people'){
        	option.title[1].text="散客总收入："+fmoney(gather.peoples[0],2);
        	option.title[2].text="团队总收入："+fmoney(gather.peoples[1],2);
        	option.series[0].data=gather.segment;
//        	option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '总收入占比';}else{return '';}};
//        	if(num1==parmes.dataIndex){
//                num1=100;
//            }else {
//            	option.title[1].text="散客总收入："+gather.peoples[0];
//                option.title[2].text="团队总收入："+gather.peoples[1];
//                var currdata = [];
//                if(parmes.name=='团队'){
//                	for(var i=0;i<gather.segment.length;i++){
//                    	currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][1]});
//                    }
//                	option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '团队收入占比';}else{return '';}};
//                }else if(parmes.name=='散客'){
//                	for(var i=0;i<gather.segment.length;i++){
//                		currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][0]});
//                    }
//                	option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '散客收入占比';}else{return '';}};
//                }
//                option.series[0].data=currdata;
//                num1=parmes.dataIndex;
//            }
        }
        myChart.setOption(option, true);
    });
}

function newIncomeFigure(gather){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: [{
            text: gather.className[0],
            left:'4%',
            top:'8%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            }
        },
            {
                text: "散客"+gather.className[1]+"："+fmoney(gather.peoples[0],0),
                left:'20%',
                top:'85%',
                textStyle:{
                    color:"white",
                    fontWeight:"normal",
                    fontSize:14
                }
            },
            {
                text:  "团队"+gather.className[1]+"："+fmoney(gather.peoples[1],0),
                right:'20%',
                top:'85%',
                textStyle:{
                    color:"white",
                    fontWeight:"normal",
                    fontSize:14
                }
            }
        ],
        tooltip: {
            trigger: 'item',
//            formatter: "{b}<br/>{c} ({d}%)",
            formatter:function(param){
            	return param.name+"<br/>"+fmoney(param.value,0)+"("+param.percent+"%)";
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            orient: 'vertical',
            x: '70%',
            y:"15%",
            data:gather.selName,
            textStyle:{
                color:"white"
            }
        },
        series: [
            {
                name:'section',
                type:'pie',
                selectedMode: 'single',
                radius: [0, '30%'],
                label: {
                    normal: {
                        show:false,
                        position: 'center',
                        formatter: function(params){
                        	if(params.dataIndex==0){
                        		return '总人数占比';
                        	}else{
                        		return '';
                        	}
                        },
                        textStyle: {
                            fontSize: '22',
                            fontWeight: 'bold',
                            color:'#B22222'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data:gather.segment
            },
            {
                name:'people',
                type:'pie',
                selectedMode: 'single',
                radius: ['40%', '55%'],
                data:[
                    {value:gather.peoples[1], name:'团队',itemStyle:{normal:{color:"#204e7f"}}},
                    {value:gather.peoples[0], name:'散客',itemStyle:{normal:{color:"#5479a3"}}}
                ]
            }
        ]
    };
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
//    var num=100;
//    var num1=100;
    myChart.on("mouseout",function(parmes){
        if(parmes.seriesName=="section"){
        	option.title[1].text="散客总人数："+fmoney(gather.peoples[0],0);
        	option.title[2].text="团队总人数："+fmoney(gather.peoples[1],0);
        	option.series[1].data[0].value=gather.peoples[1];
        	option.series[1].data[1].value=gather.peoples[0];
//            if(num==parmes.dataIndex){
//                num=100;
//            }else {
//                option.title[1].text="散客总人数："+gather.pieceData[parmes.name][0];
//                option.title[2].text="团队总人数："+gather.pieceData[parmes.name][1];
//                option.series[1].data[0].value=gather.pieceData[parmes.name][1];
//                option.series[1].data[1].value=gather.pieceData[parmes.name][0];
//                num=parmes.dataIndex;
//            }
        }else if(parmes.seriesName=='people'){
        	option.title[1].text="散客总人数："+fmoney(gather.peoples[0],0);
        	option.title[2].text="团队总人数："+fmoney(gather.peoples[1],0);
//        	option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '总人数占比';}else{return '';}};
        	option.series[0].data=gather.segment;
//        	if(num1==parmes.dataIndex){
//                num1=100;
//            }else {
//            	option.title[1].text="散客总人数："+gather.peoples[0];
//                option.title[2].text="团队总人数："+gather.peoples[1];
//                var currdata = [];
//                if(parmes.name=='团队'){
//                	for(var i=0;i<gather.segment.length;i++){
//                    	currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][1]});
//                    }
//                	option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '团队人数占比';}else{return '';}};
//                }else if(parmes.name=='散客'){
//                	for(var i=0;i<gather.segment.length;i++){
//                		currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][0]});
//                    }
//                	option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '散客人数占比';}else{return '';}};
//                }
//                option.series[0].data=currdata;
//                num1=parmes.dataIndex;
//            }
        }
        myChart.setOption(option, true);
    });
    myChart.on("mouseover",function(parmes){
        if(parmes.seriesName=="section"){
        	option.title[1].text="散客总人数："+fmoney(gather.pieceData[parmes.name][0],0);
        	option.title[2].text="团队总人数："+fmoney(gather.pieceData[parmes.name][1],0);
        	option.series[1].data[0].value=gather.pieceData[parmes.name][1];
        	option.series[1].data[1].value=gather.pieceData[parmes.name][0];
//            if(num==parmes.dataIndex){
//                option.title[1].text="散客总人数："+gather.peoples[0];
//                option.title[2].text="团队总人数："+gather.peoples[1];
//                option.series[1].data[0].value=gather.peoples[1];
//                option.series[1].data[1].value=gather.peoples[0];
//                num=100;
//            }else {
//                num=parmes.dataIndex;
//            }
        }else if(parmes.seriesName=='people'){
        	option.title[1].text="散客总人数："+fmoney(gather.peoples[0],0);
        	option.title[2].text="团队总人数："+fmoney(gather.peoples[1],0);
        	var currdata = [];
        	if(parmes.name=='团队'){
        		for(var i=0;i<gather.segment.length;i++){
        			currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][1]});
        		}
//        		option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '团队人数占比';}else{return '';}};
        	}else if(parmes.name=='散客'){
        		for(var i=0;i<gather.segment.length;i++){
        			currdata.push({'name':option.series[0].data[i].name,'value':gather.pieceData[option.series[0].data[i].name][0]});
        		}
//        		option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '散客人数占比';}else{return '';}};
        	}
        	option.series[0].data=currdata;
//        	if(num1==parmes.dataIndex){
//                option.title[1].text="散客总人数："+gather.peoples[0];
//                option.title[2].text="团队总人数："+gather.peoples[1];
//                option.series[0].label.normal.formatter = function(params){if(params.dataIndex==0){return '总人数占比';}else{return '';}};
//                option.series[0].data=gather.segment;
//                num1=100;
//            }else {
//                num1=parmes.dataIndex;
//            }
        }
        myChart.setOption(option, true);
    });
}
/*单边数据*/
function direct(gather,name){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: [{
            text: gather.className[0],
            left:'4%',
            top:'8%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            }
        },
            {
                text: "散客"+gather.className[1]+"："+fmoney(gather.pieceData[name][0],2),
                left:'20%',
                top:'85%',
                textStyle:{
                    color:"white",
                    fontWeight:"normal",
                    fontSize:14
                }
            },
            {
                text:  "团队"+gather.className[1]+"："+fmoney(gather.pieceData[name][1],2),
                right:'20%',
                top:'85%',
                textStyle:{
                    color:"white",
                    fontWeight:"normal",
                    fontSize:14
                }
            }
        ],
        tooltip: {
            trigger: 'item',
            formatter: "{b}: {c} ({d}%)",
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            orient: 'vertical',
            x: '80%',
            y:"15%",
            data:['散客','团队'],
            textStyle:{
                color:"white"
            }
        },
        series: [
            {
                name:'section',
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
                    {value:gather.pieceData[name][0], name:'散客',itemStyle:{normal:{color:"#204e7f"}}},
                    {value:gather.pieceData[name][1], name:'团队',itemStyle:{normal:{color:"#5479a3"}}}
                ]
            }
        ]
    };
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
}
/*****************************3-4图***********************/

/*总共数据*/
function movements(gather){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: gather.className,
            left:'4%',
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
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            data: ['客量', '座位', '班次*100', '团队','团队收入/100','收入/1000'],
            align: 'left',/*
            right: "0%",*/
            top:"15%",
            textStyle:{
                color:"white"
            }
        },
        grid: {
            left: '5%',
            right: '4%',
            bottom: '3%',
            top:"30%",
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : xArray,
                axisTick: {
                    alignWithLabel: true
                },
                splitLine: {
                    show:true,
                    lineStyle:{
                        color:"#1b2c4c"
                    }
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        yAxis : [
            {
                type : 'value',
                splitLine: {
                    show:false
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        series : [
            {
                name:'客量',
                smooth: true,
                type:'bar',
                showSymbol:false,
                itemStyle:{
                    normal:{
                        color:"#1f4e7f"
                    }
                },
                barWidth: '40%',
                data:gather.peoples[0]
            },
            {
                name:'座位',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#84acda"
                    }
                },
                symbol:'circle',
                data:gather.peoples[1]
            },
            {
                name:'班次*100',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#52b778"
                    }
                },
                symbol:"rect",
                data:gather.peoples[2]
            },
            {
                name:'团队',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#af9060"
                    }
                },
                symbol:"triangle",
                data:gather.peoples[3]
            },
            {
                name:'团队收入/100',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#8e672e"
                    }
                },
                symbol:"triangle",
                data:gather.peoples[4]
            },
            {
                name:'收入/1000',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#d35b4c"
                    }
                },
                symbol:"triangle",
                data:gather.peoples[5]
            }

        ]
    };
    myChart.setOption(option, true);
}

function newMovements(gather){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: gather.className,
            left:'4%',
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
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            data: ['每班旅客', '每班座位', '每班团队', '客座率','团队收入/100','每班收入/1000'],
            align: 'left',
            /*right: "0%",*/
            top:"15%",
            textStyle:{
                color:"white"
            }
        },
        grid: {
            left: '5%',
            right: '4%',
            bottom: '3%',
            top:"30%",
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : xArray,
                axisTick: {
                    alignWithLabel: true
                },
                splitLine: {
                    show:true,
                    lineStyle:{
                        color:"#1b2c4c"
                    }
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        yAxis : [
            {
                type : 'value',
                splitLine: {
                    show:false
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        series : [
            {
                name:'每班旅客',
                smooth: true,
                type:'bar',
                showSymbol:false,
                itemStyle:{
                    normal:{
                        color:"#1f4e7f"
                    }
                },
                barWidth: '40%',
                data:gather.peoples[0]
            },
            {
                name:'每班座位',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#84acda"
                    }
                },
                data:gather.peoples[1]
            },
            {
                name:'每班团队',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#52b778"
                    }
                },
                symbol:"rect",
                data:gather.peoples[2]
            },
            {
                name:'客座率',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#af9060"
                    }
                },
                symbol:"triangle",
                data:gather.peoples[3]
            },
            {
                name:'团队收入/100',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#8e672e"
                    }
                },
                symbol:"triangle",
                data:gather.peoples[4]
            },
            {
                name:'每班收入/1000',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#d35b4c"
                    }
                },
                symbol:"triangle",
                data:gather.peoples[5]
            }

        ]
    };
    myChart.setOption(option, true);
}

/*单边数据*/
function mdirect(gather,name){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: gather.className,
            left:'4%',
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
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            data: ['客量', '座位', '班次*100', '团队','团队收入/100','收入/1000'],
            align: 'left',/*
            right: "0%",*/
            top:"15%",
            textStyle:{
                color:"white"
            }
        },
        grid: {
            left: '5%',
            right: '4%',
            bottom: '3%',
            top:"30%",
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : xArray,
                axisTick: {
                    alignWithLabel: true
                },
                splitLine: {
                    show:true,
                    lineStyle:{
                        color:"#1b2c4c"
                    }
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        yAxis : [
            {
                type : 'value',
                splitLine: {
                    show:false
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        series : [
            {
                name:'客量',
                smooth: true,
                type:'bar',
                showSymbol:false,
                itemStyle:{
                    normal:{
                        color:"#1f4e7f"
                    }
                },
                barWidth: '40%',
                data:gather.movements[name][0]
            },
            {
                name:'座位',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#84acda"
                    }
                },
                data:gather.movements[name][1]
            },
            {
                name:'班次*100',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#52b778"
                    }
                },
                symbol:"rect",
                data:gather.movements[name][2]
            },
            {
                name:'团队',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#af9060"
                    }
                },
                symbol:"triangle",
                data:gather.movements[name][3]
            },
            {
                name:'团队收入/100',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#8e672e"
                    }
                },
                symbol:"triangle",
                data:gather.movements[name][4]
            },
            {
                name:'收入/1000',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#d35b4c"
                    }
                },
                symbol:"triangle",
                data:gather.movements[name][5]
            }

        ]
    };
    myChart.setOption(option, true);
}

/*单边数据*/
function newMdirect(gather,name){
    var dom = document.getElementById(gather.name);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: gather.className,
            left:'4%',
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
            borderColor:'#d85430',
            borderWidth:1
        },
        legend: {
            data: ['每班旅客', '每班座位', '每班团队', '客座率','团队收入/100','每班收入/1000'],
            align: 'left',/*
            right: "0%",*/
            top:"15%",
            textStyle:{
                color:"white"
            }
        },
        grid: {
            left: '5%',
            right: '4%',
            bottom: '3%',
            top:"30%",
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : xArray,
                axisTick: {
                    alignWithLabel: true
                },
                splitLine: {
                    show:true,
                    lineStyle:{
                        color:"#1b2c4c"
                    }
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        yAxis : [
            {
                type : 'value',
                splitLine: {
                    show:false
                },
                axisLabel:{
                    show:true,
    	           	textStyle:{
   	                 color:"white"
    	           	}
                },
                axisLine:{
                    lineStyle:{
                        color:"#24324a"
                    }
                }
            }
        ],
        series : [
            {
                name:'每班旅客',
                smooth: true,
                type:'bar',
                showSymbol:false,
                itemStyle:{
                    normal:{
                        color:"#1f4e7f"
                    }
                },
                barWidth: '40%',
                data:gather.movements[name][0]
            },
            {
                name:'每班座位',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#84acda"
                    }
                },
                data:gather.movements[name][1]
            },
            {
                name:'每班团队',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#52b778"
                    }
                },
                symbol:"rect",
                data:gather.movements[name][2]
            },
            {
                name:'客座率',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#af9060"
                    }
                },
                symbol:"triangle",
                data:gather.movements[name][3]
            },
            {
                name:'团队收入/100',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#8e672e"
                    }
                },
                symbol:"triangle",
                data:gather.movements[name][4]
            },
            {
                name:'每班收入/1000',
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#d35b4c"
                    }
                },
                symbol:"triangle",
                data:gather.movements[name][5]
            }

        ]
    };
    myChart.setOption(option, true);
}
function box(){
    $(".lin-historical-body").eq(0).css({"height":infer(".lin-historical")[1]-infer(".sr-box-head")[1]+"px"});//计算内容区的高度
    $(".body-navigation-element").css({"height":infer(".lin-historical-body")[1]/parseInt($(".body-navigation-element").size())}); //计算每个导航块的大小
    for(var i=0;i<$(".tag-box").length;i++){//计算每个导航块的居中位置
        var tagH=(infer(".body-navigation-element")[1]-parseFloat($(".tag-box").eq(i).css("height").split("px")[0]))/2;
        $(".tag-box").eq(i).css({"margin-top":tagH+"px"});
    };
//    var Lhbx=infer(".lin-historical-body")[0]-352;
    var Lhbx=infer(".lin-historical-body")[0]-55;
    $(".lin-historical-body-box").css({"width":Lhbx+"px","height":parseInt(infer(".lin-historical-body")[1])});//就按图区盒大小
}
function addElement(){
    var ele="";
    if(data1.hasStopping){
        var ndata=data1.hasStopping.split("-");
        if(ndata[1]==''){
        	ele="<div class='body-navigation-element set'><div class='tag-box'><div>"+ndata[0]+"</div> <div class='element-tag'>&#xe648;&#xe647;</div><div>"+ndata[2]+"</div> </div> </div>";
            for(var key in data1.pieceData){
                ndata=key.split("-");
                ele+="<div class='body-navigation-element'><div class='tag-box'> <div>"+ndata[0]+"</div><div class='element-tag'>&#xe648;</div><div>"+ndata[1]+"</div></div></div>";
            }
        }else{
        	ele="<div class='body-navigation-element set'><div class='tag-box'><div>"+ndata[0]+"</div> <div class='element-tag'>&#xe648;&#xe647;</div><div>"+ndata[1]+"</div><div class='element-tag'>&#xe648;&#xe647;</div><div>"+ndata[2]+"</div> </div> </div>";
            for(var key in data1.pieceData){
                ndata=key.split("-");
                ele+="<div class='body-navigation-element'><div class='tag-box'> <div>"+ndata[0]+"</div><div class='element-tag'>&#xe648;</div><div>"+ndata[1]+"</div></div></div>";
            }	
        }
    }
    $(".lin-historical-body-navigation").html(ele);
    $(".body-navigation-element").eq(0).addClass("set");
    box();//计算区域大小;
    IncomeFigure(data1);//初始化
    newIncomeFigure(data2);//初始化
    movements(data3,xArray);//初始化
    newMovements(data4,xArray);//初始化
}
function send(){
	//关闭所有选择框
	$(".c-selectCity").nextAll().remove();
	$("._set-allList").css({"display":"none"});
	$('.opensright').css('display','none');
	var dpt_AirPt_Cd = $('#cityChoice').val();
	if(dpt_AirPt_Cd!=''){
		dpt_AirPt_Cd = airports[dpt_AirPt_Cd].iata;
	}else{
		alert('请选择起始机场');
		$(".lin-historical-body").addClass("muhu");
		$(".err").css("display","block");
		return;
	}
	var Arrv_Airpt_Cd = $('#cityChoice2').val();
	if(Arrv_Airpt_Cd!=''){
		Arrv_Airpt_Cd = airports[Arrv_Airpt_Cd].iata;
	}else{
		alert('请选择到达机场');
		$(".lin-historical-body").addClass("muhu");
		$(".err").css("display","block");
		return;
	}
	//查询条件联动
	var dpt_AirPt_Cdtemp = $('#cityChoice').val();
	var pas_stptemp = $('#cityChoice3').val();
	var arrv_Airpt_Cdtemp = $('#cityChoice2').val();
	var flt_nbr_Counttemp = $('._set-list-title').text();
	var object = parent.supData;
	console.log(parent.supData);
	if(pas_stptemp!=""){
		object.lane =dpt_AirPt_Cdtemp + "=" + pas_stptemp + "=" + arrv_Airpt_Cdtemp ;
	}else{
		object.lane =dpt_AirPt_Cdtemp + "=" + arrv_Airpt_Cdtemp ;
	}
	if($('#isIncloudPasstp').is(':checked')==true){
		object.isIncloudPasstp = 'on';
	}else{
		delete object.isIncloudPasstp;
	}
	if(flt_nbr_Counttemp!=""){
		if(flt_nbr_Counttemp!="汇总"){
			var flttemp = flt_nbr_Counttemp.split("/");
			var ff = flttemp[0]+"/"+flttemp[1].substring(flttemp[1].length-2,flttemp[1].length);
			object.flight = ff;
		}else{
			object.flight = "";
		}
	}
	var pas_stp = $('#cityChoice3').val();
	if(pas_stp!=''){
		pas_stp = airports[pas_stp].iata;
	}
	var date = $('#reservation').val();
	var startTime = '';
	var endTime = '';
	if(typeof(date)=='undefined'||date==null||date==''){
		$(".lin-historical-body").addClass("muhu");
		$(".err").css("display","block");
		alert('请选择起止日期');
		return;
	}else{
		var dateArray = date.split(' - ');
		startTime = dateArray[0];
		endTime = dateArray[1];
		if(new Date(endTime).getTime()-new Date(new Date().format('yyyy-MM-dd')).getTime()>24*1000*60){
			$(".lin-historical-body").addClass("muhu");
			$(".err").css("display","block");
			alert('结束日期不能大于当前日期');
			return;
		}
	} 	
	var exceptionData = 'no';
	//判断异常数据是否选中
	if($('#exceptionData').is(':checked')==true){
		exceptionData = 'on';
	}
	var isIncloudPasstp = 'no';
	if($('#isIncloudPasstp').is(':checked')==true){
		isIncloudPasstp = 'on';
	}
	var dayOrMonth = '';//暂时
	var flt_nbr_Count =$('._set-list-title').html();
	if(flt_nbr_Count==null||flt_nbr_Count==''){
		$(".lin-historical-body").addClass("muhu");
		$(".err").css("display","block");
		return;
	}
	var date = $('#reservation').val();
	var startTime = '';
	var endTime = '';
	if(typeof(date)=='undefined'||date==null||date==''){
		alert('请选择起止日期');
//		$(".lin-historical-body").addClass("muhu");
//		$(".err").css("display","block");
		return;
	}else{
		if(date.length==23){
			dayOrMonth = 'day';
		}else if(date.length==17){
			dayOrMonth = 'month';
		}
		var dateArray = date.split(' - ');
		startTime = dateArray[0];
		endTime = dateArray[1];
		var dateArray = date.split(' - ');
		startTime = dateArray[0];
		endTime = dateArray[1];
		if(new Date(endTime).getTime()-new Date(new Date().format('yyyy-MM-dd')).getTime()>24*1000*60){
			$(".lin-historical-body").addClass("muhu");
			$(".err").css("display","block");
			alert('结束日期不能大于当前日期');
			return;
		}
	}

	$.ajax({
        type:'post',
        url : '/restful/getAirportHistroyData',
        dataType : 'jsonp',
        data:{
        	dpt_AirPt_Cd :dpt_AirPt_Cd,
        	Arrv_Airpt_Cd:Arrv_Airpt_Cd,
        	pas_stp:pas_stp,
        	flt_nbr:flt_nbr_Count,
        	startTime:startTime,
        	endTime:endTime,
        	isIncludePasDpt:isIncloudPasstp,
        	isDayOrMonth:dayOrMonth,
        	isIncludeExceptionData:exceptionData
        },
        async:false,
        success : function(data) {
        	var pieceData1 = new Map();
        	var selName = [];
        	var segment1 = [];
        	var pieceData2 = new Map();
        	var segment2 = [];
        	var peoples3 = [];
        	var movements3 = new Map();
        	var peoples4 = [];
        	var movements4 = new Map();
        	var xText = [];
        	data1 = {};
        	data2 = {};
        	data3 = {};
        	data4 = {};
        	xArray = [];
            if(data!=null&&data.success!=null&&data.success.map!=null){
            	var bz = true;
	        	//判断有无数据
	        	for(var key in data.success.map){
	        		var obj = data.success.map[key];
	        		if(obj.flag=="1"){
	        			bz = false;
	        		}
	        	}
            	data1.name = "container1";
                data1.className = ["收入占比","总收入"];
                data2.name = 'container2';
                data2.className = ['人数占比','总人数'];
                data3.name = 'container3';
                data3.className = "月流量走势分析";
                data4.name = 'container4';
                data4.className = '均班客流量走势分析';
                var reg = new RegExp(',','g');
            	for(var key in data.success.map){
            		var obj = data.success.map[key];
                	var peoples1 = [];
                	var peoples2 = [];
                	var movements1 = [];
                	var movements2 = [];
            		if(key.split('-').length==3){
        				data1.hasStopping = key;
            			data2.hasStopping = key;
            			data3.hasStopping = key;
            			data4.hasStopping = key;
            			peoples1.push(parseFloat((obj.sksrd+'').replace(reg,'')));
            			peoples1.push(parseFloat((obj.tdsrd+'').replace(reg,'')));
            			data1.peoples = peoples1;
            			peoples2.push(parseInt((obj.skrsd+'').replace(reg,'')));
            			peoples2.push(parseInt((obj.tdrsd+'').replace(reg,'')));
            			data2.peoples = peoples2;
            		}else{
            			selName.push(key);
            			segment1.push({value:(parseFloat((obj.sksrd+'').replace(reg,''))+parseFloat((obj.tdsrd+'').replace(reg,''))),name:key});
            			peoples1.push(parseFloat((obj.sksrd+'').replace(reg,'')));
            			peoples1.push(parseFloat((obj.tdsrd+'').replace(reg,'')));
            			pieceData1[key] = peoples1;
            			segment2.push({value:(parseInt((obj.skrsd+'').replace(reg,''))+parseInt((obj.tdrsd+'').replace(reg,''))),name:key});
            			peoples2.push(parseInt((obj.skrsd+'').replace(reg,'')));
            			peoples2.push(parseInt((obj.tdrsd+'').replace(reg,'')));
            			pieceData2[key+''] = peoples2;
            		}
            		if(obj.dataDate!=null){
            			var zkl = [];
            			var zzws = [];
            			var zbc = [];
            			var ztd = [];
            			var ztdsr = [];
            			var zsr = [];
            			var mbkl = [];
            			var mbzws = [];
            			var mbkzl = [];
            			var mbtd = [];
            			var mbtdsr = [];
            			var mbsr = [];
            			for(var keys in obj.dataDate){
            				var demo = obj.dataDate[keys];
            				if(dayOrMonth=='day'){
            					xText.push(parseInt(keys.split('-')[1])+'.'+parseInt(keys.split('-')[2]));//日期查询
            				}else{
            					xText.push(parseInt(keys.split('-')[1])+'月\n'+parseInt(keys.split('-')[0]));//月份查询
            				}
            				zkl.push(parseInt((demo.zkl+'').replace(reg,'')));
            				zzws.push(parseInt((demo.zftzws+'').replace(reg,'')));
            				zbc.push(parseFloat((demo.zbc+'').replace(reg,'')).toFixed(2));
            				ztd.push(parseFloat((demo.ztd+'').replace(reg,'')).toFixed(2));
            				ztdsr.push(parseFloat((demo.ztdsr+'').replace(reg,'')).toFixed(2));
            				zsr.push(parseFloat((demo.zsr+'').replace(reg,'')).toFixed(2));
            				mbkl.push(parseFloat((demo.mbkl+'').replace(reg,'')).toFixed(2));
            				mbzws.push(parseFloat((demo.mbftzws+'').replace(reg,'')).toFixed(2));
            				mbkzl.push(parseFloat((demo.mbkzl+'').replace(reg,'')).toFixed(2));
            				mbtd.push(parseFloat((demo.mbtd+'').replace(reg,'')).toFixed(2));
            				mbtdsr.push(parseFloat((demo.mbtdsr+'').replace(reg,'')).toFixed(2));
            				mbsr.push(parseFloat((demo.mbsr+'').replace(reg,'')).toFixed(2));
            			}
            			if(key.split('-').length==3){
            				peoples3.push(zkl);
            				peoples3.push(zzws);
            				peoples3.push(zbc);
            				peoples3.push(ztd);
            				peoples3.push(ztdsr);
            				peoples3.push(zsr);
            				peoples4.push(mbkl);
            				peoples4.push(mbzws);
            				peoples4.push(mbtd);
            				peoples4.push(mbkzl);
            				peoples4.push(mbtdsr);
            				peoples4.push(mbsr);
            				data3.peoples = peoples3;
            				data4.peoples = peoples4;
            			}else{
            				movements1.push(zkl);
            				movements1.push(zzws);
            				movements1.push(zbc);
            				movements1.push(ztd);
            				movements1.push(ztdsr);
            				movements1.push(zsr);
            				movements2.push(mbkl);
            				movements2.push(mbzws);
            				movements2.push(mbtd);
            				movements2.push(mbkzl);
            				movements2.push(mbtdsr);
            				movements2.push(mbsr);
            			}
            		}
            		movements3[key] = movements1;
            		movements4[key] = movements2;
            	}
            	data3.movements = movements3;
            	selName.push('团队');
            	selName.push('散客');
            	data4.movements = movements4;
            	data1.pieceData = pieceData1;
            	data1.selName = selName;
            	data1.segment = segment1;
            	data2.pieceData = pieceData2;
            	data2.selName = selName;
            	data2.segment = segment2;
            	xArray = xText;//x轴赋值
            }
            if(bz){
        		$(".lin-historical-body").addClass("muhu");
        		$(".err").css("display","block");
        	}else{
        		$(".lin-historical-body").removeClass("muhu");
        		$(".err").css("display","none");
        	}
            addElement();
        }
    });

	console.log(parent.supData);
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
function fmoney(s, n) {  
    n = n > 0 && n <= 20 ? n : 0;  
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
    var l = s.split(".")[0].split("").reverse(), r = s.split(".").length==2?s.split(".")[1]:'';  
    t = "";  
    for (var i = 0; i < l.length; i++) {  
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
    }  
    return t.split("").reverse().join("") + (r==''?r:"." + r);  
}