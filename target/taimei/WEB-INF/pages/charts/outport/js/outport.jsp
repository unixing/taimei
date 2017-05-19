<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
		var cityPicker = new HzwCityPicker({
			data: data,
			target: 'cityChoice',
			valType: 'k-v',
			hideCityInput: {
			}
		});
		cityPicker.init();
		 //在页面加载时给全选框绑定上事件
         $("#check-all").on('ifUnchecked', function(event) {
             //Uncheck all checkboxes
             $("input[type='checkbox']", ".table-mailbox").iCheck("uncheck");
         });
         //When checking the checkbox
         $("#check-all").on('ifChecked', function(event) {
             //Check all checkboxes
             $("input[type='checkbox']", ".table-mailbox").iCheck("check");
         });
	</script>
<script type="text/javascript">
	var k = 5;	
	function getAirPortData(i){
			if(i==0){
				if(k!=i){
					k=i;
					$("#li2").attr("class","");
					$("#li1").attr("class","liset");
					advancedQuery(i);
				}
			}else{
				if(k!=i){
					k=i;
					$("#li1").attr("class","");
					$("#li2").attr("class","liset");
					advancedQuery(i);
				}
			}
		}
	</script>
<script type="text/javascript">
			var graphArray = ["main","EvenPort","classRanking","Set_Ktr_Ine","clz_Ktr_Rkg","amountRatio","guestamount"];
			//此数组是装着所有的复选框的id,用来判断哪些复选框是选上了的
			var CheckArray = ["methodFlowCount","allAmount","airAmountRanking","allAmountRanking","SetIneRanking","amountRanking","amountRatio"];
			//此数组是装着所有的要执行的函数方法,用来执行所有被选上的的复选框要执行的方法
			var functions = ["mychart","evenPort","classRanking","Set_Ktr_Ine","SetIneRanking","amountRanking","guestamount"];
			
			function advancedQuery(i){
			
				sethidden();
				var searchJson = {};
				searchJson.state = i;
				searchJson.lcl_Dpt_Day = $("#cc2").val();
				searchJson.dpt_AirPt_Cd = $("#cityChoice").val();
// 				$.ajax({
//         	        type:'post',
//         	        url:'${pageContext.request.contextPath}/outPort_mychar',
//         	        data:searchJson,
//         	        success:function(data){
// 						var j = 0;
				for(var i=0;i<CheckArray.length;i++){
// 					var radioList = $("input[name="+CheckArray[i]+"]:checked");
// 					if(radioList.length!=0){
						//如果复选框被选中,那么就从第一个容器开始移除隐藏域属性
						document.getElementById(graphArray[i]).removeAttribute("hidden");
						//调用选中的复选框的值来获得要执行的对应方法
						var name = functions[i];
						window[name](searchJson,graphArray[i]);
// 						j++;
// 					}
				}
//        	        	}
//         	    }); 
			}
			
			//给div设置上hidden属性
			function sethidden(){
				for(var i=0;i<graphArray.length;i++){
					document.getElementById(graphArray[i]).setAttribute("hidden","hidden");
				}
			};
			function SetIneRanking(data,id){
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
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                  
			                // 加载数据  
			                $.ajax({
			        	        type:'post',
			        	        url:'${pageContext.request.contextPath}/evenPort_amountRanking',
			        	        data:data,
			        	        success:function(data){
			        	        	for(var index in data.list){
				        	        	one[index] = data.list[index].value;
				        	        	oneName[index]  = data.list[index].name;
			        	        	}
			        	        	tenName = data.year;//给Title赋值
			        	        },
			        	        error:function(e){
			        	        } 
			        	    }); 
			                  
			                var option = { 
			                		title : {
			                	        text: tenName+"旅客量前十排名",
			                	        x: 'center',
			                	        textStyle: {
			                                color: '#fff'
			                            }
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','旅客'] ,
			                        textStyle: {
			                            color: '#fff'
			                        }
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
			                            	rotate: 45
			                      		}, 
			                            data: oneName,
			                            axisLabel: {
			                                show: true,
			                                textStyle: {
			                                    color: '#fff'
			                                }
			                            },
			                        }  
			                    ],  
			                    yAxis: [  
			                        {  
			                            type: 'value' ,
			                            axisLabel: {
			                                show: true,
			                                textStyle: {
			                                    color: '#fff'
			                                }
			                            },
			                        }  
			                    ],  
			                    series : [
										{  
											'name': "旅客",  
										    'type': 'bar',  
										    'data': one
										 }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			function amountRanking(data,id){
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
		                  
		                // 加载数据  
		                $.ajax({
		        	        type:'post',
		        	        url:'${pageContext.request.contextPath}/evenPort_amountRanking',	
		        	        data:data,
		        	        success:function(data){
		        	            for(var index in data.list){
		        	                xtext[index] = data.list[index].name;//给X轴TEXT赋值
		        	            }
		        	            idd_Dct = data.list;
		        	            evenPort=data.year;
		        	        },
		        	        error:function(e){
		        	        } 
		        	    }); 
		                  
		                option = {
		                	    title : {
		                	        text: evenPort+'各航线年客量占比',
		                	        x:'center',
		                	        textStyle: {
		                                color: '#fff'
		                            }
		                	    },
		                	    tooltip : {
		                	        trigger: 'item',
		                	        formatter: "{a} <br/>{b} : {c} ({d}%)"
		                	    },
		                	    legend: {
		                	        orient : 'vertical',
		                	        x : 'left',
		                	        data:xtext,
		                	        textStyle: {
		                                color: '#fff'
		                            }
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
		                	            name:'客量/年',
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
			
			function guestamount(data,id){
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
			                var set_Ktr_Ine =[];
			                var guestamount =[];
			        	 	var oneName = [];
			        	    var tenName = '';
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                  
			                // 加载数据  
			                $.ajax({
			        	        type:'post',
			        	        url:'${pageContext.request.contextPath}/guestamount',
			        	        data:data,
			        	        success:function(data){
			        	        	for(var index in data.list){
				        	        	one[index] = data.list[index].count;
				        	        	set_Ktr_Ine[index] = data.list[index].set_Ktr_Ine;
				        	        	guestamount[index] = data.list[index].guestamount;
				        	        	oneName[index]  = data.list[index].dpt_AirPt_Cd+data.list[index].arrv_Airpt_Cd;
			        	        	}
			        	        	tenName = data.year;//给Title赋值
			        	        },
			        	        error:function(e){
			        	        } 
			        	    }); 
			                  
			                var option = { 
			                		title : {
			                	        text: tenName+"均班客量前十排名(不含过站)",
			                	        x: 'center',
			                	        textStyle: {
			                                color: '#fff'
			                            }
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','每班座位','每班旅客','每班团队']  ,
			                        textStyle: {
			                            color: '#fff'
			                        }
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
			                            data: oneName,
			                            axisLabel: {
			                                show: true,
			                                textStyle: {
			                                    color: '#fff'
			                                }
			                            }
			                        }  
			                    ],  
			                    yAxis: [  
			                        {  
			                            type: 'value' ,
			                            axisLabel: {
			                                show: true,
			                                textStyle: {
			                                    color: '#fff'
			                                }
			                            }
			                        }  
			                    ],  
			                    series : [
										{  
											'name': "每班座位",  
										    'type': 'bar',  
										    'data': one
										 },
			                  	    	{  
			                  	    		 'name': "每班旅客",  
			                                 'type': 'bar',  
			                                 'data': set_Ktr_Ine
			                              },
			                  	    	
			                  	    	{  
			                  	    		 'name': "每班团队",  
			                                 'type': 'bar',  
			                                 'data': guestamount
			                              }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			function Set_Ktr_Ine(data,id){
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
			                var set_Ktr_Ine =[];
			        	 	var oneName = [];
			        	    var tenName = '';
			                  
			                // 同步执行  
			                $.ajaxSettings.async = false;  
			                  
			                // 加载数据  
			                $.ajax({
			        	        type:'post',
			        	        url:'${pageContext.request.contextPath}/Set_Ktr_Ine',
			        	        data:data,
			        	        success:function(data){
			        	        	for(var index in data.list){
				        	        	one[index] = data.list[index].count;
				        	        	set_Ktr_Ine[index] = data.list[index].set_Ktr_Ine;
				        	        	oneName[index]  = data.list[index].dpt_AirPt_Cd+data.list[index].arrv_Airpt_Cd;
			        	        	}
			        	        	tenName = data.year;//给Title赋值
			        	        },
			        	        error:function(e){
			        	        } 
			        	    }); 
			                  
			                var option = { 
			                		title : {
			                	        text: tenName+"座公里收入前十排行 (不含过站)",
			                	        x: 'center',
			                	        textStyle: {
			                                color: '#fff'
			                            }
			                	    },
			                    tooltip: {  
			                        show: true  
			                    },  
			                    legend: {  
			                        data: ['','座公里收入*100','每班收入/1000']  ,
			                        textStyle: {
			                            color: '#fff'
			                        }
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
			                            	rotate: 45
			                      		}, 
			                            data: oneName,
			                            axisLabel: {
			                                show: true,
			                                textStyle: {
			                                    color: '#fff'
			                                }
			                            }
			                        }  
			                    ],  
			                    yAxis: [  
			                        {  
			                            type: 'value'  ,
			                            axisLabel: {
			                                show: true,
			                                textStyle: {
			                                    color: '#fff'
			                                }
			                            }
			                        }  
			                    ],  
			                    series : [
			                  	    	{  
			                  	    		 'name': "座公里收入*100",  
			                                 'type': 'bar',  
			                                 'data': one
			                              },
			                  	    	{  
			                  	    		 'name': "每班收入/1000",  
			                                 'type': 'bar',  
			                                 'data': set_Ktr_Ine
			                              }
			                  	    ]
			                };  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};
			function classRanking(data,id){
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
				                  
				                // 同步执行  
				                $.ajaxSettings.async = false;  
				                  
				                // 加载数据  
				                $.ajax({
				        	        type:'post',
				        	        url:'${pageContext.request.contextPath}/classRanking',	
				        	        data:data,
				        	        success:function(data){
				        	        	for(var index in data.list){
					        	        	one[index] = data.list[index].count;
					        	        	oneName[index]  = data.list[index].dpt_AirPt_Cd+data.list[index].arrv_Airpt_Cd;
				        	        	}
				        	        	tenName = data.year;//给Title赋值
				        	        },
				        	        error:function(e){
				        	        } 
				        	    }); 
				                  
				                var option = { 
				                		title : {
				                	        text: tenName+"年班次前十排行",
				                	        x: 'center',
				                	        textStyle: {
				                                color: '#fff'
				                            }
				                	    },
				                    tooltip: {  
				                        show: true  
				                    },  
				                    legend: {  
				                        data: ['','班次'] ,
				                        textStyle: {
				                            color: '#fff'
				                        }
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
				                            	rotate: 45
				                      		}, 
				                            data: oneName,
				                            axisLabel: {
				                                show: true,
				                                textStyle: {
				                                    color: '#fff'
				                                }
				                            }
				                        }  
				                    ],  
				                    yAxis: [  
				                        {  
				                            type: 'value' ,
				                            axisLabel: {
				                                show: true,
				                                textStyle: {
				                                    color: '#fff'
				                                }
				                            }
				                        }  
				                    ],  
				                    series : [
				                  	    	{  
				                  	    		 'name': "班次",  
				                                 'type': 'bar',  
				                                 'data': one
				                              }
				                  	    ]
				                };  
			                echart.setOption(option);  
			                echart.hideLoading();  
			            }
			        );
				};
				
			function mychart(data,id){
		        // 路径配置
		        
		        require.config({
		            paths: {
		                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
		            }
		        });
		        
		        // 使用
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
		                  
		                var xtext = [];//给表图上部轴TEXT
		        	 	var idd_moh = [];//客流
		        	    var Cla_Nbr = [];//班次
		        	    var Tal_Nbr_Set = [];//座位数
		        	    var Grp_moh = [];//团队数
		        	    var Grp_Ine = [];//团队收入
		        	    var Tol_Ine = [];//总收入 
		        	    var titleY = '';//title
		                  
		                // 同步执行  
		                $.ajaxSettings.async = false;  
		                  
		                // 加载数据  
		                $.ajax({
		        	        type:'post',
		        	        url:'${pageContext.request.contextPath}/outPort_mychar',	
		        	        data:data,
		        	        success:function(data){
		        	            for(var index in data.list){
		        	            	idd_moh[index] = Number(data.list[index].idd_moh); //给Y轴赋值
		        	            	Cla_Nbr[index] = Number(data.list[index].Cla_Nbr); //给Y轴赋值
		        	            	Tal_Nbr_Set[index] = Number(data.list[index].Tal_Nbr_Set); //给Y轴赋值
		        	            	Grp_moh[index] = Number(data.list[index].Grp_moh); //给Y轴赋值
		        	            	Grp_Ine[index] = Number(data.list[index].Grp_Ine)/100; //给Y轴赋值
		        	            	Tol_Ine[index] = Number(data.list[index].Tol_Ine)/1000; //给Y轴赋值
		        	                xtext[index] = data.list[index].label;//给X轴TEXT赋值
		        	            }
		        	            titleY = data.list[0].titleY;//给Title赋值
		        	        },
		        	        error:function(e){
		        	        } 
		        	    }); 
		                var option = { 
		                		title : {
		                	        text: titleY,
		                	        x: 'center',
		                	        textStyle: {
		                                color: '#fff'
		                            }
		                	    },
		                    tooltip: {  
		                        show: true  
		                    },  
		                    legend: {  
		                        data: ['','客流/月','班次/月','座位/月','团队/月','团队收入/月/100','收入/月/1000'] ,
		                        textStyle: {
		                            color: '#fff'
		                        }
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
		                            data: xtext ,
		                            axisLabel: {
		                                show: true,
		                                textStyle: {
		                                    color: '#fff'
		                                }
		                            }
		                        }  
		                    ],  
		                    yAxis: [  
		                        {  
		                            type: 'value'  ,
		                            axisLabel: {
		                                show: true,
		                                textStyle: {
		                                    color: '#fff'
		                                }
		                            }
		                        }  
		                    ],  
		                    series : [
		                  	    	{  
		                  	    		 'name': '客流/月',  
		                                 'type': 'bar',  
		                                 'data': idd_moh  
		                              },
		                  	    	{  
		                  	    		 'name': '班次/月',  
		                                 'type': 'line',  
		                                 'data': Cla_Nbr  
		                              },
		                  	    	{  
		                  	    		 'name': '座位/月',  
		                                 'type': 'line',  
		                                 'data': Tal_Nbr_Set  
		                              },
		                  	    	{  
		                  	    		 'name': '团队/月',  
		                                 'type': 'line',  
		                                 'data': Grp_moh  
		                              },
		                  	    	{  
		                  	    		 'name': '团队收入/月/100',  
		                                 'type': 'line',  
		                                 'data': Grp_Ine  
		                              },
		                  	    	{  
		                  	    		 'name': '收入/月/1000',  
		                                 'type': 'line',  
		                                 'data': Tol_Ine  
		                              },
		                  	    ]
		                };  
		                  
	                echart.setOption(option);  
	                echart.hideLoading();  
	            }
	        );
		};
		function evenPort(data,id){
			var xtext = [];//日期
     	 	var tme_Nbr = [];//天数
     	    var cla_Nbr = [];// 班次/月
     	    var tme_Cla_Moh = [];//日班次
     	    var cla_Set = [];//每班座位
     	    var cla_Per = [];//每班旅客
     	    var cla_Grp = [];//每班团队
     	    var flt_Ser_Ine = [];//团队收入/100
     	    var lod_For = [];//客座率
     	    var idd_Dct = [];//每班收入/1000
     	    var evenPort = '';//title
				require.config({
		            paths: {
		                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
		            }
		        });
	        // 使用
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
	                  
	                // 同步执行  
	                $.ajaxSettings.async = false;  
	                  
	                // 加载数据  
	                $.ajax({
	        	        type:'post',
	        	        url:'${pageContext.request.contextPath}/evenPort_mychar',	
	        	        data:data,
	        	        success:function(data){
	        	            for(var index in data.list){
	        	            	tme_Nbr[index] = Number(data.list[index].tme_Nbr); //给Y轴赋值
	        	            	cla_Nbr[index] = Number(data.list[index].cla_Nbr); //给Y轴赋值
	        	            	tme_Cla_Moh[index] = Number(data.list[index].tme_Cla_Moh); //给Y轴赋值
	        	            	cla_Set[index] = Number(data.list[index].cla_Set); //给Y轴赋值
	        	            	cla_Per[index] = Number(data.list[index].cla_Per); //给Y轴赋值
	        	            	cla_Grp[index] = Number(data.list[index].cla_Grp); //给Y轴赋值
	        	            	flt_Ser_Ine[index] = Number(data.list[index].flt_Ser_Ine); //给Y轴赋值
	        	            	lod_For[index] = Number(data.list[index].lod_For); //给Y轴赋值
	        	            	idd_Dct[index] = Number(data.list[index].idd_Dct); //给Y轴赋值
	        	                xtext[index] = data.list[index].label;//给X轴TEXT赋值
		        	            evenPort=data.list[0].evenPort;
	        	            }
	        	        },
	        	        error:function(e){
	        	        } 
	        	    }); 
	                  
	                var option = {
	               		title : {
	               	        text: evenPort,
	               	    	 x: 'center',
	               	    	textStyle: {
                                color: '#fff'
                            }
	               	    },
	                    tooltip: {  
	                        show: true  
	                    },  
	                    legend: {  
	                        data: ['','天数','班次/月','日班次','每班座位','每班旅客','每班团队','团队收入/100','客座率','每班收入/1000'] ,
	                        textStyle: {
	                            color: '#fff'
	                        }
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
	                            data: xtext ,
	                            axisLabel: {
	                                show: true,
	                                textStyle: {
	                                    color: '#fff'
	                                }
	                            }
	                        }  
	                    ],  
	                    yAxis: [  
	                        {  
	                            type: 'value'  ,
	                            axisLabel: {
	                                show: true,
	                                textStyle: {
	                                    color: '#fff'
	                                }
	                            }
	                        }  
	                    ],  
	                    series : [
	                  	    	{  
	                  	    		 'name': '天数',  
	                                 'type': 'bar',  
	                                 'data': tme_Nbr  
	                              },
	                  	    	{  
	                  	    		 'name': '班次/月',  
	                                 'type': 'line',  
	                                 'data': cla_Nbr  
	                              },
	                  	    	{  
	                  	    		 'name': '日班次',  
	                                 'type': 'line',  
	                                 'data': tme_Cla_Moh  
	                                 
	                              },
	                              {  
	                   	    		 'name': '每班旅客',  
	                                  'type': 'line',  
	                                  'data': cla_Per
	                               },
	                  	    	{  
	                  	    		 'name': '每班座位',  
	                                 'type': 'line',  
	                                 'data':  cla_Set
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
	                              },
	                  	    	
	                  	    ]
	                };  
	                echart.setOption(option);  
	                echart.hideLoading();  
	            }
	        );
		}

		</script>
<script type="text/javascript">
		var obj2=document.getElementById('cc2');  
		$.ajax({
	        type:'post',
	        url:'${pageContext.request.contextPath}/DOW_Date',//请求数据的地址
	        async:false,
	        success:function(data){
	            for(var index in data){
      				  obj2.options.add(new Option(data[index].lcl_Dpt_Day)); //这个兼容IE与firefox  
	            }
	        }
	    });
		</script>
<script type="text/javascript">
			window.onload = function(){
				advancedQuery(0);
			}
		</script>