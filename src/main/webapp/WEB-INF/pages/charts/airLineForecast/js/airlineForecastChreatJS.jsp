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
					//send();
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
				}
			}
		});
		cityPicker.init();
	</script>
<script type="text/javascript">
			function getParameter(id){
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
				return searchJson;
			};
			//查询
			function send(){
				//清空页面数据
				
				clearData();
				var searchJson = getParameter();
				if(""!=searchJson.startDate&&""!=searchJson.endDate&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					$.ajax({
				        type:'post',
				        url:'${pageContext.request.contextPath}/forecastData',
				        data:searchJson,
				        success:function(data){
				        	var airLineForecastDetailObjectList = data.airLineForecastDetailObjectList;
				        	var airLineForecast = data.airLineForecast;
				        	var grid = $("#tableData");
							var rowCount = grid.find("tr").length; 
							
							for(var i=rowCount-1;i>0;i--){
								grid.find("tr:eq("+i+")").remove();
							}
				        	createTablee(airLineForecastDetailObjectList); 
				        	showData(airLineForecast,airLineForecastDetailObjectList);
				        	geshi();
				        	 $("#forecast").attr("style","display: block;");
				        	 $("#myTabContent3").attr("style","display: block;");
				        }
				    });
				}
				
			}
			//更新或者保存
			function saveOrUpate(){
				var	airLineForecastObject = new Object();
				var airLineForecast = new Object();
				var searchJson = getParameter();
				
				if(""!=searchJson.startDate&&""!=searchJson.endDate&&""!=searchJson.dpt_AirPt_Cd&&""!=searchJson.Arrv_Airpt_Cd){
					airLineForecast.startDate = searchJson.startDate;
					airLineForecast.endDate = searchJson.endDate;
					airLineForecast.dpt_AirPt_Cd = searchJson.dpt_AirPt_Cd;
					airLineForecast.arrv_Airpt_Cd = searchJson.Arrv_Airpt_Cd;
				}else{
					alert("请选择条件");
					return;
				}
				airLineForecast.pas_stp = searchJson.pas_stp;
				airLineForecast.id = $("#id").val();
				airLineForecast.fly_time = $("#fly_time").val();
				airLineForecast.fly_price = $("#fly_price").val();
				airLineForecast.fly_type = $("#fly_type").val();
				airLineForecast.fly_site = $("#fly_site").val();
				airLineForecast.fly_banqi = $("#fly_banqi").val();
				airLineForecast.daili_price = $("#daili_price").val();
				airLineForecast.fly_banci = $("#fly_banci").val();
				airLineForecast.bp_time = $("#bp_time").val();
				airLineForecast.bark = $("#bark").val();
				airLineForecast.dta_Sce=searchJson.dta_Sce;
				airLineForecastObject.airLineForecast = airLineForecast;
				var airLineForecastDetailObjectList = new Array();
				airLineForecastDetailObjectList = getTableData();
				airLineForecastObject.airLineForecastDetailObjectList = airLineForecastDetailObjectList;
				if(airLineForecast.fly_time!=""&&airLineForecast.fly_price!=""&&airLineForecast.fly_site!=""&&airLineForecast.fly_banci!=""){
					$.ajax(
			                {
			                  url:'${pageContext.request.contextPath}/saveOrUpateforecast', 
			                  type: "POST", 
			                  data: JSON.stringify(airLineForecastObject), 
			                  success: function(data){
			                	  var airLineForecastDetailObjectList = data.airLineForecastDetailObjectList;
						          var airLineForecast = data.airLineForecast;
						          var grid = $("#tableData");
								  var rowCount = grid.find("tr").length; 
						          for(var i=rowCount-1;i>0;i--){
										grid.find("tr:eq("+i+")").remove();
									}
						           createTablee(airLineForecastDetailObjectList); 
						           showData(airLineForecast,airLineForecastDetailObjectList);
						           geshi();
			                  }, 
			                  dataType: "json",
			                  contentType: "application/json"
			               } );
				}else{
					alert("请输入基本信息");
				}
				
			}
			//动态创建行
			function createTablee(airLineForecastDetailObjectList){
				var length = airLineForecastDetailObjectList.length;
				var num = 0;
				if(length==3||length==7){
					num = length-1
					airLineForecastDetailObjectList[0].zglsr = airLineForecastDetailObjectList[length-1].zglsr
					airLineForecastDetailObjectList[0].stzys = airLineForecastDetailObjectList[length-1].stzys
					airLineForecastDetailObjectList[0].xsys = airLineForecastDetailObjectList[length-1].xsys
					airLineForecastDetailObjectList[0].zhkzl = airLineForecastDetailObjectList[length-1].zhkzl
					airLineForecastDetailObjectList[0].jbbt = airLineForecastDetailObjectList[length-1].jbbt
					airLineForecastDetailObjectList[0].nbt = airLineForecastDetailObjectList[length-1].nbt
				}else{
					num = length;
				}
				var numnew = num +1;
				for(var i=0;i<length;i++){
					var airLineForecastDetailObject = airLineForecastDetailObjectList[i];
					if(airLineForecastDetailObject.doTime!="合计"){
						var tr = $("<tr></tr>");
						tr.appendTo($("#tableData"));
						var td = $("<td style='display: none;'>"+airLineForecastDetailObject.id+"</td>");
						td.appendTo(tr);
						if(i==0){
							var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.doTime+"</td>");
							td.appendTo(tr);
						}
						
						var td = $("<td>"+airLineForecastDetailObject.hangduan+"</td>");
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.hangju+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.yc_price+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.qwtdjg_price+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.f_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.y_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.b_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.h_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.k_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.l_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.m_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.q_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.x_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.u_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.e_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.z_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.t_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.v_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.g_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.o_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.s_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.qp_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td></td>");
						var input = $("<input type='text' style='width:50px;' value="+airLineForecastDetailObject.qt_flag+">");
						input.appendTo(td);
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.strshj+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.skzrs+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.skzys+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.tdzys+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.dlf+"</td>");
						td.appendTo(tr);
						
						if(i==0){
							if(length==3||length==7){
								var td = $("<td rowspan="+numnew+">"+airLineForecastDetailObject.zglsr+"</td>");
								td.appendTo(tr);
							}else{
								var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.zglsr+"</td>");
								td.appendTo(tr);
							}
						}
						
						var td = $("<td>"+airLineForecastDetailObject.pjzk+"</td>");
						td.appendTo(tr);
						if(i==0){
							if(length==3||length==7){
								var td = $("<td rowspan="+numnew+">"+airLineForecastDetailObject.stzys+"</td>");
								td.appendTo(tr);
							}else{
								var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.stzys+"</td>");
								td.appendTo(tr);
							}
						}
						if(i==0){
							if(length==3||length==7){
								var td = $("<td rowspan="+numnew+">"+airLineForecastDetailObject.xsys+"</td>");
								td.appendTo(tr);
							}else{
								var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.xsys+"</td>");
								td.appendTo(tr);
							}
						}
						if(i==0){
							if(length==3||length==7){
								var td = $("<td rowspan="+numnew+">"+airLineForecastDetailObject.zhkzl+"</td>");
								td.appendTo(tr);
							}else{
								var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.zhkzl+"</td>");
								td.appendTo(tr);
							}
						}
						if(i==0){
							if(length==3||length==7){
								var td = $("<td rowspan="+numnew+">"+airLineForecastDetailObject.jbbt+"</td>");
								td.appendTo(tr);
							}else{
								var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.jbbt+"</td>");
								td.appendTo(tr);
							}
						}
						if(i==0){
							if(length==3||length==7){
								var td = $("<td rowspan="+numnew+">"+airLineForecastDetailObject.nbt+"</td>");
								td.appendTo(tr);
							}else{
								var td = $("<td rowspan="+num+">"+airLineForecastDetailObject.nbt+"</td>");
								td.appendTo(tr);
							}
						}
						
						var td = $("<td>"+airLineForecastDetailObject.ttl+"</td>");
						td.appendTo(tr);
						
					}else{
						var tr = $("<tr></tr>");
						tr.appendTo($("#tableData"));
						var td = $("<td style='display: none;'>"+airLineForecastDetailObject.id+"</td>");
						td.appendTo(tr);
						var td = $("<td colspan=2 >"+airLineForecastDetailObject.doTime+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.hangju+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.yc_price+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.qwtdjg_price+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.f_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.y_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.b_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.h_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.k_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.l_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.m_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.q_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.x_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.u_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.e_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.z_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.t_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.v_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.g_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.o_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.s_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.qp_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.qt_flag+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.strshj+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.skzrs+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.skzys+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.tdzys+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.dlf+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.pjzk+"</td>");
						td.appendTo(tr);
						
						var td = $("<td>"+airLineForecastDetailObject.ttl+"</td>");
						td.appendTo(tr);
					}
				}
				
				
			}
		    //显示数据
			function showData(airLineForecast,airLineForecastDetailObjectList) {
				if(airLineForecast==null){
					$("#talTable").attr("style","display:none;");
	        	}else{
	        		$("#talTable").attr("style","display:block;");
	        		$("#fly_time").val(airLineForecast.fly_time);
	        		$("#id").val(airLineForecast.id);
	        		$("#fly_price").val(airLineForecast.fly_price);
	        		$("#fly_type").val(airLineForecast.fly_type);
	        		$("#fly_site").val(airLineForecast.fly_site);
	        		$("#fly_banqi").val(airLineForecast.fly_banqi);
	        		$("#daili_price").val(airLineForecast.daili_price);
	        		$("#fly_banci").val(airLineForecast.fly_banci);
	        		$("#bp_time").val(airLineForecast.bp_time);
	        		$("#bark").val(airLineForecast.bark);
	        		$("#aa").html("航线收益预测结果"+airLineForecastDetailObjectList[0].doTime);
	        		$("#bb").text("航线");
	        		$("#cc").text("机型："+airLineForecast.fly_type);
	        		$("#dd").text("座位布局："+airLineForecast.fly_site);
	        		$("#ee").text("班期："+airLineForecast.fly_banqi);
	        		$("#ff").text("总班次");
	        		$("#gg").text("运营情况预估（往返数据）");
	        		$("#hh").text("财政补贴情况预估（元）");
	        		$("#jj").text("均班客量");
	        		$("#kk").text("均班客座率");
	        		$("#mm").text("均班营收");
	        		$("#nn").text("总吞吐量（含过站）");
	        		$("#oo").text("总营收");
	        		$("#pp").text("参考成本/往返");
	        		$("#qq").text("总成本");
	        		$("#rr").text("预估均班补贴");
	        		$("#ss").text("预估总补贴（含代理）");
	        		$("#tt").text(airLineForecast.dpt_AirPt_Cd+"="+airLineForecast.pas_stp+"="+airLineForecast.arrv_Airpt_Cd);
	        		var objectHeJi = airLineForecastDetailObjectList[airLineForecastDetailObjectList.length-1];
	        		$("#uu").text(airLineForecast.fly_banci);
	        		$("#vv").text(objectHeJi.strshj);
	        		$("#xx").text(objectHeJi.zhkzl);
	        		$("#yy").text(objectHeJi.stzys);
	        		$("#zz").text(objectHeJi.ttl*airLineForecast.fly_banci);
	        		$("#aaa").text((airLineForecast.fly_banci*objectHeJi.stzys).toFixed(2));
	        		$("#bbb").text((airLineForecast.fly_price*airLineForecast.fly_time).toFixed(2));
	        		$("#ccc").text((airLineForecast.fly_price*airLineForecast.fly_banci*airLineForecast.fly_time).toFixed(2));
	        		$("#ddd").text(objectHeJi.jbbt);
	        		$("#eee").text(objectHeJi.nbt);
	        	}
			}
		//清空页面数据
		function clearData(){
			$("#fly_time").val("");
    		$("#id").val("");
    		$("#fly_price").val("");
    		$("#fly_type").val("");
    		$("#fly_site").val("");
    		$("#fly_banqi").val("");
    		$("#daili_price").val("");
    		$("#fly_banci").val("");
    		$("#bp_time").val("");
    		$("#bark").val("");
		}
			
		
		//获得表格数据
		function getTableData(){
			var airLineForecastDetailObjectList = new Array();
			var grid = $("#tableData");
			var rowCount = grid.find("tr").length; 
			for(var i =1 ;i<rowCount;i++){
				var airLineForecastDetailObject = new Object();
				airLineForecastDetailObject.id = grid.find("tr:eq("+i+")").find("td:eq(0)").html(); 
				if(i==1){
					airLineForecastDetailObject.hangduan = grid.find("tr:eq("+i+")").find("td:eq(2)").html(); 
					airLineForecastDetailObject.hangju = grid.find("tr:eq("+i+")").find("td:eq(3)").find("input").val();
					airLineForecastDetailObject.yc_price = grid.find("tr:eq("+i+")").find("td:eq(4)").find("input").val(); 
					airLineForecastDetailObject.qwtdjg_price = grid.find("tr:eq("+i+")").find("td:eq(5)").find("input").val(); 
					airLineForecastDetailObject.f_flag = grid.find("tr:eq("+i+")").find("td:eq(6)").find("input").val(); 
					airLineForecastDetailObject.y_flag = grid.find("tr:eq("+i+")").find("td:eq(7)").find("input").val(); 
					airLineForecastDetailObject.b_flag = grid.find("tr:eq("+i+")").find("td:eq(8)").find("input").val(); 
					airLineForecastDetailObject.h_flag = grid.find("tr:eq("+i+")").find("td:eq(9)").find("input").val(); 
					airLineForecastDetailObject.k_flag = grid.find("tr:eq("+i+")").find("td:eq(10)").find("input").val(); 
					airLineForecastDetailObject.l_flag = grid.find("tr:eq("+i+")").find("td:eq(11)").find("input").val(); 
					airLineForecastDetailObject.m_flag = grid.find("tr:eq("+i+")").find("td:eq(12)").find("input").val(); 
					airLineForecastDetailObject.q_flag = grid.find("tr:eq("+i+")").find("td:eq(13)").find("input").val(); 
					airLineForecastDetailObject.x_flag = grid.find("tr:eq("+i+")").find("td:eq(14)").find("input").val(); 
					airLineForecastDetailObject.u_flag = grid.find("tr:eq("+i+")").find("td:eq(15)").find("input").val(); 
					airLineForecastDetailObject.e_flag = grid.find("tr:eq("+i+")").find("td:eq(16)").find("input").val(); 
					airLineForecastDetailObject.z_flag = grid.find("tr:eq("+i+")").find("td:eq(17)").find("input").val(); 
					airLineForecastDetailObject.t_flag = grid.find("tr:eq("+i+")").find("td:eq(18)").find("input").val(); 
					airLineForecastDetailObject.v_flag = grid.find("tr:eq("+i+")").find("td:eq(19)").find("input").val(); 
					airLineForecastDetailObject.g_flag = grid.find("tr:eq("+i+")").find("td:eq(20)").find("input").val(); 
					airLineForecastDetailObject.o_flag = grid.find("tr:eq("+i+")").find("td:eq(21)").find("input").val(); 
					airLineForecastDetailObject.s_flag = grid.find("tr:eq("+i+")").find("td:eq(22)").find("input").val(); 
					airLineForecastDetailObject.qp_flag = grid.find("tr:eq("+i+")").find("td:eq(23)").find("input").val(); 
					airLineForecastDetailObject.qt_flag = grid.find("tr:eq("+i+")").find("td:eq(24)").find("input").val(); 
				}else{
					airLineForecastDetailObject.hangduan = grid.find("tr:eq("+i+")").find("td:eq(1)").html(); 
					airLineForecastDetailObject.hangju = grid.find("tr:eq("+i+")").find("td:eq(2)").find("input").val();
					airLineForecastDetailObject.yc_price = grid.find("tr:eq("+i+")").find("td:eq(3)").find("input").val(); 
					airLineForecastDetailObject.qwtdjg_price = grid.find("tr:eq("+i+")").find("td:eq(4)").find("input").val(); 
					airLineForecastDetailObject.f_flag = grid.find("tr:eq("+i+")").find("td:eq(5)").find("input").val(); 
					airLineForecastDetailObject.y_flag = grid.find("tr:eq("+i+")").find("td:eq(6)").find("input").val(); 
					airLineForecastDetailObject.b_flag = grid.find("tr:eq("+i+")").find("td:eq(7)").find("input").val(); 
					airLineForecastDetailObject.h_flag = grid.find("tr:eq("+i+")").find("td:eq(8)").find("input").val(); 
					airLineForecastDetailObject.k_flag = grid.find("tr:eq("+i+")").find("td:eq(9)").find("input").val(); 
					airLineForecastDetailObject.l_flag = grid.find("tr:eq("+i+")").find("td:eq(10)").find("input").val(); 
					airLineForecastDetailObject.m_flag = grid.find("tr:eq("+i+")").find("td:eq(11)").find("input").val(); 
					airLineForecastDetailObject.q_flag = grid.find("tr:eq("+i+")").find("td:eq(12)").find("input").val(); 
					airLineForecastDetailObject.x_flag = grid.find("tr:eq("+i+")").find("td:eq(13)").find("input").val(); 
					airLineForecastDetailObject.u_flag = grid.find("tr:eq("+i+")").find("td:eq(14)").find("input").val(); 
					airLineForecastDetailObject.e_flag = grid.find("tr:eq("+i+")").find("td:eq(15)").find("input").val(); 
					airLineForecastDetailObject.z_flag = grid.find("tr:eq("+i+")").find("td:eq(16)").find("input").val(); 
					airLineForecastDetailObject.t_flag = grid.find("tr:eq("+i+")").find("td:eq(17)").find("input").val(); 
					airLineForecastDetailObject.v_flag = grid.find("tr:eq("+i+")").find("td:eq(18)").find("input").val(); 
					airLineForecastDetailObject.g_flag = grid.find("tr:eq("+i+")").find("td:eq(19)").find("input").val(); 
					airLineForecastDetailObject.o_flag = grid.find("tr:eq("+i+")").find("td:eq(20)").find("input").val(); 
					airLineForecastDetailObject.s_flag = grid.find("tr:eq("+i+")").find("td:eq(21)").find("input").val(); 
					airLineForecastDetailObject.qp_flag = grid.find("tr:eq("+i+")").find("td:eq(22)").find("input").val(); 
					airLineForecastDetailObject.qt_flag = grid.find("tr:eq("+i+")").find("td:eq(23)").find("input").val(); 
				}
				 
				
				airLineForecastDetailObjectList.push(airLineForecastDetailObject);
			}
			return airLineForecastDetailObjectList;
		}
		
		//合并单元格 
		function geshi(){
			var grid = $("#tableData");
			var rowCount = grid.find("tr").length - 1; 
			var rowTdCount = parseInt(grid.find("tr:eq(1)").find("td").length - 1);
			if(rowCount==3||rowCount==7){
				grid.find("tr:eq(1)").find("td:eq(1)").attr("style","text-align:center;vertical-align:middle;"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-3)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-4)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-5)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-7)+")").attr("style","text-align:center;vertical-align:middle;");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-1)+")").css("color","red"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-2)+")").css("color","red"); 
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-3)+")").css("color","red");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-4)+")").css("color","red");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-5)+")").css("color","red");  
				grid.find("tr:eq(1)").find("td:eq("+(rowTdCount-7)+")").css("color","red"); 
				grid.find("tr:eq("+rowCount+")").find("td:eq(1)").attr("style","text-align:center;vertical-align:middle;"); 
				grid.find("tr:eq("+rowCount+")").css("color","red");
			}else{
				grid.find("tr:eq(1)").find("td:eq(1)").attr("style","text-align:center;vertical-align:middle;");  
			}
			
		}
		
</script>
