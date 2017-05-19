<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%
	Object sessionValues = session.getAttribute("companyName_session");
%>
<html>
<head>
<meta charset="UTF-8">
<title>太美航空</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<%@include file="/WEB-INF/pages/common/css.jsp"%>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
#slackandbusy input,#salesplan input,#positionsset input {
	width: 100px;
	height: 20px;
}

.divideTable {
	height: 150px;
}

.divideTable td,.divideTable th,.returnTable td,.returnTable th,.goTable td,.goTable th,.toYoyTable td,.toYoyTable th,.toQoqTable td,.toQoqTable th,.returnYoyTable td,.returnYoyTable th,.returnQoqTable td,.returnQoqTable th
	{
	padding: 0px;
	vertical-align: middle;
	text-align: center;
	border: 1px solid #ddd;
	height: 37px;
}

.salePlanTable td {
	padding: 0px;
	vertical-align: middle;
	text-align: center;
	border: 1px solid #ddd;
}

.goTable select,.returnTable select {
	-moz-appearance: none;
	-webkit-appearance: none;
}
</style>
</head>
<body onload="javascript:changeTab(0)">
	<aside>
		<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
			href="#">航线月度销售预案</a>
		</font><br>
		<br>
		<form id="plan-searchForm">
			<font size="2" color="gray"> &emsp; 月份: <!-- <select id="cc2"  name="lcl_Dpt_Day" class="btn btn-default dropdown-toggle " style="appearance:none;-moz-appearance:none; -webkit-appearance:none;" >
			 		<option>请选择年份</option>
			 	</select> --> <input id="cc2" name="lcl_Dpt_Day"
				placeholder="请选择月份" onfocus="WdatePicker({dateFmt: 'yyyy-MM'})" />
				始发地:<input name="dpt_AirPt_Cd" placeholder='请选择机场'
				value="<%=sessionValues %>" id="cityChoice" size="14"> 到达地:<input
				name="arrv_Airpt_Cd" placeholder='请选择机场' id="cityChoice2" size="14">
				[可选]经停地:<input name="pas_stp" placeholder='请选择机场' id="cityChoice3"
				size="14"> [可选]航班号:&emsp;<select id="flt_nbr_Count"
				name="flt_nbr" class="btn btn-default dropdown-toggle "
				style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
					<option>汇总</option>
			</select> &emsp;<a href="#" class="btn btn-success" id="searchData">查询</a>
			</font>
		</form>
	</aside>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#slackandbusy" data-toggle="tab"
			onclick="changeTab(1);">淡旺季划分</a></li>
		<li><a href="#salesplan" data-toggle="tab" onclick="changeTab(2)">销售预案</a></li>
		<li><a href="#positionsset" data-toggle="tab"
			onclick="changeTab(3)">舱位设定</a></li>
	</ul>
	<div id="myTabContent" class="tab-content" style="overflow: scroll;">
		<div class="tab-pane fade in active" id="slackandbusy">
			<%-- <%@include file="/WEB-INF/pages/charts/monthSalesPlan/slackandbusydivide.jsp" %> --%>
		</div>
		<div class="tab-pane fade" id="salesplan">
			<%-- <%@include file="/WEB-INF/pages/charts/monthSalesPlan/slackandbusydivide.jsp" %> --%>
		</div>
		<div class="tab-pane fade" id="positionsset">
			<%-- <%@include file="/WEB-INF/pages/charts/monthSalesPlan/slackandbusydivide.jsp" %> --%>
		</div>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/monthSalesPlan/js/cabinseatset.jsp"%>
	<%@include file="/WEB-INF/pages/charts/monthSalesPlan/js/divide.jsp"%>
	<%@include file="/WEB-INF/pages/charts/monthSalesPlan/js/salesplan.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/monthSalesPlan/js/slackandbusydivide.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>