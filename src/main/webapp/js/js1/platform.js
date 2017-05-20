$(".pla-supernatant-cont").css({"height":parseFloat($("body").css("height").split("px")[0])*0.9+"px"});
var key = 0;
var curLineStyle,haveRedraw=false;
//LIU_DD  左上角菜单隐藏的功能
$(function(){
	$(document).on("click",function(){
		if(key!=0){
			if("block"==$(".pla-spread li")[1].style.display){
				for(var int=1;int < $(".pla-spread li").length;int++){
					if($(".pla-spread li")[int].style.display){
						$(".pla-spread li")[int].style.display="none";
					}
				}
			}
		}else{
			key+=1;
		}
	});
	
//测试待定**************************************
    /*展开栏目控制*/
    $(".pla-spread>ul>li:nth-of-type(1)").click(function(){
    	//清空选择的缓存航线航班
    	var object = parent.supData;
    	delete object.flight ;
		object.lane ="";
    	key=0;
        if($(".pla-spread>ul>li:nth-of-type(2)").css("display")=="none"){
            for(var i=0;i<=$(".pla-spread>ul>li").length;i++){
                $(".pla-spread>ul>li:nth-of-type("+i+")").css({"display":"block"});
            }
        }else {
            for(var i=2;i<=$(".pla-spread>ul>li").length;i++){
                $(".pla-spread>ul>li:nth-of-type("+i+")").css({"display":"none"});
            }
        }
    });
	$(".pla-tool-useName").click(function(event){
        event.stopPropagation();
        $(".useName-list").css({"display":"none"});
        if($(".se-list").css("display")=="none"){
            $(".se-list").css({"display":"block"});
        }else if($(".se-list").css("display")=="block"){
            $(".se-list").css({"display":"none"});
        }
    });
    $(".pla-tool-set").click(function(event){
        event.stopPropagation();
        $(".se-list").css({"display":"none"});
        if($(".useName-list").css("display")=="none"){
            $(".useName-list").css({"display":"block"})
        }else if($(".useName-list").css("display")=="block"){
            $(".useName-list").css({"display":"none"})
        }
    });
    $("body").click(function(){
        $(".useName-list").css({"display":"none"});
        $(".se-list").css({"display":"none"});
    });
    /*鼠标移入二级菜单*/
    $(".pla-spread>ul>li").on("mouseover",function(){
        if($(this).html()=="统计"){

        }
    });
    $(".pla-spread>ul>li:nth-of-type(1)").nextAll().on("click",function(){
    	key=0;
        $(this).children("div,ul").css("display","block");
        $(this).siblings().children("div,ul").css("display","none");
    });
    /*工具栏目-账号-天气 展开二级菜单*/
    $(".pla-tool>ul>li:nth-of-type(2)").on("mouseover",function(){
        $(".pla-tool>ul>li:nth-of-type(2)>ul").css({"display":"block"});
    });
    $(".pla-tool>ul>li:nth-of-type(3)").on("mouseover",function(){
    	$(".pla-tool>ul>li:nth-of-type(3)>ul").css({"display":"block"});
    });
    $(".pla-tool>ul>li:nth-of-type(2)").on("mouseleave",function(){
        $(".pla-tool>ul>li:nth-of-type(2)>ul").css({"display":"none"});
    });
    $(".pla-tool>ul>li:nth-of-type(3)").on("mouseleave",function(){
    	$(".pla-tool>ul>li:nth-of-type(3)>ul").css({"display":"none"});
    });
    /*页尾信息栏目*/
    $(".pla-tog").on("click",function(){
        $(this).css({"left":"-120px"});
        setTimeout(function(){
            $(".pla-data").css({"left":"0px"});
        },500);
    });
    $(".pla-data").on("click",'.material-fact-installF',function(){
    	$(".material-fact-installBox").hide("slow");
        $(".pla-data").css({"left":"-100%"});
        setTimeout(function(){
            $(".pla-tog").css({"left":"0px"});
        },1000);
    });
    /***设置界面控制***/
    $(".pla-tool-account>li:nth-of-type(2)").on("click",function(){
        $(".pla-set").css({"display":"block","background-color":"rgba(0,0,0,0.6)"});
        $(".pla-set-interface").animate({
            "margin-top":"3%"
        },300);
    });
    /***退出界面***/
    $(".se-list>li:nth-of-type(2)").on("click",function(){
    	window.location = "/outLogin";
    });
    $(".pla-set-interface>div:nth-of-type(1)>span:nth-of-type(2)").on("click",function(){
        $(".pla-set-interface").animate({
            "margin-top":"100%"//
        },300,function(){
            $(".pla-set").css({"display":"none"});
        });
    });
    ///*拖拽提示框*/
    $(".pla-promptBox").mousedown(function(event){
        var e = event || window.event;
        var top=parseInt($(".pla-promptBox").css("top").split("px")[0]);
        var left=parseInt($(".pla-promptBox").css("left").split("px")[0]);
        if(e.target.className!="rolling"){
            $("body").mousemove(function(event){
                var b = event || window.event;
                $(".pla-promptBox").css({"top":top-e.screenY+b.screenY,"left":left-e.screenX+b.screenX});
            });
        }
    });
  
    /*拖拽框-机场视角*/
    $(".their-own").mousedown(function(event){
        var e = event || window.event;
        var top=parseInt($(".their-own").css("top").split("px")[0]);
        var left=parseInt($(".their-own").css("left").split("px")[0]);
        if(e.target.className!="rolling"){
            $("body").mousemove(function (event){
                var b = event || window.event;
                $(".their-own").css({"top":top-e.screenY+b.screenY,"left":left-e.screenX+b.screenX});
            });
        }
    });
    $("body").mouseup(function(){//鼠标松开取消事件绑定
        $("body").unbind("mousemove");
    });
    
    /*模拟滚动条*/
    $(".pla-promptBox").on("mousewheel","div",function(e,delta){
    	if($(this).attr("class")=="content-rolling"){
	        var countHeight=0;//总的航线航班内容高度
	        for(var i= 0;i<$(".pla-promptBox-cont-line").length;i++){
	            countHeight+=parseFloat($(".pla-promptBox-cont-line").eq(i).css("height").split("px")[0]);
	        }
	        var h=parseInt($(".pla-promptBox-cont").css("height").split("px")[0]);//固定内容高度
	        var rh=parseInt($(".pla-promptBox-cont").css("height").split("px")[0])-parseInt($(".rolling").css("height").split("px")[0]);//滚动条的可滚动高度
	        if(countHeight>h){
	            $(".rolling").css("display","block");
	            if(delta=="-1"){
	                $(this).css("top","-=30");
	                $(".rolling").css("top",-parseInt($(".content-rolling").css("top").split("px")[0])*rh/Math.abs(countHeight-h));
	                if(parseInt(Math.abs($(this).css("top").split("px")[0]))<Math.abs(countHeight-h)){
	
	                }else {
	                    $(this).css("top",-Math.abs(countHeight-h));
	                    $(".rolling").css("top",rh);
	                }
	            }else if(delta=="1"){
	                $(this).css("top","+=30");
	                $(".rolling").css("top",-parseInt($(".content-rolling").css("top").split("px")[0])*rh/Math.abs(countHeight-h));
	                if(parseInt($(this).css("top").split("px")[0])<0){
	
	                }else {
	                    $(this).css("top",0);
	                    $(".rolling").css("top",0);
	                }
	            }
	        }else {
	            $(".rolling").css("display","none");
	        }
    	}
    });
    /*鼠标拖动滚动条*/
    $(".pla-promptBox").on("mousedown","div",function(b){
    	if($(this).attr("class")=="rolling"){
	        var H=0;//总的航线航班内容高度
	        for(var i= 0;i<$(".pla-promptBox-cont-line").length;i++){
	            H+=parseFloat($(".pla-promptBox-cont-line").eq(i).css("height").split("px")[0]);
	        }
	        var cleY= b.screenY;
	        var oldTop=parseInt($(".rolling").css("top").split("px")[0]);
	        var h=parseInt($(".pla-promptBox-cont").css("height").split("px")[0]-$(".rolling").css("height").split("px")[0]);
	        var kH=parseInt($(".pla-promptBox-cont").css("height").split("px")[0]);
	        $(".pla-box").mousemove(function(e){
	            if(H>kH){
	                $(".rolling").css("top",oldTop+(e.screenY-cleY));
	                if($(".rolling").css("top").split("px")[0]>h){
	                    $(".rolling").css("top",h);
	                }else if($(".rolling").css("top").split("px")[0]<0){
	                    $(".rolling").css("top",0);
	                }
	                $(".content-rolling").css("top",-parseInt($(".rolling").css("top").split("px")[0])*(H-kH)/h);
	            }
	        });
    	}
    });

    /*右侧选择信息框*/
    $(".pla-promptBox").on("mouseover","li",function(){
    	if($(this).parent().attr("class")=="right-rolling-ul right-rolling-cont"){
	        var tag=$(this).index();
	        $(this).css({"background-color":"#dfdfdf"}).siblings().css({"background-color":"white"});
	        $(".right-rolling-title>li").eq(tag).css({"background-color":"#354d89","color":"white"}).siblings().css({"background-color":"transparent","color":"#7c9ec9"});
	        $(this).children("span").css("opacity","1");
	        $(this).siblings().children("span").css("opacity","0");
	        for(var i=0;i<$(".count-flight,.count-lines").length;i++){
	            if($(".count-flight,.count-lines").eq(i).attr("tag")=="set"){
	                $(".count-flight,.count-lines").eq(i).css("background-color","rgba(223,223,223,1)");
	            }else {
	                $(".count-flight,.count-lines").eq(i).css("background-color","white");
	            }
	        }
    	}
    });
   
    /*右侧选择信息框*/
    $(".pla-tool-accounts>li:nth-of-type(1)").on("click",function(){
			$("#pages",parent.document.body).attr("src","/processTask");
    		$(".pla-supernatant").css({"display":"block","background-color":"rgba(0,0,0,0.6)"});
    		$(".pla-promptBox").css({"display":"none"});
    		$(".pla-supernatant-cont").css({"display":"block"});
    		$(".pla-supernatant-cont").animate({"opacity":"1","top":"5%"},500);
    });
    $(".pla-promptBox").on("mouseout","li",function(){
    	if($(this).parent().attr("class")=="right-rolling-ul right-rolling-cont"){
    		$(".count-flight,.count-lines").css("background-color","white");
	        var tag=$(this).index();
	        $(".right-rolling-cont>li").css({"background-color":"white"});
	        $(".right-rolling-title>li").eq(tag).css({"background-color":"transparent","color":"#7c9ec9"});
	        $(".right-rolling-cont>li>span").css("opacity","0");
	       
    	}
    });
    //适应信息框位置
    /*右侧选择信息框*/
    $(".pla-promptBox").on("click","div",function(){
    	if($(this).hasClass("pla-prompTip-des")){
    		if($(this).parent().hasClass("lis")){
    			return false;
    		}
    		supData.flt=$('.pla-prompRight').attr('flt');//判断是否为航段标记
    		supData.pageclass=$(this).html();
        	var fnURL = [];
        	 fnURL[0] = new Object();fnURL[0].name="共飞运营对比";fnURL[0].urll="/totalFlyAnalysis";
             fnURL[1] = new Object();fnURL[1].name="航线历史收益统计";fnURL[1].urll="/airline";
             fnURL[2] = new Object();fnURL[2].name="销售报表";fnURL[2].urll="/salesReport";
             fnURL[4] = new Object();fnURL[4].name="销售动态";fnURL[4].urll="/buyTicketReport";
             fnURL[5] = new Object();fnURL[5].name="客源组成";fnURL[5].urll="/SourceDistribution";
             fnURL[6] = new Object();fnURL[6].name="销售数据";fnURL[6].urll="/SalesData/accountCheck";
            for(var a in fnURL){
           	 if(supData.pageclass==fnURL[a].name){
           		$("#pages",parent.document.body).attr("src",fnURL[a].urll);
           	 };
           }
            $(".pla-supernatant").css({"display":"block","background-color":"rgba(0,0,0,0.6)"});
            $(".pla-promptBox").css({"display":"none"});
            $(".pla-supernatant-cont").css({"display":"block"});
            $(".pla-supernatant-cont").animate({"opacity":"1","top":"5%"},500);
            if(typeof(supData.flight)!="undefined"&&supData.flight!=""){
            	supData.linFlag = "0";
            }else{
            	supData.linFlag = "1";
            }
    	}
    });
    
    $(".pla-promptBox").on("mouseover","div",function(){
    	if($(this).hasClass("_tipFlight")){
    		var abbr = $(this).attr("abbr");
    		if(typeof(abbr) != "undefined"){
    			var abbrarr = abbr.split("-");
    			var airline = "";
    			var flynum = "";
    			if(abbrarr.length>1){
    				var lines = abbrarr[0].split(",");
    				if(lines.length>2){
    					airline = lines[0]+"="+lines[1]+"="+lines[2];
    				}else{
    					airline = lines[0]+"="+lines[1];
    				}
    				flynum = abbrarr[1];
    				supData={"lane":airline,"flight":flynum};
    			}else{
    				var lines = abbrarr[0].split(",");
    				if(lines.length>2){
    					airline = lines[0]+"="+lines[1]+"="+lines[2];
    				}else{
    					airline = lines[0]+"="+lines[1];
    				}
    				supData={"lane":airline};
    			}
    			
    		}
        }
    });
    $("#container").on("click",function(){
        $(".pla-promptBox").css("display","none");
        $(".their-own").css("display","none");
    });
    //LIU_DD 菜单消失效果
	$("div:not(div.pla-promptBox, div.pla-prompTip, div.pla-prompRight, div.pla-prompRight-box, div.pla-prompRight-sj)").on("click",function(){
		 $(".pla-promptBox").css("display","none");
	});
	$(".pla-promptBox").on("mousemove","div",function(){
            if($(this).attr("class")=="count-flight"||$(this).attr("class")=="count-lines"){
                $(".count-flight,.count-lines").attr("tag","");
                $(".pla-promptBox-title").attr("tag","");
                $(this).attr("tag","set");
            }
            if($(this).attr("class")=="pla-promptBox-title"){
            	$(".pla-promptBox-title").attr("tag","");
            	$(".count-flight,.count-lines").attr("tag","");
            	$(this).attr("tag","set");
            }
    });
    $(".pla-promptBox").on("mouseout","div",function(){
        if($(this).attr("class")=="count-flight"||$(this).attr("class")=="count-lines"){
            $(this).css("background-color","white");
        }
    });

});
function closeIframe(){
	$('.pla-supernatant').hide();
}


