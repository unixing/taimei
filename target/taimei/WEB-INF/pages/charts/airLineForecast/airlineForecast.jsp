<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>太美航空</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<%@include file="/WEB-INF/pages/common/css.jsp"%>
</head>
<body>
	<aside>
		<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
			href="#">航线收益预测</a>
		</font><br>
		<br>
		<form id="DOW-searchForm">
			<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
			开始日期: <input type='text' width="100px;" name="startDate"
				class="Wdate" onclick="WdatePicker()" id='datetimepicker4' /> 结束日期:
			<input type='text' width="100px;" name="endDate" class="Wdate"
				onclick="WdatePicker()" id='datetimepicker4' /> 始发地:<input
				name="dpt_AirPt_Cd" value="<%=sessionValues %>" id="cityChoice"
				size="14"> 到达地:<input name="Arrv_Airpt_Cd"
				placeholder='请选择机场' id="cityChoice2" size="14"> [可选]经停地:<input
				name="pas_stp" placeholder='请选择机场' id="cityChoice3" size="14">
			&emsp;<a href="#" class="btn btn-success" onclick="send();">查询</a>
		</form>
	</aside>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#forecast" data-toggle="tab"
			onclick="advancedQuery();">收益预测</a></li>
	</ul>
	<div id="myTabContent" class="tab-content" style="overflow-x: auto;">
		<div class="tab-pane fade in active" id="forecast"
			style="display: none;">
			<%@include
				file="/WEB-INF/pages/charts/airLineForecast/airlineForecastCharts.jsp"%>
		</div>
	</div>
	<div id="myTabContent3" style="display: none;" class="tab-content"
		align="center">
		<input type="button" class="btn btn-success" name="mySbumit" id="btn"
			value="收益预测" onclick="saveOrUpate();"></input>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/airLineForecast/js/airlineForecastChreatJS.jsp"%>
</body>
</html>