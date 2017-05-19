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
			href="#">航线历史收益统计</a>
		</font><br>
		<br>
		<form id="DOW-searchForm">
			<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
			<font size="2" color="gray"> &emsp; 年份: <select id="cc2"
				name="lcl_Dpt_Day" class="btn btn-default dropdown-toggle "
				style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
			</select> 始发地:<input name="dpt_AirPt_Cd" value="<%=sessionValues %>"
				id="cityChoice" size="14"> 到达地:<input name="Arrv_Airpt_Cd"
				placeholder='请选择机场' id="cityChoice2" size="14"> [可选]经停地:<input
				name="pas_stp" placeholder='请选择机场' id="cityChoice3" size="14">
				[可选]航班号:&emsp;<select id="flt_nbr_Count" name="flt_nbr"
				class="btn btn-default dropdown-toggle "
				style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
					<option>汇总</option>
			</select> [可选]航司:<input name="Cpy_Nm" placeholder='如:MU' size="4"
				onchange="send();"> &emsp;<a href="#"
				class="btn btn-success" onclick="send();">查询</a>
			</font>
		</form>
	</aside>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#data" data-toggle="tab"
			onclick="advancedQuery();">走势分析</a></li>
		<li><a href="#count" data-toggle="tab" onclick="getTimeCount();">均班收益</a></li>
		<li><a href="#airLine" data-toggle="tab"
			onclick="getDateAndCost();">收益汇总</a></li>
	</ul>
	<div id="wate" style="display: none;" align="center">
		<img src="/flash/wait.gif">
	</div>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade active in" id="data">
			<div class="row" hidden="hidden" id="divtoMain">
				<div class="col-md-6">
					<div id="toMain" style="height: 400px" align="center"></div>
				</div>
				<div class="col-md-6">
					<div id="toPort" style="height: 400px" align="center"></div>
				</div>
			</div>
			<div class="row" hidden="hidden" id="divreturnMain">
				<div class="col-md-6">
					<div id="returnMain" style="height: 400px" align="center"></div>
				</div>
				<div class="col-md-6">
					<div id="returnPort" style="height: 400px" align="center"></div>
				</div>
			</div>
			<div class="row" hidden="hidden" id="divpasStpMain">
				<div class="col-md-6">
					<div id="pasStpMain" style="height: 400px" align="center"></div>
				</div>
				<div class="col-md-6">
					<div id="pasStpPort" style="height: 400px" align="center"></div>
				</div>
			</div>
			<div class="row" hidden="hidden" id="divtoTwoMain">
				<div class="col-md-6">
					<div id="toTwoMain" style="height: 400px" align="center"></div>
				</div>
				<div class="col-md-6">
					<div id="toTwoPort" style="height: 400px" align="center"></div>
				</div>
			</div>
			<div class="row" hidden="hidden" id="divtoThreeMain">
				<div class="col-md-6">
					<div id="toThreeMain" style="height: 400px" align="center"></div>
				</div>
				<div class="col-md-6">
					<div id="toThreePort" style="height: 400px" align="center"></div>
				</div>
			</div>
			<div class="row" hidden="hidden" id="divreturnThreeMain">
				<div class="col-md-6">
					<div id="returnThreeMain" style="height: 400px" align="center"></div>
				</div>
				<div class="col-md-6">
					<div id="returnThreePort" style="height: 400px" align="center"></div>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="count">
			<div hidden="hidden">
				总飞时间:<input id="countTime" onchange="saveAndQuery();"
					onkeypress="EnterPress(event)" onkeydown="EnterPress()">
			</div>
		</div>
		<div class="tab-pane fade" id="airLine">
			<table id="methodCountData">

			</table>
		</div>
	</div>


	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/airLine/js/airlineChreatJS.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>