<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
//绑定回车事件
		
		var cityPicker = new HzwCityPicker({
			data: data,
			target: 'cityChoice',
			valType: 'k-v',
			hideCityInput: {
			},
			callback: function(){
				var searchJson = getParameter();
				if("数据源"!=searchJson.dta_Sce&&"请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					//send();
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
				if("数据源"!=searchJson.dta_Sce&&"请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					//send();
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
				if("数据源"!=searchJson.dta_Sce&&"请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					//send();
					getFlt_Nbr(searchJson);
				}
			}
		});
		cityPicker.init();
	</script>
<script type="text/javascript">
		function EnterPress(e){ //传入 event
			var e = e || window.event;
			if(e.keyCode == 13){
				saveAndQuery();
			}
		} 
		/* function ParameterEnterPress(e){ //传入 event
			var e = e || window.event;
			if(e.keyCode == 13){
				saveParameter();
			}
		}  */
			var divArray = ["divtoMain","divreturnMain","divpasStpMain","divtoTwoMain","divtoThreeMain","divreturnThreeMain"];
			var toLists = ["toMain","returnMain","pasStpMain","toTwoMain","toThreeMain","returnThreeMain"];
			var toList = ["toPort","returnPort","pasStpPort","toTwoPort","toThreePort","returnThreePort"];
			function getParameter(){
				var lcl_Dpt_Day = $("#cc2").val();
				var custormersearchForm;
		// 		拿到form表单对象
				custormersearchForm = $("#DOW-searchForm");
		// 		调用自定义方法, 内部处理好数据结构拿到json数据对象
				var searchJson = custormersearchForm.searchJson();
				searchJson.lcl_Dpt_Day = lcl_Dpt_Day;
				return searchJson;
			};
			//获得总飞时间,如果有的话则赋值给,没有的话,则填写
			function getTimeCount(){
				var searchJson = getParameter();
				if("请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					$.ajax({
				        type:'post',
				        url:'${pageContext.request.contextPath}/getTimeCount',//请求数据的地址	
				        data:searchJson,
				        success:function(data){
				        	$("#countTime").val("");
				        	if(data.list!=""&&data.list!=null){
				        		//这里是总飞时间文本框赋值
					        	$("#countTime").val(data.list);
					        	searchJson.flt_Rte_Cd = data.list;
					        	for(var i =0;i<12;i++){
					        		$("#tableAir"+i+"").bootstrapTable("destroy");
					        	}
					        	//调用生成数据函数
					        	getTableData(searchJson);
				        	}
				        }
				    });
				}
			};
			
			//在总飞时间填写结束时把当前参数信息保存到数据库
			function saveAndQuery(){
				var searchJson = getParameter();
				var Tim_Cout = $("#countTime").val();
				searchJson.flt_Rte_Cd = Tim_Cout;
				var passtp = searchJson.pas_stp;
				$.ajax({
			        type:'post',
			        url:'${pageContext.request.contextPath}/saveTimeCount',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//调用生成数据函数
			        	var grid = $("#tableAir0");
		        		var trCount = parseInt(grid.find("tr").length-1);
						var rowTdCount = parseInt(grid.find("tr:eq(1)").find("td").length); 
			        	if(passtp==""){
							for(var i =0;i<trCount/3;i++){
								var indexx = i*3+1
								var a = grid.find("tr:eq("+indexx+")").find("td:eq("+(rowTdCount-3)+")").html();
								var xssr = Number(a)/Number(Tim_Cout);
								grid.find("tr:eq("+indexx+")").find("td:eq("+(rowTdCount-2)+")").html(xssr.toFixed(2));
							}
			        	}else{
			        		for(var i =0;i<trCount/6;i++){
								var indexx = i*6+1
								var a = grid.find("tr:eq("+indexx+")").find("td:eq("+(rowTdCount-3)+")").html();
								var xssr = Number(a)/Number(Tim_Cout);
								grid.find("tr:eq("+indexx+")").find("td:eq("+(rowTdCount-2)+")").html(xssr.toFixed(2));
							}
			        	}
		        		
			        }
			    });
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
			function infoFormatter(value, row, index){
	            return fomatDigit(value,2);
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
						title: '日期',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'airPort',
						title: '航段',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'yPrice',
						title: 'Y舱<br/>价格',
						width:'80',
						align: 'center',
						valign: 'middle'
						},    
						{
						field: 'cutPriceTeam',
						title: '切位团<br/>队价格',
						width:'80',
						align: 'center',
						valign: 'middle'
						}, 
						{
						field: 'two_Tak_Ppt',
						title: '150%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'ful_Pce_Ppt',
						title: '100%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'nne_Dnt_Ppt',
						title: '90%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'eht_Five_Dnt_Ppt',
						title: '85%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'eht_Dnt_Ppt',
						title: '80%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'sen_Five_Dnt_Ppt',
						title: '75%',
						align: 'center',
						valign: 'middle'
						}, 
						{
						field: 'sen_Dnt_Ppt',
						title: '70%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'six_Dnt_Ppt',
						title: '60%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'fve_Dnt_Ppt',
						title: '50%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'fur_Fve_Dnt_Ppt',
						title: '45%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'fur_Dnt_Ppt',
						title: '40%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'thr_Dnt_Ppt',
						title: '30%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'two_Dnt_Ppt',
						title: '20%',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'sal_Tak_Ppt',
						title: '特殊<br/>舱位',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'grp_Nbr',
						title: '团队',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'pgs_Per_Cls',
						title: '散团人<br/>数合计',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'wak_tol_Nbr',
						title: '散客<br/>总人数',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'wak_tol_Ine',
						title: '散客<br/>总收入(元)',
						align: 'center',
						valign: 'middle',
						formatter: 'infoFormatter'
						},
						{
						field: 'grp_Ine',
						title: '团队<br/>总收入(元)',
						align: 'center',
						valign: 'middle',
						formatter: 'infoFormatter'
						},
						{
						field: 'avg_Dct',
						title: '平均<br/>折扣(%)',
						align: 'center',
						valign: 'middle'
						},
						{
						field: 'pgs_Ine',
						title: '散团<br/>总收入(元)',
						align: 'center',
						valign: 'middle',
						formatter: 'infoFormatter'
						},
						{
						field: 'hour_Ine',
						title: '小时<br/>收入(元)',
						align: 'center',
						valign: 'middle',
						formatter: 'infoFormatter'
						},
						{
						field: 'avg_Per',
						title: '均客<br/>座率(%)',
						align: 'center',
						valign: 'middle'
						}
						]
		       		 });
			}
			
			//向服务器发送回来的JSON数据添加合计数据
			function newJsonData(data){
				
				var lineSize = data.length;
				
				var airPort = "合计"; 
				
				var  pgs_Ine = parseInt(0.0); 
				var hour_Ine = parseFloat(0.0); 
				var avg_Per = parseFloat(0.0);
				
				var two_Tak_Ppt = parseInt(0); 
				var ful_Pce_Ppt = parseInt(0); 
				var nne_Dnt_Ppt = parseInt(0); 
				var eht_Five_Dnt_Ppt = parseInt(0); 
				var eht_Dnt_Ppt = parseInt(0); 
				var sen_Five_Dnt_Ppt = parseInt(0); 
				var sen_Dnt_Ppt = parseInt(0); 
				var six_Dnt_Ppt = parseInt(0); 
				var fve_Dnt_Ppt = parseInt(0); 
				var fur_Fve_Dnt_Ppt = parseInt(0); 
				var fur_Dnt_Ppt = parseInt(0); 
				var thr_Dnt_Ppt = parseInt(0); 
				var two_Dnt_Ppt = parseInt(0); 
				var sal_Tak_Ppt = parseInt(0); 
				var grp_Nbr = parseInt(0); 
				var pgs_Per_Cls = parseInt(0); 
				var wak_tol_Nbr = parseInt(0); 
				var wak_tol_Ine = parseInt(0); 
				var grp_Ine = parseInt(0); 
				var avg_Dct = parseInt(0); 
				var tal_Nbr_Set = parseInt(0);
				
				var pgs_Per_Cls1 = parseInt(0);
				var pgs_Per_Cls2 = parseInt(0);
				var pgs_Per_Cls3 = parseInt(0);
				var pgs_Per_Cls4 = parseInt(0);
				var pgs_Per_Cls5 = parseInt(0);
				var pgs_Per_Cls6 = parseInt(0);
				var date;
				var price  = 1;
				for(var i =0;i<lineSize;i++){
					date = data[i].date;
					price  = data[i].yPrice;
					if(i==0){
						 pgs_Per_Cls1 = parseInt(data[i].pgs_Per_Cls);
					}
					if(i==1){
						 pgs_Per_Cls2 = parseInt(data[i].pgs_Per_Cls);
					}
					if(i==2){
						 pgs_Per_Cls3 = parseInt(data[i].pgs_Per_Cls);
					}
					if(i==3){
						 pgs_Per_Cls4 = parseInt(data[i].pgs_Per_Cls);
					}
					if(i==4){
						 pgs_Per_Cls5 = parseInt(data[i].pgs_Per_Cls);
					}
					if(i==5){
						 pgs_Per_Cls6 = parseInt(data[i].pgs_Per_Cls);
					}
					
					 two_Tak_Ppt = two_Tak_Ppt + parseInt(data[i].two_Tak_Ppt); 
					 ful_Pce_Ppt = ful_Pce_Ppt + parseInt(data[i].ful_Pce_Ppt); 
					 nne_Dnt_Ppt = nne_Dnt_Ppt + parseInt(data[i].nne_Dnt_Ppt); 
					 eht_Five_Dnt_Ppt = eht_Five_Dnt_Ppt + parseInt(data[i].eht_Five_Dnt_Ppt); 
					 eht_Dnt_Ppt = eht_Dnt_Ppt + parseInt(data[i].eht_Dnt_Ppt); 
					 sen_Five_Dnt_Ppt = sen_Five_Dnt_Ppt + parseInt(data[i].sen_Five_Dnt_Ppt); 
					 sen_Dnt_Ppt = sen_Dnt_Ppt + parseInt(data[i].sen_Dnt_Ppt); 
					 six_Dnt_Ppt = six_Dnt_Ppt + parseInt(data[i].six_Dnt_Ppt); 
					 fve_Dnt_Ppt = fve_Dnt_Ppt + parseInt(data[i].fve_Dnt_Ppt); 
					 fur_Fve_Dnt_Ppt = fur_Fve_Dnt_Ppt + parseInt(data[i].fur_Fve_Dnt_Ppt); 
					 fur_Dnt_Ppt = fur_Dnt_Ppt + parseInt(data[i].fur_Dnt_Ppt); 
					 thr_Dnt_Ppt = thr_Dnt_Ppt + parseInt(data[i].thr_Dnt_Ppt); 
					 two_Dnt_Ppt = two_Dnt_Ppt + parseInt(data[i].two_Dnt_Ppt); 
					 sal_Tak_Ppt = sal_Tak_Ppt + parseInt(data[i].sal_Tak_Ppt); 
					 grp_Nbr = grp_Nbr + parseInt(data[i].grp_Nbr); 
					 pgs_Per_Cls = pgs_Per_Cls + parseInt(data[i].pgs_Per_Cls); 
					 wak_tol_Nbr = wak_tol_Nbr + parseInt(data[i].wak_tol_Nbr); 
					 wak_tol_Ine = wak_tol_Ine + parseInt(data[i].wak_tol_Ine); 
					 grp_Ine = grp_Ine + parseInt(data[i].grp_Ine); 
					// avg_Dct = avg_Dct + parseInt(data[i].avg_Dct); 
					 tal_Nbr_Set = parseInt(data[i].tal_Nbr_Set);
				}
				var hours = Number($("#countTime").val());
				if(hours<=0){
					hours = 1;
				 }
				if(lineSize<3){
					//直飞
					 pgs_Ine = wak_tol_Ine + grp_Ine ;
					 hour_Ine = pgs_Ine / hours
					 avg_Per = 	 pgs_Per_Cls/(tal_Nbr_Set*2);
				}else{
					//经停
					 pgs_Ine = wak_tol_Ine + grp_Ine ;
					 hour_Ine = pgs_Ine /hours;
					 avg_Per = (pgs_Per_Cls1+pgs_Per_Cls2*2+pgs_Per_Cls3+pgs_Per_Cls4+pgs_Per_Cls5*2+pgs_Per_Cls6)/(tal_Nbr_Set*4);
				}
				 avg_Dct =  (pgs_Ine/pgs_Per_Cls/price*100).toFixed(2);
				var object = {
						date : date,
						airPort : airPort,
						two_Tak_Ppt : two_Tak_Ppt,
						ful_Pce_Ppt : ful_Pce_Ppt,
						nne_Dnt_Ppt : nne_Dnt_Ppt,
						eht_Five_Dnt_Ppt : eht_Five_Dnt_Ppt,
						eht_Dnt_Ppt : eht_Dnt_Ppt,
						sen_Five_Dnt_Ppt : sen_Five_Dnt_Ppt,
						sen_Dnt_Ppt : sen_Dnt_Ppt,
						six_Dnt_Ppt : six_Dnt_Ppt,
						fve_Dnt_Ppt : fve_Dnt_Ppt,
						fur_Fve_Dnt_Ppt : fur_Fve_Dnt_Ppt,
						fur_Dnt_Ppt : fur_Dnt_Ppt,
						thr_Dnt_Ppt : thr_Dnt_Ppt,
						two_Dnt_Ppt : two_Dnt_Ppt,
						sal_Tak_Ppt : sal_Tak_Ppt,
						grp_Nbr : grp_Nbr,
						pgs_Per_Cls : pgs_Per_Cls,
						wak_tol_Nbr : wak_tol_Nbr,
						wak_tol_Ine : wak_tol_Ine,
						grp_Ine : grp_Ine,
						avg_Dct : avg_Dct,
						pgs_Ine : pgs_Ine,
						hour_Ine : hour_Ine.toFixed(2),
						avg_Per : avg_Per.toFixed(2)
				}
				data.push(object);
				return data;
			}
			function tallDataHeBing(list){
				var datas = [];
				var datalength = list.length;
				for(var i =0;i<datalength;i++){
					for(var j =0;j<list[i].length;j++){
						datas.push(list[i][j]);
					}
				}
				return datas;
			}
			//这里实现表格数据的js方法
			function getTableData(searchJson){
				$.ajax({
					beforeSend: function(){
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        },
			        type:'post',
			        url:'${pageContext.request.contextPath}/getTableData',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	//这里在赋值之后调用后台数据给表格赋值
			        	var monthSize = data.list.length;
			        	var lineSize = data.list[0].length;
			        	//根据月份创建表格
			        	var lenghtt ;
			        	var index =0 ;
			        	var arr = new Array()
			        	 for(var i=0;i<monthSize;i++){
			        		if(data.list[i]!=null&&data.list[i]!=""){
			        			//createTbl(i);
				        		//createTableData(i,newJsonData(data.list[i]));
				        		data.list[i] = newJsonData(data.list[i]);
				        		//对表格单元格合并
				        		lenghtt = data.list[i].length;
				        		arr.push(lenghtt);
				        		index = index+1;
			        		}
			        	}
			        	 var datas = tallDataHeBing(data.list);
			        	 createTbl(0);
			        	 createTableData(0,datas);
			        	 mergeCell(index,arr);
			        }
			    });
			}
			//合并单元格 
			function mergeCell(lengthData,arr){
				var grid = $("#tableAir0");
				var rowTdCount = parseInt(grid.find("tr:eq(0)").find("td").length-1);
				var len = 0;
				var lenn = 1;
				for(var i =0;i<lengthData;i++){
					var lengthList = arr[i];
					len =len + lengthList;
					var flagRow24 = grid.find("tr:eq("+(len)+")").find("td:eq("+(rowTdCount-2)+")").html(); 
					var flagRow25 = grid.find("tr:eq("+(len)+")").find("td:eq("+(rowTdCount-1)+")").html(); 
					var flagRow26 = grid.find("tr:eq("+(len)+")").find("td:eq("+(rowTdCount-0)+")").html(); 
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-2)+")").html(flagRow24)
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-1)+")").html(flagRow25);
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-0)+")").html((flagRow26*100).toFixed(2)+"");
					
					grid.find("tr:eq("+lenn+")").find("td:eq(0)").html(grid.find("tr:eq("+lenn+")").find("td:eq(0)").html()+"月");
					grid.find("tr:eq("+lenn+")").find("td:eq(0)").attr("style","text-align:center;vertical-align:middle;"); 
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-2)+")").attr("style","text-align:center;vertical-align:middle;");  
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-1)+")").attr("style","text-align:center;vertical-align:middle;"); 
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-0)+")").attr("style","text-align:center;vertical-align:middle;");  
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-2)+")").css("color","red"); 
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-1)+")").css("color","red"); 
					grid.find("tr:eq("+lenn+")").find("td:eq("+(rowTdCount-0)+")").css("color","red");  
					grid.find("tr:eq("+len+")").css("color","red");
					grid.bootstrapTable('mergeCells', {index: lenn-1, field: 'date', colspan:1, rowspan: lengthList});
					grid.bootstrapTable('mergeCells', {index: lenn-1, field: 'pgs_Ine', colspan:1, rowspan: lengthList});
					grid.bootstrapTable('mergeCells', {index: lenn-1, field: 'hour_Ine', colspan:1, rowspan: lengthList});
					grid.bootstrapTable('mergeCells', {index: lenn-1, field: 'avg_Per', colspan:1, rowspan: lengthList});
					lenn =lenn + lengthList;
				}
			}
			//动态生成航班号
			function getFlt_Nbr(searchJson){
				var obj2=document.getElementById('flt_nbr_Count');  
				obj2.length=0;
				$.ajax({
			        type:'post',
			        url:'${pageContext.request.contextPath}/getFlt_Nbr',//请求数据的地址	
			        data:searchJson,
			        success:function(data){
			        	obj2.options.add(new Option("汇总"));
			            for(var index in data.list){
			            	if(flight==data.list[index]){
			            		var obj =new Option(data.list[index]);
			            		obj.selected=true;
			      				obj2.options.add(obj); //这个兼容IE与firefox  
			            	}else{
			      				obj2.options.add(new Option(data.list[index])); //这个兼容IE与firefox  			            		
			            	}
			            }
			        }
			    });
			}
			//这个函数为点击查询时出发的函数
			function send(){
				var las1 = $('#data').attr('class');
				var las2 = $('#count').attr('class');
				var las3 = $('#airLine').attr('class');
				if(las1=="tab-pane fade active in"){
					advancedQuery();
				}
				if(las2=="tab-pane fade active in"){
					getTimeCount();
				}
				if(las3=="tab-pane fade active in"){
					getDateAndCost();
				}
				
			}
			function advancedQuery(){
				var searchJson = getParameter();
				sethidden();
				if("请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					// 加载数据  
	                $.ajax({
	                	beforeSend: function(){
							$("#wate").attr("style","display: block;");
				        },
				        complete:function(){
				        	$("#wate").attr("style","display: none;");
				        },
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
	        	        		document.getElementById(divArray[index]).removeAttribute("hidden");
								evenPort(data.lists[index],toList[index]);
	        	        	}
	        	        }
	        	    }); 
				}else{
					alert("请检查查询条件");
				}
			};
			//给div设置上hidden属性
			function sethidden(){
				for(var i=0;i<divArray.length;i++){
					document.getElementById(divArray[i]).setAttribute("hidden","hidden");
				}
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
		                $.ajaxSettings.async = true;  
		                // 加载数据  
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
		        	     
		                var option = { 
		                		title : {
		                	        text: titleY,
		                	        x: 'center'
		                	    },
		                    tooltip: {  
		                        show: true  
		                    },  
		                    legend: {  
		                        data: ['','客流/月','班次/月','座位/月','团队/月','团队收入/月/100','收入/月/1000']  
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
	                $.ajaxSettings.async = true;  
	                  
	                // 加载数据  
       	            for(var index in data.list){
       	            	tme_Nbr[index] = Number(data.list[index].tme_Nbr); //给Y轴赋值
       	            	cla_Nbr[index] = Number(data.list[index].cla_Nbr); //给Y轴赋值
       	            	tme_Cla_Moh[index] = Number(data.list[index].tme_Cla_Moh); //给Y轴赋值
       	            	cla_Set[index] = Number(data.list[index].cla_Set); //给Y轴赋值
       	            	cla_Per[index] = Number(data.list[index].cla_Per); //给Y轴赋值
       	            	cla_Grp[index] = Number(data.list[index].cla_Grp); //给Y轴赋值
       	            	flt_Ser_Ine[index] = Number(data.list[index].flt_Ser_Ine)/100; //给Y轴赋值
       	            	lod_For[index] = Number(data.list[index].lod_For); //给Y轴赋值
       	            	idd_Dct[index] = Number(data.list[index].idd_Dct); //给Y轴赋值
       	                xtext[index] = data.list[index].label;//给X轴TEXT赋值
        	            evenPort=data.list[0].evenPort;
       	            }
	                  
	                var option = {
	               		title : {
	               	        text: evenPort,
	               	    	 x: 'center'
	               	    },
	                    tooltip: {  
	                        show: true  
	                    },  
	                    legend: {  
	                        data: ['','天数','班次/月','日班次','每班座位','每班旅客','每班团队','团队收入/100','客座率','每班收入/1000']  
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
	                              },
	                  	    	
	                  	    ]
	                };  
	                echart.setOption(option);  
	                echart.hideLoading();  
	            }
	        );
		}
		//获得航线汇总的参数
		function getDateAndCost(){
			var searchJson = getParameter();
			if("请选择年份"!=searchJson.lcl_Dpt_Day&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
				$.ajax({
					beforeSend: function(){
						$("#wate").attr("style","display: block;");
			        },
			        complete:function(){
			        	$("#wate").attr("style","display: none;");
			        },
				       type:'post',
				       url:'${pageContext.request.contextPath}/getDataTable',//请求数据的地址	
				       data:searchJson,
				       success:function(data){
				           if(data.list!=null){
				        	   $("#methodCountData").bootstrapTable("destroy");
				        	 	getDataTable(data.list);
				    		}
				       }
				});
			}
		}
		function infoFormatter(value, row, index){
            return fomatDigit(value,2);
        }
		//生成汇总表格
		function getDataTable(data){
			$("#methodCountData").bootstrapTable({
				data: data,         
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
	            rowStyle: function (row, index) {
	                   //这里有5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
	                   var strclass = "";
	                   if (row.method == "总计") {
	                       strclass = 'success';//还有一个active
	                   }
	                   else if (row.method == "代理费率") {
	                       strclass = 'danger';
	                   }
	                   else {
	                       return {};
	                   }
	                   return { classes: strclass }
	               },
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
						title: '成本班（元）'
					},
					{
						field: 'fixedCose',
						title: '固定成本（元）',
						formatter: 'infoFormatter'
					},
					{
						field: 'hour',
						title: '小时数',
					},
					{
						field: 'costHour',
						title: '成本小时（元）',
						formatter: 'infoFormatter'
					},
					{
						field: 'incomeHour',
						title: '小时营收（元）'
					},
					{
						field: 'income',
						title: '经营收入（元）',
						formatter: 'infoFormatter'
					},
					{
						field: 'subsidyClz',
						title: '补贴班（元）'
					},
					{
						field: 'subsidyMethod',
						title: '补贴月（元）',
						formatter: 'infoFormatter'
					},
					{
						field: 'parlor',
						title: '客座（%）',
					}
				]
			});
		}
		/* function saveParameter(){
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
		} */