//2017-3-30 龙洪  主页搜索按钮
$(".search-iconarea").click(function(){
	var tip=$(".pla-btn-switch").attr("tag");
	var Spanel=$(".pla-search .pla-search-panel");
	if(tip=="line"){
		if($(Spanel).css("display")=="none"){
			$(Spanel).show();
			$(this).addClass("searchSet");
			open_search(true);
		}
		else{			
			$(Spanel).hide();
			$("input#pla-search-id").val("");
			$(this).removeClass("searchSet");
		}
	}
	else if(tip=="air"){
		if($(Spanel).css("display")=="none"){			
			$(Spanel).show();
			$(this).addClass("searchSet");
			open_search(false);
		}
		else{			
			$(Spanel).hide();
			$("input#pla-search-id").val("");
			$(this).removeClass("searchSet");
		}
	}
	else{
		console.log("暂只支持航线视图");
	}
	//阻止
	$(Spanel).click(function(event){
		event.stopPropagation();
	})
})




//开启搜索，自动补全
function open_search(thisflag){	
	var type=$("#pla-search-tor").val();
	var flyNum=[];	//航班号
	var CNnum=parent.searchCNnum;
	for(key in parent.searchNum){
		
		flyNum.push(formatFlyNum(key,true) + reshape(parent.searchNum[key]));
		formatFlyNum(formatFlyNum(key,true),false);
	}
	var nowsource = flyNum;
	
	var portdot=[]; //航点	
	$.each(parent.nationalAirport,function(i,el){
		portdot.push(el.code+'('+ el.airportName + ')');
	})
	$("#pla-search-id").typeahead({
		source:flyNum,
		items:5
	})	
	search_getNum($("#pla-search-id"),flyNum);
	$(".for-search-select p").unbind("click");
	$(".for-search-select .slt li").unbind("click");
	if(thisflag){
		$(".for-search-select p").bind("click",function(){	
			if($(".for-search-select .slt").css("display")=="none"){
				$(".for-search-select .slt").show();
			}
			else{
				$(".for-search-select .slt").hide();
			}
		})
			
		

		$(".for-search-select .slt li").bind("click",function(event){
			$(".for-search-select span.search-type-t").text($(this).text()).attr("tag",$(this).attr("tag"));
			$(".for-search-select .slt").hide();
			$(".pla-search-panel-body").empty();
			if($(this).attr("tag")=="fdot"){
				$(".pla-search-panel-body").append('<input id="pla-search-id" type="text" placeholder="输入三字码、机场后敲击回车搜索">');
				$(".pla-search-panel-body #pla-search-id").typeahead({
					source:portdot
				})
				search_getNum($(".pla-search-panel-body #pla-search-id"),portdot);

			}
			else{
				$(".pla-search-panel-body").append('<input id="pla-search-id" type="text" placeholder="输入航班号后敲击回车搜索">');
				$(".pla-search-panel-body #pla-search-id").typeahead({
					source:flyNum
				})
				search_getNum($(".pla-search-panel-body #pla-search-id"),flyNum);
			}		
		})		
	}
	else{
		$(".pla-search-panel-body").empty();
		$(".for-search-select span.search-type-t").text("航点").attr("tag","fdot");
		$(".pla-search-panel-body").append('<input id="pla-search-id" type="text" placeholder="输入三字码、机场后敲击回车搜索">');
		$(".pla-search-panel-body #pla-search-id").typeahead({
			source:portdot
		})
		search_getNum($(".pla-search-panel-body #pla-search-id"),portdot);
	}

}


