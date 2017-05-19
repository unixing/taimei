<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
var ColorA = "#e3170d";
var ColorB = "#228b22";
// 颜色#FF00FF格式转为Array(255,0,255)
function color2rgb(color) {   
	var r = parseInt(color.substr(1, 2), 16);
	var g = parseInt(color.substr(3, 2), 16);
	var b = parseInt(color.substr(5, 2), 16); 
	return new Array(r, g, b);
}  
// 颜色Array(255,0,255)格式转为#FF00FF
function rgb2color(rgb) {
	var s = "#";
	for (var i = 0; i < 3; i++)  {
		var c = Math.round(rgb[i]).toString(16);
		if (c.length == 1) 
			c = '0' + c;   s += c; 
	}
	return s.toUpperCase();
}

function inputBorder(){
	$(":input:text[readonly]").css({"border":"none"});
}

// 生成渐变 
function gradient(value,max,min) {
	var result = "";
	var Step = max - min - 1;
	var Gradient = new Array(3);
	var A = color2rgb(ColorA);
	var B = color2rgb(ColorB);
	if(value<=min){
		result += "<td style='background-color:" + rgb2color(A) + "'>" + value + "</td>";
	}else if(value>=max){
		result += "<td style='background-color:" + rgb2color(B) + "'>" + value + "</td>";
	}else{
		for (var c = 0; c < 3; c++)// RGB通道分别进行计算   
		{
			Gradient[c] = A[c] + (B[c]-A[c]) / Step * (value-min);
		}
		result += "<td style='background-color:" + rgb2color(Gradient) + "'>" + value + "</td>";
	}
	return result;
}
var getDivideParameter = function(){
	var searchJson = getParameter();
	if(searchJson.lcl_Dpt_Day == ""||searchJson.lcl_Dpt_Day == "请选择月份"){
		alert('请选择月份');
		return;
	}
	if(searchJson.dpt_AirPt_Cd == ""||searchJson.dpt_AirPt_Cd == "请选择机场"){
		alert('请选择始发地');
		return;
	}
	if(searchJson.arrv_Airpt_Cd == ""||searchJson.arrv_Airpt_Cd == "请选择机场"){
		alert('请选择到达地');
		return;
	}
	$.ajax({
	       type:'post',
	       url:'${pageContext.request.contextPath}/getMonthData?type='+1,//请求数据的地址	
	       data:searchJson,
	       success:function(data){
	          if(data!=null && data.list != null&& data.list.length>0){
	        	  var list = data.list;
        		  $("#slackandbusy").empty();
        		  for(var i=0;i<list.length;i++){
    	        	  var operation = "";
        			 if(list[i].type==1){
        				 operation += '<form id="slackandbusyform'+(i+1)+'">';
            			 //设置隐藏参数
            			 operation += '<input type="hidden" id="seasonId" name="seasonId" value="'+list[i].seasonId+'"/><input type="hidden" name="dpt_Airpt_Cd" value="'+list[i].dpt_AirPt_Cd+'" /><input type="hidden" name="arrv_Airpt_Cd" value="'+list[i].arrv_Airpt_Cd+'"/><input type="hidden" id="flt_Rte_Cd'+(i+1)+'" name="flt_Rte_Cd" value="'+list[i].flt_Rte_Cd+'"/><input type="hidden" value="'+list[i].lcl_Dpt_Day+'" name="lcl_Dpt_Day"/><input name="flt_nbr" value="'+list[i].flt_nbr+'" type="hidden"/>';
            			 operation += '<table class="table table-hover table-striped divideTable" style="width:100%;">';
            			 operation += '<tr><th colspan="14"><h4><b>'+searchJson.lcl_Dpt_Day+' '+(i!=2?searchJson.dpt_AirPt_Cd:searchJson.pas_stp)+' = '+(i!=1?searchJson.arrv_Airpt_Cd:searchJson.pas_stp)+' 月度淡旺季划分</b></h4></th></tr>';
            			 operation += '<tr><td colspan="2">'+(parseInt((searchJson.lcl_Dpt_Day).substring(0,4))-1)+'年度淡旺季划分</td><td colspan="12"><input type="text" readonly="readonly" name="description" id="description'+(i+1)+'" style="width:90%" value="旺季：春运（腊月6-正月25） 、暑运（7初至9月初，高峰期7月上旬及 8 月下旬）、十一黄金周及各航段特殊的节日、较好的 DOW。淡季：4月、5月、6月、9月"/></td></tr>';
            			 operation += '<tr><td>本月天数</td><td><input type="text" name="monthDays" value="'+list[i].monthDays+'"/></td><td>同比运力/日</td><td><input type="text" readonly="readonly" id="yoy_Trans'+(i+1)+'" name="yoy_Trans" value="'+list[i].yoyTrans+'"/></td><td>环比运力/日</td><td><input type="text" readonly="readonly" name="qoq_Trans" id="qoq_Trans'+(i+1)+'" value="'+list[i].qoqTrans+'"/></td><td>本月运力/日</td><td colspan="7"><input type="text" style="width:430px" name="cur_Trans" id="cur_Trans'+(i+1)+'" value="'+list[i].currTrans+'"/></td></tr>';
            			 operation += '<tr><th colspan="2">同比客量均值[参考]'+(parseInt(list[i].toAvgTraveller)==0?"<br/><input name='refFlt' id='start"+(i+1)+"' placeholder='请选择机场'/>=<input name='refFlt' id='end"+(i+1)+"' placeholder='请选择机场' onblur='changeAddr("+(i+1)+")'/>":"")+'</th><th colspan="4">偏离均值幅度</th><th colspan="4">偏离值</th><th colspan="4">划分点</th></tr>';
            			 operation += '<tr><td style="vertical-align: middle;" rowspan="2">'+list[i].toFlt+'</td><td style="vertical-align: middle;" rowspan="2">'+list[i].backFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].toFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].backFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].toFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].backFlt+'</td><td colspan="2">'+list[i].toFlt+'</td><td colspan="2">'+list[i].backFlt+'</td></tr>';
            			 operation += '<tr><td>正向</td><td>负向</td><td>正向</td><td>负向</td><td>正向</td><td>负向</td><td>正向</td><td>负向</td><td>淡季（＜）</td><td>旺季（＞）</td><td>淡季（＜）</td><td>旺季（＞）</td></tr>';
            			 operation += '<tr><td style="width:9%;"><input type="text" value="'+list[i].toAvgTraveller+'" readonly="readonly" name="toAvgTraveller" id="toAvgTraveller'+(i+1)+'"/></td><td style="width:9%;"><input type="text" value="'+list[i].backAvgTraveller+'" readonly="readonly" name="backAvgTraveller" id="backAvgTraveller'+(i+1)+'"/></td><td style="width:9%;"><input type="text" id="toForwardOffsetRan'+(i+1)+'" name="toForwardOffsetRan" value="'+(parseFloat(list[i].toForwardOffset)/parseFloat(list[i].toAvgTraveller)).toFixed(2)+'" readonly="readonly"/></td><td style="width:9%;"><input type="text" readonly="readonly" id="toReverseOffsetRan'+(i+1)+'" name="toReverseOffsetRan" value="'+(parseFloat(list[i].toReverseOffset)/parseFloat(list[i].toAvgTraveller)).toFixed(2)+'"/></td><td style="width:9%;"><input type="text" id="backForwardOffsetRan'+(i+1)+'" name="backForwardOffsetRan" readonly="readonly" value="'+(parseFloat(list[i].backForwardOffset)/parseFloat(list[i].backAvgTraveller)).toFixed(2)+'"/></td><td style="width:9%;"><input type="text" id="backReverseOffsetRan'+(i+1)+'" name="backReverseOffsetRan" value="'+(parseFloat(list[i].backReverseOffset)/parseFloat(list[i].backAvgTraveller)).toFixed(2)+'" readonly="readonly"/></td><td style="width:9%;"><input readonly="readonly" id="toForwardOffset'+(i+1)+'" name="toForwardOffset" value="'+list[i].toForwardOffset+'"/></td><td style="width:9%;"><input readonly="readonly" id="toReverseOffset'+(i+1)+'" name="toReverseOffset" value="'+list[i].toReverseOffset+'"/></td><td style="width:9%;"><input readonly="readonly" id="backForwardOffset'+(i+1)+'" name="backForwardOffset" value="'+list[i].backForwardOffset+'"/></td><td style="width:9%;"><input readonly="readonly" id="backReverseOffset'+(i+1)+'" name="backReverseOffset" value="'+list[i].backReverseOffset+'"/></td><td style="width:9%;"><input style="color:#e3170d" readonly="readonly" id="toDiviMin'+(i+1)+'" value="'+(parseFloat(list[i].toAvgTraveller)-parseFloat(list[i].toReverseOffset)).toFixed(0)+'"/></td><td style="width:9%;"><input style="color:#228b22;" readonly="readonly" id="toDiviMax'+(i+1)+'" value="'+(parseFloat(list[i].toAvgTraveller)+parseFloat(list[i].toForwardOffset)).toFixed(0)+'"/></td><td style="width:9%;"><input style="style="color:#e3170d" readonly="readonly" id="backDiviMin'+(i+1)+'" value="'+(parseFloat(list[i].backAvgTraveller)-parseFloat(list[i].backReverseOffset)).toFixed(0)+'"/></td><td style="width:9%;"><input style="color:#228b22;" readonly="readonly" id="backDiviMax'+(i+1)+'" value="'+(parseFloat(list[i].backAvgTraveller)+parseFloat(list[i].backForwardOffset)).toFixed(0)+'"/></td></tr>';
            			 operation += '</table>';
            			 operation += '<div style="width:100%;height:300px;margin-top:20px; padding:0px;">';
            			 operation += '<table class="table table-hover table-striped goTable" id="goTable'+(i+1)+'" style="width:30%; float:left;">';
            			 if(list[i].goTimeList!=null&&list[i].goTimeList.length>0){
            				 var goTimeList = list[i].goTimeList;
            				 operation += '<tr><th style="vertical-align: middle;" rowspan="4">'+list[i].toFlt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(searchJson.lcl_Dpt_Day.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
     						 for(var j=0;j<goTimeList.length;j++){
     							operation += '<tr><td><input type="hidden" value="'+goTimeList[j].divideId+'"><input value="'+goTimeList[j].startDate+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+goTimeList[j].endDate+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+goTimeList[j].refSaleStartDate+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+goTimeList[j].refSaleEndDate+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature" value="'+goTimeList[j].nature+'"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(i+1)+',1,this)">删除</button></td></tr>';
     						 }
     						operation += '</table><button id="goAddRowBtn'+(i+1)+'" style="float:left;position:relative; left: -46px; top:'+(46+(39*goTimeList.length))+'px;" type="button" class="btn btn-xs btn-link" onclick="addRow('+(i+1)+',1)">添加</button>';
            			 }else{
            				 operation += getDiviMonthTable(i+1,searchJson.lcl_Dpt_Day,1,list[i].toFlt);
            				 operation += '</table><button id="goAddRowBtn'+(i+1)+'" style="float:left;position:relative; left: -46px; top:85px;" type="button" class="btn btn-xs btn-link" onclick="addRow('+(i+1)+',1)">添加</button>';
            			 }
            			 /* operation += '<tr><th style="vertical-align: middle;" rowspan="3">'+list[i].toFlt+'</th><th rowspan="2">开始日期</th><th rowspan="2">结束日期</th><th rowspan="2" colspan="2">'+(parseInt(searchJson.lcl_Dpt_Day.substring(0,4))-1)+'年对应销售日期</th><th rowspan="2">性质</th></tr>';
            			 operation += '<tr></tr>';
            			 operation += '<tr><td><input name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
            			 //operation += getDiviMonthTable(searchJson.lcl_Dpt_Day,1,list[i].toFlt);
            			 //operation += '</table><a type="button" style="width:60px;height:30px;float:left;" class="btn btn-success" onclick="addRow(\'goTable'+(i+1)+'\',1)">添加</a>';
            			 operation += '<table class="table table-hover table-striped returnTable" id="returnTable'+(i+1)+'" style="width:30%; margin-left:20px; float:left">';
            			 /* operation += '<tr><th style="vertical-align: middle;" rowspan="3">'+list[i].backFlt+'</th><th rowspan="2">开始日期</th><th rowspan="2">结束日期</th><th rowspan="2" colspan="2">'+(parseInt(searchJson.lcl_Dpt_Day.substring(0,4))-1)+'年对应销售日期</th><th rowspan="2">性质</th></tr>';
            			 operation += '<tr></tr>';
            			 operation += '<tr><td><input name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
            			 if(list[i].backTimeList!=null&&list[i].backTimeList.length>0){
            				 var backTimeList = list[i].backTimeList;
            				 operation += '<tr><th style="vertical-align: middle;" rowspan="4">'+list[i].backFlt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(searchJson.lcl_Dpt_Day.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
     						 for(var j=0;j<backTimeList.length;j++){
     							operation += '<tr><input type="hidden" value="'+backTimeList[j].divideId+'"/><td><input value="'+backTimeList[j].startDate+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+backTimeList[j].endDate+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+backTimeList[j].refSaleStartDate+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+backTimeList[j].refSaleEndDate+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature" value="'+backTimeList[j].nature+'"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(i+1)+',2,this)">删除</button></td></tr>';
     						 }
     						operation += '</table><button id="backAddRowBtn'+(i+1)+'" style="position:relative;left: -46px; top:'+(46+(39*backTimeList.length))+'px;" type="button" class="btn btn-xs btn-link" onclick="addRow('+(i+1)+',2)">添加</button>';
            			 }else{
	            			 operation += getDiviMonthTable(i+1,searchJson.lcl_Dpt_Day,2,list[i].backFlt);
	            			 operation += '</table><button id="backAddRowBtn'+(i+1)+'" style="position:relative;left: -46px; top:85px;" type="button" class="btn btn-xs btn-link" onclick="addRow('+(i+1)+',2)">添加</button>';
            			 }
            			 //operation += '</table><a type="button" style="width:60px;height:30px" class="btn btn-success" onclick="addRow(\'returnTable'+(i+1)+'\',2)">添加</a>';
            			 operation += '<div style="width:100%; float:left;height:30px;text-align:center;margin:10px auto;"><a class="btn btn-success" style="30px;" onclick="saveMonthParameters(\''+("slackandbusyform"+(i+1))+'\','+(i+1)+')">保存</a></div></div></form>';
            			 $("#slackandbusy").append(operation);
            			 $('#slackandbusyform'+(i+1)).append(getMonthData(list[i]));
        			 }else{
        				 operation += '<form id="slackandbusyform'+(i+1)+'">';
            			 //设置隐藏参数
            			 operation += '<input type="hidden" name="dpt_Airpt_Cd" value="'+list[i].dpt_AirPt_Cd+'" /><input type="hidden" name="arrv_Airpt_Cd" value="'+list[i].arrv_Airpt_Cd+'"/><input type="hidden" id="flt_Rte_Cd'+(i+1)+'" name="flt_Rte_Cd" value="'+list[i].flt_Rte_Cd+'"/><input type="hidden" value="'+list[i].lcl_Dpt_Day+'" name="lcl_Dpt_Day"/><input name="flt_nbr" value="'+list[i].flt_nbr+'" type="hidden"/>';
            			 operation += '<table class="table table-hover table-striped divideTable" style="width:100%;">';
            			 operation += '<tr><th colspan="14"><h4><b>'+searchJson.lcl_Dpt_Day+' '+(i!=2?searchJson.dpt_AirPt_Cd:searchJson.pas_stp)+' = '+(i!=1?searchJson.arrv_Airpt_Cd:searchJson.pas_stp)+' 月度淡旺季划分</b></h4></th></tr>';
            			 operation += '<tr><td colspan="2">'+(parseInt((searchJson.lcl_Dpt_Day).substring(0,4))-1)+'年度淡旺季划分</td><td colspan="12"><input type="text" readonly="readonly" name="description" id="description'+(i+1)+'" style="width:90%" value="旺季：春运（腊月6-正月25） 、暑运（7初至9月初，高峰期7月上旬及 8 月下旬）、十一黄金周及各航段特殊的节日、较好的 DOW。淡季：4月、5月、6月、9月"/></td></tr>';
            			 operation += '<tr><td>本月天数</td><td><input type="text" name="monthDays" value="'+list[i].monthDays+'"/></td><td>同比运力/日</td><td><input type="text" readonly="readonly" id="yoy_Trans'+(i+1)+'" name="yoy_Trans" value="'+(parseFloat(parseInt(list[i].yoyFlightCount)).toFixed(2)/parseFloat(parseInt(list[i].monthDays)).toFixed(2)).toFixed(2)+'"/></td><td>环比运力/日</td><td><input type="text" readonly="readonly" name="qoq_Trans" id="qoq_Trans'+(i+1)+'" value="'+(parseFloat(list[i].qoqFlightCount).toFixed(2)/parseFloat(list[i].monthDays).toFixed(2)).toFixed(2)+'"/></td><td>本月运力/日</td><td colspan="7"><input type="text" style="width:430px" name="cur_Trans" id="cur_Trans'+(i+1)+'"/></td></tr>';
            			 operation += '<tr><th colspan="2">同比客量均值[参考]'+(parseInt(list[i].toAvgTraveller)==0?"<br/><input name='refFlt' id='start"+(i+1)+"' placeholder='请选择机场'/>=<input name='refFlt' id='end"+(i+1)+"' placeholder='请选择机场' onblur='changeAddr("+(i+1)+")'/>":"")+'</th><th colspan="4">偏离均值幅度</th><th colspan="4">偏离值</th><th colspan="4">划分点</th></tr>';
            			 operation += '<tr><td style="vertical-align: middle;" rowspan="2">'+list[i].toFlt+'</td><td style="vertical-align: middle;" rowspan="2">'+list[i].backFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].toFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].backFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].toFlt+'</td><td style="vertical-align: middle;" colspan="2">'+list[i].backFlt+'</td><td colspan="2">'+list[i].toFlt+'</td><td colspan="2">'+list[i].backFlt+'</td></tr>';
            			 operation += '<tr><td>正向</td><td>负向</td><td>正向</td><td>负向</td><td>正向</td><td>负向</td><td>正向</td><td>负向</td><td>淡季（＜）</td><td>旺季（＞）</td><td>淡季（＜）</td><td>旺季（＞）</td></tr>';
            			 operation += '<tr><td style="width:9%;"><input type="text" value="'+list[i].toAvgTraveller+'" readonly="readonly" name="toAvgTraveller" id="toAvgTraveller'+(i+1)+'"/></td><td style="width:9%;"><input type="text" value="'+list[i].backAvgTraveller+'" readonly="readonly" name="backAvgTraveller" id="backAvgTraveller'+(i+1)+'"/></td><td style="width:9%;"><input type="text" id="toForwardOffsetRan'+(i+1)+'" readonly="readonly" name="toForwardOffsetRan" value="'+(parseInt(list[i].toAvgTraveller)==0?0:(parseFloat(list[i].toForwardOffset)/parseFloat(list[i].toAvgTraveller)).toFixed(2))+'"/></td><td style="width:9%;"><input type="text" readonly="readonly" id="toReverseOffsetRan'+(i+1)+'" name="toReverseOffsetRan" value="'+(parseInt(list[i].toAvgTraveller)==0?0:(parseFloat(list[i].toReverseOffset)/parseFloat(list[i].toAvgTraveller)).toFixed(2))+'"/></td><td style="width:9%;"><input type="text" readonly="readonly" id="backForwardOffsetRan'+(i+1)+'" name="backForwardOffsetRan" value="'+(parseInt(list[i].backAvgTraveller)==0?0:(parseFloat(list[i].backForwardOffset)/parseFloat(list[i].backAvgTraveller)).toFixed(2))+'"/></td><td style="width:9%;"><input type="text" readonly="readonly" id="backReverseOffsetRan'+(i+1)+'" name="backReverseOffsetRan" value="'+(parseInt(list[i].backAvgTraveller)==0?0:(parseFloat(list[i].backReverseOffset)/parseFloat(list[i].backAvgTraveller)).toFixed(2))+'"/></td><td style="width:9%;"><input readonly="readonly" id="toForwardOffset'+(i+1)+'" name="toForwardOffset" value="'+list[i].toForwardOffset+'"/></td><td style="width:9%;"><input readonly="readonly" id="toReverseOffset'+(i+1)+'" name="toReverseOffset" value="'+list[i].toReverseOffset+'"/></td><td style="width:9%;"><input readonly="readonly" id="backForwardOffset'+(i+1)+'" name="backForwardOffset" value="'+list[i].backForwardOffset+'"/></td><td style="width:9%;"><input readonly="readonly" id="backReverseOffset'+(i+1)+'" name="backReverseOffset" value="'+list[i].backReverseOffset+'"/></td><td style="width:9%;"><input style="color:#e3170d;" readonly="readonly" id="toDiviMin'+(i+1)+'" value="'+(parseFloat(list[i].toAvgTraveller)-parseFloat(list[i].toReverseOffset)).toFixed(2)+'"/></td><td style="width:9%;"><input style="color:#228b22;" readonly="readonly" id="toDiviMax'+(i+1)+'" value="'+(parseFloat(list[i].toForwardOffset)+parseFloat(list[i].toAvgTraveller)).toFixed(2)+'"/></td><td style="width:9%;"><input style="color:#e3170d;" readonly="readonly" id="backDiviMin'+(i+1)+'" value="'+(parseFloat(list[i].backAvgTraveller)-parseFloat(list[i].backReverseOffset)).toFixed(2)+'"/></td><td style="width:9%;"><input style="color:#228b22;" readonly="readonly" id="backDiviMax'+(i+1)+'" value="'+(parseFloat(list[i].backForwardOffset)+parseFloat(list[i].backAvgTraveller)).toFixed(2)+'"/></td></tr>';
            			 operation += '</table>';
            			 operation += '<div style="width:100%;height:300px;margin-top:20px; padding:0px;">';
            			 operation += '<table class="table table-hover table-striped goTable" id="goTable'+(i+1)+'" style="width:30%; float:left;">';
            			 /* operation += '<tr><th style="vertical-align: middle;" rowspan="3">'+list[i].toFlt+'</th><th rowspan="2">开始日期</th><th rowspan="2">结束日期</th><th rowspan="2" colspan="2">'+(parseInt(searchJson.lcl_Dpt_Day.substring(0,4))-1)+'年对应销售日期</th><th rowspan="2">性质</th></tr>';
            			 operation += '<tr></tr>';
            			 operation += '<tr><td><input name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
            			 operation += getDiviMonthTable(i+1,searchJson.lcl_Dpt_Day,1,list[i].toFlt);
            			 //operation += '</table><a type="button" style="width:60px;height:30px;float:left;" class="btn btn-success" onclick="addRow(\'goTable'+(i+1)+'\',1)">添加</a>';
            			 operation += '</table><button id="goAddRowBtn'+(i+1)+'" style="float:left;position:relative;left: -46px; top:85px;" type="button" class="btn btn-xs btn-link" onclick="addRow('+(i+1)+',1)">添加</button>';
            			 operation += '<table class="table table-hover table-striped returnTable" id="returnTable'+(i+1)+'" style="width:30%; margin-left:20px; float:left">';
            			 /* operation += '<tr><th style="vertical-align: middle;" rowspan="3">'+list[i].backFlt+'</th><th rowspan="2">开始日期</th><th rowspan="2">结束日期</th><th rowspan="2" colspan="2">'+(parseInt(searchJson.lcl_Dpt_Day.substring(0,4))-1)+'年对应销售日期</th><th rowspan="2">性质</th></tr>';
            			 operation += '<tr></tr>';
            			 operation += '<tr><td><input name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
            			 operation += getDiviMonthTable(i+1,searchJson.lcl_Dpt_Day,2,list[i].backFlt);
            			 //operation += '</table><a type="button" style="width:60px;height:30px" class="btn btn-success" onclick="addRow(\'returnTable'+(i+1)+'\',2)">添加</a>';
            			 operation += '</table><button id="backAddRowBtn'+(i+1)+'" style="position:relative; left: -46px; top:85px;" type="button" class="btn btn-xs btn-link" onclick="addRow('+(i+1)+',2)">添加</button>';
            			 operation += '<div style="width:100%; float:left;height:30px;text-align:center;margin:10px auto;"><a class="btn btn-success" style="30px;" onclick="saveMonthParameters(\''+("slackandbusyform"+(i+1))+'\','+(i+1)+')">保存</a></div></div></form>';
						 $("#slackandbusy").append(operation);
            			 $('#slackandbusyform'+(i+1)).append(getMonthData(list[i]));
        			 }
        			 init(i+1);
        		  }
        		  inputBorder();//去掉input边框
	          }else{
	        	  alert("没有查询到数据");
	          }
	    }
	});
};

function getDiviMonthTable(index,monthStr,type,flt){
	var option = '';
	if(monthStr!=null&&monthStr!=""){
		var strs = monthStr.split('-');
		var months = strs[1];
		var month = parseInt(strs[1]);
		var year = parseInt(strs[0]);
		if((year%4==0&&year%100!=0)||year%400==0){
			switch(month){
				case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
					if(type==1){
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
					}else{
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
					}
					break;
				};
				case 4:case 6:case 9:case 11:{
					if(type==1){
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
					}else{
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
					}
					break;
				};
				case 2:{
					if(type==1){
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-29')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-28')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-29')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-28')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
					}else{
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-29')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-28')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-29')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-28')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
					}
					break;
				};
			}
		}else{
			switch(month){
				case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
					if(type==1){
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
					}else{
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-31')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-31')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
					}
					break;
				};
				case 4:case 6:case 9:case 11:{
					if(type==1){
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>'; */
					}else{
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						/* option += '<tr><td><input value="'+(monthStr+'-11')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						option += '<tr><td><input value="'+(monthStr+'-21')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-30')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-21')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-30')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>'; */
					}
					break;
				};
				case 2:{
					if(type==1){
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						//option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-10')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-10')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						//option += '<tr><td><input value="'+(monthStr+'-11')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td></tr>';
						if((year-1)%4==0&&(year-1)%100==0&&(year-1)%400==0){
							option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-28')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-29')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						}else{
							option += '<tr><td><input value="'+(monthStr+'-01')+'" name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-28')+'" name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-28')+'" name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						}
					}else{
						option += '<tr><th style="vertical-align: middle;" rowspan="4">'+flt+'</th><th>开始日期</th><th>结束日期</th><th colspan="2">'+(parseInt(monthStr.substring(0,4))-1)+'年对应销售日期</th><th>性质</th><th>操作</th></tr>';
						//option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-10')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-10')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						//option += '<tr><td><input value="'+(monthStr+'-11')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-20')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-11')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-20')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td></tr>';
						if((year-1)%4==0&&(year-1)%100==0&&(year-1)%400==0){
							option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-28')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-29')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',1,this)">删除</button></td></tr>';
						}else{
							option += '<tr><td><input value="'+(monthStr+'-01')+'" name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+(monthStr+'-28')+'" name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-01')+'" name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input value="'+((year-1)+'-'+months+'-28')+'" name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+(index)+',2,this)">删除</button></td></tr>';
						}
					}
					break;
				};
			}
		}
	}
	return option;
}

