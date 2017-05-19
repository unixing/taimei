<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
		var cityPicker = new HzwCityPicker({
			data: data,
			target: 'cityChoice',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var searchJson = getParameter();
				if("数据源"!=searchJson.dta_Sce&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					getFlt_Nbr(searchJson);
				}
			}
			
		});
		cityPicker.init();
		var cityPicker = new HzwCityPicker({
			data: data,
			target: 'cityChoice2',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var searchJson = getParameter();
				if("数据源"!=searchJson.dta_Sce&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					getFlt_Nbr(searchJson);
				}
			}
		});
		cityPicker.init();
		var cityPicker = new HzwCityPicker({
			data: data,
			target: 'cityChoice3',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var searchJson = getParameter();
				if("数据源"!=searchJson.dta_Sce&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					getFlt_Nbr(searchJson);
				}
			}
		});
		cityPicker.init();
	</script>
<script type="text/javascript">
	var flight = "";
	window.onload = function(){ 
		var object = parent.supData;
		var flightTemp = object.flight.split("/");
		flight =flightTemp[0]+"/"+flightTemp[0].substring(0,4)+flightTemp[1];
			
		var lane = object.lane;
		if(lane!=null&&lane!=''&&lane!='undefined'){
			var dpt = lane.split("=");
			if(dpt.length==3){
				$('#cityChoice').val(dpt[0]);
				$('#cityChoice3').val(dpt[1]);
				$('#cityChoice2').val(dpt[2]);
			}else{
				$('#cityChoice').val(dpt[0]);
				$('#cityChoice2').val(dpt[1]);
			}
			var searchJson = getParameter();
			getFlt_Nbr(searchJson);
			getNewDate(searchJson);
		}
	};
	function getNewDate(searchJson){
		$.ajax({
	        type:'post',
	        url:'${pageContext.request.contextPath}/getDayAndMonth',//请求数据的地址	
	        data:searchJson,
	        success:function(data){
	        	$("#dailyReportDate").val(data.defaultDate);
	        	$("#weeklyReportDate").val(data.defaultMonth);
	        	$("#monthlyReportDate").val(data.defaultMonth);
	        	$("#halfYearReportDate").val(data.defaultYear);
	        	$("#yearlyReportDate").val(data.defaultYear);
	        	doSend();
	        }
	    });
	}
		//获得参数
		function getParameter(id){
			var dta_Sce = $(window.parent.document.body).find("#cc1").val();
			var custormersearchForm;
			custormersearchForm = $("#DOW-searchForm");
			var searchJson = custormersearchForm.searchJson();
			searchJson.dta_Sce = dta_Sce;
			if("数据源"==searchJson.dta_Sce){
				searchJson.dta_Sce="中航";
			}
			return searchJson;
		};
		//该执行那个查询方法
		function doSend(){
			var las1 = $('#dailyReport').attr('class');
			var las2 = $('#weeklyReport').attr('class');
			var las3 = $('#monthlyReport').attr('class');
			var las4 = $('#halfYearReport').attr('class');
			var las5 = $('#yearlyReport').attr('class');
			if(las1=="tab-pane fade active in"){
				getAllTime();
			}
			if(las2=="tab-pane fade active in"){
				weeklyReport();
			}
			if(las3=="tab-pane fade active in"){
				monthlyReport();
			}
			if(las4=="tab-pane fade active in"){
				halfYearReport();
			}
			if(las5=="tab-pane fade active in"){
				yearlyReport();
			}
		}
		//动态生成航班号
		function getFlt_Nbr(searchJson){
			var obj2=document.getElementById('flt_nbr_Count');  
			obj2.length=0;
			$.ajax({
		        type:'post',
		        url:'${pageContext.request.contextPath}/getHbh',//请求数据的地址	
		        data:searchJson,
		        success:function(data){
		        	obj2.options.add(new Option("汇总"));
		            for(var index in data.list){
		            	if(flight==data.list[index]){
		            		var a = new Option(data.list[index]);
		            		a.selected = true;
		            		obj2.options.add(a); 
		            	}else{
		            		obj2.options.add(new Option(data.list[index])); 
		            	}
		            }
		        }
		    });
		}
		//日报
		function dailyReport(){
			exchangeDate();
			var searchJson = getParameter();
			var dailyReportDate = $("#dailyReportDate").val();
			var flyTime = $("#flyTime").val();
			var hourPrice = $("#hourPrice").val();
			searchJson.day = dailyReportDate;
			searchJson.flyTime = flyTime;
			searchJson.hourPrice = hourPrice;
			if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
					beforeSend: function(){
						$('#myTabContent').hide();
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        	$('#myTabContent').show();
			        },
			        type:'post',
			        url:'${pageContext.request.contextPath}/getDailyReportData',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//创建表格
			        		$("#dailyReportTable").bootstrapTable("destroy");
				        	createTableData(data.list);
				        	if(data.list.length>1){
				        		$("#hourPrice").val(data.list[data.list.length-1].mbxssr);
				        	}
				        	mergeCell(data.list.length);
			        	
			        }
			    });
			}else{
				alert("请输入查询条件");
			}
		};
		function getAllTime(){
			var searchJson = getParameter();
			var dailyReportDate = $("#dailyReportDate").val();
			searchJson.day = dailyReportDate;
			if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
			        type:'post',
			        url:'${pageContext.request.contextPath}/getTalTime',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	$("#flyTime").val(data.allTime);
			        	dailyReport();
			        }
			    });
			}else{
				alert("请输入查询条件");
			}
		};
		//周报
		function weeklyReport(){
			var searchJson = getParameter();
			var weeklyReportDate = $("#weeklyReportDate").val();
			searchJson.weekly = weeklyReportDate;
			if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
					beforeSend: function(){
						$('#myTabContent').hide();
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        	$('#myTabContent').show();
			        },
			        type:'post',
			        url:'${pageContext.request.contextPath}/getWeeklyReportData',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//创建表格
			        	var i = 0;
			        	var object ;
			        	for(var key in data){
			        		$("#weeklyReportTable"+key+"").bootstrapTable("destroy");
			        		if(data[key].length>1){
				        		createWeeklyTable(key,data[key]);
				        		objcet = data[key];
				        		i++;
				        		mergeCell2(key);
			        		}
			        		
			        	}
			        	if(i==0){
			        		createWeeklyTable(1,object);
			        	}
			        }
			    });
			}else{
				alert("请输入查询条件");
			}
		};
		//月报
		function monthlyReport(){
			var searchJson = getParameter();
			var monthlyReportDate = $("#monthlyReportDate").val();
			searchJson.month = monthlyReportDate;
			if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
					beforeSend: function(){
						$('#myTabContent').hide();
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        	$('#myTabContent').show();
			        },
			        type:'post',
			        url:'${pageContext.request.contextPath}/getMonthlyReportData',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//创建表格
			        	$("#monthlyReportTable").bootstrapTable("destroy");
			        	createMonthlyTable(data.list);
			        	mergeCell3();
			        }
			    });
			}else{
				alert("请输入查询条件");
			}
		};
		//季报
		function halfYearReport(){
			var searchJson = getParameter();
			var halfYearReportDate = $("#halfYearReportDate").val();
			searchJson.year = halfYearReportDate;
			if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
					beforeSend: function(){
						$('#myTabContent').hide();
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        	$('#myTabContent').show();
			        },
			        type:'post',
			        url:'${pageContext.request.contextPath}/getHalfYearReportData',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//创建表格
			        	for(var index=1;index<=data.list.length;index++){
			        		$("#halfYearReportTable"+index).bootstrapTable("destroy");
			        		createHalfYearlyTable(data.list[index-1],index);
			        		mergeCell5(index);
			        	}
			        	
			        }
			    });
			}else{
				alert("请输入查询条件");
			}
		};
		//年报
		function yearlyReport(){
			var searchJson = getParameter();
			var yearlyReportDate = $("#yearlyReportDate").val();
			searchJson.year = yearlyReportDate;
			if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
					beforeSend: function(){
						$('#myTabContent').hide();
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        	$('#myTabContent').show();
			        },
			        type:'post',
			        url:'${pageContext.request.contextPath}/getYearlyReportData',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//创建表格
			        	for(var index=1;index<=data.list.length;index++){
			        		$("#yearlyReportTable"+index).bootstrapTable("destroy");
			        		createYearlyTable(data.list[index-1],index);
			        		mergeCell4(index);
			        	}
			        }
			    });
			}else{
				alert("请输入查询条件");
			}
		};
		
		function infoFormatter(value, row, index){
            return fomatDigit(value,2);
        }
		//月报表格创建
		function createMonthlyTable(datasorce){
			$("#monthlyReportTable").bootstrapTable({
				data: datasorce,         
	            method: 'get',                      
	            cache: false,  
	            showFooter:false,
	            showColumns: false,
	            dataType: "json",
	            pagination: false, 
	            width: "100%",
	            queryParams: null,
	            sidePagination: "server",          
	            pageNumber:1,                       
	            pageSize: 10,                       
	            pageList: [10, 25, 50, 100],  
	            columns:[
					{
					field: 'weekly',
					title: '年月',
					width:'120',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'date',
					title: '日期',
					width:'120',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'hbys',
					title: '航班营收(元)',
					width:'80px',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'xsys',
					title: '小时营收(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'rs',
					title: '人数',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'sk',
					title: '散客',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'td',
					title: '团队',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'kzl',
					title: '客座率(%)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'pjzk',
					title: '平均折扣',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'zgl',
					title: '座公里',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'mbdcl',
					title: '目标达成率',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'bt',
					title: '补贴(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'bthdl',
					title: '补贴（含代理）(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					}
					]
	       		 });
		}
		//周报表格创建
		function createWeeklyTable(index,datasorce){
			$("#weeklyReportTable"+index+"").bootstrapTable({
				data: datasorce,         
	            method: 'get',                      
	            cache: false,  
	            showFooter:false,
	            showColumns: false,
	            dataType: "json",
	            pagination: false, 
	            width: "100%",
	            queryParams: null,
	            sidePagination: "server",          
	            pageNumber:1,                       
	            pageSize: 10,                       
	            pageList: [10, 25, 50, 100],  
	            columns:[
					{
					field: 'weekly',
					title: ' 周数',
					width:'120',
					align: 'center',
					valign: 'middle'
					},
					{
					
					field: 'date',
					title: '日期',
					width:'120',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'hbys',
					title: '航班营收(元)',
					width:'80px',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'xsys',
					title: '小时营收(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'rs',
					title: '人数',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'sk',
					title: '散客',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'td',
					title: '团队',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'kzl',
					title: '客座率(%)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'pjzk',
					title: '平均折扣',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'zgl',
					title: '座公里',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'mbdcl',
					title: '目标达成率',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'bt',
					title: '补贴(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'bthdl',
					title: '补贴（含代理）(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					}
					]
	       		 });
		}
		//年报表格创建
		function createYearlyTable(datasorce,index){
			$("#yearlyReportTable"+index+"").bootstrapTable({
				data: datasorce,         
	            method: 'get',                      
	            cache: false,  
	            showFooter:false,
	            showColumns: false,
	            dataType: "json",
	            pagination: false, 
	            width: "100%",
	            queryParams: null,
	            sidePagination: "server",          
	            pageNumber:1,                       
	            pageSize: 10,                       
	            pageList: [10, 25, 50, 100],  
	            columns:[
					{
					field: 'year',
					title: ' 年份',
					width:'120',
					align: 'center',
					valign: 'middle'
					},
					{
					
					field: 'month',
					title: '月份',
					width:'120',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'bc',
					title: '班次',
					width:'80px',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'yys',
					title: '月营收(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'jbxsys',
					title: '均班小时营收(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'zrs',
					title: '总人数',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'jbrs',
					title: '均班人数',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'jbkzl',
					title: '均班客座率(%)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'zglsr',
					title: '座公里收入(元)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'zbt',
					title: '总补贴(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'jbbt',
					title: '均班补贴(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'bthdlf',
					title: '补贴(含代理费)(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					}
					]
	       		 });
		}
		//季报表格创建
		function createHalfYearlyTable(datasorce,index){
			$("#halfYearReportTable"+index+"").bootstrapTable({
				data: datasorce,         
	            method: 'get',                      
	            cache: false,  
	            showFooter:false,
	            showColumns: false,
	            dataType: "json",
	            pagination: false, 
	            width: "100%",
	            queryParams: null,
	            sidePagination: "server",          
	            pageNumber:1,                       
	            pageSize: 10,                       
	            pageList: [10, 25, 50, 100],  
	            columns:[
					{
					field: 'qury',
					title: ' 航季',
					width:'10%',
					align: 'center',
					valign: 'middle'
					},
					{
					
					field: 'month',
					title: '月份',
					width:'10%',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'bc',
					title: '班次',
					width:'10%',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'yys',
					title: '月营收',
					width:'10%',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'jbxsys',
					title: '均班小时营收',
					width:'10%',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'zrs',
					title: '总人数',
					width:'10%',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'jbrs',
					title: '均班人数',
					width:'10%',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'jbkzl',
					title: '均班客座率(%)',
					width:'10%',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'zglsr',
					title: '座公里收入',
					width:'5%',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'zbt',
					title: '总补贴',
					width:'5%',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'jbbt',
					title: '均班补贴',
					width:'5%',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'bthdlf',
					title: '补贴(含代理费)',
					width:'5%',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					}
					]
	       		 });
		}
		//日报表格创建 
		function createTableData(datasorce){
			$("#dailyReportTable").bootstrapTable({
				data: datasorce,         
	            method: 'get',                      
	            cache: false,  
	            showFooter:false,
	            showColumns: false,
	            dataType: "json",
	            pagination: false, 
	            width: "100%",
	            queryParams: null,
	            sidePagination: "server",          
	            pageNumber:1,                       
	            pageSize: 10,                       
	            pageList: [10, 25, 50, 100],  
	            columns:[
					{
					field: 'date',
					title: '航班<br/>日期',
					width:'500',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'airPort',
					title: '&nbsp&nbsp&nbsp&nbsp&nbsp航段&nbsp&nbsp&nbsp&nbsp&nbsp',
					width:'80px',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'yPrice',
					title: 'Y舱<br/>价格<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},    
					{
					field: 'cutPriceTeam',
					title: '切位团<br/>队价格<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle'
					}, 
					{
					field: 'two_Tak_Ppt',
					title: 'F<br/>200%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'ful_Pce_Ppt',
					title: 'Y<br/>100%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'nne_Dnt_Ppt',
					title: 'B<br/>90%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'eht_Five_Dnt_Ppt',
					title: 'H<br/>85%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'eht_Dnt_Ppt',
					title: 'K<br/>80%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'sen_Five_Dnt_Ppt',
					title: 'L<br/>75%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					}, 
					{
					field: 'sen_Dnt_Ppt',
					title: 'M<br/>70%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'six_Dnt_Ppt',
					title: 'Q<br/>60%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'fve_Dnt_Ppt',
					title: 'X<br/>50%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'fur_Fve_Dnt_Ppt',
					title: 'U<br/>45%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'fur_Dnt_Ppt',
					title: 'E<br/>40%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'thr_Dnt_Ppt',
					title: '30%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'two_Dnt_Ppt',
					title: 'T<br/>20%<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'grp_Nbr',
					title: 'G<br/>团队<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'sal_Tak_Ppt',
					title: '特殊<br/>舱位<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'pgs_Per_Cls',
					title: '散团人<br/>数合计<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'wak_tol_Nbr',
					title: '散客<br/>总人数<br/>',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'wak_tol_Ine',
					title: '散客<br/>总收入<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'grp_Ine',
					title: '团队<br/>总收入<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'avg_Dct',
					title: '平均<br/>折扣',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'set_Ktr_Ine',
					title: '座公<br/>里收入<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'pjkzl',
					title: '平均<br/>客座率(%)',
					width:'80',
					align: 'center',
					valign: 'middle'
					},
					{
					field: 'stzsr',
					title: '散团<br/>总收入<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'xssr',
					title: '小时<br/>收入<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'mbxssr',
					title: '目标小<br/>时收入<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'bbbt',
					title: '本班<br/>补贴<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					},
					{
					field: 'byljbt',
					title: '本月累<br/>计补贴<br/>(元)',
					width:'80',
					align: 'center',
					valign: 'middle',
					formatter: 'infoFormatter'
					}
					]
	       		 });
		}
		
		//合并日报单元格 
		function mergeCell(lineSize){
			var grid = $("#dailyReportTable");
			var rowCount = grid.find("tr").length - 1; 
			var rowTdCount = parseInt(grid.find("tr:eq("+rowCount+")").find("td").length - 1);
			
			var flagRow22 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-4)+")").html(); 
			var flagRow23 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-3)+")").html(); 
			var flagRow24 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-2)+")").html(); 
			var flagRow25 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-1)+")").html(); 
			var flagRow26 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-0)+")").html(); 
			
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-4)+")").html(flagRow22)
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-3)+")").html(flagRow23)
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").html(flagRow24)
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").html(flagRow25);
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-0)+")").html(flagRow26);
			grid.bootstrapTable('mergeCells', {index: 0, field: 'stzsr', colspan:1, rowspan: lineSize});
			grid.bootstrapTable('mergeCells', {index: 0, field: 'xssr', colspan:1, rowspan: lineSize});
			
			grid.bootstrapTable('mergeCells', {index: 0, field: 'mbxssr', colspan:1, rowspan: lineSize}); 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'bbbt', colspan:1, rowspan: lineSize}); 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'byljbt', colspan:1, rowspan: lineSize}); 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'date', colspan:1, rowspan: lineSize}); 
			if(lineSize>3){
				grid.bootstrapTable('mergeCells', {index: 0, field: 'set_Ktr_Ine', colspan:1, rowspan: (lineSize-1)/2});
				grid.bootstrapTable('mergeCells', {index: 0, field: 'pjkzl', colspan:1, rowspan: (lineSize-1)/2});
				grid.bootstrapTable('mergeCells', {index: 3, field: 'set_Ktr_Ine', colspan:1, rowspan: (lineSize-1)/2});
				grid.bootstrapTable('mergeCells', {index: 3, field: 'pjkzl', colspan:1, rowspan: (lineSize-1)/2});
			}else{
				var flagRow21 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-5)+")").html(); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-5)+")").html(flagRow21)
				grid.bootstrapTable('mergeCells', {index: 0, field: 'pjkzl', colspan:1, rowspan: lineSize});
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-5)+")").css("color","red"); 
			}
			
			//
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-4)+")").css("color","red"); 
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-3)+")").css("color","red"); 
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").css("color","red"); 
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").css("color","red"); 
			grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-0)+")").css("color","red");  
			grid.find("tr:eq("+rowCount+")").css("color","red");
		}
		//合并周报单元格 
		function mergeCell2(index){
			var grid = $("#weeklyReportTable"+index+"");
			var rowCount = grid.find("tr").length; 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'weekly', colspan:1, rowspan: rowCount}); 
			
			grid.find("tr:eq("+(rowCount-1)+")").css("color","red");
		}
		//合并月报单元格 
		function mergeCell3(){
			var grid = $("#monthlyReportTable");
			var rowCount = grid.find("tr").length; 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'weekly', colspan:1, rowspan: rowCount}); 
			grid.find("tr:eq("+(rowCount-1)+")").css("color","red");
		}
		//合并年单元格 
		function mergeCell4(index){
			var grid = $("#yearlyReportTable"+index);
			var rowCount = grid.find("tr").length; 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'year', colspan:1, rowspan: rowCount}); 
			grid.find("tr:eq("+(rowCount-1)+")").css("color","red");
		}
		//合并季单元格 
		function mergeCell5(index){
			var grid = $("#halfYearReportTable"+index);
			var rowCount = grid.find("tr").length; 
			grid.bootstrapTable('mergeCells', {index: 0, field: 'qury', colspan:1, rowspan: rowCount}); 
			grid.find("tr:eq("+(rowCount-1)+")").css("color","red");
		}
		//改变日报选择的日期，其他报表的日期也改变
		function exchangeDate(){
			var date = $("#dailyReportDate").val();
			var year = date.substr(0,4);
			var month = date.substr(0,7);
			$("#weeklyReportDate").val(month);
			$("#monthlyReportDate").val(month);
			$("#halfYearReportDate").val(year);
			$("#yearlyReportDate").val(year);
		}
</script>
