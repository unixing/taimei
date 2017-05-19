var ultimately="";
/*滚动条*/
var High=0;
var airports = parent.airportMap;
var currentCheckedYear = '';
var ff1 = true;
var ff2 = true;
$(function(){
	var dptabbr = airports[parent.cityIata].aptChaNam + "-" + parent.cityIata;
	$('#cityChoice').attr("abbr",dptabbr);
	$('#cityChoice').val(airports[parent.cityIata].aptChaNam);
	$('.air-name').text(airports[parent.cityIata].aptChaNam);
	var date = new Date();
	var year = date.getFullYear();
	currentCheckedYear = year;
	var startYear = year-4;
	var endYear = year+1;
	//赋值年份序列
	$('#years').text(startYear+'-'+endYear);
	var html = '';
	for(var i=startYear;i<=endYear;i++){
		html+='<div class="year-btn">'+i+'</div>';
	}
	$('.sr-box-body-date-body').html(html);
	$('.sr-box-body-date-body').on('click','.year-btn',function(){
		$('.year-btn').each(function(e){
			$(this).removeClass('list');
		});
		$(this).addClass('list');
		currentCheckedYear = $(this).text();
	});
	var childs = $('.sr-box-body-date-body').children();
	if(childs!='undefined'&&childs.length>0){
		for(var i=0;i<childs.length;i++){
			var obj = childs[i];
			if($(obj).text()==year){
				$(obj).addClass('list');
			}else{
				$(obj).removeClass('list');
			}
		}
	}
    /*图区*/
    /*********************************图***************************/
//    $(".lin-historical-body-navigation").on("click","div",function(){
//        if($(this).hasClass("body-navigation-element")){
//            if( !$(this).hasClass("set")){
//                $(this).addClass("set").siblings().removeClass("set");
//                if($(this).children().children().length==3){
//                    var num=$(this).children().children().eq(0).text()+"-"+$(this).children().children().eq(2).text();
//                }else{
//                }
//            }
//        }
//    });
    $(".Into").on("click",function(){
        if(!$(this).hasClass("set")){
            $(this).addClass("set").siblings().removeClass("set");
            drawing();
        }
        if(ff1){
    		$(".lin-historical-body-box").addClass("muhu");
    		$(".reportErr").css("display","block");
    		$('#scroll-bar').css("display","none");
    	}else{
    		$(".lin-historical-body-box").removeClass("muhu");
    		$(".reportErr").css("display","none");
    		$('#scroll-bar').css("display","block");
    	}
    });
    $(".Out").on("click",function(){
        if(!$(this).hasClass("set")){
            $(this).addClass("set").siblings().removeClass("set");
            out();
        }
        if(ff2){
    		$(".lin-historical-body-box").addClass("muhu");
    		$(".reportErr").css("display","block");
    		$('#scroll-bar').css("display","none");
    	}else{
    		$(".lin-historical-body-box").removeClass("muhu");
    		$(".reportErr").css("display","none");
    		$('#scroll-bar').css("display","block");
    	}
    });
    /*模拟滚动条*/
    $(".lin-historical-body-box").on("mousewheel",function(e,delta){
        if(delta=="1"){//上滑
            if(infer(".lin-historical-body-box")[4]>=-30&&infer(".lin-historical-body-box")[4]<0){
                $(this).css("top","0");
                var h=Math.abs(infer(".lin-historical-body-box")[4])/High*(infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1]);
                $("#scroll-bar").css("top",h+"px");
            }else if(infer(".lin-historical-body-box")[4]<-30){
                $(this).css("top","+=30");
                var h=Math.abs(infer(".lin-historical-body-box")[4])/High*(infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1]);
                $("#scroll-bar").css("top",h+"px");
            }
        }else {//下滑
            if(Math.abs(infer(".lin-historical-body-box")[4])<(High)){
                $(this).css("top","-=30");
                var h=Math.abs(infer(".lin-historical-body-box")[4])/High*(infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1]);
                var oh=infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1];
                if(h<oh){
                    $("#scroll-bar").css("top",h+"px");
                }
            }
        }
    });
    /*鼠标拖动滚动条*/
    $("#scroll-bar").on("mousedown",function(b){
        var H=b.screenY;//总的航线航班内容高度
        var tops=infer("#scroll-bar")[4];
        $(".lin-historical-body").mousemove(function(e){
            var HK=e.screenY;
            var nums=Math.abs(H-HK);
            var space=infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1];
            if(infer("#scroll-bar")[4]>=0&&infer("#scroll-bar")[4]<=space){
                if(H>HK){
                    var top=tops-nums;
                    if(top>=0){
                        $("#scroll-bar").css("top",top);
                        var boxh=(High*top)/(infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1]);
                        $(".lin-historical-body-box").css("top",-boxh+"px");
                    }
                }else {
                    var top=tops+nums;
                    if(top<=space){
                        $("#scroll-bar").css("top",top);
                        var boxh=(High*top)/(infer(".lin-historical-body-box")[1]-infer("#scroll-bar")[1]);
                        $(".lin-historical-body-box").css("top",-boxh+"px");
                    }
                }
            }
        });
    });
    $("body").on("mouseup",function(){
        $(".lin-historical-body").unbind();
    });
    send();
    var objs={
            back:function(){
//            	getFlt_Nbr();
            }
        };
    	oub = objs;
        airControl(".selectCity",objs);
});
function loadWeather(ioca){
	$.ajax({
		url:'/getAirportWeather',
		type:'get',
		data:{
			ioca:ioca
		},
		success:function(data){
			if(data!=null&&data!=''){
				var weatherInfo =  data.weatherInfo;
				var ss = weatherInfo.split(" ");
				metar_decode(weatherInfo);
				//符号的转义
//				op_text.replace(/摄氏度/,"°C");
//				op_text.replace(/度/,"°");
//				op_text.replace(/米每秒/,"m/s");
//				op_text.replace(/米/,"m");
//				op_text.replace(/百帕/,"°hPa");
//				op_text.replace(/英寸汞柱/,"inHg");
				$("#weather .ptxt").html(op_text);
				
			}
		}
	})
}
function calculate(){
    High=infer("#inTrafficAnalysis")[1]*4;
}
function box(){
    $(".lin-historical-body").eq(0).css({"height":infer(".lin-historical")[1]-infer(".sr-box-head")[1]+"px"});//计算内容区的高度
    $(".body-navigation-element").css({"height":infer(".lin-historical-body")[1]/parseInt($(".body-navigation-element").size())}); //计算每个导航块的大小
    $(".lin-historical-body-navigation>div").css("line-height",infer(".lin-historical-body-navigation")[1]/2+"px"); //让导航字体居中
    $(".lin-historical-body-navigation>div").eq(0).text('进港');
    $(".lin-historical-body-navigation>div").eq(0).addClass("set").siblings().removeClass("set");
    $(".lin-historical-body-navigation>div").eq(1).text('出港');
    var Lhbx=infer(".lin-historical-body")[0]-infer(".lin-historical-body-navigation")[0]-301;
    $(".lin-historical-body-box").css({"width":Lhbx+"px","height":infer(".lin-historical-body")[1]});//就按图区盒大小
}
function infer(name){
    var infer=[];
    infer.push(parseFloat($(name).css("width").split("px")[0]));
    infer.push(parseFloat($(name).css("height").split("px")[0]));
    infer.push(parseFloat($(name).css("margin-top").split("px")[0]));
    infer.push(parseFloat($(name).css("left").split("px")[0]));
    infer.push(parseFloat($(name).css("top").split("px")[0]));
    return infer;
}
function send(){
	//关闭所有选择框
	ff = true;
	$(".c-selectCity").nextAll().remove();
	var dpt_AirPt_Cd = $('#cityChoice').val();
//	var dpt_AirPt_Cd_name = $('#cityChoice').val();
	var cpy_Nm = $('#cpy_Nm').val();
	if(dpt_AirPt_Cd!=''){
		$('.air-name').text(dpt_AirPt_Cd);//设置机场名称
		dpt_AirPt_Cd = airports[dpt_AirPt_Cd].iata;
	}else{
		ff1 = true;
		ff2 = true;
		$(".lin-historical-body-box").addClass("muhu");
		$(".reportErr").css("display","block");
		alert('请选择起始机场');
		return;
	}
	var year = $('.list').text();
	var startTime = year;
	$.ajax({
        url : '/airport_Operating_History',
        data:{
	    	dpt_AirPt_Cd :dpt_AirPt_Cd,
	    	startTime:startTime,
	    	cpy_Nm : cpy_Nm
	    },
        success : function(data) {
        	var bz1 = true;
        	var bz2 = true;
        	if(data.outPort1.flag == "1"){
        		bz1 = false;
        		ff1 = false;
        		$('#scroll-bar').css("display","block");
        	}else{
        		$('#scroll-bar').css("display","none");
        		ff1 = true;
        	}
        	if(data.outPort2.flag == "1"){
        		bz2 = false;
        		ff2 = false;
        	}else{
        		ff2 = true;
        	}
        	//出港----------------------------------------------------
//        	月流量走势分析数据组装
        	var month = [];//月流量走势分析
        	var m_k = [];//客流
        	var m_z = [];//座位
        	var m_b = [];//班次*100
        	var m_g = [];//团队
        	var m_gs = [];//团队收入/100
        	var m_s = [];//收入/1000
        	for(var i in data.outPort1.list){
        		month[i] = data.outPort1.list[i].label;
        		m_k[i] = data.outPort1.list[i].idd_moh;
        		m_z[i] = data.outPort1.list[i].Tal_Nbr_Set;
        		m_b[i] =Number(data.outPort1.list[i].Cla_Nbr)*100;
        		m_g[i] = data.outPort1.list[i].Grp_moh;
        		m_gs[i] = (Number(data.outPort1.list[i].Grp_Ine)/100).toFixed(2);
        		m_s[i] = (Number(data.outPort1.list[i].Tol_Ine)/1000).toFixed(2);
        	}
//        	均班客流量走势分析数据组装
        	var j_month = [];//月流量走势分析
        	var j_k = [];//客流
        	var j_z = [];//座位
        	var j_b = [];//班次*100
        	var j_g = [];//团队
        	var j_gs = [];//团队收入/100
        	var j_s = [];//收入/1000
        	for(var i in data.evenPort1.list){
        		j_month[i] = data.evenPort1.list[i].label;
        		j_k[i] = data.evenPort1.list[i].cla_Per;
        		j_z[i] = data.evenPort1.list[i].cla_Set;
        		j_b[i] =data.evenPort1.list[i].lod_For;
        		j_g[i] = data.evenPort1.list[i].cla_Grp;
        		j_gs[i] = data.evenPort1.list[i].flt_Ser_Ine;
        		j_s[i] = data.evenPort1.list[i].idd_Dct;
        	}
//        	年班次前十排行数据组装
        	var n_d = [];
        	var n_d_a = [];
        	var n_d_a_m = [];
        	for(var i in data.class1.list){
        		n_d[i] = data.class1.list[i].count;
//        		n_d_a[i] = data.class1.list[i].dpt_AirPt_Cd +"-"+data.class1.list[i].arrv_Airpt_Cd;
        		n_d_a[i] = data.class1.list[i].dpt_AirPt_Cd +"-"+data.class1.list[i].arrv_Airpt_Cd;
        		n_d_a_m[n_d_a[i]] = data.class1.list[i].dpt_AirPt_Cd +"-"+data.class1.list[i].arrv_Airpt_Cd;
        	}
//        	座公里收入前十排行数据组装
        	var s_z = [];
        	var s_b = [];
        	var s_d_a = [];
        	var s_d_a_m = [];
        	for(var i in data.set1.list){
        		s_b[i] = data.set1.list[i].set_Ktr_Ine;
        		s_z[i] = data.set1.list[i].count;
//        		s_d_a[i] = data.set1.list[i].dpt_AirPt_Cd + "-" +data.set1.list[i].arrv_Airpt_Cd;
        		s_d_a[i] = data.set1.list[i].dpt_AirPt_Cd +"-"+data.set1.list[i].arrv_Airpt_Cd;
        		s_d_a_m[s_d_a[i]] = data.set1.list[i].dpt_AirPt_Cd +"-"+data.set1.list[i].arrv_Airpt_Cd;
        	}
//        	旅客前十排行数据组装 ,各航线年客量占比
        	var l_z = [];
        	var l_d_a = [];
        	var l_d_a_m = [];
        	for(var i in data.amoun1.list){
        		l_z[i] = data.amoun1.list[i].value;
//        		l_d_a[i] = data.amoun1.list[i].dpt_AirPt_Cd + "-" +data.amoun1.list[i].arrv_Airpt_Cd;
        		l_d_a[i] = data.amoun1.list[i].dpt_AirPt_Cd +"-"+data.amoun1.list[i].arrv_Airpt_Cd;
        		l_d_a_m[l_d_a[i]] = data.amoun1.list[i].dpt_AirPt_Cd +"-"+data.amoun1.list[i].arrv_Airpt_Cd;
        	}
//        	出港均班前十排行数据组装
        	var j_z_2 = [];
        	var j_l_2 = [];
        	var j_t_2 = [];
        	var j_d_a_2 = [];
        	var j_d_a_2_m = [];
        	for(var i in data.guest1.list){
        		j_z_2[i] = data.guest1.list[i].count;
        		j_l_2[i] = data.guest1.list[i].set_Ktr_Ine;
        		j_t_2[i] = data.guest1.list[i].guestamount;
//        		j_d_a_2[i] = data.guest1.list[i].dpt_AirPt_Cd + "-" +data.guest1.list[i].arrv_Airpt_Cd;
        		j_d_a_2[i] = data.guest1.list[i].dpt_AirPt_Cd +"-"+data.guest1.list[i].arrv_Airpt_Cd;
        		j_d_a_2_m[j_d_a_2[i]] = data.guest1.list[i].dpt_AirPt_Cd +"-"+data.guest1.list[i].arrv_Airpt_Cd;
        	}
//        	各航司旅客前十,客量占比,数据组装
        	var h_z = [];
        	var h_d_a = [];
        	for(var i in data.cpy_amoun1.list){
        		h_z[i] = data.cpy_amoun1.list[i].value;
        		h_d_a[i] = data.cpy_amoun1.list[i].cpy_Nm;
        	}
//        	各航司年班次前十排行
        	var h_b_2 =[];
        	var h_b_d_a_2 = [];
        	for(var i in data.cpy_class1.list){
        		h_b_2[i] = data.cpy_class1.list[i].count;
        		h_b_d_a_2[i] = data.cpy_class1.list[i].cpy_Nm;
        	}
        	
        	//进港------------------------------------------------------------
//        	月流量走势分析数据组装
        	var c_month = [];//月流量走势分析
        	var c_m_k = [];//客流
        	var c_m_z = [];//座位
        	var c_m_b = [];//班次*100
        	var c_m_g = [];//团队
        	var c_m_gs = [];//团队收入/100
        	var c_m_s = [];//收入/1000
        	for(var i in data.outPort2.list){
        		c_month[i] = data.outPort2.list[i].label;
        		c_m_k[i] = data.outPort2.list[i].idd_moh;
        		c_m_z[i] = data.outPort2.list[i].Tal_Nbr_Set;
        		c_m_b[i] =Number(data.outPort2.list[i].Cla_Nbr)*100;
        		c_m_g[i] = data.outPort2.list[i].Grp_moh;
        		c_m_gs[i] = (Number(data.outPort2.list[i].Grp_Ine)/100).toFixed(2);
        		c_m_s[i] = (Number(data.outPort2.list[i].Tol_Ine)/1000).toFixed(2);
        	}
//        	均班客流量走势分析数据组装
        	var c_j_month = [];//月流量走势分析
        	var c_j_k = [];//客流
        	var c_j_z = [];//座位
        	var c_j_b = [];//班次*100
        	var c_j_g = [];//团队
        	var c_j_gs = [];//团队收入/100
        	var c_j_s = [];//收入/1000
        	for(var i in data.evenPort2.list){
        		c_j_month[i] = data.evenPort2.list[i].label;
        		c_j_k[i] = data.evenPort2.list[i].cla_Per;
        		c_j_z[i] = data.evenPort2.list[i].cla_Set;
        		c_j_b[i] =data.evenPort2.list[i].lod_For;
        		c_j_g[i] = data.evenPort2.list[i].cla_Grp;
        		c_j_gs[i] = data.evenPort2.list[i].flt_Ser_Ine;
        		c_j_s[i] = data.evenPort2.list[i].idd_Dct;
        	}
//        	年班次前十排行数据组装
        	var c_n_d = [];
        	var c_n_d_a = [];
        	var c_n_d_a_m = [];
        	for(var i in data.class2.list){
        		c_n_d[i] = data.class2.list[i].count;
//        		c_n_d_a[i] = data.class2.list[i].dpt_AirPt_Cd +"-"+data.class2.list[i].arrv_Airpt_Cd;
        		c_n_d_a[i] = data.class2.list[i].dpt_AirPt_Cd +"-"+data.class2.list[i].arrv_Airpt_Cd;
        		c_n_d_a_m[c_n_d_a[i]] = data.class2.list[i].dpt_AirPt_Cd +"-"+data.class2.list[i].arrv_Airpt_Cd;
        		
        	}
//        	座公里收入前十排行数据组装
        	var c_s_z = [];
        	var c_s_b = [];
        	var c_s_d_a = [];
        	var c_s_d_a_m = [];
        	for(var i in data.set2.list){
        		c_s_b[i] = data.set2.list[i].set_Ktr_Ine;
        		c_s_z[i] = data.set2.list[i].count;
//        		c_s_d_a[i] = data.set2.list[i].dpt_AirPt_Cd + "-" +data.set2.list[i].arrv_Airpt_Cd;
        		c_s_d_a[i] = data.set2.list[i].dpt_AirPt_Cd +"-"+data.set2.list[i].arrv_Airpt_Cd;
        		c_s_d_a_m[c_s_d_a[i]] = data.set2.list[i].dpt_AirPt_Cd +"-"+data.set2.list[i].arrv_Airpt_Cd;
        	}
//        	旅客前十排行数据组装 ,各航线年客量占比
        	var c_l_z = [];
        	var c_l_d_a = [];
        	var c_l_d_a_m = [];
        	for(var i in data.amoun2.list){
        		c_l_z[i] = data.amoun2.list[i].value;
//        		c_l_d_a[i] = data.amoun2.list[i].dpt_AirPt_Cd + "-" +data.amoun2.list[i].arrv_Airpt_Cd;
        		c_l_d_a[i] = data.amoun2.list[i].dpt_AirPt_Cd +"-"+data.amoun2.list[i].arrv_Airpt_Cd;
        		c_l_d_a_m[c_l_d_a[i]] = data.amoun2.list[i].dpt_AirPt_Cd +"-"+data.amoun2.list[i].arrv_Airpt_Cd;
        	}
//        	出港均班前十排行数据组装
        	var c_j_z_2 = [];
        	var c_j_l_2 = [];
        	var c_j_t_2 = [];
        	var c_j_d_a_2 = [];
        	var c_j_d_a_2_m = [];
        	for(var i in data.guest2.list){
        		c_j_z_2[i] = data.guest2.list[i].count;
        		c_j_l_2[i] = data.guest2.list[i].set_Ktr_Ine;
        		c_j_t_2[i] = data.guest2.list[i].guestamount;
//        		c_j_d_a_2[i] = data.guest2.list[i].dpt_AirPt_Cd + "-" +data.guest2.list[i].arrv_Airpt_Cd;
        		c_j_d_a_2[i] = data.guest2.list[i].dpt_AirPt_Cd +"-"+data.guest2.list[i].arrv_Airpt_Cd;
        		c_j_d_a_2_m[c_j_d_a_2[i]] = data.guest2.list[i].dpt_AirPt_Cd +"-"+data.guest2.list[i].arrv_Airpt_Cd;
        	}
//        	各航司旅客前十,客量占比,数据组装
        	var c_h_z = [];
        	var c_h_d_a = [];
        	for(var i in data.cpy_amoun2.list){
        		c_h_z[i] = data.cpy_amoun2.list[i].value;
        		c_h_d_a[i] = data.cpy_amoun2.list[i].cpy_Nm;
        	}
//        	各航司年班次前十排行
        	var c_h_b_2 =[];
        	var c_h_b_d_a_2 = [];
        	for(var i in data.cpy_class2.list){
        		c_h_b_2[i] = data.cpy_class2.list[i].count;
        		c_h_b_d_a_2[i] = data.cpy_class2.list[i].cpy_Nm;
        		
        	}
            if(data){
	            ultimately={
	                enterT:{
	                    inTA:{
	                        id:"inTrafficAnalysis",
	                        name:"月流量走势分析",
	                        time:month,
	                        data:[m_k,m_z,m_b,m_g,m_gs,m_s],
	                        calibration:[ "客流", "座位", "班次*100", "团队","团队收入/100","收入/1000"]
	                    },
	                    actsa:{
	                        id:"analysis",
	                        name:"均班客流量走势分析",
	                        time:j_month,
	                        data:[j_k,j_z,j_b,j_g,j_gs,j_s],
	                        calibration:[ "客流", "座位", "客座率", "团队","团队收入/100","收入/1000"]
	                    },
	                    averageA:{
	                        className:"班次",
	                        id:"averageA",
	                        name:"年班次前十排行",
	                        data:n_d,
	                        xalse:n_d_a,
	                        keyval:n_d_a_m
	                    },
	                    kttr:{
	                        name:"座公里收入前十排行",
	                        subname:"",
	                        id:"kttr",
	                        classNmae:["座公里收入*100","每班收入/1000"],
	                        datazuo:s_z,
	                        databan:s_b,
	                        xalse:s_d_a,
	                        keyval:s_d_a_m
	                    },
	                    rp10: {
	                        id:"rp10",
	                        className:"客量",
	                        name:"旅客前十排行",
	                        data:l_z,
	                        xalse:l_d_a,
	                        keyval:l_d_a_m
	                    },
	                    tracpq10:{
	                        id:"tracpq10",
	                        name: "均班客量前十排行",
	                        classNmae:["每班旅客","每班座位","每班团队"],
	                        datal:j_l_2,
	                        dataz:j_z_2,
	                        datat:j_t_2,
	                        xalse:j_d_a_2,
	                        keyval:j_d_a_2_m
	                    },
	                    deguest10: {
	                        id:"de-guest10",
	                        className:"客量",
	                        name:"航司年客量前十排行",
	                        data:h_z,
	                        xalse:h_d_a
	                    },
	                    deshift10: {
	                        id:"deshift10",
	                        className:"班次",
	                        name:"航司年班次前十排行",
	                        data:h_b_2,
	                        xalse:h_b_d_a_2
	                    },
	                    routes:{
	                        name:"各航线年客量占比",
	                        id:"routes",
	                        className:l_d_a,
	                        data:l_z,
	                        keyval:l_d_a_m
	                    },
	                    sDepartment:{
	                        name:"各航司年客量占比",
	                        id:"sDepartment",
	                        className:h_d_a,
	                        data:h_z
	                    }
	                },
	                clearance:{
	                	inTA:{
	                        id:"inTrafficAnalysis",
	                        name:"月流量走势分析",
	                        time:c_month,
	                        data:[c_m_k,c_m_z,c_m_b,c_m_g,c_m_gs,c_m_s],
	                        calibration:[ "客流", "座位", "班次*100", "团队","团队收入/100","收入/1000"]
	                    },
	                    actsa:{
	                        id:"analysis",
	                        name:"均班客流量走势分析",
	                        time:c_j_month,
	                        data:[c_j_k,c_j_z,c_j_b,c_j_g,c_j_gs,c_j_s],
	                        calibration:[ "客流", "座位", "客座率", "团队","团队收入/100","收入/1000"]
	                    },
	                    averageA:{
	                        className:"班次",
	                        id:"averageA",
	                        name:"年班次前十排行",
	                        data:c_n_d,
	                        xalse:c_n_d_a,
	                        keyval:c_n_d_a_m
	                    },
	                    kttr:{
	                        name:"座公里收入前十排行",
	                        subname:"",
	                        id:"kttr",
	                        classNmae:["座公里收入*100","每班收入/1000"],
	                        datazuo:c_s_z,
	                        databan:c_s_b,
	                        xalse:c_s_d_a,
	                        keyval:c_s_d_a_m
	                    },
	                    rp10: {
	                        id:"rp10",
	                        className:"客量",
	                        name:"旅客前十排行",
	                        data:c_l_z,
	                        xalse:c_l_d_a,
	                        keyval:c_l_d_a_m
	                    },
	                    tracpq10:{
	                        id:"tracpq10",
	                        name: "均班客量前十排行",
	                        classNmae:["每班旅客","每班座位","每班团队"],
	                        datal:c_j_l_2,
	                        dataz:c_j_z_2,
	                        datat:c_j_t_2,
	                        xalse:c_j_d_a_2,
	                        keyval:c_j_d_a_2_m
	                    },
	                    deguest10: {
	                        id:"de-guest10",
	                        className:"客量",
	                        name:"航司年客量前十排行",
	                        data:c_h_z,
	                        xalse:c_h_d_a
	                    },
	                    deshift10: {
	                        id:"deshift10",
	                        className:"班次",
	                        name:"航司年班次前十排行",
	                        data:c_h_b_2,
	                        xalse:c_h_b_d_a_2
	                    },
	                    routes:{
	                        name:"各航线年客量占比",
	                        id:"routes",
	                        className:c_l_d_a,
	                        data:c_l_z,
	                        keyval:c_l_d_a_m
	                    },
	                    sDepartment:{
	                        name:"各航司年客量占比",
	                        id:"sDepartment",
	                        className:c_h_d_a,
	                        data:c_h_z
	                    }
	                }
	            };
	            if(bz1){
	        		$(".lin-historical-body-box").addClass("muhu");
	        		$(".reportErr").css("display","block");
	        	}else{
	        		$(".lin-historical-body-box").removeClass("muhu");
	        		$(".reportErr").css("display","none");
	        	}
	            box();
	            drawing();
	            $(window).resize(function(){
	                box();
	                if($(".set").next().length==1){
	                    drawing();
	                }else {
	                    out();
	                }
	                calculate();//默认执行一次
	            });
	            calculate();//默认执行一次
            }
//            console.log(airports[dpt_AirPt_Cd]);
//            loadWeather(airports[dpt_AirPt_Cd].icao);
            loadWeather(parent.iataMap[dpt_AirPt_Cd].icao);
        },error : function() {//FIXME  请求数据后此函数内容应放在success里面 -暂时做无求情数据测试
        }
    });
}
/*进港方法*/
function drawing(){
    /**/
    movements(ultimately.enterT.inTA);
    movements(ultimately.enterT.actsa);
    /**/
    legend2(ultimately.enterT.averageA);
    legend2(ultimately.enterT.rp10);
    legend2(ultimately.enterT.deguest10);
    legend2(ultimately.enterT.deshift10);
    /**/
    legend3(ultimately.enterT.kttr);
    /**/
    legend4(ultimately.enterT.tracpq10);
    /**/
    legend5(ultimately.enterT.routes);
    legend5(ultimately.enterT.sDepartment);
}
/*出港方法*/
function out(){
    movements(ultimately.clearance.inTA);
    movements(ultimately.clearance.actsa);
    /**/
    legend2(ultimately.clearance.averageA);
    legend2(ultimately.clearance.rp10);
    legend2(ultimately.clearance.deguest10);
    legend2(ultimately.clearance.deshift10);
    /**/
    legend3(ultimately.clearance.kttr);
    /**/
    legend4(ultimately.clearance.tracpq10);
    /**/
    legend5(ultimately.clearance.routes);
    legend5(ultimately.clearance.sDepartment);
}
/******绘图函数*********/
/*单混合折-柱图*/
function movements(coll){
    var dom = document.getElementById(coll.id);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: coll.name,
            left:'10%',
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
            data: coll.calibration,
            align: 'left',
            right: "5%",
            top:"15%",
            textStyle:{
                color:"white"
            }
        },
        grid: {
            left: '4%',
            right: '10%',
            bottom: '20%',
            top:"25%",
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : coll.time,
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
                name:coll.calibration[0],
                smooth: true,
                type:'bar',
                showSymbol:false,
                itemStyle:{
                    normal:{
                        color:"#1f4e7f"
                    }
                },
                barWidth:20,
                data:coll.data[0]
            },
            {
                name:coll.calibration[1],
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#84acda"
                    }
                },
                data:coll.data[1]
            },
            {
                name:coll.calibration[2],
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#52b778"
                    }
                },
                symbol:"rect",
                data:coll.data[2]
            },
            {
                name:coll.calibration[3],
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#af9060"
                    }
                },
                symbol:"triangle",
                data:coll.data[3]
            },
            {
                name:coll.calibration[4],
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#8e672e"
                    }
                },
                symbol:"triangle",
                data:coll.data[4]
            },
            {
                name:coll.calibration[5],
                type:'line',
                itemStyle:{
                    normal:{
                        color:"#d35b4c"
                    }
                },
                symbol:"triangle",
                data:coll.data[5]
            }

        ]
    };
    myChart.setOption(option, true);
}
/*单柱状图*/
function legend2(coll){
    var dom = document.getElementById(coll.id);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: coll.name,
            left:'10%',
            top:'5%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            }
        },
        grid: {
            left: '4%',
            right: '10%',
            bottom: '20%',
            top:"25%",
            containLabel: true
        },
        tooltip: {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            },
            formatter:function(params){
                return typeof(coll.keyval)!='undefined'?(coll.keyval[params[0].name]+'<br/>'+params[0].seriesName+'：'+params[0].value):(params[0].seriesName+'：'+params[0].value);
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        toolbox: {
            show: false
        },
        xAxis:  {
            type: 'category',
            boundaryGap: true,
            data: coll.xalse,
            axisTick: {
                alignWithLabel: false
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            splitLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            axisLabel:{
                interval:0,
                rotate:45,
                margin:10,
	           	textStyle:{
  	                 color:"white"
   	           	}
            }
        },
        yAxis: {
            show:true,
            type: 'value',
            boundaryGap: ['0%', '20%'],
            splitLine:{
                show:false
            },
            axisLabel: {
                formatter: '{value}',
	           	textStyle:{
  	                 color:"white"
   	           	}
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            axisTick:{
                show:true
            }
        },
        legend: {
            x:'right',
            show:true,
            data: [{name:coll.className,icon:'roundRect', textStyle: {color: 'white'}}],
            itemHeight :10,
            itemWidth:25,
            left:"80%",
            top:"10%"
        },
        series: [
            {
                name:coll.className,
                type:'bar',
                stack:'total',
                label:{
                    normal:{
                        show: false,
                        position:'top'
                    }
                },
                barWidth: 20,
                itemStyle:{
                    normal:{
                        color:'#7ebce9',
                        label : {show: true, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                data:coll.data
            }
        ]
    };
    myChart.setOption(option, true);
}
/*双柱图*/
function legend3(coll){
    var dom = document.getElementById(coll.id);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: coll.name,
            left:'10%',
            top:'5%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            },
//            subtext: '（不过站）'
        },
        grid: {
            left: '4%',
            right: '10%',
            bottom: '20%',
            top:"25%",
            containLabel: true
        },
        tooltip: {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            },
            formatter:function(params){
            	if(params.length==2){
            		return coll.keyval[params[0].name]+'<br/>'+params[0].seriesName+'：'+params[0].value+'<br/>'+params[1].seriesName+'：'+params[1].value;
            	}else{
            		return coll.keyval[params[0].name]+'<br/>'+params[0].seriesName+'：'+params[0].value;
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
            boundaryGap: true,
            data: coll.xalse,
            axisTick: {
                alignWithLabel: false
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            splitLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            axisLabel:{
                interval:0,
                rotate:45,
                margin:10,
	           	textStyle:{
  	                 color:"white"
   	           	}
            }
        },
        yAxis: [
            {
                type: 'value',
                show:true,
                boundaryGap: ['0%', '20%'],
                splitLine:{
                    show:false
                },
                axisLabel: {
                    formatter: '{value}',
    	           	textStyle:{
      	                 color:"white"
       	           	}
                },
                axisLine:{
                    show:true,
                    lineStyle:{
                        color:'#475367'
                    }
                }
            },{
                type: 'value',
                show:false,
                name:coll.classNmae[1],
                boundaryGap: ['0%', '20%'],
                splitLine:{
                    show:false
                },
                axisLabel: {
                    formatter: '{value}',
    	           	textStyle:{
      	                 color:"white"
       	           	}
                },
                axisLine:{
                    show:true,
                    lineStyle:{
                        color:'#475367'
                    }
                }
            }],
        legend: {
            x:'right',
            show:true,
            data: [{name:coll.classNmae[0],icon:'roundRect', textStyle: {color: 'white'}},{name:coll.classNmae[1],icon:'roundRect',textStyle: {color: 'white'}}],
            itemHeight :10,
            itemWidth:25,
            left:"55%",
            top:"10%"
        },
        series: [
            {
                name:coll.classNmae[0],
                type:'bar',
                data:coll.datazuo,
                itemStyle:{
                    normal:{
                        color:'#7ebce9',
                        label : {show: false, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                barWidth:20
            },
            {
                name:coll.classNmae[1],
                type:'bar',
                data:coll.databan,
                itemStyle:{
                    normal:{
                        color:'#fdc671',
                        label : {show: false, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                barWidth:20
            }
        ]
    };
    myChart.setOption(option, true);
}
/*三柱图*/
function legend4(coll){
    var dom = document.getElementById(coll.id);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: coll.name,
            left:'10%',
            top:'5%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            },
//            subtext: '（不过站）'
        },
        grid: {
            left: '4%',
            right: '10%',
            bottom: '20%',
            top:"25%",
            containLabel: true
        },
        tooltip: {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            },
            formatter:function(params){
            	if(params.length==3){
            		return coll.keyval[params[0].name]+'<br/>'+params[0].seriesName+'：'+params[0].value+'<br/>'+params[1].seriesName+'：'+params[1].value+'<br/>'+params[2].seriesName+'：'+params[2].value;
            	}else if(params.length==2){
            		return coll.keyval[params[0].name]+'<br/>'+params[0].seriesName+'：'+params[0].value+'<br/>'+params[1].seriesName+'：'+params[1].value;
            	}else{
            		return coll.keyval[params[0].name]+'<br/>'+params[0].seriesName+'：'+params[0].value+'<br/>';
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
            boundaryGap: true,
            data: coll.xalse,
            axisTick: {
                alignWithLabel: false
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            splitLine:{
                show:true,
                lineStyle:{
                    color:'#475367'
                }
            },
            axisLabel:{
                interval:0,
                rotate:45,
                margin:10,
	           	textStyle:{
  	                 color:"white"
   	           	}
            }
        },
        yAxis: [
            {
                type: 'value',
                show:true,
                boundaryGap: ['0%', '20%'],
                splitLine:{
                    show:false
                },
                axisLabel: {
                    formatter: '{value}',
    	           	textStyle:{
      	                 color:"white"
       	           	}
                },
                axisLine:{
                    show:true,
                    lineStyle:{
                        color:'#475367'
                    }
                }
            },{
                type: 'value',
                show:false,
                name:"座公里收入*100",
                boundaryGap: ['0%', '20%'],
                splitLine:{
                    show:false
                },
                axisLabel: {
                    formatter: '{value}',
    	           	textStyle:{
      	                 color:"white"
       	           	}
                },
                axisLine:{
                    show:true,
                    lineStyle:{
                        color:'#475367'
                    }
                }
            }],
        legend: {
            x:'right',
            show:true,
            data: [{name:coll.classNmae[0],icon:'roundRect', textStyle: {color: 'white'}},{name:coll.classNmae[1],icon:'roundRect',textStyle: {color: 'white'}},{name:coll.classNmae[2],icon:'roundRect',textStyle: {color: 'white'}}],
            itemHeight :10,
            itemWidth:25,
            left:"50%",
            top:"12%"
        },
        series: [
            {
                name:coll.classNmae[0],
                type:'bar',
                data:coll.datal,
                itemStyle:{
                    normal:{
                        color:'#7ebce9',
                        label : {show: false, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                barWidth:15
            },
            {
                name:coll.classNmae[1],
                type:'bar',
                data:coll.dataz,
                itemStyle:{
                    normal:{
                        color:'#fdc671',
                        label : {show: false, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                barWidth:15
            },
            {
                name:coll.classNmae[2],
                type:'bar',
                data:coll.datat,
                itemStyle:{
                    normal:{
                        color:'#52b778',
                        label : {show: false, position: 'top',textStyle: {color: '#fff'}}
                    }
                },
                barWidth:15
            }
        ]
    };
    myChart.setOption(option, true);
}
/*混合柱-饼图*/
function legend5(coll){
	var newdata = [];
	for(var i in coll.data){
		newdata[i] =  {value:coll.data[i], name:coll.className[i]};
	}
    var dom = document.getElementById(coll.id);
    var myChart = echarts.init(dom);
    var option = {
        title: {
            text: coll.name,
            left:'10%',
            top:'5%',
            textStyle:{
                color:"white",
                fontWeight:"normal"
            }
        },
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            },
            borderColor:'#d85430',
            borderWidth:1
        },
        grid: {
            left: '70%',
            right: '4%',
            bottom: '10%',
            top:"10%",
            containLabel: true
        },
        calculable : true,
        legend: {
            data:coll.className,
            left:"10%",
            right:"70%",
            top:"25%",
            textStyle:{
                color:"white"
            }
        },
        xAxis : [
            {
                show:false,
                type : 'value',
                position: 'right'
            }
        ],
        yAxis : [
            {
                show:true,
                type : 'category',
                splitLine : {show : false},

                axisLine:{
                    show:false,
                    lineStyle:{
                        color:"#fff"
                    }
                },
                axisTick:{
                    show:false
                },
                data : coll.className
            }
        ],
        series : [
            {
                name:'排行',
                type:'bar',
                tooltip : {
                    trigger: 'item',
//                    formatter: '{b} : {c}',
                    formatter:function(params){
                    	return typeof(params.percent)=='undefined'?(typeof(coll.keyval)!='undefined'?(coll.keyval[params.name]+'：'+params.value+'人'):(params.name+'：'+params.value+'人')):(typeof(coll.keyval)!='undefined'?(coll.keyval[params.name]+'：'+params.percent+'%（'+params.value+'人）'):(params.name+'：'+params.value+'人'));
                    },
                    borderColor:'#d85430',
                    borderWidth:1
                },
                barWidth: "18",
                data:coll.data,
                itemStyle:{
                    normal:{
                        color:"#83acda"
                    }
                }

            },
            {
                name:'占比',
                type:'pie',
                tooltip : {
                    trigger: 'item',
//                    formatter: '{b} : {c} ({d}%)',
                    formatter:function(params){
                    	return typeof(params.percent)=='undefined'?(typeof(coll.keyval)!='undefined'?(coll.keyval[params.name]+'：'+params.value+'人'):(params.name+'：'+params.value+'人')):(typeof(coll.keyval)!='undefined'?(coll.keyval[params.name]+'：'+params.percent+'%（'+params.value+'人）'):(params.name+'：'+params.percent+'%（'+params.value+'人）'));
                    },
                    borderColor:'#d85430',
                    borderWidth:1
                },
                center:["45%","50%"],
                radius : [0, "50%"],
                label: {
                    normal: {
                        show: false
                    }
                },
                itemStyle :{
                    normal : {
                        labelLine : {
                            length : 20
                        }
                    }
                },
                data: newdata
            }
        ]
    };
    myChart.setOption(option, true);
}
function lastyears(){
	var years = $('#years').text();
	years = parseInt(years.split('-')[0]);
	var startYear = years-6;
	var endYear = years-1;
	$('#years').text(startYear+'-'+endYear);
	var html = '';
	for(var i=startYear;i<=endYear;i++){
		if(i==parseInt(currentCheckedYear)){
			html+='<div class="year-btn list">'+i+'</div>';
		}else{
			html+='<div class="year-btn">'+i+'</div>';
		}
	}
	$('.sr-box-body-date-body').html(html);
}
function nextyears(){
	var years = $('#years').text();
	years = parseInt(years.split('-')[1]);
	var startYear = years+1;
	var endYear = years+6;
	$('#years').text(startYear+'-'+endYear);
	var html = '';
	for(var i=startYear;i<=endYear;i++){
		if(i==parseInt(currentCheckedYear)){
			html+='<div class="year-btn list">'+i+'</div>';
		}else{
			html+='<div class="year-btn">'+i+'</div>';
		}
	}
	$('.sr-box-body-date-body').html(html);
}

//日历绑定事件
$(function(){
	$(".sr-box-body-date-body").on("click",'.year-btn',function(val){
		$(".list").attr("class","year-btn");
		$(val.target).attr("class","year-btn list");
		send();
	});
});