function getMonthData(list){
	var operation = '';
	var toYoyData = list.toyoyList;
	var toDiviMin = parseInt((parseFloat(list.toAvgTraveller)-parseFloat(list.toReverseOffset)));
	var toDiviMax = parseInt(parseFloat(list.toAvgTraveller)+parseFloat(list.toForwardOffset));
	var backDiviMin = parseInt(parseFloat(list.backAvgTraveller)-parseFloat(list.backReverseOffset));
	var backDiviMax = parseInt(parseFloat(list.backAvgTraveller)+parseFloat(list.backForwardOffset));
	operation += '<div style="width:90%;height:1300px;" class="monthTableData">';
	operation += '<table class="table table-hover table-striped toYoyTable" style="width:15%; float:left;">';
	operation += '<tr><td rowspan="2">'+list.toFlt+'</td><td rowspan="2">同比</td></tr>';	
	operation += '<tr></tr>';
	operation += '<tr><td>日期</td><td>日客流量</td></tr>';
	if(toYoyData!=null && toYoyData.length>0){
	 for(var j=0;j<toYoyData.length;j++){
	  //operation += '<tr><td>'+toYoyData[j].lcl_Dpt_Day+'</td><td>'+toYoyData[j].pgs_Per_Cls+'</td></tr>';
	  operation += '<tr><td>'+toYoyData[j].lcl_Dpt_Day+'</td>'+gradient(toYoyData[j].pgs_Per_Cls,toDiviMax,toDiviMin)+'</tr>';
	 }
	}else{
	 operation += '<tr><td colspan="2">没有相应数据</td>';
	}
	operation += '</table>';
	var toQoqData = list.toqoqList;
	operation += '<table class="table table-hover table-striped toYoyTable" style="width:15%;margin-left:10%; float:left;">';
	operation += '<tr><td rowspan="2">'+list.toFlt+'</td><td rowspan="2">环比</td></tr>';
	operation += '<tr></tr>';
	operation += '<tr><td>日期</td><td>日客流量</td></tr>';
	if(toQoqData!=null && toQoqData.length>0){
	 for(var j=0;j<toQoqData.length;j++){
	  //operation += '<tr><td>'+toQoqData[j].lcl_Dpt_Day+'</td><td>'+toQoqData[j].pgs_Per_Cls+'</td></tr>';
	  operation += '<tr><td>'+toQoqData[j].lcl_Dpt_Day+'</td>'+gradient(toQoqData[j].pgs_Per_Cls,toDiviMax,toDiviMin)+'</tr>';
	 }
	}else{
	 operation += '<tr><td colspan="2">没有相应数据</td>';
	}
	operation += '</table>';
	var backYoyData = list.backyoyList;
	operation += '<table class="table table-hover table-striped toQoqTable" style="width:15%;margin-left:10%; float:left;">';
	operation += '<tr><td rowspan="2">'+list.backFlt+'</td><td rowspan="2">同比</td></tr>';	
	operation += '<tr></tr>';
	operation += '<tr><td>日期</td><td>日客流量</td></tr>';
	if(backYoyData!=null && backYoyData.length>0){
	 for(var j=0;j<backYoyData.length;j++){
	  //operation += '<tr><td>'+backYoyData[j].lcl_Dpt_Day+'</td><td>'+backYoyData[j].pgs_Per_Cls+'</td></tr>';
	  operation += '<tr><td>'+backYoyData[j].lcl_Dpt_Day+'</td>'+gradient(backYoyData[j].pgs_Per_Cls,backDiviMax,backDiviMin)+'</tr>';
	 }
	}else{
	 operation += '<tr><td colspan="2">没有相应数据</td>';
	}
	operation += '</table>';
	var backQoqData = list.backqoqList;
	operation += '<table class="table table-hover table-striped toQoqTable" style="width:15%;margin-left:10%; float:left;">';
	operation += '<tr><td rowspan="2">'+list.backFlt+'</td><td rowspan="2">环比</td></tr>';	
	operation += '<tr></tr>';
	operation += '<tr><td>日期</td><td>日客流量</td></tr>';
	if(backQoqData!=null && backQoqData.length>0){
	 for(var j=0;j<backQoqData.length;j++){
	  //operation += '<tr><td>'+backQoqData[j].lcl_Dpt_Day+'</td><td>'+backQoqData[j].pgs_Per_Cls+'</td></tr>';
	  operation += '<tr><td>'+backQoqData[j].lcl_Dpt_Day+'</td>'+gradient(backQoqData[j].pgs_Per_Cls,backDiviMax,backDiviMin)+'</tr>';
	 }
	}else{
	 operation += '<tr><td colspan="2">没有相应数据</td>';
	}
	operation += '</table></div>';
	return operation;
}
function setInitParam(id,dpt_cd,arr_cd,_index){
	getDiviParam(_index);
	getMonthData(id,dpt_cd,arr_cd,_index);
}
function getDiviParam(_index){
	var toAvgTraveller = parseInt($('#toAvgTraveller'+_index).val());
	var backAvgTraveller = parseInt($('#backAvgTraveller'+_index).val());
	if($('#toOffsetRan'+_index).val()==""){
		return;
	}
	if($('#backOffsetRan'+_index).val()==""){
		return;
	}
	var toOffsetRan = parseFloat($('#toOffsetRan'+_index).val()).toFixed(2)/100;
	var backOffsetRan = parseFloat($('#backOffsetRan'+_index).val()).toFixed(2)/100;
	var toOffset = Math.round(toAvgTraveller*toOffsetRan);
	var backOffset = Math.round(backAvgTraveller*backOffsetRan);
	$('#toOffset'+_index).val(toOffset);
	$('#backOffset'+_index).val(backOffset);
	$('#toDiviMin'+_index).val(toAvgTraveller-toOffset);
	$('#toDiviMax'+_index).val(toAvgTraveller+toOffset);
	$('#backDiviMin'+_index).val(backAvgTraveller-backOffset);
	$('#backDiviMax'+_index).val(backAvgTraveller+backOffset);
}
function saveMonthParameters(id,_index){
	var curTrans = $("#cur_Trans"+_index).val();
	if(curTrans==null||curTrans==''){
		alert('请填写本月运力');
		return;
	}
	var startAddr = $('#start'+_index).val();
	var endAddr = $('#end'+_index).val();
	var query = '';
	if(typeof(startAddr)!='undefined'&&startAddr!=null&&startAddr!=''&&typeof(endAddr)!='undefined'&&endAddr!=null&&endAddr!=''){
		query = $('#'+id).serialize()+"&refFlt:"+startAddr+"/"+endAddr;
		alert(query);
	}else{
		query = $('#'+id).serialize();
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/saveMonthParam',
		data:query,
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.result);
				if(data.opResult=='0'){
					$('#'+id).hide();
				}
			}else{
				alert('服务器繁忙，请稍后再试。');
			}
		}
	});
}
function addRow(index,type){
	var operation = '';
	if(type==1){
		operation += '<tr><td><input name="startDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="endDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="saleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="saleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="nature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+index+',1,this)">删除</button></td></tr>';
		$('#goTable'+index).find('th')[0].setAttribute("rowspan",$('#goTable'+index).find('th')[0].getAttribute("rowspan")+1);
		$('#goTable'+index).append(operation);
		$('#goAddRowBtn'+index).css('top',(parseInt($('#goAddRowBtn'+index).css('top').substring(0,$('#goAddRowBtn'+index).css('top').length-2))+39)+'px');
	}else{
		operation += '<tr><td><input name="returnStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnEndDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnSaleStartDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input name="returnSaleEndDate"onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd\'})"/></td><td><input type="text" name="returnNature"/></td><td><button type="button" class="btn btn-xs btn-link" onclick="deleteRow('+index+',2,this)">删除</button></td></tr>';
		$('#returnTable'+index).find('th')[0].setAttribute("rowspan",$('#returnTable'+index).find('th')[0].getAttribute("rowspan")+1);
		$('#returnTable'+index).append(operation);
		$('#backAddRowBtn'+index).css('top',(parseInt($('#backAddRowBtn'+index).css('top').substring(0,$('#backAddRowBtn'+index).css('top').length-2))+39)+'px');
	}
	
}

