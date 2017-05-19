$(".pla-supernatant-cont").css({"height":parseFloat($("body").css("height").split("px")[0])*0.9+"px"});
var key = 0;
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
            $(".pla-box").mousemove(function(event){
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
            $(".pla-box").mousemove(function(event){
                var b = event || window.event;
                $(".their-own").css({"top":top-e.screenY+b.screenY,"left":left-e.screenX+b.screenX});
            });
        }
    });
    $("body").mouseup(function(){//鼠标松开取消事件绑定
        $(".pla-box").unbind();
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

//    myConfirm('你真的要走',closeIframe, '空港大数据系统提示');
});
function closeIframe(){
	$('.pla-supernatant').hide();
}


//2017-3-30 龙洪  主页搜索按钮
$(".pla-search span.pla-search-icon").click(function(event){
    //console.log(987);
    //console.log(geoCoordMap);
 
	var Spanel=$(".pla-search .pla-search-panel");
	//$(Spanel).toggle();
	
	
	/* 
	$(Spanel).click(function(event){
		event.stopPropagation();		
	})
	if($(Spanel).css("display")=="block"){
		$(Spanel).hide();
	}
	else{
		$(Spanel).show();
	}*/
})