</script>
<script type="text/javascript">
		var obj2=document.getElementById('cc2');  
		$.ajax({
		       type:'post',
		       url:'${pageContext.request.contextPath}/DOW_Date',
		       async:false,//请求数据的地址	
		       success:function(data){
		           for(var index in data){
		    			obj2.options.add(new Option(data[index].lcl_Dpt_Day)); //这个兼容IE与firefox  
		           }
		       }
		   });
</script>
<script type="text/javascript">
	var flight = "";
	var airports = parent.airportMap;
	window.onload = function(){
		var flightTemp = parent.supData.flight.split("/");
		flight ="航班号"+flightTemp[0]+"/"+flightTemp[0].substring(0,4)+flightTemp[1];
		var airLine = parent.supData.lane;
		if(airLine!=null&&airLine!="undefined"&&airLine!=''){
			var cds = airLine.split("=");
			if(cds.length==3){
				$('#cityChoice').val(airports[cds[0]].ctyChaNam);
				$('#cityChoice3').val(airports[cds[1]].ctyChaNam);
				$('#cityChoice2').val(airports[cds[2]].ctyChaNam);
			}else{
				$('#cityChoice').val(airports[cds[0]].ctyChaNam);
				$('#cityChoice2').val(airports[cds[1]].ctyChaNam);
			}
			var searchJson = getParameter();
			getFlt_Nbr(searchJson);
			send();
		}
	};
</script>