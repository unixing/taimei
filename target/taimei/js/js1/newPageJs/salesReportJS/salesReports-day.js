var searchJson1={};
var indexflag = 1;
//存放选择的天数
var day = "";
var object = parent.supData;
var airports = parent.airportMap;
var flight = '';
var airFltNbr = parent.supData.flight;
var flightTemp = new Array();
if(airFltNbr!=""&&typeof(airFltNbr)!="undefined"){
	flightTemp = airFltNbr.split('/');
}
if(flightTemp.length>=2){
	var flttemp = parseInt(flightTemp[0].substring(2,6))+1;
	flight =flightTemp[0]+"/"+flightTemp[0].substring(0,2)+flttemp;
}
$(function(){
	parent.supData.linFlag = "0"; 
	 $("#flyTime").keydown(function(event){
	    event=document.all?window.event:event;
	    if((event.keyCode || event.which)==13){
	    	exchate();
	    }
    }); 
	//为查询按钮绑定事件
	$("._set-query").on("click",function(e){
		e.stopPropagation(); //屏蔽事件冒泡
		var searchJson = getParameter();
		send(searchJson);
	}) ;
    /*********************************************请求数据********************************************/
	
	var lane = object.lane;
	if(lane!=null&&lane!=''&&lane!='undefined'&&lane!="="&&lane!="=="){
		var dpt = lane.split("=");
		if(dpt.length==3){
			var dptabbr = dpt[0] + "-" + airports[dpt[0]].iata;
			var pstabbr = dpt[1] + "-" + airports[dpt[1]].iata;
			var arrabbr = dpt[2] + "-" + airports[dpt[2]].iata;
			$('#dpt_AirPt_Cd').attr("abbr",dptabbr);
			$('#pas_stp').attr("abbr",pstabbr);
			$('#arrv_Airpt_Cd').attr("abbr",arrabbr);
			$('#dpt_AirPt_Cd').val(dpt[0]);
			$('#pas_stp').val(dpt[1]);
			$('#arrv_Airpt_Cd').val(dpt[2]);
		}else{
			var dptabbr = dpt[0] + "-" + airports[dpt[0]].iata;
			var arrabbr = dpt[1] + "-" + airports[dpt[1]].iata;
			$('#dpt_AirPt_Cd').attr("abbr",dptabbr);
			$('#arrv_Airpt_Cd').attr("abbr",arrabbr);
			$('#dpt_AirPt_Cd').val(dpt[0]);
			$('#arrv_Airpt_Cd').val(dpt[1]);
		}
	}
	getFlt_Nbr();
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
    changeCK();
    var saveData={};
    var data = {};
    function send(searchJson){
    	var dpt_AirPt_Cd = $('#dpt_AirPt_Cd').val();
    	var pas_stp = $('#pas_stp').val();
    	var arrv_Airpt_Cd = $('#arrv_Airpt_Cd').val();
    	var flt_nbr_Count = $('._set-list-title').html();
    	//关闭所有选择框
    	$(".sr-box-body-chart").removeClass("muhu");
		$(".reportErr").css("display","none");
		$(".time-line").css("display","block");
		//起始机场判断
		if(dpt_AirPt_Cd==''){
			alert('请选择起始机场');
			$(".sr-box-body-chart").addClass("muhu");
    		$(".reportErr").css("display","block");
    		$(".time-line").css("display","none");
    		$(this).initDatee();
			return;
		}
		if(arrv_Airpt_Cd==''){
			alert('请选择到达机场');
			$(".sr-box-body-chart").addClass("muhu");
    		$(".reportErr").css("display","block");
    		$(".time-line").css("display","none");
    		$(this).initDatee();
			return;
		}
		//查询条件联动
    	var object = parent.supData;
    	if(pas_stp!=""){
    		object.lane =dpt_AirPt_Cd + "=" + pas_stp + "=" + arrv_Airpt_Cd ;
    	}else{
    		object.lane =dpt_AirPt_Cd + "=" + arrv_Airpt_Cd ;
    	}
    	if(flt_nbr_Count!=""){
    		var flt = flt_nbr_Count.split("/");
    		var ff = flt[0]+"/"+flt[1].substring(flt[1].length-2,flt[1].length);
    		object.flight = ff;
    	}else{
    		object.flight = "";
    	}
    	if(searchJson.flt_nbr_Count==null||searchJson.flt_nbr_Count==''){
    		alert('没有对应航班号');
    		$(".sr-box-body-chart").addClass("muhu");
    		$(".reportErr").css("display","block");
    		$(".time-line").css("display","none");
    		$(this).initDatee();
    		return;
    	}
    	$.ajax({
    		url:'restful/getDailyReportDataNew',
            dataType : 'jsonp',
            data:getairCode(searchJson),
            async:false,
            success : function(datas) {
                if(datas){
                	//对日期排序
                	set=0;
                	//清空所有画线的点
                	$("#datee").val(datas.success.datee);
                	$(this).initDatee();
                    point={};
                	sureHangxiandatas(datas);
                	data = datas;
                	saveData=datas;
                    mid(datas);
                    coll(datas,sortDate(datas));
                    initalData(datas);
                    day = datas.success.datee;
                    //默认第三个图的往返
                    $("#income-set").find("li").eq(0).css("background-color","rgb(42, 62, 99)");
                    $("#income-set").find("li").eq(1).css("background-color","rgb(90, 122, 169)");
                    $("#income-set").find("li").eq(2).css("background-color","rgb(42, 62, 99)");
                    if(jQuery.isEmptyObject(datas.success.map.data_person)){
            			$(".sr-box-body-chart").addClass("muhu");
                		$(".reportErr").css("display","block");
                		$(".time-line").css("display","none");
                		$(this).initDatee();
            		}
                }
            },
            error : function() {
            }
        }
    );
    }
    function sortDate(datas){
    	var tempDate = datas.success.map.date;
    	var arrDate = new Array();
    	var arrMS = new Array();
    	var d = new Date();
    	d.setHours(0,0,0,0);
    	for(var key in tempDate) {
    		var arrTmp = key.split('-');
    		arrMS.push(d.setFullYear(arrTmp[0],arrTmp[1] - 1,arrTmp[2]));
		}
    	arrMS.sort();
    	for (var i = 0; i < arrMS.length; i ++) {
    	    d.setTime(arrMS[i]);
    	    var month=d.getMonth()+1; 
    	 	var day = d.getDate(); 
    	 	if(month<10){ 
    	 		month = "0"+month; 
    	 	} 
    	 	if(day<10){ 
    	 		day = "0"+day; 
    	 	} 
    	 	var val = d.getFullYear()+"-"+month+"-"+day; 
    	    arrDate.push(val);
    	}
    	var retTemp = new Object();
    	for(var i=0;i<arrDate.length;i++){
    		var dd = arrDate[i].split("-");
    		retTemp[parseInt(dd[1])+"."+dd[2]] = tempDate[arrDate[i]];
    	}
    	return retTemp;
    }
    function sureHangxiandatas(datas){
    	if(typeof(datas.success.Pas_stp)!="undefined"){
    		$('#dpt_AirPt_Cd').val(datas.success.Dpt_AirPt_Cd);
    		$('#pas_stp').val(datas.success.Pas_stp);
    		$('#arrv_Airpt_Cd').val(datas.success.Arrv_Airpt_Cd);
    		var dptabbr = datas.success.Dpt_AirPt_Cd + "-" + datas.success.Dpt_AirPt_Cd_code;
			var pstabbr = datas.success.Pas_stp + "-" + datas.success.Pas_stp_code;
			var arrabbr = datas.success.Arrv_Airpt_Cd + "-" + datas.success.Arrv_Airpt_Cd_code;
			$('#dpt_AirPt_Cd').attr("abbr",dptabbr);
			$('#pas_stp').attr("abbr",pstabbr);
			$('#arrv_Airpt_Cd').attr("abbr",arrabbr);
    	}else{
    		$('#dpt_AirPt_Cd').val(datas.success.Dpt_AirPt_Cd);
    		$('#arrv_Airpt_Cd').val(datas.success.Arrv_Airpt_Cd);
    		var dptabbr = datas.success.Dpt_AirPt_Cd + "-" + datas.success.Dpt_AirPt_Cd_code;
			var arrabbr = datas.success.Arrv_Airpt_Cd + "-" + datas.success.Arrv_Airpt_Cd_code;
			$('#dpt_AirPt_Cd').attr("abbr",dptabbr);
			$('#arrv_Airpt_Cd').attr("abbr",arrabbr);
    	}
    }
    function setTotalTime(flyTime){
    	$("#flyTime").val(flyTime);
    }
    function initalData(data){
        if($(".change-line-o").hasClass("change-line-o2")){
            $(".change-line-o").removeClass("change-line-o2");
            $(".change-line").removeClass("change-line2");
        };
        if(typeof(data.success.Pas_stp_code)=="undefined"){
            $(".change-line-o").addClass("change-line-o2");
            $(".change-line").addClass("change-line2");
        }
    	$("#qone").html(data.success.goNum);
    	$("#hone").html(data.success.backNum);
    	$("#qone2").html(data.success.goNum);
    	$("#hone2").html(data.success.backNum);
    	$(".time-line-fli").html(data.success.goNum+"/"+data.success.backNum);
    	$(".change-line-f").find("p").html(airports[data.success.Dpt_AirPt_Cd_code].iata);
    	$(".change-line-f").find("div").html(airports[data.success.Dpt_AirPt_Cd].aptChaNam);
    	
    	$(".change-line-o").find("p").html(data.success.Pas_stp_code);
    	$(".change-line-o").find("div").html(data.success.Pas_stp);
    	
    	$(".change-line-l").find("p").html(airports[data.success.Arrv_Airpt_Cd_code].iata);
    	$(".change-line-l").find("div").html(airports[data.success.Arrv_Airpt_Cd].aptChaNam);
    	searchJson1.dpt_AirPt_Cd = data.success.Dpt_AirPt_Cd_code;
    	searchJson1.pas_stp = typeof(data.success.Pas_stp_code)=='undefined'?"":data.success.Pas_stp_code;
    	searchJson1.arrv_Airpt_Cd = data.success.Arrv_Airpt_Cd_code;
    }
    function mid(data){
        changew();
        deductive(data,0);//默认加载全部航线
        nodeData();
    }
    function nodeData(){
        $(".Flight-num").eq(0).html(saveData.success.goNum);
        $(".Flight-num").eq(1).html(saveData.success.backNum);
    }
/***********************************************canvas区域************************************/
    /***各种封装****/
   
    function changew(){
        /*计算中间块大小*/
        var Lwidth=infer(".sr-box-body-report")[0];
        var Zwidth=infer(".sr-box")[0];
        var Rwidth=infer(".sr-box-body-date")[0];
        var Swidth=Zwidth-Lwidth-Rwidth-2;
        $(".sr-box-body-chart").css("width",Swidth+"px");
        /*计算绘图区域大小*/
        var Cheight=infer(".sr-box-body-chart-income")[1]-infer(".p-height")[1]-infer(".p-height")[2]-infer(".d-height")[1];
        var Cwidth=infer(".graph-table")[0];
        $(".graph-table").css("height",Cheight);
        $("#income").attr({"width":Cwidth,"height":Cheight});
        $("#canvas").attr({"width":Cwidth,"height":Cheight});
        $("#graph-line").attr({"width":Cwidth,"height":Cheight});
    }
    $(window).resize(function(){
		changeCK();
        initalData(data);
        mid(saveData);
        setTimeout(function(){
        	coll(data,sortDate(datas));
        },50);
    });
    changew();
    /*************************************************客量，折扣图********************************************/
    $("body").mouseup(function(){//鼠标松开取消事件绑定
        $("#income-set>li:nth-of-type(3)").unbind("mousemove");
    });
    /*************************************************客量，折扣图********************************************/
    var set=0;
    $("#income-set>li:nth-of-type(1)").on("click",function(){
        $(this).css("background-color","#5a7aa9").siblings().css("background-color","#2a3e63");
        set=data.success.goNum;
        deductive(saveData,set);
    });
    $("#income-set>li:nth-of-type(2)").on("click",function(){
        $(this).css("background-color","#5a7aa9").siblings().css("background-color","#2a3e63");
        set=0;
        deductive(saveData,set);
    });
    $("#income-set>li:nth-of-type(3)").on("click",function(){
        $(this).css("background-color","#5a7aa9").siblings().css("background-color","#2a3e63");
        set=data.success.backNum;
        deductive(saveData,set);
    });
    /*小标签*/
    function icon(ctx,come){
        var gBox=infer("#graph-line");
        ctx.save();//保存环境
        if(come=="go"){
            var data=[0.4,0.63];
            for(var i=0;i<data.length;i++){
                ctx.beginPath();
                ctx.fillStyle="#2a416b";
                ctx.fillRect(gBox[0]*data[i]+5,gBox[1]*0.5-3,3,6);
                ctx.translate(5,0);
                ctx.fillRect(gBox[0]*data[i]+4,gBox[1]*0.5-3,4,6);
                ctx.translate(10,0);
                ctx.moveTo(gBox[0]*data[i],gBox[1]*0.5);
                ctx.lineTo(gBox[0]*data[i],gBox[1]*0.5-3);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5-3);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5-6);
                ctx.lineTo(gBox[0]*data[i]+12,gBox[1]*0.5);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5+6);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5+3);
                ctx.lineTo(gBox[0]*data[i],gBox[1]*0.5+3);
                ctx.lineTo(gBox[0]*data[i],gBox[1]*0.5);
                ctx.fill();
            }
        }else if(come=="goandback"){
            ctx.beginPath();
            ctx.fillStyle="#2a416b";
            ctx.fillRect(gBox[0]*0.4+4,gBox[1]*0.5-3,3,6);
            ctx.translate(5,0);
            ctx.fillRect(gBox[0]*0.4+4,gBox[1]*0.5-3,4,6);
            ctx.translate(10,0);
            ctx.moveTo(gBox[0]*0.4,gBox[1]*0.5);
            ctx.lineTo(gBox[0]*0.4,gBox[1]*0.5-3);
            ctx.lineTo(gBox[0]*0.4+6,gBox[1]*0.5-3);
            ctx.lineTo(gBox[0]*0.4+6,gBox[1]*0.5-6);
            ctx.lineTo(gBox[0]*0.4+12,gBox[1]*0.5);
            ctx.lineTo(gBox[0]*0.4+6,gBox[1]*0.5+6);
            ctx.lineTo(gBox[0]*0.4+6,gBox[1]*0.5+3);
            ctx.lineTo(gBox[0]*0.4,gBox[1]*0.5+3);
            ctx.lineTo(gBox[0]*0.4,gBox[1]*0.5);
            ctx.fill();
            ctx.beginPath();
            ctx.translate(-5,0);
            ctx.moveTo(gBox[0]*0.65,gBox[1]*0.5);
            ctx.lineTo(gBox[0]*0.65+6,gBox[1]*0.5-6);
            ctx.lineTo(gBox[0]*0.65+6,gBox[1]*0.5-3);
            ctx.lineTo(gBox[0]*0.65+12,gBox[1]*0.5-3);
            ctx.lineTo(gBox[0]*0.65+12,gBox[1]*0.5+3);
            ctx.lineTo(gBox[0]*0.65+6,gBox[1]*0.5+3);
            ctx.lineTo(gBox[0]*0.65+6,gBox[1]*0.5+6);
            ctx.lineTo(gBox[0]*0.65,gBox[1]*0.5);
            ctx.fillStyle="#2a416b";
            ctx.fillRect(gBox[0]*0.65+14,gBox[1]*0.5-3,3,6);
            ctx.fillRect(gBox[0]*0.65+19,gBox[1]*0.5-3,4,6);
            ctx.fill();
        }else if(come=="back"){
            var data=[0.4,0.65];
            for(var i=0;i<data.length;i++){
                ctx.beginPath();
                ctx.translate(3,0);
                ctx.moveTo(gBox[0]*data[i],gBox[1]*0.5);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5-6);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5-3);
                ctx.lineTo(gBox[0]*data[i]+12,gBox[1]*0.5-3);
                ctx.lineTo(gBox[0]*data[i]+12,gBox[1]*0.5+3);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5+3);
                ctx.lineTo(gBox[0]*data[i]+6,gBox[1]*0.5+6);
                ctx.lineTo(gBox[0]*data[i],gBox[1]*0.5);
                ctx.fillStyle="#2a416b";
                ctx.fillRect(gBox[0]*data[i]+14,gBox[1]*0.5-3,3,6);
                ctx.fillRect(gBox[0]*data[i]+20,gBox[1]*0.5-3,4,6);
                ctx.fill();
            }
        }
        ctx.restore();//恢复环境

    }
    /*画图*/
    function deductive(data,exp){
    	var les="goandback";
    	if(exp!=0){
    		var num= exp.replace(/[^0-9]/ig,"");
    		if(parseInt(num)%2==1){
    			les="go";
    		}else{
    			les="back";
    		}
    	}
        var gBox=infer("#graph-line");
        var ctx=document.getElementById('graph-line').getContext('2d');//获取对象\
        ctx.clearRect(0,0,gBox[0],gBox[1]);
        ctx.beginPath();
        //X轴
        //1段
        ctx.moveTo(gBox[0]*0.07,gBox[1]*0.5);
        ctx.lineTo(gBox[0]*0.4,gBox[1]*0.5);
        //2段
        ctx.moveTo(gBox[0]*0.45,gBox[1]*0.5);
        ctx.lineTo(gBox[0]*0.65,gBox[1]*0.5);
        //3段
        ctx.moveTo(gBox[0]*0.7,gBox[1]*0.5);
        ctx.lineTo(gBox[0]*0.9,gBox[1]*0.5);
        /************无经停***************/
        //Y轴
        ctx.moveTo(gBox[0]*0.16,0);
        ctx.lineTo(gBox[0]*0.16,gBox[1]);
        ctx.strokeStyle="#2c4170";
        ctx.lineWidth="1";
        //城市文字
        ctx.fillStyle="#2d4062";
        ctx.font="bold 45px 微软雅黑";
        ctx.textAlign="center";
        ctx.fillText("客量",gBox[0]*0.55,gBox[1]*0.25);
        ctx.fillText("平均折扣",gBox[0]*0.55,gBox[1]*0.75);
        ctx.textAlign="start";
        ctx.fillStyle="white";
        ctx.font="12px 微软雅黑";
        ctx.fillText(data.success.Dpt_AirPt_Cd,gBox[0]*0.3-20,gBox[1]*0.56);
        if(data.success.Pas_stp){
            ctx.fillText(data.success.Pas_stp,gBox[0]*0.55-20,gBox[1]*0.56);
        }
        ctx.fillText(data.success.Arrv_Airpt_Cd,gBox[0]*0.8-20,gBox[1]*0.56);
        ctx.stroke();
        //三字码
        ctx.beginPath();
        ctx.fillStyle="white";
        ctx.font="20px 微软雅黑";
        ctx.fillText(data.success.Dpt_AirPt_Cd_code,gBox[0]*0.3-20,gBox[1]*0.47);
        if(data.success.Pas_stp){
            ctx.fillText(data.success.Pas_stp_code,gBox[0]*0.55-20,gBox[1]*0.47);
        }
        ctx.fillText(data.success.Arrv_Airpt_Cd_code,gBox[0]*0.8-20,gBox[1]*0.47);
        /*调用函数*/
        icon(ctx,les);//调用icon函数
        lines(data,exp);
    }
    /**********************************图线***************************************/
    /*绘制函数*/
    var point={};//数据
    function draw(pro,tag,num,p){
        var gBox=infer("#graph-line");
        var ctx=document.getElementById('graph-line').getContext('2d');//获取对象
        ctx.beginPath();
        ctx.moveTo(tag.Bl[0],gBox[1]*tag.Yt);
        ctx.lineTo(tag.Bl[1],pro);
        ctx.lineTo(tag.Bl[2],gBox[1]*tag.Yt);
        ctx.strokeStyle=tag.color;
        ctx.lineWidth="3";
        ctx.lineCap="round";
        ctx.stroke();
        if(num==1){
            ctx.beginPath();
            ctx.fillStyle=tag.color;
            ctx.arc(tag.Bl[1],pro,5,0,2*Math.PI);
            ctx.fill();
        }else if(num==0){
            ctx.beginPath();
            ctx.fillStyle=tag.color;
            ctx.rect(tag.Bl[1]-5,pro-5,10,10);
            ctx.fill();
        }
        /*数据*/
        if(!point[p]){
            point[p]=[];
            point[p].push(tag.Bl[1]);
            point[p].push(pro);
        }else {
            point[p].push(tag.Bl[1]);
            point[p].push(pro);
        }
    }
    /*控制函数*/
    function lines(data,swit){
        var gBox=infer("#graph-line");
        /*去最大值做Y轴参照*/
        var nums=data.success.map.data_person;
        var maxp=0;
        var maxt=0;
        for(var p in nums){
            if(parseFloat(nums[p].pgs_Per_Cls)>maxp){
                maxp=nums[p].pgs_Per_Cls;
            }
            if(parseFloat(nums[p].avg_Dct)>maxt){
                maxt=nums[p].avg_Dct;
            }
        }
       
        /*经停航线*/
        if(data.success.Pas_stp){
            /*客座率*/
            if(swit==0){
                var tData={color:"",Bl:[],Yt:0.38};
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].pgs_Per_Cls)/maxp;
                    Ycoor=gBox[1]*0.38-Ycoor+8;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#d6552e";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短段1*/
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#1c4b81";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#1270c7";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短2*/
                    if(data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#276c73";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#64c8d8";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                };
                /*折扣*/
                var tData={color:"",Bl:[],Yt:0.62};
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].avg_Dct)/maxt;
                    Ycoor=gBox[1]*0.62+Ycoor-13;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#d6552e";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短段1*/
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#1270c7";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,0,p);
                    }
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#1c4b81";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,1,p);
                    }
                    /*短2*/
                    if(data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#276c73";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#64c8d8";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                };
            }else if(swit==data.success.goNum){
                var tData={color:"",Bl:[],Yt:0.38};
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].pgs_Per_Cls)/maxp;
                    Ycoor=gBox[1]*0.38-Ycoor+8;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    /*短段1*/
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#1c4b81";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,1,p);
                    }
                    /*短2*/
                    if(data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#276c73";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                };
                /*折扣*/
                var tData={color:"",Bl:[],Yt:0.62};//////////////////////////////////////////////////
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].avg_Dct)/maxt;
                    Ycoor=gBox[1]*0.62+Ycoor-13;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    /*短段1*/
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#1c4b81";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,1,p);
                    }
                    /*短2*/
                    if(data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#276c73";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                };
            }else if(swit==data.success.backNum){
                var tData={color:"",Bl:[],Yt:0.38};
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].pgs_Per_Cls)/maxp;
                    Ycoor=gBox[1]*0.38-Ycoor+8;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#d6552e";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短段1*/
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#1270c7";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短2*/
                    if(data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#64c8d8";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                };
                /*折扣*/
                var tData={color:"",Bl:[],Yt:0.62};//////////////////////////////////////////////////
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].avg_Dct)/maxt;
                    Ycoor=gBox[1]*0.62+Ycoor-13;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#d6552e";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短段1*/
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Pas_stp_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#1270c7";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.3+(gBox[0]*0.55-gBox[0]*0.3)/2,gBox[0]*0.55];
                        draw(Ycoor,tData,0,p);
                    }
                    /*短2*/
                    if(data.success.Pas_stp_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#64c8d8";
                        tData.Bl=[gBox[0]*0.55,gBox[0]*0.55+(gBox[0]*0.8-gBox[0]*0.55)/2,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                };
            }
        }else {//非经停航线
            if(swit==0){
                var tData={color:"",Bl:[],Yt:0.38};
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].pgs_Per_Cls)/maxp;
                    Ycoor=gBox[1]*0.38-Ycoor+8;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#d6552e";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                }
                var tData={color:"",Bl:[],Yt:0.62};
                for(var p in nums){
                    /*折扣*/
                    var Ycoor=(gBox[1]*0.38*nums[p].avg_Dct)/maxt;
                    Ycoor=gBox[1]*0.62+Ycoor-13;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                        tData.color="#d6552e";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,0,p);
                    }
                };
            }else if(swit==data.success.goNum){
                var tData={color:"",Bl:[],Yt:0.38};
                for(var p in nums){
                    /*直段线*/
                    var Ycoor=(gBox[1]*0.38*nums[p].pgs_Per_Cls)/maxp;
                    Ycoor=gBox[1]*0.38-Ycoor+8;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                }
                var tData={color:"",Bl:[],Yt:0.62};
                for(var p in nums){
                    /*折扣*/
                    var Ycoor=(gBox[1]*0.38*nums[p].avg_Dct)/maxt;
                    Ycoor=gBox[1]*0.62+Ycoor-13;
                    if(data.success.Dpt_AirPt_Cd_code==nums[p].dpt_AirPt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].arrv_Airpt_Cd){
                        tData.color="#582218";
                        tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                        draw(Ycoor,tData,1,p);
                    }
                };
            }else if(swit==data.success.backNum){
            	 var tData={color:"",Bl:[],Yt:0.38};
                 for(var p in nums){
                     /*直段线*/
                     var Ycoor=(gBox[1]*0.38*nums[p].pgs_Per_Cls)/maxp;
                     Ycoor=gBox[1]*0.38-Ycoor+8;
                     if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                         tData.color="#d6552e";
                         tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                         draw(Ycoor,tData,0,p);
                     }
                 }
                 var tData={color:"",Bl:[],Yt:0.62};
                 for(var p in nums){
                     /*折扣*/
                     var Ycoor=(gBox[1]*0.38*nums[p].avg_Dct)/maxt;
                     Ycoor=gBox[1]*0.62+Ycoor-13;
                     if(data.success.Dpt_AirPt_Cd_code==nums[p].arrv_Airpt_Cd&&data.success.Arrv_Airpt_Cd_code==nums[p].dpt_AirPt_Cd){
                         tData.color="#d6552e";
                         tData.Bl=[gBox[0]*0.3,gBox[0]*0.55,gBox[0]*0.8];
                         draw(Ycoor,tData,0,p);
                     }
                 };
            }
               
        }
    };
    /*点线*/
    function drawDashedLine(context, x1, y1, x2, y2, dashLength) {
        dashLength = dashLength === undefined ? 5 : dashLength;
        var deltaX = x2 - x1;
        var deltaY = y2 - y1;
        var numDashes = Math.floor(
            Math.sqrt(deltaX * deltaX + deltaY * deltaY) / dashLength);
        for (var i=0; i < numDashes; ++i) {
            context[ i % 2 === 0 ? 'moveTo' : 'lineTo' ]
            (x1 + (deltaX / numDashes) * i, y1 + (deltaY / numDashes) * i);
        }
        context.stroke();
    };
    /*获取鼠标点击事件*/
    var nusname="";//暂存当前移入的航线
    $("#graph-line").on("mousemove",function(e){
        var ctx=document.getElementById('graph-line').getContext('2d');//获取对象
        var cleX=e.offsetX;
        var cleY=e.offsetY;
        for(var key in point){
            if(point[key][0]-5<cleX&&point[key][0]+5>cleX&&point[key][1]-5<cleY&&point[key][1]+5>cleY){
                for( var e in saveData.success.map.data_person){
                    if(e==key){
                        if(set==0){
                            var people=saveData.success.map.data_person[key].pgs_Per_Cls;
                            $("body").css({cursor:"pointer"});
                            ctx.beginPath();
                            ctx.lineWidth="1";
                            ctx.strokeStyle="#2c416e";
                            drawDashedLine(ctx,infer("#graph-line")[0]*0.16,point[key][1],point[key][0],point[key][1],6);
                            $("#matter").html(people+"人").css({"opacity":"1",left:point[key][0],top:point[key][1],width:"60px",height:"24px"});
                            nusname=key;
                        }else if(saveData.success.map.data_person[e].flt_Nbr==set){
                            var people=saveData.success.map.data_person[key].pgs_Per_Cls;
                            $("body").css({cursor:"pointer"});
                            ctx.beginPath();
                            ctx.lineWidth="1";
                            ctx.strokeStyle="#2c416e";
                            drawDashedLine(ctx,infer("#graph-line")[0]*0.16,point[key][1],point[key][0],point[key][1],6);
                            $("#matter").html(people+"人").css({"opacity":"1",left:point[key][0],top:point[key][1],width:"60px",height:"24px"});
                            nusname=key;
                        }
                    }
                }
            }else if(point[key][2]-5<cleX&&point[key][2]+5>cleX&&point[key][3]-5<cleY&&point[key][3]+5>cleY){
                for( var e in saveData.success.map.data_person){
                    if(e==key){
                        if(set==0){
                            var dis=saveData.success.map.data_person[key].avg_Dct;
                            $("body").css({cursor:"pointer"});
                            ctx.beginPath();
                            ctx.lineWidth="1";
                            ctx.strokeStyle="#2c416e";
                            drawDashedLine(ctx,infer("#graph-line")[0]*0.16,point[key][3],point[key][2],point[key][3],6);
                            $("#matter").html(dis+"%").css({"opacity":"1",left:point[key][2],top:point[key][3],width:"60px",height:"24px"});
                            nusname=key;
                        }else if(saveData.success.map.data_person[e].flt_Nbr==set){
                            var dis=saveData.success.map.data_person[key].avg_Dct;
                            $("body").css({cursor:"pointer"});
                            ctx.beginPath();
                            ctx.lineWidth="1";
                            ctx.strokeStyle="#2c416e";
                            drawDashedLine(ctx,infer("#graph-line")[0]*0.16,point[key][3],point[key][2],point[key][3],6);
                            $("#matter").html(dis+"%").css({"opacity":"1",left:point[key][2],top:point[key][3],width:"60px",height:"24px"});
                            nusname=key;
                        }
                    }
                }
            } else {
                if(nusname!=""){//关闭信息框
                    if(nusname==key){
                        $("body").css({cursor:""});
                        $("#matter").html("").css({"opacity":"0",left:point[key][0],top:point[key][1],width:"0px",height:"0px"});
                        var gBox=infer("#graph-line");
                        ctx.clearRect(0,0,gBox[0],gBox[1]);
//                        point={}
//                        nusname="";
                        deductive(saveData,set);
                    }
                }
            }
        }
       
    });
    /**********************绘图函数*********echarts******************/
    function theCurve(name,xdata,totaldata,godata,backdata,gozhibiaoData,backzhibiaoData,goAndBackzhibiaoData){
        var dom = document.getElementById(name);
        var myChart = echarts.init(dom);
        if(xdata.length==1){
        	var xArr=[" "];
        	xArr.push(xdata[0])
        	xdata=xArr;
        	var xArr=["0"];
        	xArr.push(totaldata[0])
        	totaldata=xArr;
        	var xArr=["0"];
        	xArr.push(godata[0])
        	godata=xArr;
        	var xArr=["0"];
        	xArr.push(backdata[0])
        	backdata=xArr;
        	option = {
                    grid: {
                        top:'20%',
                        left: '0%',
                        right: '20%',
                        bottom: '7%',
                        containLabel: true
                    },
                    toolbox: {
                        show:false,
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: xdata,
                        silent:true,
                        axisLine:{
                            show:true,
                            lineStyle:{
                                color:"#2e416c"
                            }
                        },
                        axisLabel:{
                            textStyle:{
                                color:"white"
                            }
                        },
                        splitLine:{
                            show:true,
                            lineStyle:{
                                color:"#304b76",
                                opacity:0.6
                            }
                        }
                    },
                    yAxis: {
                        type: 'value',
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
                    },
                    series: [
                        {
                            name:'合计',
                            smooth: true,
                            type:'line',
                            symbolSize:0,
                            showSymbol:false,
                            markPoint:{
                                symbol:"circle",
                                silent:true,
                                symbolSize:15,
                                data:[ {
                                    yAxis: goAndBackzhibiaoData,
                                    x: '80%',
                                }],
                                label:{
                                    normal:{
                                        show:false
                                    }
                                },
                                itemStyle:{
                                    normal:{
                                        color:"#bd5741"
                                    }
                                }
                            },
                            lineStyle: {
                                normal: {
                                    width: 4,
                                    color: 'transparent'
                                }
                            },
                            data:totaldata
                        },
                        {
                            name:'去程',
                            type:'line',
                            smooth: true,
                            symbolSize:0,
                            showSymbol:false,
                            markPoint:{
                                symbol:"circle",
                                symbolSize:15,
                                silent:true,
                                data:[{
                                    name: '固定 x 像素位置',
                                    yAxis: gozhibiaoData,
                                    x: '80%',
                                    symbolSize:15,
                                    label:{
                                        normal:{
                                            show:false
                                        }
                                    },
                                    itemStyle:{
                                        normal:{
                                            color:"#63c7d7"
                                        }
                                    }
                                }]

                            },
                            lineStyle: {
                                normal: {
                                    width: 4,
                                    color: 'transparent'
                                }
                            },
                            data:godata
                        },
                        {
                            name:'返程',
                            type:'line',
                            smooth: true,
                            symbolSize:0,
                            showSymbol:false,
                            markPoint:{
                                symbol:"circle",
                                symbolSize:15,
                                silent:true,
                                data:[{
                                    name: '固定 x 像素位置',
                                    yAxis: backzhibiaoData,
                                    x: '80%'
                                }],
                                label:{
                                    normal:{
                                        show:false
                                    }
                                },
                                itemStyle:{
                                    normal:{
                                        color:"#1b72bf"
                                    }
                                }
                            },
                            lineStyle: {
                                normal: {
                                    width: 4,
                                    color: 'transparent'
                                }
                            },
                            data:backdata
                        }
                    ]
                };
        }else{
        	option = {
                    grid: {
                        top:'20%',
                        left: '0%',
                        right: '20%',
                        bottom: '7%',
                        containLabel: true
                    },
                    toolbox: {
                        show:false,
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: xdata,
                        silent:true,
                        axisLine:{
                            show:true,
                            lineStyle:{
                                color:"#2e416c"
                            }
                        },
                        axisLabel:{
                            textStyle:{
                                color:"white"
                            }
                        },
                        splitLine:{
                            show:true,
                            lineStyle:{
                                color:"#304b76",
                                opacity:0.6
                            }
                        }
                    },
                    yAxis: {
                        type: 'value',
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
                    },
                    series: [
                        {
                            name:'合计',
                            smooth: true,
                            type:'line',
                            symbolSize:0,
                            showSymbol:false,
                            markPoint:{
                                symbol:"circle",
                                silent:true,
                                symbolSize:15,
                                data:[ {
                                    yAxis: goAndBackzhibiaoData,
                                    x: '80%'
                                }],
                                label:{
                                    normal:{
                                        show:false
                                    }
                                },
                                itemStyle:{
                                    normal:{
                                        color:"#bd5741"
                                    }
                                }
                            },
                            lineStyle: {
                                normal: {
                                    width: 4,
                                    color: '#bd5741'
                                }
                            },
                            data:totaldata
                        },
                        {
                            name:'去程',
                            type:'line',
                            smooth: true,
                            symbolSize:0,
                            showSymbol:false,
                            markPoint:{
                                symbol:"circle",
                                symbolSize:15,
                                silent:true,
                                data:[{
                                    name: '固定 x 像素位置',
                                    yAxis: gozhibiaoData,
                                    x: '80%',
                                    symbolSize:15,
                                    label:{
                                        normal:{
                                            show:false
                                        }
                                    },
                                    itemStyle:{
                                        normal:{
                                            color:"#63c7d7"
                                        }
                                    }
                                }]

                            },
                            lineStyle: {
                                normal: {
                                    width: 4,
                                    color: '#63c7d7'
                                }
                            },
                            data:godata
                        },
                        {
                            name:'返程',
                            type:'line',
                            smooth: true,
                            symbolSize:0,
                            showSymbol:false,
                            markPoint:{
                                symbol:"circle",
                                symbolSize:15,
                                silent:true,
                                data:[{
                                    name: '固定 x 像素位置',
                                    yAxis: backzhibiaoData,
                                    x: '80%'
                                }],
                                label:{
                                    normal:{
                                        show:false
                                    }
                                },
                                itemStyle:{
                                    normal:{
                                        color:"#1b72bf"
                                    }
                                }
                            },
                            lineStyle: {
                                normal: {
                                    width: 4,
                                    color: '#1b72bf'
                                }
                            },
                            data:backdata
                        }
                    ]
                };
        }
        myChart.setOption(option,true);
    }
    /*4图*/
    function dailyReport(id,dayData){
        var xData = [];
        var yPrice = [];
        var totalData = [];
        var dpt = $('#dpt_AirPt_Cd').val();
    	var pas = $('#pas_stp').val();
    	var arrv = $('#arrv_Airpt_Cd').val();
    	var colorArray = {};
    	if(pas==''){
        	colorArray[arrv+'-'+dpt] = '#d85430';
        	colorArray[dpt+'-'+arrv] = '#662210';
    	}else{
    		colorArray[pas+'-'+dpt] = '#1470c5';
        	colorArray[arrv+'-'+dpt] = '#d85430';
        	colorArray[arrv+'-'+pas] = '#64c7d9';
        	colorArray[dpt+'-'+pas] = '#1c4b81';
        	colorArray[dpt+'-'+arrv] = '#662210';
        	colorArray[pas+'-'+arrv] = '#246b71';
    	}
        var salesreportmap = dayData.data_person;
        var disc_len ;
        var xdata = ['F'];//['F\n200%','Y\n100%','B\n90%','H\n85%','K\n80%','L\n75%','M\n70%','Q\n60%','X\n50%','U\n45%','E\n40%','G','特殊']
        for(var key in salesreportmap ){
        	disc_len = salesreportmap[key].airdiscounts.length;
        }
      
        for(var key in salesreportmap ){
        	var datainfo = new Array(disc_len-4);
        	xData.push({name:key,textStyle:{color:'#fff'}/*,icon:'line'*/});
        	var obj = salesreportmap[key];
        	yPrice.push('\nY:'+parseFloat(obj.yPrice).toFixed(0)+'元');
        	datainfo[0] = parseInt(obj.two_Tak_Ppt);
        	if(salesreportmap[key].eterm_account_id==''){
        		for(var disc= 1; disc<disc_len-3;disc++){
        			datainfo[disc] = parseInt(obj.airdiscounts[disc-1].dct_Pge);
        			xdata.push(obj.airdiscounts[disc-1].dct_Chr+"\n"+obj.airdiscounts[disc-1].dct_Ppt+"%");
        		}
        		xdata.push('特');
        		datainfo[disc_len-3] = parseInt(obj.sal_Tak_Ppt);
        		xdata.push('团队');
        		datainfo[disc_len-2] = parseInt(obj.grp_Nbr);
        		totalData.push({name:key,type:'bar',stack: 'sum',barWidth : 10,itemStyle : { normal: {label : {show: false, position: 'insideRight'},color: colorArray[key]}},data:datainfo});
        	}else{
	            for(var disc= 1; disc<disc_len+1;disc++){
	            	datainfo[disc] = parseInt(obj.airdiscounts[disc-1].dct_Pge);
	            	xdata.push(obj.airdiscounts[disc-1].dct_Chr+"\n"+obj.airdiscounts[disc-1].dct_Ppt+"%");
	            }
	            xdata.push('<\n20%');
	            datainfo[disc_len+1] = parseInt(obj.sal_Tak_Ppt);
	            xdata.push('团队');
	            datainfo[disc_len+2] = parseInt(obj.grp_Nbr);
	            totalData.push({name:key,type:'bar',stack: 'sum',barWidth : 10,itemStyle : { normal: {label : {show: false, position: 'insideRight'},color: colorArray[key]}},data:datainfo});
        	}
        }
        /*var lastOne = totalData[totalData.length-1];
        if(typeof(lastOne) == "undefined"){
        }else{
        	totalData[totalData.length-1] = {name:lastOne.name,type:'bar',stack: 'sum',barWidth :10,itemStyle : {normal: {label : {show: true,position: 'top',color:lastOne.itemStyle.color,formatter: function (params) {for (var i = 0, l = option.xAxis[0].data.length; i < l; i++) {if (option.xAxis[0].data[i] == params.name) {var sum = params.value;for(var j=0;j<option.series.length-1;j++){sum += option.series[j].data[i];}return sum>0?'合计\n'+sum+'人':'';}}},textStyle: {color: '#fff'}}}},data:lastOne.data}
        }*/
        var dom = document.getElementById(id);
        //用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
        var myChart = echarts.init(dom);
        option = {
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                },
                borderColor:'#d85430',
                borderWidth:1
            },
            backgroundColor:'#13233d',
            legend: {
                x:'6%',
                y:'top',
                height: dom.style.height,
                width: dom.style.width,
                data:xData,
                formatter: function (data){
                    for(var i=0;i<xData.length;i++){
                        if(data==xData[i].name){
                            return data+yPrice[i];
                        }
                    }
                }
            },
            toolbox: {
                show : false,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    axisLabel:{
                        interval: 0
                    },
                    data : xdata,
                    axisLine:{
                        show:true,
                        lineStyle:{
                            color:"#fff"
                        }
                    }
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    show : false
                }
            ],
            series : totalData
        };
        myChart.setOption(option,true);
    }
    function coll(data,tempdata){
    	var xdata_date = [];
    	var totaldata_income = [];
    	var godata_income = [];
    	var backdata_income = [];
    	var totaldata_canvas = [];
    	var godata_canvas = [];
    	var backdata_canvas = [];
    	var objMap = tempdata;
    	var gostzsrData = "";
    	var backstzsrData = "";
    	var goAndBackstzsrData = "";
    	var goxssrData = "";
    	var backxssrData = "";
    	var goAndBackxssrData = "";
    	var goset_Ktr_IneData = "";
    	var backset_Ktr_IneData = "";
    	var goAndBackset_Ktr_IneData = "";
    	var goegs_Lod_FtsData = "";
    	var backegs_Lod_FtsData = "";
    	var goAndBackegs_Lod_FtsData = "";
    	for(var a in objMap){
    		xdata_date.push(a);
    	}  
//    	xdata_date.sort(function(a,b){
//        	return a-b;
//        });
    	for(var i in xdata_date){
    		a = xdata_date[i];
    		totaldata_income.push(objMap[a].goAndBack.stzsr);
    		godata_income.push(objMap[a].go.stzsr);
    		backdata_income.push(objMap[a].back.stzsr);
    		
    		totaldata_canvas.push(objMap[a].goAndBack.egs_Lod_Fts);
    		godata_canvas.push(objMap[a].go.egs_Lod_Fts);
    		backdata_canvas.push(objMap[a].back.egs_Lod_Fts);
    	}
    	if(xdata_date.length>=1){
    		var a  = xdata_date[xdata_date.length-1];
        	gostzsrData = objMap[a].go.stzsr;
        	backstzsrData = objMap[a].back.stzsr;
        	goAndBackstzsrData = objMap[a].goAndBack.stzsr;
        	
        	goxssrData = objMap[a].go.xssr;
        	backxssrData = objMap[a].back.xssr;
        	goAndBackxssrData = objMap[a].goAndBack.xssr;
        	
        	goset_Ktr_IneData = objMap[a].go.set_Ktr_Ine;
        	backset_Ktr_IneData = objMap[a].back.set_Ktr_Ine;
        	goAndBackset_Ktr_IneData = objMap[a].goAndBack.set_Ktr_Ine;
        	
        	goegs_Lod_FtsData = objMap[a].go.egs_Lod_Fts;
        	backegs_Lod_FtsData = objMap[a].back.egs_Lod_Fts;
        	goAndBackegs_Lod_FtsData = objMap[a].goAndBack.egs_Lod_Fts;
    	}
        if((gostzsrData-backstzsrData)>0){
        	$("#goshouru").removeClass("graph-table-inf-go").removeClass("graph-table-inf-back");
        	$("#backshouru").removeClass("graph-table-inf-back").removeClass("graph-table-inf-go");
        	$("#goshouru").addClass("graph-table-inf-go");
            $("#backshouru").addClass("graph-table-inf-back");
        	$("#gostzsrData").html(gostzsrData);
            $("#backstzsrData").html(backstzsrData);
            $("#goAndBackstzsrData").html(goAndBackstzsrData);
            $("#goxssrData").html(goxssrData);
            $("#backxssrData").html(backxssrData);
            $("#goAndBackxssrData").html(goAndBackxssrData);
            var totalTime = 0;
            if(goxssrData>0&&gostzsrData>0){
            	totalTime = (gostzsrData/goxssrData);
            }
            if(backstzsrData>0&&backxssrData>0){
            	totalTime = totalTime + (backstzsrData/backxssrData);
            }
            if(totalTime. toFixed(2)=="NaN"||totalTime. toFixed(2)=="0.00"){
            	setTotalTime();
            }else{
            	setTotalTime(totalTime.toFixed(2));
            }
            $("#goset_Ktr_IneData").html(goset_Ktr_IneData);
            $("#backset_Ktr_IneData").html(backset_Ktr_IneData);
            $("#goAndBackset_Ktr_IneData").html(goAndBackset_Ktr_IneData);
        }else{
        	$("#goshouru").removeClass("graph-table-inf-go").removeClass("graph-table-inf-back");
        	$("#goshouru").addClass("graph-table-inf-back");
        	$("#backshouru").removeClass("graph-table-inf-back").removeClass("graph-table-inf-go");
        	$("#backshouru").addClass("graph-table-inf-go");
        	
        	$("#backstzsrData").html(gostzsrData);
            $("#gostzsrData").html(backstzsrData);
            $("#goAndBackstzsrData").html(goAndBackstzsrData);
            
            $("#backxssrData").html(goxssrData);
            $("#goxssrData").html(backxssrData);
            $("#goAndBackxssrData").html(goAndBackxssrData);
            
            var totalTime = 0;
            if(goxssrData>0&&gostzsrData>0){
            	totalTime = (gostzsrData/goxssrData);
            }
            if(backstzsrData>0&&backxssrData>0){
            	totalTime = totalTime + (backstzsrData/backxssrData);
            }
            if(totalTime. toFixed(2)=="NaN"||totalTime. toFixed(2)=="0.00"){
            	setTotalTime();
            }else{
            	setTotalTime(totalTime.toFixed(2));
            }
            $("#backset_Ktr_IneData").html(goset_Ktr_IneData);
            $("#goset_Ktr_IneData").html(backset_Ktr_IneData);
            $("#goAndBackset_Ktr_IneData").html(goAndBackset_Ktr_IneData);
        }
        $("#goandbackkz").removeClass("graph-table-inf-go").removeClass("graph-table-inf-back").removeClass("graph-table-inf-goandback");
        $("#gokz").removeClass("graph-table-inf-go").removeClass("graph-table-inf-back").removeClass("graph-table-inf-goandback");
        $("#backkz").removeClass("graph-table-inf-go").removeClass("graph-table-inf-back").removeClass("graph-table-inf-goandback");
        var obj1 = {id:"goAndBackegs_Lod_FtsData",name:"graph-table-inf-goandback",value:goAndBackegs_Lod_FtsData}
        var obj2 = {id:"goegs_Lod_FtsData",name:"graph-table-inf-go",value:goegs_Lod_FtsData}
        var obj3 = {id:"backegs_Lod_FtsData",name:"graph-table-inf-back",value:backegs_Lod_FtsData}
        var aa = new Array(obj1,obj2,obj3);
        aa.sort(function(a,b){
        	return a.value-b.value;
        });
        $("#goandbackkz").addClass(aa[2].name).children().text(aa[2].value);
        $("#gokz").addClass(aa[1].name).children().text(aa[1].value);
        $("#backkz").addClass(aa[0].name).children().text(aa[0].value);
        var name="income";
        theCurve(name,xdata_date,totaldata_income,godata_income,backdata_income,gostzsrData,backstzsrData,goAndBackstzsrData);
        var name="canvas";
    	theCurve(name,xdata_date,totaldata_canvas,godata_canvas,backdata_canvas,goegs_Lod_FtsData,backegs_Lod_FtsData,goAndBackegs_Lod_FtsData);
        dailyReport('dayliReport',data.success.map);
       
    }
    function afterinitFc(datas){
        for(var i=0;i<datas.success.dateList.length;i++){
            for(var j=0;j< $(".time-box").find("td").length;j++){
                if($("td").eq(j).attr("abbr")==datas.success.dateList[i]){
                	$("td").eq(j).addClass("have-colorr");
                }
            }
        }
       
    }
    $(".time-box").on("click","td",function(){
    	if($(this).hasClass("have-colorr")){
	    	day = $(this).attr("abbr");
	    	var searchJson = getParameter();
	    	$('#matter').css('opacity','0');//隐藏客量折扣中的弹出框
	    	send(searchJson);
    	}else{
			$(this).removeAttr("style");
			$(this).removeClass("calendar-selected");
			for(var i =0;i<$("td").length;i++){
				if($("td").eq(i).attr("abbr")==day){
					$("td").eq(i).addClass("calendar-selected");
				}
			}
    	}
    });
    //机场选址控件
    var objs={
        back:function(){
        	getFlt_Nbr();
        }
    };
    oub = objs;
    airControl(".selectCity",objs);
});
function getairCode(searchJson){
	var airports = parent.airportMap;
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
function getParameter(){
	var searchJson={};
	searchJson.dpt_AirPt_Cd = $('#dpt_AirPt_Cd').val();
	searchJson.pas_stp = $('#pas_stp').val();
	searchJson.arrv_Airpt_Cd = $('#arrv_Airpt_Cd').val();
	searchJson.flt_nbr_Count = $('._set-list-title').html();
	if($('#isIncludeExceptionData').attr("checked")=="checked"){
		searchJson.isIncludeExceptionData = "on";
	}else{
		searchJson.isIncludeExceptionData = "no";
	}
	searchJson.day = day;
	return searchJson;
};
function exchate(){
    var thisvalue = parseFloat($("#flyTime").val());
    if(!isNaN(thisvalue)&&thisvalue>0){
    	var qshij = thisvalue/2;
    	var hshij = thisvalue/2;
    	$("#flyTime").val(thisvalue);
    	$("#goxssrData").html((parseFloat($("#gostzsrData").html())/qshij).toFixed(2));
    	$("#backxssrData").html((parseFloat( $("#backstzsrData").html())/hshij).toFixed(2));
    	$("#goAndBackxssrData").html((parseFloat($("#goAndBackstzsrData").html())/thisvalue).toFixed(2));
    }
}
//动态生成航班号
function getFlt_Nbr(){
	var dpt_AirPt_Cd = typeof(airports[$('#dpt_AirPt_Cd').val()])=='undefined'?'':airports[$('#dpt_AirPt_Cd').val()].iata;
	var pas_stp = typeof(airports[$('#pas_stp').val()])=='undefined'?'':airports[$('#pas_stp').val()].iata;
	var arrv_Airpt_Cd = typeof(airports[$('#arrv_Airpt_Cd').val()])=='undefined'?'':airports[$('#arrv_Airpt_Cd').val()].iata;
	if(searchJson1.dpt_AirPt_Cd!=dpt_AirPt_Cd||pas_stp!=searchJson1.pas_stp||arrv_Airpt_Cd!=searchJson1.arrv_Airpt_Cd){
		searchJson1.dpt_AirPt_Cd = dpt_AirPt_Cd;
		searchJson1.pas_stp = pas_stp;
		searchJson1.arrv_Airpt_Cd = arrv_Airpt_Cd;
	}
	//表示只查询航线下的航班号的标识。
	searchJson1.isFltAir = "true";
	$.ajax({
        type:'post',
        url:'getHbh',//请求数据的地址	
        data:getairCode(searchJson1),
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
        	        	day = "";
        	        	//标志位，选择航班号后第一次初始化日期控件
        	        	b=1;
        	        	if(indexflag>1){
        	        		$("._set-query").click();
        	        	}
        	        }
        	    };
        	    setChoose(list);
        	    if(indexflag==1){
        	    	$("._set-query").click();
        	    }
        	    indexflag++;
        }
		
    });
}