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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
	<aside>
		<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
			href="#">销售报表</a>
		</font><br>
		<br>
		<form id="DOW-searchForm">
			<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
			<font size="2" color="gray"> 始发地:<input name="dpt_AirPt_Cd"
				value="" id="cityChoice" size="14"> 到达地:<input
				name="Arrv_Airpt_Cd" placeholder='请选择机场' id="cityChoice2" size="14">
				[可选]经停地:<input name="pas_stp" placeholder='请选择机场' id="cityChoice3"
				size="14"> [可选]航班号:&emsp;<select id="flt_nbr_Count"
				name="flt_nbr_Count" class="btn btn-default dropdown-toggle "
				style="appearance: none; -moz-appearance: none; -webkit-appearance: none;"
				onchange="doSend();">
					<option>汇总</option>
			</select> <input type="checkbox" name="isIncludeExceptionData"
				value="isIncludeExceptionData">异常数据 <input type="checkbox"
				name="isIncludePasDpt" value="isIncludePasDpt">经停 <input
				type="button" class="btn btn-success" name="mySbumit" id="btn"
				value="查询" onclick="doSend();"></input>
			</font>
		</form>
	</aside>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#dailyReport" data-toggle="tab"
			onclick="getAllTime();">日报</a></li>
		<li><a href="#weeklyReport" data-toggle="tab"
			onclick="weeklyReport();">周报</a></li>
		<li><a href="#monthlyReport" data-toggle="tab"
			onclick="monthlyReport();">月报</a></li>
		<li><a href="#halfYearReport" data-toggle="tab"
			onclick="halfYearReport();">航季报</a></li>
		<li><a href="#yearlyReport" data-toggle="tab"
			onclick="yearlyReport();">年报</a></li>
	</ul>
	<div id="wate" style="display: none;" align="center">
		<img src="/flash/wait.gif">
	</div>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade active in" id="dailyReport">
			<%@include file="/WEB-INF/pages/charts/salesReport/dailyReport.jsp"%>
		</div>
		<div class="tab-pane fade" id="weeklyReport">
			<%@include file="/WEB-INF/pages/charts/salesReport/weeklyReport.jsp"%>
		</div>
		<div class="tab-pane fade" id="monthlyReport">
			<%@include file="/WEB-INF/pages/charts/salesReport/monthlyReport.jsp"%>
		</div>

		<div class="tab-pane fade" id="halfYearReport">
			<%@include
				file="/WEB-INF/pages/charts/salesReport/halfYearReport.jsp"%>
		</div>
		<div class="tab-pane fade" id="yearlyReport">
			<%@include file="/WEB-INF/pages/charts/salesReport/yearlyReport.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/salesReport/js/salesReportJS.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>