function mouseChoose(){//鼠标点击事件
	$('ul.dropdown-menu').bind('click',function(){
		//5-15
		setTimeout(function(){
			var e = jQuery.Event("keyup");
			e.which = 13 ;
			e.keyCode=13;
			$(".pla-search-panel-body #pla-search-id").trigger(e);
		},200)
	})
}

//回车确认事件
function search_getNum(oInput,con){	
	$(oInput).bind("keyup",function(e){
		var chip=false;
		if(e.keyCode=="27"){
			$(".pla-search .pla-search-panel").hide();
			return false;
		}
		else if(e.keyCode=="13"){
			var ishas=isContain($(this).val(),con);
			if(ishas){
				chip==true;
				search_reset_map($(this).val(),$("#pla-search-tor").attr("tag"));	
				return;
			}
			else{
				setTimeout(function(){
					if($('.pla-promptBox').css('display')=="block" || $('.their-own-title').css('display')=="blcok"){	
					}
					else{
						search_openTip();
					}
				},200)
				$(this).val("");
			}
		}
	})
	mouseChoose();
}


//判断是否存在
function isContain(i,con){
	var has=false;
	for(key in con){
		if(con[key]==i){
			has=true;
		}
	}
	return has;
}


//弹出提示
function search_openTip(){
	$(".SD-hd-null").css({
		'top':'64%',
		'left':'82%'
	});
	$('.SD-hd-null').show();
	setTimeout(function(){
		$(".SD-hd-null").slideUp();
	},1000)
}
//重置地图
function search_reset_map(val,flag){
	var par={};
	var num = JSON.parse(JSON.stringify(stickOption));
	$(".search-iconarea").click();
	if($('.pla-btn .pla-btn-switch').attr('tag')=='air'){	//机场视图
		//航点——机场
		var ct = search_getCity(val.substr(0,3));		
		reDrawDot(val.substr(0,3),ct,"port");
		haveRedraw=true;
	}
	else{	//航线视图
		curLineStyle={};
		//判断航点还是航班号获取坐标点
		if(flag=="fnum"){
			num.series = search_delLine(num.series,val.substr(9),true);
			num.tooltip.formatter=function(params){};
			myChart.setOption(num);
			haveRedraw=true;
			
			$(document).click(function(e){
			    var _con = $('.pla-promptBox');   // 航线菜单框
			    if(!_con.is(e.target) && _con.has(e.target).length === 0){
			    	if($('.pla-btn .pla-btn-switch').attr('tag')=='line'){
				    	for(var i=0;i<num.series.length;i++){
				    		if(num.series[i].name=="航线搜索新增" && haveRedraw){				    			
				    			num.series[i].lineStyle=curLineStyle;
				    			myChart.setOption(num);
				    			haveRedraw=false;
				    		}
				    	}
			    	}
			    }
			});
			
		}
		else{//航点——城市			
			var ct = search_getCity(val.substr(0,3));
			reDrawDot(val.substr(0,3),ct,"city");
			haveRedraw=true;
		}
	}
	
	$(document).click(function(e){
	    var _con = $('.pla-promptBox');   // 航线菜单框
	    if(!_con.is(e.target) && _con.has(e.target).length === 0){
	    	var curnum=JSON.parse(JSON.stringify(myChart.getOption()));			    	
	    	for(var i=0;i<curnum.series.length;i++){
	    		if(curnum.series[i].name=="航线搜索新增" && haveRedraw){	    			
	    			curnum.series.pop();
	    			myChart.clear();
	    			myChart.setOption(curnum);
	    			haveRedraw=false;
	    			return;
	    		}
	    	}
	    }
	});
	
	if(flag=="fnum"){
		par.seriesType="lines";
		par.data=num.series[num.series.length-1].data[num.series[num.series.length-1].data.length-1];
	}
	else if(flag=="fdot"){
		par={
			"seriesType":"scatter",
			"data":{
				"name":getCityNameThree(val)
			},
			"componentType":"series",
			"name":getCityNameThree(val),
			
		}
		if(!getCityNameThree(val)){
			return false;
		}
	}
	if($('.pla-btn .pla-btn-switch').attr('tag')=='air'){
		par.data.typeSelf="outs";
		par.name=getAirPortName(val);
	}
	
	par.event={
			offsetX:"200",
			offsetY:"200"
	}
	
	$(".pla-promptBox").hide();
	$(".their-own").hide();
	parent.chart_openTool(par);
}



