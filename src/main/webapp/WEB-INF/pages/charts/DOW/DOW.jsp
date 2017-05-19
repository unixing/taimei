<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>太美航空</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<%@include file="/WEB-INF/pages/common/css.jsp"%>
</head>
<body>
	<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
		href="#">航前DOW分析</a>
	</font>
	<br>
	<br>
	<form id="DOW-searchForm">
		<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
		<font size="2" color="gray"> &emsp;DOW分析年份: <select id="cc2"
			name="lcl_Dpt_Day" class="btn btn-default dropdown-toggle "
			style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
		</select> 始发地:<input name="dpt_AirPt_Cd" id="cityChoice"
			value="<%=sessionValues %>" size="14"> 到达地:<input
			name="arrv_Airpt_Cd" id="cityChoice1" placeholder='请输入城市名' size="14">
			[可选]航班号:<input name="flt_nbr" placeholder='请输入航班号如:NB0001' size="22">
			<a href="#" class="btn btn-success" onclick="advancedQuery();">查询</a>
		</font>
	</form>
	<div class="row">
		<div class="col-md-6">
			<table id="example2" class="table table-bordered table-hover">
			</table>
			<table id="example3" class="table table-bordered table-hover">
			</table>
		</div>
		<div class="col-md-6" align="right">
			月份选择：<select id="methodSelect" onchange="onSelect(this)"></select><br>
			<h1 align="center">
				<font color="red"><label id="prompt" hidden="hidden"></label></font>
			</h1>
			<div id="line" style="height: 400px" align="center">
				<h1>
					<font color="red"></font>
				</h1>
			</div>
			<div id="main" style="height: 400px" align="center">
				<h1>
					<font color="red"></font>
				</h1>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/DOW/js/DOW.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>