function deleteRow(index,type,r){
	var i=r.parentNode.parentNode.rowIndex;
	if(type==1){
		//$('#goTable'+index).deleteRow(i);
		document.getElementById('goTable'+index).deleteRow(i);
		$('#goAddRowBtn'+index).css('top',(parseInt($('#goAddRowBtn'+index).css('top').substring(0,$('#goAddRowBtn'+index).css('top').length-2))-39)+'px');
	}else{
		//$('#returnTable'+index).deleteRow(i);
		document.getElementById('returnTable'+index).deleteRow(i);
		$('#backAddRowBtn'+index).css('top',(parseInt($('#backAddRowBtn'+index).css('top').substring(0,$('#backAddRowBtn'+index).css('top').length-2))-39)+'px');
	}
    
}

function changeAddr(_index){
	var searchJson = getParameter();
	var dpt_AirPt_Cd = $('#start'+_index).val();
	var arrv_Airpt_Cd = $('#end'+_index).val();
	if(dpt_AirPt_Cd==null||dpt_AirPt_Cd==''){
		return;
	}
	if(arrv_Airpt_Cd==null||arrv_Airpt_Cd==''){
		return;
	}
	searchJson.dpt_AirPt_Cd = dpt_AirPt_Cd;
	searchJson.arrv_Airpt_Cd = arrv_Airpt_Cd;
	$.ajax({
		url:'${pageContext.request.contextPath}/getMonthData?type='+1,
		data:searchJson,
		type:'post',
		success:function(data){
			if(data!=null){
				$('#toAvgTraveller'+_index).val(data.list[0].toAvgTraveller);
				$('#backAvgTraveller'+_index).val(data.list[0].backAvgTraveller);
				$('#yoy_Trans'+_index).val((parseFloat(parseInt(data.list[0].yoyFlightCount)).toFixed(2)/parseFloat(parseInt(data.list[0].monthDays)).toFixed(2)).toFixed(2));
				$('#qoq_Trans'+_index).val((parseFloat(data.list[0].qoqFlightCount).toFixed(2)/parseFloat(data.list[0].monthDays).toFixed(2)).toFixed(2));
			}else{
				alert(data.message);
			}
		}
	});
}

function init(_index){
	var cityPicker = new HzwCityPicker({
		data: data,
		target: 'start'+_index,
		valType: 'k-v',
		hideCityInput: {
		},
		callback: function(){
			
		}
	});
	cityPicker.init();
	var cityPicker2 = new HzwCityPicker({
		data: data,
		target: 'end'+_index,
		valType: 'k-v',
		hideCityInput: {
		},
		callback: function(){
			changeAddr(_index);
		}
	});
	cityPicker2.init();
}
</script>