//5-16
//航点绘图
function reDrawDot(name,ZN,type){
	var newa = JSON.parse(JSON.stringify(myChart.getOption().series)); //自己用
	var newb = JSON.parse(JSON.stringify(myChart.getOption()));	//还回去	
	var nowdot="";
	var flag=false;
	if(name==parent.cityIata){
		return false;	//搜索本机场直接退出
	}
	if(newa[newa.length-1].name=="搜索功能增加series"){
		newa.pop();
	}
	if(type=="city"){//航线	PUSH
		for(var i=0;i<newa.length;i++){
			if(newa[i].type=="scatter" && newa[i].data.length>0){
				for(var a=0;a<newa[i].data.length;a++){
					if(newa[i].data[a].name==ZN){
						nowdot=newa[i].data[a];
						newseries=JSON.parse(JSON.stringify(newa[i]))
						flag=true;
					}
				}
			}
		}		
	}
	else{//机场	PUSH
		var portname= search_getPort(name);
		for(var i=0;i<newa[0].data.length;i++){
			if(newa[0].data[i].name==portname){
				nowdot=newa[0].data[i];
				newseries=JSON.parse(JSON.stringify(newa[0]));
				flag=true
			}
		}
	}
	if(flag){
		newseries.name="航线搜索新增";		
		newseries.data=[];
		newseries.data.push(nowdot);
		newseries.label={};
		newseries.type="effectScatter";
		newseries.symbolSize=10;
		newseries.itemStyle={
				normal:{
					color: "red",
					opacity: 0.8
				}
		}
		newa.push(newseries);
		newb.series=newa;
		myChart.setOption(newb);
	}
	else{
		return false
	}
	return nowdot;
}

