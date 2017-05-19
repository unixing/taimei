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
				if("数据源"!=searchJson.dta_Sce&&"请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					getMonthFltNum(searchJson);
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
				if("数据源"!=searchJson.dta_Sce&&"请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					getMonthFltNum(searchJson);
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
				if("数据源"!=searchJson.dta_Sce&&"请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					getMonthFltNum(searchJson);
				}
			}
		});
		cityPicker.init();
		var starter1 = new HzwCityPicker({
			data:data,
			target:'start1',
			valType:'k-v',
			hideCityInput:{
			},
			callback:function(){}
		});
		var ender1 = new HzwCityPicker({
			data:data,
			target:'end1',
			valType:'k-v',
			hideCityInput:{
			},
			callback:function(){}
		});
		var starter2 = new HzwCityPicker({
			data:data,
			target:'start2',
			valType:'k-v',
			hideCityInput:{
			},
			callback:function(){}
		});
		var ender2 = new HzwCityPicker({
			data:data,
			target:'end2',
			valType:'k-v',
			hideCityInput:{
			},
			callback:function(){}
		});
		var starter3 = new HzwCityPicker({
			data:data,
			target:'start3',
			valType:'k-v',
			hideCityInput:{
			},
			callback:function(){}
		});
		var ender3 = new HzwCityPicker({
			data:data,
			target:'end3',
			valType:'k-v',
			hideCityInput:{
			},
			callback:function(){}
		});
	</script>
