<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script>
				var cityPicker = new HzwCityPicker({
					data: data,
					target: 'cityChoice',
					valType: 'k-v',
					hideCityInput: {
						
					}
				});
				
				cityPicker.init();
				var cityPicker1 = new HzwCityPicker({
					data: data,
					target: 'cityChoice1',
					valType: 'k-v',
					hideCityInput: {
						
					}
				});
				
				cityPicker1.init();
				$("input[name='chk']").click(function () {  
					alert(11);
				})
			</script>
<script type="text/javascript">
			function iFdisabled(){
				alert(1);
			};
			function advancedQuery(){
				var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
		// 		拿到form表单对象
				custormersearchForm = $("#DOW-searchForm");
		// 		调用自定义方法, 内部处理好数据结构拿到json数据对象
				var searchJson = custormersearchForm.searchJson();
				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
		// 		调用datagrid组件的load方法, 传入参数就成为了加载datagrid组件
				if(searchJson.lcl_Dpt_Day!='请选择年份'&&searchJson.dpt_AirPt_Cd!=''&&searchJson.arrv_Airpt_Cd!=''){
					getData(searchJson);
					$.ajax({
				        type:'post',
				        url:${pageContext.request.contextPath}'/getMinMonth',//请求数据的地址	
				        data:searchJson,
				        success:function(data){
				        	var index = {method:data};
						    mychart(index);
				    	    mychart2(index);
				        }
				    });
					
				}else{
	        		alert("请查看查询条件");
	        	}
			};
			
	        function getData(searchJson){
               		$('#example2').bootstrapTable("destroy");
                	$('#example2').bootstrapTable({
               			url: '${pageContext.request.contextPath}/DOW_list',
               			toolbar: '#toolbar',  
               			method: 'get',
               			striped: true,
						showExport: true,                     //是否显示导出
            			exportDataType: "basic",              //basic', 'all', 'selected'.
    		            queryParams:searchJson,
    		            sidePagination:'server',//设置为服务器端分页
    	        	    onClickRow: onClickRow,
    	        	    columns:[
								{
								field: 'method',
								title: '月份',
								width: '40'
								},
								{
								field: 'executeClz',
								title: '执行班次',
								width: '40'
								},
								{
								field: 'clzPer',
								title: '均班人数',
								width: '40'
								},    
     	 						{
     	 						field: 'monTotal',
     	 						title: '星期一',
     	 						width: '40'
     	 						},    
     	 						{
     	 						field: 'tueTotal',
     	 						title: '星期二',
     	 						width: '40'
     	 						},
     	 						{
     	 						field: 'wedTotal',
     	 						title: '星期三',
     	 						width: '40'
     	 						}, {
     	 						field: 'thurTotal',
     	 						title: '星期四',
     	 						width: '40'
     	 						}, {
     	 						field: 'friTotal',
     	 						title: '星期五',
     	 						width: '40'
     	 						}, {
     	 						field: 'satTotal',
     	 						title: '星期六',
     	 						width: '40'
     	 						}, {
     	 						field: 'sunTotal',
     	 						title: '星期日',
     	 						width: '40'
     	 						}],
    	        	    onLoadSuccess:function(data){
	    	        	    	$('#example3').bootstrapTable("destroy");
	    	                	$('#example3').bootstrapTable({
    	                		url: '${pageContext.request.contextPath}/DOW_list',
    	               			method: 'get',
    	               			striped: true,
    	               			showHeader:false,
    	    		            sidePagination:'server',
    	                		data:data.fitFooter,
    	                		 columns:[
										{
										field: 'method',
										width: '40'
										},
										{
										field: 'executeClz',
										width: '40'
										},
										{
										field: 'clzPer',
										width: '40'
										}, 
    	      	 						{
    	      	 						field: 'monTotal',
    	      	 						width: '40'
    	      	 						},    
    	      	 						{
    	      	 						field: 'tueTotal',
    	      	 						width: '40'
    	      	 						},
    	      	 						{
    	      	 						field: 'wedTotal',
    	      	 						width: '40'
    	      	 						}, {
    	      	 						field: 'thurTotal',
    	      	 						width: '40'
    	      	 						}, {
    	      	 						field: 'friTotal',
    	      	 						width: '40'
    	      	 						}, {
    	      	 						field: 'satTotal',
    	      	 						width: '40'
    	      	 						}, {
    	      	 						field: 'sunTotal',
    	      	 						width: '40'
    	      	 						}]
    	                	});
    	        	    }
    	        	   
    	        	});
	     };
	     function onClickRow(index){
	    	 var obj4=document.getElementById('methodSelect');
	    	 mychart(index);
	    	 mychart2(index);
	 	 };
	     function onSelect(index){
	    	 var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
		// 		拿到form表单对象
				custormersearchForm = $("#DOW-searchForm");
		// 		调用自定义方法, 内部处理好数据结构拿到json数据对象
				var searchJson = custormersearchForm.searchJson();
				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
		// 		调用datagrid组件的load方法, 传入参数就成为了加载datagrid组件
				if(searchJson.lcl_Dpt_Day!='请选择年份'&&searchJson.dpt_AirPt_Cd!=''&&searchJson.arrv_Airpt_Cd!=''){
	    	 		data.method = index.value.replace("月","");
	    	 		mychart(data);
	    	 		mychart2(data);
				}else{
	        		alert("请查看查询条件");
	        	}
	     };
	     function mychart2(data){
	    	 var method = data.method;
		        require.config({
		            paths: {
		                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
		            }
		        });
		        
		        // 使用
		        require(
		            [
		                'echarts',
		                'echarts/chart/bar',
		                'echarts/chart/line',
		            ],
		            function (ec) {  
		                var chart = document.getElementById('line');  
		                var echart = ec.init(chart);  
		                  
		                echart.showLoading({  
		                    text: '正在努力加载中...'  
		                });  
		                var xmethod = [];
		        	 	var one_method = [];//DOW数据分析
		        	 	var two_method = [];//DOW数据分析
		        	 	var three_method = [];//DOW数据分析
		        	 	var four_method = [];//DOW数据分析
		        	 	var method1 = '';
		        	 	var one='';
		        	 	var two='';
		        	 	var three='';
		        	 	var four='';
		                  
		                // 同步执行  
		                $.ajaxSettings.async = false;  
		                  
		                // 加载数据  
		                $.ajax({
		        	        type:'post',
		        	        url:'${pageContext.request.contextPath}/DOW_Clz_Graph2?searchKey='+method,
		        	        success:function(data){
		        	        	if(data.list.length==0){
		        	        		$("#prompt").show();
		        	        		$("#prompt").html("你查询的月份暂无数据")
		        	        		return ;
		        	        	}
		        	        	$("#prompt").hide();
		        	            for(var index in data.list){
		        	            	one_method[index] = Number(data.list[index].one_method);
		        	            	two_method[index] = Number(data.list[index].two_method);
		        	            	three_method[index] = Number(data.list[index].three_method);
		        	            	four_method[index] = Number(data.list[index].four_method);
		        	            }
			        	        method1 = data.echart2[0].MonTotal; //给Y轴赋值
			        	        xmethod = data.method;
			        	        one = xmethod[0];
			        	        two = xmethod[1];
			        	        three = xmethod[2];
			        	        four = xmethod[3];
		        	        },
		        	        error:function(e){
		        	        } 
		        	    }); 
		                var option = { 
		                		title : {
		                	        text: method1,
		                	        x: 'center'
		                	    },
		                    tooltip: {  
		                    	trigger: 'axis',
		                        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		                            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		                        },
		                        formatter : '{b}<br/>{a0}:{c0}人次<br/>{a1}:{c1}人次<br/>{a2}:{c2}人次<br/>{a3}:{c3}人次'
		                    },  
		                    legend: {  
		                    	orient : 'vertical',
		                        x : 'right',
		                        data:  xmethod
		                    },
		                    toolbox: {
		                        show : true,
		                        orient: 'vertical',
		                        x: 'right',
		                        y: 'center',
		                        feature : {
		                            mark : {show: true},
		                            dataView : {show: true, readOnly: false},
		                            magicType : {show: true, type: ['line', 'bar']},
		                            restore : {show: true},
		                            saveAsImage : {show: true}
		                        }
		                    },
		                    xAxis: [  
		                        {  
		                            type: 'category',  
		                            data: ['周一','周二','周三','周四','周五','周六','周日']
		                        }  
		                    ],  
		                    yAxis: [  
		                        {  
		                            type: 'value'  
		                        }  
		                    ],  
		                    series : [
		                              {
		                                  name:one,
		                                  type:'line',
		                                  smooth:true,
		                                  itemStyle: {normal: {areaStyle: {type: 'default'}}},
		                                  data:one_method
		                              },
		                              {
		                                  name:two,
		                                  type:'line',
		                                  smooth:true,
		                                  itemStyle: {normal: {areaStyle: {type: 'default'}}},
		                                  data:two_method
		                              },
		                              {
		                                  name:three,
		                                  type:'line',
		                                  smooth:true,
		                                  itemStyle: {normal: {areaStyle: {type: 'default'}}},
		                                  data:three_method
		                              },
		                              {
		                                  name:four,
		                                  type:'line',
		                                  smooth:true,
		                                  itemStyle: {normal: {areaStyle: {type: 'default'}}},
		                                  data:four_method
		                              }
		                          ]
		                };  
		                  
		                echart.setOption(option);  
		                echart.hideLoading();  
		            }
		        );
			};	//柱形图代码
		function mychart(data){
			var method = data.method;
	        require.config({
	            paths: {
	                echarts: '${pageContext.request.contextPath}/echarts/build/dist'
	            }
	        });
	        
	        // 使用
	        require(
	            [
	                'echarts',
	                'echarts/chart/bar',
	                'echarts/chart/line',
	            ],
	            function (ec) {  
	                var chart = document.getElementById('main');  
	                var echart = ec.init(chart);  
	                  
	                echart.showLoading({  
	                    text: '正在努力加载中...'  
	                });  
	                  
	                var xtext = [];//给表图上部轴TEXT
	        	 	var idd_moh = [];//DOW数据分析
	        	 	var method1 = '';
	                  
	                // 同步执行  
	                $.ajaxSettings.async = false;  
	                // alert(data.method);
	                // 加载数据  
	                $.ajax({
	        	        type:'post',
	        	        url:'${pageContext.request.contextPath}/DOW_Clz_Graph?searchKey='+method,
	        	        success:function(data){
	        	        	if(data.list.length==0){
	        	        		return;
	        	        	}
	        	        	for(var index in data.list){
	        	            	idd_moh[index] = Number(data.list[index].Cla_Nbr); //给Y轴赋值
	        	            	xtext[index] = data.list[index].idd_moh; //给Y轴赋值
	        	            }
		        	        method1 = data.echart2[0].MonTotal; //给Y轴赋值
	        	        },
	        	        error:function(e){
	        	        } 
	        	    }); 
	                var option = { 
	                		title : {
	                	        text: method1,
	                	        x: 'center'
	                	    },
	                    tooltip: {  
	                        show: true  
	                    },  
	                    legend: {  
	                    	orient : 'vertical',
	                        x : 'right',
	                        data: ['班次']
	                    },
	                    toolbox: {
	                        show : true,
	                        orient: 'vertical',
	                        x: 'right',
	                        y: 'center',
	                        feature : {
	                            mark : {show: true},
	                            dataView : {show: true, readOnly: false},
	                            magicType : {show: true, type: ['line', 'bar']},
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
	                  	    		 'name': '班次',  
	                                 'type': 'bar',  
	                                 'data': idd_moh 
	                              }
	                  	    ]
	                };  
	                  
	                echart.setOption(option);  
	                echart.hideLoading();  
	            }
	        );
		};
		</script>
<script type="text/javascript">
			var obj2=document.getElementById('cc2');  
			$.ajax({
		        type:'post',
		        url:${pageContext.request.contextPath}'/DOW_Date',//请求数据的地址	
		        success:function(data){
		            for(var index in data){
	      				  obj2.options.add(new Option(data[index].lcl_Dpt_Day)); //这个兼容IE与firefox  
		            }
		        }
		    });
		</script>
<script type="text/javascript">
			var obj3=document.getElementById('methodSelect');
			var method = ["01月","02月","03月","04月","05月","06月","07月","08月","09月","10月","11月","12月"];
			 for(var index in method){
				 obj3.options.add(new Option(method[index]));  
           }
		</script>