function getCityNameThree(iata,flag){
	if(iata){
		var code = iata.substring(0,3);
		if(parent.airportMap[code]){
			return parent.airportMap[code].ctyChaNam;			
		}
		else{
			search_openTip();
			return false;
		}
	}
	else{return false}
}

function getAirPortName(iata){
	var code = iata.substring(0,3);
	for (var a=0;a<parent.nationalAirport.length;a++){
		if(parent.nationalAirport[a].code==code){
			return parent.nationalAirport[a].airportName;
		}
	}	
}

//航点重构原有线
function search_deldot(series,dot){
	
	var flag=false;//判断当前是否存在该航点
	
	for(var a=0; a< series[2].data.length;a++){
		if(series[2].data[a].name==dot) {flag=true};
	}
	for(var a=0; a< series[5].data.length;a++){
		if(series[5].data[a].name==dot) {flag=true};
	}
	
	
	if(flag){
		//search_delLine(series,dot,false);
	}
	else{
		alert("机场暂无此航点信息！");
		return false;
	}
}



//重构原有线
function search_delLine(series,nam,type){
	var newline=[];
	var flag=0;	
	if(type){//航班号
		//从在飞
		for(var a= series[0].data.length - 1 ; a>-1 ; a--){
			if(nam.indexOf(series[0].data[a].fromName)!=-1){
				if(nam.indexOf(series[0].data[a].toName)!=-1){
					newline.push(series[0].data[a]);
					series[0].data.splice(a,1);
					curLineStyle=series[0].lineStyle;
					flag=1;
				}
			}
		}
		//从历史
		if(flag!=1){
			for(var a= series[4].data.length - 1 ; a>-1 ; a--){
				if(nam.indexOf(series[4].data[a].fromName)!=-1){
					if(nam.indexOf(series[4].data[a].toName)!=-1){
						newline.push(series[4].data[a]);
						series[4].data.splice(a,1);
						curLineStyle=series[4].lineStyle;
						flag=2;
					}
				}
			}
		}
	}
/*	else{	//航点
		var port=parent.airportName;
		//从在飞
		for(var a= series[0].data.length - 1 ; a>-1 ; a--){
			if(nam==series[0].data[a].toName && port==series[0].data[a].fromName){		//有直飞			
					newline.push(series[0].data[a]);
					series[0].data.splice(a,1);
					flag=1;	
					break;							
			}
		}
		if(newline.length==0){	//不是直飞
			for(var a= series[0].data.length - 1 ; a>-1 ; a--){	  
				if(nam==series[0].data[a].toName){
					newline.push(series[0].data[a]);
					if(port==series[0].data[a].fromName){
						series[0].data.splice(a,1);
						flag=1;
						break;
					}
					else{
						newline.push(research(port,series[0].data[a].fromName,series[4].data));
						series[0].data.splice(a,1);
						flag=1;	
						break;
					}
				}
			}			
		}
		//从历史
		if(flag!=1){
			for(var a= series[4].data.length - 1 ; a>-1 ; a--){
				if(nam==series[4].data[a].toName && port==series[4].data[a].fromName){	//有直飞
					newline.push(series[4].data[a]);
					series[4].data.splice(a,1);
					flag=2;
					break;					
				}				
			}	
		}
		if(newline.length==0){	//不是直飞
			for(var a= series[4].data.length - 1 ; a>-1 ; a--){	  
				if(nam==series[4].data[a].toName){
					newline.push(series[4].data[a]);
					if(port==series[4].data[a].fromName){
						series[4].data.splice(a,1);
						flag=2;
						break;
					}
					else{
						newline.push(research(port,series[4].data[a].fromName,series[4].data));
						series[4].data.splice(a,1);
						flag=2;	
						break;
					}
				}
			}			
		}
	}*/
	function research(p,t,data){
		var result={};
		for(var a= data.length - 1 ; a>-1 ; a--){
			if(t==data[a].toName){
				if(p==data[a].fromName){					
					result = data[a];
					data.splice[a,1];
					break;					
				}							
			}			
		}	
		return result;
	}
	
	var news={};
	if(flag==1){
		news=JSON.parse(JSON.stringify(series[0]));
	}
	else if(flag==2){
		news=JSON.parse(JSON.stringify(series[4]));
	}	
	if(flag>0){
		news.name="航线搜索新增";
		news.data=newline;
		news.lineStyle.normal.color="#d85330";
		news.lineStyle.emphasis.color="d85330"
		news.lineStyle.emphasis.width=2.5;
		series.push(news);
		return series;
	}
	else{
		return false;
	}
}