<script type="text/javascript">
			/* var divArray = ["divtoMain","divreturnMain","divpasStpMain","divtoTwoMain","divtoThreeMain","divreturnThreeMain"];
			var toLists = ["toMain","returnMain","pasStpMain","toTwoMain","toThreeMain","returnThreeMain"];
			var toList = ["toPort","returnPort","pasStpPort","toTwoPort","toThreePort","returnThreePort"]; */
			function getParameter(){
				var dta_Sce = $(window.parent.document.body).find("#cc1").val();
				var custormersearchForm;
		// 		拿到form表单对象
				custormersearchForm = $("#plan-searchForm");
		// 		调用自定义方法, 内部处理好数据结构拿到json数据对象
				var searchJson = custormersearchForm.searchJson();
				searchJson.dta_Sce = dta_Sce;
				if("数据源"==searchJson.dta_Sce){
					searchJson.dta_Sce="中航";
				}
				return searchJson;
			};
			
			//动态创建表格
			function createTbl (indexx){ 
				$('<table/>',{ 
				id:'tableAir'+indexx, 
				}).appendTo($("#count")); 
			}
			
			function sumFormatter(data) {
			    field = this.field;
			    return data.reduce(function(sum, row) { 
			        return sum + (+row[field]);
			    }, 0);
			}
			function totalTextFormatter(data) {
			    return '合计';
			}
			//表格填充数据
			function createTableData(indexx,datasorce){
				$("#tableAir"+indexx+"").bootstrapTable({
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
						title: '航班日期',
						
						},
						{
						field: 'airPort',
						title: '航段',
						
						footerFormatter:totalTextFormatter
						},
						{
						field: 'yPrice',
						title: 'Y舱价格',
						width:'80'
						},    
						{
						field: 'cutPriceTeam',
						title: '切位团队价格',
						width:'80'
						}, 
						{
						field: 'two_Tak_Ppt',
						title: '150%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'ful_Pce_Ppt',
						title: '100%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'nne_Dnt_Ppt',
						title: '90%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'eht_Five_Dnt_Ppt',
						title: '85%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'eht_Dnt_Ppt',
						title: '80%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'sen_Five_Dnt_Ppt',
						title: '75%',
						
						footerFormatter:sumFormatter
						}, 
						{
						field: 'sen_Dnt_Ppt',
						title: '70%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'six_Dnt_Ppt',
						title: '60%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'fve_Dnt_Ppt',
						title: '50%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'fur_Fve_Dnt_Ppt',
						title: '45%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'fur_Dnt_Ppt',
						title: '40%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'thr_Dnt_Ppt',
						title: '30%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'two_Dnt_Ppt',
						title: '20%',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'sal_Tak_Ppt',
						title: '特殊位舱位',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'grp_Nbr',
						title: '团队',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'pgs_Per_Cls',
						title: '散团人数合计',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'wak_tol_Nbr',
						title: '散客总人数',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'wak_tol_Ine',
						title: '散客总收入',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'grp_Ine',
						title: '团队总收入',
						
						footerFormatter:sumFormatter
						},
						{
						field: 'avg_Dct',
						title: '平均折扣'
						
						},
						{
						field: 'pgs_Ine',
						title: '散团总收入'
						
						},
						{
						field: 'hour_Ine',
						title: '小时收入'
						
						},
						{
						field: 'avg_Per',
						title: '平均客座率'
						}
						]
		       		 });
			}
			
			$("#count").focus(function(){
				alert("aaa");
			})
			
			//合并单元格 
			function mergeCell(indexx,lineSize){
				var grid = $("#tableAir"+indexx+"");
				var rowCount = grid.find("tr").length - 1; 
				var rowTdCount = parseInt(grid.find("tr:eq("+rowCount+")").find("td").length - 1);
				var flagRow24 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-2)+")").html(); 
				var flagRow25 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-1)+")").html(); 
				var flagRow26 = grid.find("tr:eq("+rowCount+")").find("td:eq("+(rowTdCount-0)+")").html(); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").html(flagRow24)
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").html(flagRow25);
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-0)+")").html(flagRow26*100+"%");
				grid.bootstrapTable('mergeCells', {index: 0, field: 'date', colspan:1, rowspan: lineSize+1});
				grid.bootstrapTable('mergeCells', {index: 0, field: 'pgs_Ine', colspan:1, rowspan: lineSize+1});
				grid.bootstrapTable('mergeCells', {index: 0, field: 'hour_Ine', colspan:1, rowspan: lineSize+1});
				grid.bootstrapTable('mergeCells', {index: 0, field: 'avg_Per', colspan:1, rowspan: lineSize+1}); 
				
				grid.find("tr:eq(1)").find("td:eq(0)").html(grid.find("tr:eq("+rowCount+")").find("td:eq(0)").html()+"月");
				
				grid.find("tr:eq(1)").find("td:eq(0)").attr("style","text-align:center;vertical-align:middle;"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").attr("style","text-align:center;vertical-align:middle;"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-0)+")").attr("style","text-align:center;vertical-align:middle;");  
				
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").css("color","red"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").css("color","red"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-0)+")").css("color","red");  
				grid.find("tr:eq("+rowCount+")").css("color","red");
			}
			//动态生成航班号
			function getMonthFltNum(searchJson){
				var obj2=document.getElementById('flt_nbr_Count');
				var searchJson = getParameter();
				if("请选择月份"==searchJson.lcl_Dpt_Day||""==searchJson.lcl_Dpt_Day){
					return;
				}else{
					var months = searchJson.lcl_Dpt_Day.split('-');
					searchJson.lcl_Dpt_Day = (parseInt(months[0])-1)+'-'+months[1];//查询同步航班号
				}
				if("请选择机场"==searchJson.dpt_AirPt_Cd||""==searchJson.dpt_AirPt_Cd){
					return;
				}
				if("请选择机场"==searchJson.Arrv_Airpt_Cd||""==searchJson.Arrv_Airpt_Cd){
					return;
				}
				obj2.length=0;
				$.ajax({
			        type:'post',
			        url:'${pageContext.request.contextPath}/getMonthFltNum',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	obj2.options.add(new Option("汇总"));
			            for(var index in data.list){
		      				  obj2.options.add(new Option(data.list[index])); //这个兼容IE与firefox  
			            }
			        }
			    });
			}
			//这个函数为点击查询时出发的函数
			function send(){
				advancedQuery();
				getTimeCount();
				getDateAndCost();
			}
			function advancedQuery(){
				var searchJson = getParameter();
				//sethidden();
				if("请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					// 加载数据  
	                $.ajax({
	        	        type:'post',
	        	        url:'${pageContext.request.contextPath}/airline_list',
	        	        data:searchJson,
	        	        success:function(data){
	        	        	for(var index in data.lists){
	        	        		document.getElementById(divArray[index]).removeAttribute("hidden");
								mychart(data.lists[index],toLists[index]);
	        	        	}
	        	        }
	        	    }); 
	                $.ajax({
	        	        type:'post',
	        	        url:'${pageContext.request.contextPath}/airline_list2',	
	        	        data:searchJson,
	        	        success:function(data){
	        	        	for(var index in data.lists){
								evenPort(data.lists[index],toList[index]);
	        	        	}
	        	        }
	        	    }); 
				}else{
					alert("请检查查询条件");
				}
			};
			//给div设置上hidden属性
			/* function sethidden(){
				for(var i=0;i<divArray.length;i++){
					document.getElementById(divArray[i]).setAttribute("hidden","hidden");
				}
			}; */	
			
		//获得航线汇总的参数
		function getDateAndCost(){
			var searchJson = getParameter();
			if("请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
				       type:'post',
				       url:'${pageContext.request.contextPath}/getDateAndCost',//请求数据的地址	
				       data:searchJson,
				       success:function(data){
				          if(data.list!=null){
				        	  $("#countDate").val(data.list.tim_Cout);
				        	  $("#dateCost").val(data.list.tim_Cot);
				        	  $("#agencyRate").val(data.list.agy_Rte);
				        	  //调用数据表格函数
				        	  getDataTable(searchJson);
				          }else{
				        	  $("#countDate").val("");
				        	  $("#dateCost").val("");
				        	  $("#agencyRate").val("");
				        	  getDataTable(searchJson);
				          }
				    }
				});
			}
		}
		//生成汇总表格
		function getDataTable(data){
			var searchJson = getParameter();
			var tim_Cout = $("#countDate").val();
			var tim_Cot = $("#dateCost").val();
			var agy_Rte = $("#agencyRate").val();
			if(tim_Cout!=""&&tim_Cot!=""&&agy_Rte!=""){
				data.tim_Cout = tim_Cout;
				data.tim_Cot = tim_Cot;
				data.agy_Rte = agy_Rte;
				$.ajax({
				       type:'post',
					   async:false,
				       url:'${pageContext.request.contextPath}/getDataTable',//请求数据的地址	
				       data:data,
				       success:function(data){
				    	   $("#methodCountData").bootstrapTable("destroy").bootstrapTable({
				    		   showExport: true,
				    		   data:data.list,
				    		   exportDataType: "basic", 
				    		   sidePagination:'server',
				    		   columns:[
										{
											field: 'method',
											title: '月份',
										},
										{
											field: 'clazz',
											title: '班次',
										},
										{
											field: 'costClz',
											title: '成本班',
										},
										{
											field: 'fixedCose',
											title: '固定成本',
										},
										{
											field: 'hour',
											title: '小时数',
										},
										{
											field: 'costHour',
											title: '成本小时',
										},
										{
											field: 'incomeHour',
											title: '营收',
										},
										{
											field: 'income',
											title: '经营收入',
										},
										{
											field: 'subsidyClz',
											title: '补贴班',
										},
										{
											field: 'subsidyMethod',
											title: '补贴月',
										},
										{
											field: 'parlor',
											title: '客座',
										}
								]
				    	   })
				    	}
				});
			}else{
				 $("#methodCountData").bootstrapTable("destroy");
			}
		}
		function saveParameter(){
			var searchJson = getParameter();
			var tim_Cout = $("#countDate").val();
			var tim_Cot = $("#dateCost").val();
			var agy_Rte = $("#agencyRate").val();
			if(tim_Cout!=""&&tim_Cot!=""&&agy_Rte!=""){
				searchJson.tim_Cout = tim_Cout;
				searchJson.tim_Cot = tim_Cot;
				searchJson.agy_Rte = agy_Rte;
				$.ajax({
				       type:'post',
				       url:'${pageContext.request.contextPath}/saveParameter',//请求数据的地址	
				       data:searchJson,
				       success:function(data){
				    	   getDataTable(searchJson);
				       }
				});
				
			}
		}
		function changeTab(index){
			if(index==0){
				$('#searchData').bind('click',getDivideParameter);
				$('#flt_nbr_Count').bind('change',getDivideParameter);
			}else if(index==1){
				$('#searchData').unbind('click');
				$('#searchData').bind('click',getDivideParameter);
				$('#flt_nbr_Count').unbind('change');
				$('#flt_nbr_Count').bind('change',getDivideParameter);
			}else if(index==2){
				$('#searchData').unbind('click');
				$('#searchData').bind('click',getMonthSalesPlanParam);
				$('#flt_nbr_Count').unbind('change');
				$('#flt_nbr_Count').bind('change',getMonthSalesPlanParam);
			}else{
				$('#searchData').unbind('click');
				$('#searchData').bind('click',getCabinSetData);
				$('#flt_nbr_Count').unbind('change');
				$('#flt_nbr_Count').bind('change',getCabinSetData);
			}
		}
</script>