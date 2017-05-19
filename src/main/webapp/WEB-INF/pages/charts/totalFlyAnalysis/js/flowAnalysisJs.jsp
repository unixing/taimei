<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<script type="text/javascript">
			function send(){
				removeDiv();
				var abzs = $('#abflowAsiay').attr('class');
				var bazs = $('#baflowAsiay').attr('class');
				var abgf = $('#abtotalflyAsiay').attr('class');
				var bagf = $('#batotalflyAsiay').attr('class');
				var abbagf = $('#abbatotalflyAsiay').attr('class');
				if(abzs=="tab-pane fade active in"){
					abflowAsiay();
				}
				if(bazs=="tab-pane fade active in"){
					baflowAsiay();
				}
				if(abgf=="tab-pane fade active in"){
					abtotalflyAsiay();
				}
				if(bagf=="tab-pane fade active in"){
					batotalflyAsiay();
				}
				if(abbagf=="tab-pane fade active in"){
					abbatotalflyAsiay();
				}
			}
			function abflowAsiay(){
				removeDiv();
				var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
				advancedQuery(searchJson,"abflowcharts");
			}
			function baflowAsiay(){
				removeDiv();
				var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				var dpt_AirPt_Cd = searchJson.dpt_AirPt_Cd
				var arrv_Airpt_Cd = searchJson.Arrv_Airpt_Cd
				searchJson.dpt_AirPt_Cd = arrv_Airpt_Cd
				searchJson.Arrv_Airpt_Cd = dpt_AirPt_Cd
				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
				advancedQuery(searchJson,"baflowcharts");
			}
			function advancedQuery(searchJson,id){
				var width = $(document.body).width()/2+"px";
				var charts = $("#"+id);
				var dataAll = 0;
				if(""!=searchJson.startDate&&""!=searchJson.endDate&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
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
	        	        url:'${pageContext.request.contextPath}/getFlowAnalysisData',
	        	        data:searchJson,
	        	        success:function(data){
	        	        	if(data.flowCount!=null&&data.flowCount!=""){
	        	        		for(var i=0;i<data.flowCount.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.flowCount[i]){
	        	        				 dataAll = dataAll + Number(data.flowCount[i][index].tal_Nbr_Set);
	        	        				 isShow = isShow + Number(data.flowCount[i][index].tal_Nbr_Set);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var main=$("<div class='col-md-6' id='main"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>");
		        	        			 charts.append(main);
	        	        				 flowCountEcharts(data.flowCount[i],"main"+id+i,searchJson);
	        	        			 }
	        	        		}
	        	        	}
	        	        	 if(data.allAmount!=null&&data.allAmount!=""){
	        	        		for(var i=0;i<data.allAmount.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.allAmount[i]){
	        	        				 dataAll = dataAll + Number(data.allAmount[i][index].cla_Set);
	        	        				 isShow = isShow + Number(data.allAmount[i][index].cla_Set);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var EvenPort=$("<div class='col-md-6' id='evenpot"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(EvenPort);
		        	        			 allAmountEcharts(data.allAmount[i],"evenpot"+id+i,searchJson);
	        	        			 }
	        	        		}
	        	        	} 
	        	        	 if(dataAll<=0){
	   	        				 alert("当前条件下无数据，请检查查询条件");
	   	        			 }
	        	        }
	        	    }); 
				}else{
					alert("请检查查询条件");
				}
			};
			//移除DIV
			function removeDiv(){
				$("#abflowcharts div").remove();
				$("#baflowcharts div").remove();
				$("#abtotalcharts div").remove();
				$("#batotalcharts div").remove();
				$("#abbatotalcharts div").remove();
			};
			function flowCountEcharts(flowCountData,divId,searchJson){
				require.config({
		            paths: {
		                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
		            }
		        });
		        require(
			            [
			                'echarts',
			                'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
			                'echarts/chart/bar'
			            ],
			            function (ec) {  
			                var chart = document.getElementById(divId);  
			                
			                var echart = ec.init(chart);  
			                  
			                echart.showLoading({  
			                    text: '正在努力加载中...'  
			                });  
			                  
			        	 	var oneName = [];//X轴
			         	    var idd_moh = [];// 客流/月
			         	    var cla_Nbr = [];// 班次/月
			         	    var tal_Nbr_Set = [];// 座位/月
			         	    var grp_moh = [];//团队人数/月
			         	    var grp_Ine = [];//团队收入/月/100
			         	    var tol_Ine = [];//收入/月/1000
			        	    var tenName = '';
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                  
	        	        	for(var index in flowCountData){
		        	        	oneName[index]  = flowCountData[index].month+"月";
		        	        	idd_moh[index]  = flowCountData[index].idd_moh;
		        	        	cla_Nbr[index]  = flowCountData[index].cla_Nbr;
		        	        	tal_Nbr_Set[index]  = flowCountData[index].tal_Nbr_Set;
		        	        	grp_moh[index]  = flowCountData[index].grp_moh;
		        	        	grp_Ine[index]  = flowCountData[index].grp_Ine/100;
		        	        	tol_Ine[index]  = flowCountData[index].tol_Ine/1000;
		        	        	tenName = flowCountData[index].year+"年"+flowCountData[index].hangduan;
	        	        	}
			                  
			                var option = { 
			                		title : {
			                	        text: tenName+"  流量走势图",
			                	        x: 'center'
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','客流/月','班次/月','座位/月','团队人数/月','团队收入/月/100','收入/月/1000']  
			                    },
			                    toolbox: {
			                        show : true,
			                        orient: 'vertical',
			                        x: 'right',
			                        y: 'center',
			                        feature : {
			                            mark : {show: true},
			                            dataView : {show: true, readOnly: false},
			                            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
			                            restore : {show: true},
			                            saveAsImage : {show: true}
			                        }
			                    },
			                    xAxis: [  
			                        {  
			                            type: 'category',  
			                            data: oneName
			                        }  
			                    ],  
			                    yAxis: [  
			                        {  
			                            type: 'value'  
			                        }  
			                    ],  
			                    series : [
										{  
											'name': "客流/月",  
										    'type': 'bar',  
										    'data': idd_moh
										 },
										{  
											'name': "班次/月",  
										    'type': 'line',  
										    'data': cla_Nbr
										 },
										{  
											'name': "座位/月",  
										    'type': 'line',  
										    'data': tal_Nbr_Set
										 },
										{  
											'name': "团队人数/月",  
										    'type': 'line',  
										    'data': grp_moh
										 },
										{  
											'name': "团队收入/月/100",  
										    'type': 'line',  
										    'data': grp_Ine
										 },
										{  
											'name': "收入/月/1000",  
										    'type': 'line',  
										    'data': tol_Ine
										 }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			}
			//均班客量
			function allAmountEcharts(allAmountData,divId,searchJson){
				require.config({
		            paths: {
		                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
		            }
		        });
		        require(
			            [
			                'echarts',
			                'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
			                'echarts/chart/bar'
			            ],
			            function (ec) {  
			                var chart = document.getElementById(divId);  
			                
			                var echart = ec.init(chart);  
			                  
			                echart.showLoading({  
			                    text: '正在努力加载中...'  
			                });  
			                  
			                var xtext = [];//日期
			         	 	//var tme_Nbr = [];//天数
			         	    //var cla_Nbr = [];// 班次/月
			         	    //var tme_Cla_Moh = [];//日班次
			         	    var cla_Set = [];//每班座位
			         	    var cla_Per = [];//每班旅客
			         	    var cla_Grp = [];//每班团队
			         	    var flt_Ser_Ine = [];//团队收入/100
			         	    var lod_For = [];//客座率
			         	    var idd_Dct = [];//每班收入/1000
			         	    var evenPort = '';//title
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                  
	        	        	for(var index in allAmountData){
	        	        		//tme_Nbr[index] = Number(allAmountData[index].tme_Nbr); 
	        	            	//cla_Nbr[index] = Number(allAmountData[index].cla_Nbr); 
	        	            	//tme_Cla_Moh[index] = Number(allAmountData[index].tme_Cla_Moh); 
	        	            	cla_Set[index] = Number(allAmountData[index].cla_Set); 
	        	            	cla_Per[index] = Number(allAmountData[index].cla_Per); 
	        	            	cla_Grp[index] = Number(allAmountData[index].cla_Grp); 
	        	            	flt_Ser_Ine[index] = Number(allAmountData[index].flt_Ser_Ine)/100; 
	        	            	lod_For[index] = Number(allAmountData[index].lod_For)*100; 
	        	            	idd_Dct[index] = Number(allAmountData[index].idd_Dct)/1000; 
	        	                xtext[index] = allAmountData[index].month;
	        	                evenPort = allAmountData[index].year+"年"+allAmountData[index].hangduan;
	        	        	}
			                  
			                var option = { 
			                		title : {
			                	        text: evenPort+" 均班客量走势图",
			                	        x: 'center'
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                    	 data: ['','每班座位','每班旅客','每班团队','团队收入/100','客座率','每班收入/1000']  
			                    },
			                    toolbox: {
			                        show : true,
			                        orient: 'vertical',
			                        x: 'right',
			                        y: 'center',
			                        feature : {
			                            mark : {show: true},
			                            dataView : {show: true, readOnly: false},
			                            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
			                            restore : {show: true},
			                            saveAsImage : {show: true}
			                        }
			                    },
			                    xAxis: [  
			                        {  
			                            type: 'category',  
			                            data: xtext
			                        }  
			                    ],  
			                    yAxis: [  
			                        {  
			                            type: 'value'  
			                        }  
			                    ],  
			                    series : [
											 {  
													 'name': '每班座位',  
											     'type': 'line',  
											     'data': cla_Set  
											  },
												{  
													 'name': '每班旅客',  
											    'type': 'line',  
											    'data': cla_Per  
											 },
												
												{  
													 'name': '每班团队',  
											    'type': 'line',  
											    'data': cla_Grp  
											 },
												{  
													 'name': '团队收入/100',  
											    'type': 'line',  
											    'data': flt_Ser_Ine  
											 },
												{  
													 'name': '客座率',  
											    'type': 'line',  
											    'data': lod_For  
											 },
												{  
													 'name': '每班收入/1000',  
											    'type': 'line',  
											    'data': idd_Dct  
											 }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			}
			
		</script>
<script type="text/javascript">
	window.onload = function(){
		var airLine = parent.supData.lane;
		if(airLine!=null&&airLine!=""&&airLine!='undefined'){
			var cds = airLine.split("=");
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth();
			$('#startDate').val(year+'-01');
			if(month>=9){
				$('#endDate').val(year+'-'+(month+1));
			}else{
				$('#endDate').val(year+'-0'+(month+1));
			}
			if(cds.length==3){
				$('#cityChoice').val(cds[0]);
				$('#cityChoice3').val(cds[1]);
				$('#cityChoice2').val(cds[2]);
				$("#abzs").html(cds[0]+">>"+cds[1]+">>"+cds[2]+"走势分析");
				$("#bazs").html(cds[2]+">>"+cds[1]+">>"+cds[0]+"走势分析");
				$("#abgf").html(cds[0]+">>"+cds[1]+">>"+cds[2]+"共飞对比分析");
				$("#bagf").html(cds[2]+">>"+cds[1]+">>"+cds[0]+"共飞对比分析");
				$("#abbagf").html(cds[0]+"="+cds[1]+"="+cds[2]+"共飞对比分析");
			}else{
				$('#cityChoice').val(cds[0]);
				$('#cityChoice2').val(cds[1]);
				$("#abzs").html(cds[0]+">>"+cds[1]+"走势分析");
				$("#bazs").html(cds[1]+">>"+cds[0]+"走势分析");
				$("#abgf").html(cds[0]+">>"+cds[1]+"共飞对比分析");
				$("#bagf").html(cds[1]+">>"+cds[0]+"共飞对比分析");
				$("#abbagf").html(cds[0]+"="+cds[1]+"共飞对比分析");
			}
			send();
		}
	};
</script>