//三字码转换中文地名
function reshape(itlist){
	var l=itlist.split("=");
	for(var i =0 ; i<l.length;i++){
		l[i]=parent.airportMap[l[i]].ctyChaNam;
	}	
	return l.join("=") ;
}

//中文地名返回坐标
function it_to_coords(cnlist){
	var adrArr=[];
	var a = cnlist.split("=");
	var allcoor = parent.cityCoordinateList;
	if(a.length > 1){
		for(var q = 0 ; q<allcoor.length;q++){
			for(var w= 0 ; w< a.length ;w++){
				if(allcoor[q].cityName==a[w]){
					adrArr.push(allcoor[q].cityCoordinatee.split(","));
				}
			}			
		}
	}
	else{
		return false;
	}
	return adrArr
}
//通过航班号获取三字码
function search_fromFly(num){
	var list={};
	var itlist=[];
	for(var i=0;i<parent.airFlyIata.length;i++){
		if(parent.airFlyIata[i].flyNum==num){
			list=parent.airFlyIata[i];
			itlist.push(parent.airFlyIata[i].airport);
			if(parent.airFlyIata[i].arrAirport){
				itlist.push(parent.airFlyIata[i].arrAirport);				
			}
			itlist.push(parent.airFlyIata[i].dptAirport);
		}
		else{
			//显示错误信息。
		}
	}
	return itlist;
}

