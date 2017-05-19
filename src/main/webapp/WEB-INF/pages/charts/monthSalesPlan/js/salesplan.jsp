<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
var getMonthSalesPlanParam = function(){
	var searchJson = getParameter();
	if(searchJson.lclDptDay == ""||searchJson.lclDptDay == "请选择月份"){
		alert('请选择月份');
		return;
	}
	if(searchJson.dptAirPtCd == ""||searchJson.dptAirPtCd == "请选择机场"){
		alert('请选择始发地');
		return;
	}
	if(searchJson.arrvAirptCd == ""||searchJson.arrvAirptCd == "请选择机场"){
		alert('请选择到达地');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/monthSalesPlanParam',
		data:searchJson,
		type:'post',
		success:function(data){
		  if(data!=null){
			  if(data.opResult!=1){
				  if(data!=null&&data.list!=null&&data.list.length>0){
					  var list = data.list;
					  $("#salesplan").empty();
					  var operation = "";
			  		  if("请选择机场"!= searchJson.passtp&&"" != searchJson.passtp){
			  			  for(var i=0;i<list.length;i++){
			      			 operation += '<form id="saleplanform'+(i+1)+'">';
			      			 //设置隐藏参数
			      			 operation += '<input type="hidden" id="goYb'+(i+1)+'" value="'+list[i].goYb+'" /><input type="hidden" id="returnYb'+(i+1)+'" value="'+list[i].returnYb+'"/><input type="hidden" id="seasonId'+(i+1)+'" value="'+list[i].seasonId+'"/><input type="hidden" id="fltDct'+(i+1)+'" value="'+list[i].goFlt+'"/>';
			      			 operation += '<table class="table table-hover table-striped salePlanTable">';
			      			 operation += '<tr><td rowspan="2">航班号</td><td rowspan="2">航段</td><td rowspan="2">开始日期</td><td rowspan="2">结束日期</td><td rowspan="2" colspan="2">同比对应销售期</td><td rowspan="2">性质</td><td rowspan="2">同比运力变化</td><td colspan="6">同比</td><td rowspan="2">有无协议</td><td colspan="4">散客预分配</td><td colspan="3">团队预分配</td><td colspan="2">航段收入情况</td><td rowspan="2">班次</td><td rowspan="2">每段月收入</td><td rowspan="2">预估每班虚耗位置数量</td><td rowspan="2">虚耗处置方案</td></tr>';
			      			 operation += '<tr><td>每日班次</td><td>客座率（%）</td><td>散客折扣</td><td>均班散客量</td><td>团队折扣</td><td>均班团队量</td><td>数量</td><td>均折</td><td>最低仓位起售</td><td>销售调控周期</td><td>数量</td><td>往返折扣</td><td>销售调控周期</td><td>营运收入</td><td>客量</td></tr>';
			      			 var goTimeList = list[i].goTimeList;
			      			 var goList = list[i].goList;
			      			 var returnTimeList = list[i].returnTimeList;
			      			 var returnList = list[i].returnList;
			      			 if(goList!=null&&goList.length>0&&goTimeList!=null&&goTimeList.length>0){
			      				 for(var j=0;j<goTimeList.length;j++){
			      					 if(goTimeList[j]!=null&&goList[j]!=null){
			      						var monthSalePlan = goTimeList[j].monthSalePlan;
			      						if(j==0){
			      							if(monthSalePlan!=null){
			      								operation += '<tr><input type="hidden" name="id" value="'+monthSalePlan.id+'"/><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td rowspan="'+(goTimeList.length+returnTimeList.length)+'"><select name="fltNbr" id="fltList'+(i+1)+'" onchange="changeFlight(\'saleplanform'+(i+1)+'\','+(i+1)+')">'+$("#flt_nbr_Count").html()+'</select></td><td rowspan="'+goTimeList.length+'"><input readonly="readonly" value="'+list[i].goFlt+'"/></td><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input id="agreement'+(i+1)+(j+1)+'" name="agreement" value="'+monthSalePlan.agreement+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input id="lowestSale'+(i+1)+(j+1)+'" name="lowestSale" value="'+monthSalePlan.lowestSale+'"/></td><td><input id="fITSaleCycle'+(i+1)+(j+1)+'" name="fITSaleCycle" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="discountReturn" onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="frequency'+(i+1)+(j+1)+'" name="frequency"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
			      							}else{
			      								operation += '<tr><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td rowspan="'+(goTimeList.length+returnTimeList.length)+'"><select name="fltNbr" id="fltList'+(i+1)+'" onchange="changeFlight(\'saleplanform'+(i+1)+'\','+(i+1)+')">'+$("#flt_nbr_Count").html()+'</select></td><td rowspan="'+goTimeList.length+'"><input readonly="readonly" value="'+list[i].goFlt+'"/></td><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input id="agreement'+(i+1)+(j+1)+'" name="agreement"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'"/></td><td><input id="lowestSale'+(i+1)+(j+1)+'" name="lowestSale"/></td><td><input id="fITSaleCycle'+(i+1)+(j+1)+'" name="fITSaleCycle" /></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'"/></td><td><input name="discountReturn" onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'"/></td><td><input readonly="readonly" value="0" id="goIncome'+(i+1)+(j+1)+'" /></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="0"/></td><td><input value="'+goList[j].two_Tak_Ppt+'" id="frequency'+(i+1)+(j+1)+'" name="frequency"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="0"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'"/></td></tr>';
			      							}
				      					 }else{
				      						if(monthSalePlan!=null){
				      							operation += '<tr><input type="hidden" name="id" value="'+monthSalePlan.id+'"/><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input name="agreement" id="agreement'+(i+1)+(j+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input id="lowestSale'+(i+1)+(j+1)+'" name="lowestSale" value="'+monthSalePlan.lowestSale+'"/></td><td><input id="fITSaleCycle'+(i+1)+(j+1)+'" name="fITSaleCycle" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="discountReturn"  onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="frequency'+(i+1)+(j+1)+'" name="frequency"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
				      						}else{
				      							operation += '<tr><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input name="agreement" id="agreement'+(i+1)+(j+1)+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'"/></td><td><input id="lowestSale'+(i+1)+(j+1)+'" name="lowestSale"/></td><td><input id="fITSaleCycle'+(i+1)+(j+1)+'" name="fITSaleCycle" /></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'"/></td><td><input name="discountReturn"  onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="0"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="0"/></td><td><input value="'+goList[j].two_Tak_Ppt+'" id="frequency'+(i+1)+(j+1)+'" name="frequency"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="0"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'"/></td></tr>';
				      						}
				      					 }
			      					 }			 
			      				 }
			      			 }
			      			 if(returnList!=null&&returnList.length>0&&returnTimeList!=null&&returnTimeList.length>0){
			      				 for(var k=0;k<returnTimeList.length;k++){
			      					if(returnList[k]!=null&&returnTimeList[k]!=null){
			      						var monthSalePlan = returnTimeList[k].monthSalePlan;
			      						if(k==0){
			      							if(monthSalePlan!=null){
			      								operation += '<tr><input type="hidden" name="rId" value="'+monthSalePlan.id+'"/><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td rowspan="'+returnTimeList.length+'"><input readonly="readonly" value="'+list[i].returnFlt+'"/></td><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'" value="'+monthSalePlan.lowestSale+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
			      							}else{
			      								operation += '<tr><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td rowspan="'+returnTimeList.length+'"><input readonly="readonly" value="'+list[i].returnFlt+'"/></td><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'" /></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="0"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="0"/></td><td><input value="'+returnList[k].two_Tak_Ppt+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="0"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'"/></td></tr>';
			      							}
				      					}else{
				      						if(monthSalePlan!=null){
				      							operation += '<tr><input type="hidden" name="rId" value="'+monthSalePlan.id+'"/><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'" value="'+monthSalePlan.lowestSale+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
				      						}else{
				      							operation += '<tr><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'"/></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="0"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="0"/></td><td><input value="'+returnList[k].two_Tak_Ppt+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="0"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'"/></td></tr>';
				      						}
				      					}
			      					}
			      				 }
			      			 }
			      			 operation += '</table>';
			      			 operation += '<div style="height:30px;text-align:center;margin:10px auto;"><a class="btn btn-success" style="30px;" onclick="saveSalePlanData(\''+("saleplanform"+(i+1))+'\','+(i+1)+')">保存</a><a class="btn btn-success" style="30px;" onclick="deleteSalePlanData('+(i+1)+')">删除</a></div></div></form>';
			      		  }
			  		  }else{
			  			  for(var i=0;i<list.length;i++){
			  				operation += '<form id="saleplanform'+(i+1)+'">';
			     			 //设置隐藏参数
			     			 operation += '<input type="hidden" id="goYb'+(i+1)+'" value="'+list[i].goYb+'" /><input type="hidden" id="returnYb'+(i+1)+'" value="'+list[i].returnYb+'"/><input type="hidden" id="seasonId'+(i+1)+'" value="'+list[i].seasonId+'"/><input type="hidden" id="fltDct'+(i+1)+'" value="'+list[i].goFlt+'"/>';
			     			 operation += '<table class="table table-hover table-striped salePlanTable">';
			     			 operation += '<tr><td rowspan="2">航班号</td><td rowspan="2">航段</td><td rowspan="2">开始日期</td><td rowspan="2">结束日期</td><td rowspan="2" colspan="2">同比对应销售期</td><td rowspan="2">性质</td><td rowspan="2">同比运力变化</td><td colspan="6">同比</td><td rowspan="2">有无协议</td><td colspan="4">散客预分配</td><td colspan="3">团队预分配</td><td colspan="2">航段收入情况</td><td rowspan="2">班次</td><td rowspan="2">每段月收入</td><td rowspan="2">预估每班虚耗位置数量</td><td rowspan="2">虚耗处置方案</td></tr>';
			     			 operation += '<tr><td>每日班次</td><td>客座率（%）</td><td>散客折扣</td><td>均班散客量</td><td>团队折扣</td><td>均班团队量</td><td>数量</td><td>均折</td><td>最低仓位起售</td><td>销售调控周期</td><td>数量</td><td>往返折扣</td><td>销售调控周期</td><td>营运收入</td><td>客量</td></tr>';
			     			 var goTimeList = list[i].goTimeList;
			     			 var goList = list[i].goList;
			     			 var returnTimeList = list[i].returnTimeList;
			     			 var returnList = list[i].returnList;
			     			 if(goList!=null&&goList.length>0&&goTimeList!=null&&goTimeList.length>0){
			     				 for(var j=0;j<goTimeList.length;j++){
			     					if(goTimeList[j]!=null&&goList[j]!=null){
			     						var monthSalePlan = goTimeList[j].monthSalePlan;
			      						if(j==0){
				      						if(monthSalePlan!=null){
				      							operation += '<tr><input type="hidden" name="id" value="'+monthSalePlan.id+'"/><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td rowspan="'+(goTimeList.length+returnTimeList.length)+'"><select name="fltNbr" id="fltList'+(i+1)+'" onchange="changeFlight(\'saleplanform'+(i+1)+'\','+(i+1)+')">'+$("#flt_nbr_Count").html()+'</select></td><td rowspan="'+goTimeList.length+'"><input readonly="readonly" value="'+list[i].goFlt+'"/></td><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input name="agreement" id="agreement'+(i+1)+(j+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input name="lowestSale" id="lowestSale'+(i+1)+(j+1)+'" value="'+monthSalePlan.lowestSale+'"/></td><td><input name="fITSaleCycle" id="fITSaleCycle'+(i+1)+(j+1)+'" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="discountReturn" onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fItNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="frequency'+(i+1)+(j+1)+'" name="frequency"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
				      						}else{
				      							operation += '<tr><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td rowspan="'+(goTimeList.length+returnTimeList.length)+'"><select name="fltNbr" id="fltList'+(i+1)+'" onchange="changeFlight(\'saleplanform'+(i+1)+'\','+(i+1)+')">'+$("#flt_nbr_Count").html()+'</select></td><td rowspan="'+goTimeList.length+'"><input readonly="readonly" value="'+list[i].goFlt+'"/></td><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input name="agreement" id="agreement'+(i+1)+(j+1)+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'"/></td><td><input name="lowestSale" id="lowestSale'+(i+1)+(j+1)+'"/></td><td><input name="fITSaleCycle" id="fITSaleCycle'+(i+1)+(j+1)+'"/></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'"/></td><td><input name="discountReturn" onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="0"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="0"/></td><td><input id="frequency'+(i+1)+(j+1)+'" name="frequency" value="'+goList[j].two_Tak_Ppt+'"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="0"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'"/></td></tr>';
				      						}
				      					 }else{
				      						if(monthSalePlan!=null){
				      							operation += '<tr><input type="hidden" name="id" value="'+monthSalePlan.id+'"/><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input name="agreement" id="agreement'+(i+1)+(j+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input name="lowestSale" id="lowestSale'+(i+1)+(j+1)+'" value="'+monthSalePlan.lowestSale+'"/></td><td><input name="fITSaleCycle" id="fITSaleCycle'+(i+1)+(j+1)+'" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="discountReturn" onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="frequency'+(i+1)+(j+1)+'" name="frequency"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="'+((monthSalePlan.fItNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
				      						}else{
				      							operation += '<tr><input type="hidden" name="timeId" value="'+goTimeList[j].divideId+'"/><td><input readonly="readonly" value="'+goTimeList[j].startDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].endDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+goTimeList[j].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+goList[j].idd_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Dct+'" /></td><td><input readonly="readonly" value="'+goList[j].grp_Nbr+'" /></td><td><input name="agreement" id="agreement'+(i+1)+(j+1)+'"/></td><td><input name="fITNbr" id="fITNbr'+(i+1)+(j+1)+'"/></td><td><input name="allFold" id="allFold'+(i+1)+(j+1)+'"/></td><td><input name="lowestSale" id="lowestSale'+(i+1)+(j+1)+'"/></td><td><input name="fITSaleCycle" id="fITSaleCycle'+(i+1)+(j+1)+'"/></td><td><input name="groupNbr" id="groupNbr'+(i+1)+(j+1)+'"/></td><td><input name="discountReturn" onchange="setInitDataParam(1,'+(i+1)+','+(j+1)+')" id="discountReturn'+(i+1)+(j+1)+'"/></td><td><input name="groupSaleCycle" id="groupSaleCycle'+(i+1)+(j+1)+'"/></td><td><input readonly="readonly" id="goIncome'+(i+1)+(j+1)+'" value="0"/></td><td><input readonly="readonly" id="goTranNbr'+(i+1)+(j+1)+'" value="0"/></td><td><input id="frequency'+(i+1)+(j+1)+'" name="frequency" value="'+goList[j].two_Tak_Ppt+'"/></td><td><input readonly="readonly" id="goEPI'+(i+1)+(j+1)+'" value="0"/></td><td><input name="estPosiNbr" id="estPosiNbr'+(i+1)+(j+1)+'"/></td><td><input name="estDisposePlan" id="estDisposePlan'+(i+1)+(j+1)+'"/></td></tr>';
				      						}
				      					 } 
			      					 }			 
			     				 }
			     			 }
			     			 if(returnList!=null&&returnList.length>0&&returnTimeList!=null&&returnTimeList.length>0){
			     				 for(var k=0;k<returnTimeList.length;k++){
			     					if(returnList[k]!=null&&returnTimeList[k]!=null){
			     						var monthSalePlan = returnTimeList[k].monthSalePlan;
			      						if(k==0){
				      						if(monthSalePlan!=null){
				      							operation += '<tr><input type="hidden" name="rId" value="'+monthSalePlan.id+'"/><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td rowspan="'+returnTimeList.length+'"><input readonly="readonly" value="'+list[i].returnFlt+'"/></td><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'" value="'+monthSalePlan.lowestSale+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
				      						}else{
				      							operation += '<tr><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td rowspan="'+returnTimeList.length+'"><input readonly="readonly" value="'+list[i].returnFlt+'"/></td><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'" /></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="0"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="0"/></td><td><input value="'+returnList[k].two_Tak_Ppt+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="0"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'"/></td></tr>';
				      						}
				      					}else{
				      						if(monthSalePlan!=null){
				      							operation += '<tr><input type="hidden" name="rId" value="'+monthSalePlan.id+'"/><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'" value="'+monthSalePlan.agreement+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITNbr+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'" value="'+monthSalePlan.allFold+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'" valeu="'+monthSalePlan.lowestSale+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.fITSaleCycle+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupNbr+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'" value="'+monthSalePlan.discountReturn+'"/></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'" value="'+monthSalePlan.groupSaleCycle+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb)+'"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="'+(monthSalePlan.fITNbr+monthSalePlan.groupNbr)+'"/></td><td><input value="'+monthSalePlan.frequency+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="'+((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*list[i].goYb*monthSalePlan.frequency).toFixed(2)+'"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'" value="'+monthSalePlan.estPosiNbr+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'" value="'+monthSalePlan.estDisposePlan+'"/></td></tr>';
				      						}else{
				      							operation += '<tr><input type="hidden" name="rTimeId" value="'+returnTimeList[k].divideId+'"/><td><input readonly="readonly" value="'+returnTimeList[k].startDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].endDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleStartDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].refSaleEndDate+'" /></td><td><input readonly="readonly" value="'+returnTimeList[k].nature+'" /></td><td><input readonly="readonly" value="'+list[i].transChange+'" /></td><td><input readonly="readonly" value="'+list[i].yoyTrans+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Fng_Rte+'" /></td><td><input readonly="readonly" value="'+returnList[k].idd_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].ech_Cls_Grp+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Dct+'" /></td><td><input readonly="readonly" value="'+returnList[k].grp_Nbr+'" /></td><td><input name="rAgreement" id="rAgreement'+(i+1)+(k+1)+'"/></td><td><input name="rFITNbr" id="rFITNbr'+(i+1)+(k+1)+'"/></td><td><input name="rAllFold" id="rAllFold'+(i+1)+(k+1)+'"/></td><td><input name="rLowestSale" id="rLowestSale'+(i+1)+(k+1)+'"/></td><td><input name="rFITSaleCycle" id="rFITSaleCycle'+(i+1)+(k+1)+'"/></td><td><input name="rGroupNbr" id="rGroupNbr'+(i+1)+(k+1)+'"/></td><td><input name="rDiscountReturn" onchange="setInitDataParam(2,'+(i+1)+','+(k+1)+')" id="rDiscountReturn'+(i+1)+(k+1)+'"/></td><td><input name="rGroupSaleCycle" id="rGroupSaleCycle'+(i+1)+(k+1)+'"/></td><td><input readonly="readonly" id="returnIncome'+(i+1)+(k+1)+'" value="0"/></td><td><input readonly="readonly" id="returnTranNbr'+(i+1)+(k+1)+'" value="0"/></td><td><input value="'+returnList[k].two_Tak_Ppt+'" id="rFrequency'+(i+1)+(k+1)+'" name="rFrequency"/></td><td><input readonly="readonly" id="returnEPI'+(i+1)+(k+1)+'" value="0"/></td><td><input name="rEstPosiNbr" id="rEstPosiNbr'+(i+1)+(k+1)+'"/></td><td><input name="rEstDisposePlan" id="rEstDisposePlan'+(i+1)+(k+1)+'"/></td></tr>';
				      						}
				      					}
			      					}
			     				 }
			     			 }
			     			 operation += '</table>';
			     			 operation += '<div style="height:30px;text-align:center;margin:10px auto; width:54px;"><a class="btn btn-success" style="30px;" onclick="saveSalePlanData(\''+("saleplanform"+(i+1))+'\','+(i+1)+')">保存</a><a class="btn btn-success" style="30px;" onclick="deleteSalePlanData('+(i+1)+')">删除</a></div></div></form>';
				        }
			  		  }
			  		  $("#salesplan").append(operation);
				  	  for(var i=0;i<list.length;i++){
				  		  //fltInit(i+1);
				  		  if(list[i].flight!=null&&list[i].flight!=""){
				  			  $('#fltList'+(i+1)).val(list[i].flight);
				  		  }
				  	  }
			  		  inputBorder();//去掉input边框
				  }else{
					  alert("没有数据");
				  }
			  }else{
				  alert(data.message);
				  $('#salesplan').empty();
			  }
		  }else{
			  alert("服务器繁忙，请稍后再试");
		  }
        }
	});
}
function fltInit(_index){
	  $('#fltList'+_index).val($('#flt_nbr_Count').val());
}
function setInitDataParam(type,index,row){
	var yb = $("#goYb"+index).val()==""?0:parseInt($("#goYb"+index).val());
	if(type==1){
		var fitNbr = $("#fITNbr"+index+row).val()==""?0:parseInt($("#fITNbr"+index+row).val());
		var allFold = $("#allFold"+index+row).val()==""?0:parseInt($('#allFold'+index+row).val());
		var groupNbr = $("#groupNbr"+index+row).val()==""?0:parseInt($("#groupNbr"+index+row).val());
		var discountRet = $("#discountReturn"+index+row).val()==""?0:parseInt($("#discountReturn"+index+row).val());
		var frequency = $('#frequency'+index+row).val()==""?0:parseInt($('#frequency'+index+row).val());
		var goTranNbr = fitNbr+groupNbr;
		var goIncome = (fitNbr*allFold/100+groupNbr*discountRet/100)*yb;
		var goEPI = goIncome*frequency;
		$('#goTranNbr'+index+row).val(goTranNbr);
		$('#goIncome'+index+row).val(goIncome);
		$('#goEPI'+index+row).val(goEPI);
			
	}else{
		var fitNbr = $("#rFITNbr"+index+row).val()==""?0:parseInt($("#rFITNbr"+index+row).val());
		var allFold = $("#rAllFold"+index+row).val()==""?0:parseInt($('#rAllFold'+index+row).val());
		var groupNbr = $("#rGroupNbr"+index+row).val()==""?0:parseInt($("#rGroupNbr"+index+row).val());
		var discountRet = $("#rDiscountReturn"+index+row).val()==""?0:parseInt($("#rDiscountReturn"+index+row).val());
		var frequency = $('#rFrequency'+index+row).val()==""?0:parseInt($('#rFrequency'+index+row).val());
		var returnTranNbr = fitNbr+groupNbr;
		var returnIncome = (fitNbr*allFold/100+groupNbr*discountRet/100)*yb;
		var returnEPI = returnIncome*frequency;
		$('#returnTranNbr'+index+row).val(returnTranNbr);
		$('#returnIncome'+index+row).val(returnIncome);
		$('#returnEPI'+index+row).val(returnEPI);
	}
}
function deleteSalePlanData(_index){
	var seasonId = $('#seasonId'+_index).val();
	var fltNbr = $('#fltList'+_index).val();
	$.ajax({
		url:'${pageContext.request.contextPath}/deleteSalePlanData',
		data:{
			seasonId:seasonId,
			fltNbr:fltNbr
		},
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.result);
				getMonthSalesPlanParam();
			}else{
				alert('服务器繁忙，请稍后再试');
			}
		}
	});
}
function saveSalePlanData(id,_index){
	var fltNbr = $('#fltList'+_index).val();
	if(fltNbr==null||fltNbr ==''||fltNbr=='汇总'){
		alert('请选择一个航班号');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/saveSalePlanData',
		data:$('#'+id).serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.result)
				if(data.opResult=='0'){
					$('#'+id).hide();
				}
			}else{
				alert('服务器繁忙，请稍后再操作。');
			}
		}
	});
}
function changeFlight(id,_index){
	var flight = $('#fltList'+_index).val();
	if(flight==null||flight ==''||flight =='汇总'){
		alert("请选择一个航班号");
		return;
	}
	var fltDct = $('#fltDct'+_index).val();
	var lcl_Dpt_Day = $('#cc2').val();
	var dpt_AirPt_Cd = $('#cityChoice').val();
	var arrv_Airpt_Cd = $('#cityChoice2').val();
	var pas_stp = $('#cityChoice3').val();
	var flt_nbr = $('#flt_nbr_Count').val();
	if(flt_nbr!=null&&flt_nbr=='汇总'){
		flt_nbr = '';
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/getCurrentFlightSalePlan',
		data:'lcl_Dpt_Day='+lcl_Dpt_Day+'&dpt_AirPt_Cd='+dpt_AirPt_Cd+'&arrv_Airpt_Cd='+arrv_Airpt_Cd+'&pas_stp='+pas_stp+'&flt_nbr'+flt_nbr+'&flight='+flight+'&fltDct='+fltDct,
		type:'post',
		success:function(data){
			if(data!=null){
				var yb = $("#goYb"+_index).val()==""?0:parseInt($("#goYb"+_index).val());
				if(data.goTimeList!=null&&data.goTimeList.length>0){
					var goList = data.goTimeList;
					for(var i=0;i<goList.length;i++){
						var monthSalePlan = goList[i].monthSalePlan;
						if(monthSalePlan!=null){
							$('#agreement'+_index+(i+1)).val(monthSalePlan.agreement);
							$('#fITNbr'+_index+(i+1)).val(monthSalePlan.fITNbr);
							$('#allFold'+_index+(i+1)).val(monthSalePlan.allFold);
							$('#lowestSale'+_index+(i+1)).val(monthSalePlan.lowestSale);
							$('#fITSaleCycle'+_index+(i+1)).val(monthSalePlan.fITSaleCycle);
							$('#groupNbr'+_index+(i+1)).val(monthSalePlan.groupNbr);
							$('#discountReturn'+_index+(i+1)).val(monthSalePlan.discountReturn);
							$('#groupSaleCycle'+_index+(i+1)).val(monthSalePlan.groupSaleCycle);
							$('#goIncome'+_index+(i+1)).val((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*yb);
							$('#goTranNbr'+_index+(i+1)).val(monthSalePlan.fITNbr+monthSalePlan.groupNbr);
							$('#frequency'+_index+(i+1)).val(monthSalePlan.frequency);
							$('#goEPI'+_index+(i+1)).val((monthSalePlan.fITNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*yb*monthSalePlan.frequency);
							$('#estPosiNbr'+_index+(i+1)).val(monthSalePlan.estPosiNbr);
							$('#estDisposePlan'+_index+(i+1)).val(monthSalePlan.estDisposePlan);
						}else{
							$('#agreement'+_index+(i+1)).val('');
							$('#fITNbr'+_index+(i+1)).val('');
							$('#allFold'+_index+(i+1)).val('');
							$('#lowestSale'+_index+(i+1)).val('');
							$('#fITSaleCycle'+_index+(i+1)).val('');
							$('#groupNbr'+_index+(i+1)).val('');
							$('#discountReturn'+_index+(i+1)).val('');
							$('#groupSaleCycle'+_index+(i+1)).val('');
							$('#goIncome'+_index+(i+1)).val('');
							$('#goTranNbr'+_index+(i+1)).val('');
							$('#goEPI'+_index+(i+1)).val('');
							$('#estPosiNbr'+_index+(i+1)).val('');
							$('#estDisposePlan'+_index+(i+1)).val('');
						}
					}
				}
				if(data.returnTimeList!=null&&data.returnTimeList.length>0){
					var returnList = data.returnTimeList;
					for(var i=0;i<returnList.length;i++){
						var monthSalePlan = returnList[i].monthSalePlan;
						if(monthSalePlan!=null){
							$('#rAgreement'+_index+(i+1)).val(monthSalePlan.agreement);
							$('#rFITNbr'+_index+(i+1)).val(monthSalePlan.fITNbr);
							$('#rAllFold'+_index+(i+1)).val(monthSalePlan.allFold);
							$('#rLowestSale'+_index+(i+1)).val(monthSalePlan.lowestSale);
							$('#rFITSaleCycle'+_index+(i+1)).val(monthSalePlan.fITSaleCycle);
							$('#rGroupNbr'+_index+(i+1)).val(monthSalePlan.groupNbr);
							$('#rDiscountReturn'+_index+(i+1)).val(monthSalePlan.discountReturn);
							$('#rGroupSaleCycle'+_index+(i+1)).val(monthSalePlan.groupSaleCycle);
							$('#rGoIncome'+_index+(i+1)).val((monthSalePlan.fitNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*yb);
							$('#rGoTranNbr'+_index+(i+1)).val(monthSalePlan.fITNbr+monthSalePlan.groupNbr);
							$('#rFrequency'+_index+(i+1)).val(monthSalePlan.frequency);
							$('#rGoEPI'+_index+(i+1)).val((monthSalePlan.fitNbr*monthSalePlan.allFold/100+monthSalePlan.groupNbr*monthSalePlan.discountReturn/100)*yb*monthSalePlan.frequency);
							$('#rEstPosiNbr'+_index+(i+1)).val(monthSalePlan.estPosiNbr);
							$('#rEstDisposePlan'+_index+(i+1)).val(monthSalePlan.estDisposePlan);
						}else{
							$('#rAgreement'+_index+(i+1)).val('');
							$('#rFITNbr'+_index+(i+1)).val('');
							$('#rAllFold'+_index+(i+1)).val('');
							$('#rLowestSale'+_index+(i+1)).val('');
							$('#rFITSaleCycle'+_index+(i+1)).val('');
							$('#rGroupNbr'+_index+(i+1)).val('');
							$('#rDiscountReturn'+_index+(i+1)).val('');
							$('#rGroupSaleCycle'+_index+(i+1)).val('');
							$('#returnIncome'+_index+(i+1)).val('');
							$('#returnTranNbr'+_index+(i+1)).val('');
							$('#returnEPI'+_index+(i+1)).val('');
							$('#rEstPosiNbr'+_index+(i+1)).val('');
							$('#rEstDisposePlan'+_index+(i+1)).val('');
						}
					}
				}
			}else{
				alert('系统繁忙，请稍后再试。');
			}
		}
	});
}
</script>