<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
		var cityPicker = new HzwCityPicker({
			data: data,
			target: 'cityChoice',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					if(""!=searchJson.pas_stp){
						$("#abzs").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.Arrv_Airpt_Cd+"走势分析");
						$("#bazs").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.dpt_AirPt_Cd+"走势分析");
						$("#abgf").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
						$("#bagf").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.dpt_AirPt_Cd+"共飞对比分析");
						$("#abbagf").html(searchJson.dpt_AirPt_Cd+"="+searchJson.pas_stp+"="+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
					}else{
						$("#abzs").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.Arrv_Airpt_Cd+"走势分析");
						$("#bazs").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.dpt_AirPt_Cd+"走势分析");
						$("#abgf").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
						$("#bagf").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.dpt_AirPt_Cd+"共飞对比分析");
						$("#abbagf").html(searchJson.dpt_AirPt_Cd+"="+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
					}
				}
			}
		});
		cityPicker.init();
		var cityPicker2 = new HzwCityPicker({
			data: data,
			target: 'cityChoice2',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					if(""!=searchJson.pas_stp){
						$("#abzs").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.Arrv_Airpt_Cd+"走势分析");
						$("#bazs").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.dpt_AirPt_Cd+"走势分析");
						$("#abgf").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
						$("#bagf").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.dpt_AirPt_Cd+"共飞对比分析");
						$("#abbagf").html(searchJson.dpt_AirPt_Cd+"="+searchJson.pas_stp+"="+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
					}else{
						$("#abzs").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.Arrv_Airpt_Cd+"走势分析");
						$("#bazs").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.dpt_AirPt_Cd+"走势分析");
						$("#abgf").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
						$("#bagf").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.dpt_AirPt_Cd+"共飞对比分析");
						$("#abbagf").html(searchJson.dpt_AirPt_Cd+"="+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
					}
				}
			}
		});
		cityPicker2.init();
		var cityPicker3 = new HzwCityPicker({
			data: data,
			target: 'cityChoice3',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				if(""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					if(""!=searchJson.pas_stp){
						$("#abzs").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.Arrv_Airpt_Cd+"走势分析");
						$("#bazs").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.dpt_AirPt_Cd+"走势分析");
						$("#abgf").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
						$("#bagf").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.pas_stp+">>"+searchJson.dpt_AirPt_Cd+"共飞对比分析");
						$("#abbagf").html(searchJson.dpt_AirPt_Cd+"="+searchJson.pas_stp+"="+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
					}else{
						$("#abzs").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.Arrv_Airpt_Cd+"走势分析");
						$("#bazs").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.dpt_AirPt_Cd+"走势分析");
						$("#abgf").html(searchJson.dpt_AirPt_Cd+">>"+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
						$("#bagf").html(searchJson.Arrv_Airpt_Cd+">>"+searchJson.dpt_AirPt_Cd+"共飞对比分析");
						$("#abbagf").html(searchJson.dpt_AirPt_Cd+"="+searchJson.Arrv_Airpt_Cd+"共飞对比分析");
					}
				}
			}
		});
		cityPicker3.init();
         $("#check-all").on('ifUnchecked', function(event) {
             $("input[type='checkbox']", ".table-mailbox").iCheck("uncheck");
         });
         $("#check-all").on('ifChecked', function(event) {
             $("input[type='checkbox']", ".table-mailbox").iCheck("check");
         });
         function subbTime(){
        	custormersearchForm = $("#DOW-searchForm");
			var searchJson = custormersearchForm.searchJson();
			/* var starttime = new Date(searchJson.startDate) ;
			var endtime = new Date(searchJson.endDate);
			var cha = endtime.valueOf() - starttime.valueOf();
			var yearcha = cha/(365*24*60*60*1000);
			if(yearcha>2){
				alert("你选择的时间段过长，请选择两年以内的时间段");
			} */
			var starttime = searchJson.startDate;
			var endtime = searchJson.endDate;
			var cha = endtime.split("-")[0] - starttime.split("-")[0];
			if(cha>=2){
				alert("你选择的时间段过长，请选择两年以内的时间段");
			}
         }
	</script>