//有没的航点哟
function nowHasCity(iata){
	
}


//通过三字码得到城市名
function search_getCity(it){
	if(parent.airportMap[it]){
		var ct =parent.airportMap[it].ctyChaNam;		
		return ct;
	}
	else{
		search_openTip();
		return false;
	}
}
//通过三字码得到机场
function search_getPort(it){
	var port="";
	for(var i=0;i<parent.nationalAirport.length;i++){
		if(parent.nationalAirport[i].code==it){
			port=parent.nationalAirport[i].airportName;
		}
	}
	if(port!=""){	
		return port;
	}
	else{
		search_openTip();
		return false;
	}
}

//航班号格式化
function formatFlyNum(val,flag){	
	var list=val.split('/');
	if(list.length>2 || list.length<1) return false;
	var newval=list[1];
	if(flag){	//变长
		list[1]=list[0].substr(0,list[0].length-2)+ newval ;
	}
	else{	//变短
		list[1]=list[1].substr(list[1].length-2);
	}
	newval=list.join('/');
	return  newval;
}


//冒泡关闭
$(document).click(function(e){
	var _con = $('.pla-search');   // 搜索条
    if(!_con.is(e.target) && _con.has(e.target).length === 0){
    	$(".pla-search-panel-body #pla-search-id").val("");
    	$('.pla-search .pla-search-panel').hide();
    	$('.search-iconarea').removeClass("searchSet");
    }
    
});