<script type="text/javascript">
			function abtotalflyAsiay(){
				removeDiv();
				var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();

				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
				totalflyAnalysis(searchJson,"abtotalcharts");
			}
			function batotalflyAsiay(){
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
				totalflyAnalysis(searchJson,"batotalcharts");
			}
			function abbatotalflyAsiay(){
				removeDiv();
				var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
				totalflyAnalysisHd(searchJson,"abbatotalcharts");
			}
			//共飞分析
			function totalflyAnalysisHd(searchJson,id){
				var charts = $("#"+id);
				var dataAll = 0;
				var width = $(document.body).width()/2+"px";
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
	        	        url:'${pageContext.request.contextPath}/getTotalFlyAnalysisDataHd',
	        	        data:searchJson,
	        	        success:function(data){
	        	        	if(data.flightNum!=null&&data.flightNum!=""){
	        	        		for(var i=0;i<data.flightNum.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.flightNum[i]){
	        	        				 dataAll = dataAll + Number(data.flightNum[i][index].flt_Nbr_num)
	        	        				 isShow = isShow + Number(data.flightNum[i][index].flt_Nbr_num);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var flightNum=$("<div class='col-md-6' id='flightNum"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>");
		        	        			 charts.append(flightNum);
		        	        			 flightNumEcharts(data.flightNum[i],"flightNum"+id+i);
	        	        			 }
	        	        		}
	        	        	}
	        	             if(data.raskRanking!=null&&data.raskRanking!=""){
	        	        		for(var i=0;i<data.raskRanking.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.raskRanking[i]){
	        	        				 dataAll = dataAll + Number(data.raskRanking[i][index].jbys)
	        	        				 isShow = isShow + Number(data.raskRanking[i][index].jbys);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var raskRanking=$("<div class='col-md-6' id='raskRanking"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(raskRanking);
		        	        			 raskRankingEcharts(data.raskRanking[i],"raskRanking"+id+i);
	        	        			 } 
	        	        		}
	        	        	} 
	        	        	 if(data.passengerRank!=null&&data.passengerRank!=""){
	        	        		for(var i=0;i<data.passengerRank.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.passengerRank[i]){
	        	        				 dataAll = dataAll + Number(data.passengerRank[i][index].pgs_Per_Cls_num)
	        	        				 isShow = isShow + Number(data.passengerRank[i][index].pgs_Per_Cls_num);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var passengerRank=$("<div class='col-md-6' id='passengerRank"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(passengerRank);
		        	        			 passengerRankEcharts(data.passengerRank[i],"passengerRank"+id+i);
	        	        			 } 
	        	        		}
	        	        	} 
	        	        	 if(data.passengerCompared!=null&&data.passengerCompared!=""){
	        	        		for(var i=0;i<data.passengerCompared.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.passengerCompared[i]){
	        	        				 dataAll = dataAll + Number(data.passengerCompared[i][index].value)
	        	        				 isShow = isShow + Number(data.passengerCompared[i][index].value);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var passengerCompared=$("<div class='col-md-6' id='passengerCompared"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(passengerCompared);
		        	        			 passengerComparedEcharts(data.passengerCompared[i],"passengerCompared"+id+i);
	        	        			 }
	        	        		}
	        	        	}  
	        	        	 if(data.allClassRank!=null&&data.allClassRank!=""){
	        	        		for(var i=0;i<data.allClassRank.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.allClassRank[i]){
	        	        				 dataAll = dataAll + Number(data.allClassRank[i][index].jbzw)
	        	        				 isShow = isShow + Number(data.allClassRank[i][index].jbzw);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var allClassRank=$("<div class='col-md-6' id='allClassRank"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(allClassRank);
		        	        			 allClassRankEcharts(data.allClassRank[i],"allClassRank"+id+i);
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
			//共飞分析
			function totalflyAnalysis(searchJson,id){
				var charts = $("#"+id);
				 var dataAll = 0;
				var width = $(document.body).width()/2+"px";
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
	        	        url:'${pageContext.request.contextPath}/getTotalFlyAnalysisData',
	        	        data:searchJson,
	        	        success:function(data){
	        	        	if(data.flightNum!=null&&data.flightNum!=""){
	        	        		for(var i=0;i<data.flightNum.length;i++){
	        	        			 var isShow = 0 ;
	        	        			 for(var index in data.flightNum[i]){
	        	        				 dataAll = dataAll + Number(data.flightNum[i][index].flt_Nbr_num)
	        	        				 isShow = isShow + Number(data.flightNum[i][index].flt_Nbr_num);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var flightNum=$("<div class='col-md-6' id='flightNum"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>");
		        	        			 charts.append(flightNum);
		        	        			 flightNumEcharts(data.flightNum[i],"flightNum"+id+i);
	        	        			 }
	        	        		}
	        	        	}
	        	             if(data.raskRanking!=null&&data.raskRanking!=""){
	        	        		for(var i=0;i<data.raskRanking.length;i++){
	        	        			var isShow = 0 ;
	        	        			 for(var index in data.raskRanking[i]){
	        	        				 dataAll = dataAll + Number(data.raskRanking[i][index].jbys)
	        	        				 isShow = isShow + Number(data.raskRanking[i][index].jbys);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var raskRanking=$("<div class='col-md-6' id='raskRanking"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(raskRanking);
		        	        			 raskRankingEcharts(data.raskRanking[i],"raskRanking"+id+i);
	        	        			 } 
	        	        		}
	        	        	} 
	        	        	 if(data.passengerRank!=null&&data.passengerRank!=""){
	        	        		for(var i=0;i<data.passengerRank.length;i++){
	        	        			var isShow = 0 ;
	        	        			 for(var index in data.passengerRank[i]){
	        	        				 dataAll = dataAll + Number(data.passengerRank[i][index].pgs_Per_Cls_num)
	        	        				 isShow = isShow + Number(data.passengerRank[i][index].pgs_Per_Cls_num);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var passengerRank=$("<div class='col-md-6' id='passengerRank"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(passengerRank);
		        	        			 passengerRankEcharts(data.passengerRank[i],"passengerRank"+id+i);
	        	        			 } 
	        	        		}
	        	        	} 
	        	        	 if(data.passengerCompared!=null&&data.passengerCompared!=""){
	        	        		for(var i=0;i<data.passengerCompared.length;i++){
	        	        			var isShow = 0 ;
	        	        			 for(var index in data.passengerCompared[i]){
	        	        				 dataAll = dataAll + Number(data.passengerCompared[i][index].value)
	        	        				 isShow = isShow + Number(data.passengerCompared[i][index].value);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var passengerCompared=$("<div class='col-md-6' id='passengerCompared"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(passengerCompared);
		        	        			 passengerComparedEcharts(data.passengerCompared[i],"passengerCompared"+id+i);
	        	        			 }
	        	        			 
	        	        		}
	        	        	}  
	        	        	 if(data.allClassRank!=null&&data.allClassRank!=""){
	        	        		for(var i=0;i<data.allClassRank.length;i++){
	        	        			var isShow = 0 ;
	        	        			 for(var index in data.allClassRank[i]){
	        	        				 dataAll = dataAll + Number(data.allClassRank[i][index].jbzw)
	        	        				 isShow = isShow + Number(data.allClassRank[i][index].jbzw);
	     			    	         }
	        	        			 if(isShow<=0){
	        	        			 }else{
	        	        				 var allClassRank=$("<div class='col-md-6' id='allClassRank"+id+i+"' style='height: 400px;width:" +width+"' align='center'></div>"); 
		        	        			 charts.append(allClassRank);
		        	        			 allClassRankEcharts(data.allClassRank[i],"allClassRank"+id+i);
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
			
			
			 
			function flightNumEcharts(data,id){
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
			                var chart = document.getElementById(id);  
			                var echart = ec.init(chart);  
			                  
			                echart.showLoading({  
			                    text: '正在努力加载中...'  
			                });  
			                  
			                var one = [];
			        	 	var oneName = [];
			        	    var tenName = '';
			                var jb =[];
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                 
	                	    for(var index in data){
			                	one[index] = data[index].flt_Nbr; 
			                	oneName[index] = Number(data[index].flt_Nbr_num); 
			                 	tenName = data[index].hangduan+"  "+data[index].startDate+"至"+data[index].endDate;
			                 	jb[index] = data[index].jb;
			    	        }
			               
			                var option = { 
			                		title : {
			                	        text: tenName+"航班量前十排行",
			                	        x: 'center'
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','班次',]  
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
			                            axisLabel: {
			                            	rotate: 45,
			                            },
			                            data: one
			                        }  
			                    ],  
			                    grid: { // 控制图的大小，调整下面这些值就可以，
			                        x: 40,
			                        x2: 100,
			                        y2: 80,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			                    },
			                    yAxis: [  
			                        {  
			                            type: 'value'  
			                        }  
			                    ],  
			                    series : [
			                  	    	{  
			                  	    		 'name': "班次",  
			                                 'type': 'bar',  
			                                 'data': oneName,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			
			
			function raskRankingEcharts(data,id){
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
			                var chart = document.getElementById(id);  
			                var echart = ec.init(chart);  
			                  
			                echart.showLoading({  
			                    text: '正在努力加载中...'  
			                });  
			                  
			                var one = [];
			        	 	var Tal_Nbr_num = [];//每班营收
			        	 	var Set_Ktr_Ine_num = [];//座公里收入
			        	    var tenName = '';
			                // 同步执行  
			                $.ajaxSettings.async = true;  
			                 
	                	    for(var index in data){
	                	    	one[index] = data[index].flt_Nbr;
			                	Tal_Nbr_num[index] = Number((data[index].tal_Nbr_num/1000).toFixed(2)); 
			                	Set_Ktr_Ine_num[index] = Number(data[index].set_Ktr_Ine_num)*100; 
			                 	tenName = data[index].hangduan+"  "+data[index].startDate+"至"+data[index].endDate;
			    	        }
			               
			                var option = { 
			                		title : {
			                	        text: tenName+"座收前十排行",
			                	        x: 'center'
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','每班营收/1000','座公里收入*100']  
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
			                            axisLabel: {
			                            	rotate: 45,
			                            },
			                            data: one
			                        }  
			                    ],  
			                    grid: { // 控制图的大小，调整下面这些值就可以，
			                        x: 40,
			                        x2: 100,
			                        y2: 80,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			                    },
			                    yAxis: [  
			                        {  
			                            type: 'value'  
			                        }  
			                    ],  
			                    series : [
			                  	    	{  
			                  	    		 'name': "每班营收/1000",  
			                                 'type': 'bar',  
			                                 'data': Tal_Nbr_num,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              },
			                              {  
			                  	    		 'name': "座公里收入*100",  
			                                 'type': 'bar',  
			                                 'data': Set_Ktr_Ine_num,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			
			
			function passengerRankEcharts(data,id){
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
			                var chart = document.getElementById(id);  
			                var echart = ec.init(chart);  
			                  
			                echart.showLoading({  
			                    text: '正在努力加载中...'  
			                });  
			                  
			                var one = [];
			                var jbkl = [];
			        	 	var oneName = [];
			        	    var tenName = '';
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                 
	                	    for(var index in data){
			                	one[index] = data[index].flt_Nbr; 
			                	jbkl[index] = data[index].jbkl; 
			                	oneName[index] = Number(data[index].pgs_Per_Cls_num); 
			                 	tenName = data[index].hangduan+"  "+data[index].startDate+"至"+data[index].endDate;
			    	        }
			               
			                var option = { 
			                		title : {
			                	        text: tenName+"客量前十排行",
			                	        x: 'center'
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','客量']  
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
			                            axisLabel: {
			                            	rotate: 45,
			                            },
			                            data: one
			                        }  
			                    ],  
			                    grid: { // 控制图的大小，调整下面这些值就可以，
			                        x: 50,
			                        x2: 100,
			                        y2: 80,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			                    },
			                    yAxis: [  
			                        {  
			                            type: 'value'  
			                        }  
			                    ],  
			                    series : [
			                  	    	{  
			                  	    		 'name': "客量",  
			                                 'type': 'bar',  
			                                 'data': oneName,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			
			
			function allClassRankEcharts(data,id){
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
			                var chart = document.getElementById(id);  
			                var echart = ec.init(chart);  
			                  
			                echart.showLoading({  
			                    text: '正在努力加载中...'  
			                });  
			                  
			                var jbzw = [];
			                var jblk = [];
			                var jbtd = [];
			                var one = [];
			        	 	var Tal_Nbr_Set_num = [];
			        	 	var Pgs_Per_num = [];
			        	 	var Grp_Nbr_num = [];
			        	    var tenName = '';
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                 
	                	    for(var index in data){
	                	    	jbzw[index] = data[index].jbzw; 
	                	    	jblk[index] = data[index].jblk; 
	                	    	jbtd[index] = data[index].jbtd; 
			                	one[index] = data[index].flt_Nbr; 
			                	Tal_Nbr_Set_num[index] = Number(data[index].tal_Nbr_Set_num); 
			                	Pgs_Per_num[index] = Number(data[index].pgs_Per_num); 
			                	Grp_Nbr_num[index] = Number(data[index].grp_Nbr_num); 
			                 	tenName = data[index].hangduan+"  "+data[index].startDate+"至"+data[index].endDate;
			    	        }
			               
			                var option = { 
			                		title : {
			                	        text: tenName+"均班客量前十排行",
			                	        x: 'center'
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','每班座位','每班旅客','每班团队']  
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
			                            axisLabel: {
			                            	rotate: 45,
			                            },
			                            data: one
			                        }  
			                    ],  
			                    grid: { // 控制图的大小，调整下面这些值就可以，
			                        x: 40,
			                        x2: 100,
			                        y2: 80,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			                    },
			                    yAxis: [  
			                        {  
			                            type: 'value'  
			                        }  
			                    ],  
			                    series : [
			                  	    	{  
			                  	    		 'name': "每班座位",  
			                                 'type': 'bar',  
			                                 'data': Tal_Nbr_Set_num,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              },
			                  	    	{  
			                  	    		 'name': "每班旅客",  
			                                 'type': 'bar',  
			                                 'data': Pgs_Per_num,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              },
			                  	    	{  
			                  	    		 'name': "每班团队",  
			                                 'type': 'bar',  
			                                 'data': Grp_Nbr_num,
			                                 markLine : {
			                                     data : [
			                                         // 纵轴，默认
			                                      {type : 'average', name : '平均值'},
			                                     ]
			                                 }
			                              }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			
			function passengerComparedEcharts(data,id){
				require.config({
		            paths: {
		                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
		            }
		        });
		        
		        // 使用
		        require(
		            [
		                'echarts',
		                'echarts/chart/pie',
		                'echarts/chart/funnel'
		            ],
		            function (ec) {  
		                var chart = document.getElementById(id);  
		                var echart = ec.init(chart);  
		                  
		                echart.showLoading({  
		                    text: '正在努力加载中...'  
		                });  
		                  
		                var xtext = [];//标题
		        	    var idd_Dct = [];//客量/名称
		        	    var evenPort = '';//title
		                  
		                // 同步执行  
		                $.ajaxSettings.async = false;  
		                  
		                for(var index in data){
        	                xtext[index] = data[index].name;//给X轴TEXT赋值
        	                evenPort=data[index].title;
        	            }
        	            idd_Dct = data;
        	            
		                  
		                option = {
		                	    title : {
		                	        text: evenPort,
		                	        x:'center'
		                	    },
		                	    tooltip : {
		                	        trigger: 'item',
		                	        formatter: "{a} <br/>{b} : {c} ({d}%)"
		                	    },
		                	    legend: {
		                	        orient : 'vertical',
		                	        x : 'left',
		                	        data:xtext
		                	    },
		                	    toolbox: {
		                	        show : true,
		                	        feature : {
		                	            mark : {show: true},
		                	            dataView : {show: true, readOnly: false},
		                	            magicType : {
		                	                show: true, 
		                	                type: ['pie', 'funnel'],
		                	                option: {
		                	                    funnel: {
		                	                        x: '25%',
		                	                        width: '50%',
		                	                        funnelAlign: 'left',
		                	                        max: 1548
		                	                    }
		                	                }
		                	            },
		                	            restore : {show: true},
		                	            saveAsImage : {show: true}
		                	        }
		                	    },
		                	    calculable : true,
		                	    series : [
		                	        {
		                	            name:'客量占比',
		                	            type:'pie',
		                	            radius : '55%',
		                	            center: ['50%', '60%'],
		                	            data:idd_Dct
		                	        }
		                	    ]
		                	};
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
		</script>


