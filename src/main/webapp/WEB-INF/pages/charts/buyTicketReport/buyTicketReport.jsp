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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<body>
	<aside>
		<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
			href="#">上客进度表</a>
		</font><br>
		<br>
		<form id="DOW-searchForm">
			<font size="2" color="gray"> 日期范围: <input type='text'
				width="100px;" name="startTime" class="Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" id='datetimepicker4' />
				- <input type='text' width="100px;" name="endTime" class="Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" id='datetimepicker5' />
				航班号:<input name="flt_nbr_Count" id="flt_nbr_Count" placeholder=''
				size="8"> <a href="#" class="btn btn-success"
				onclick="send();">查询</a>
			</font>
		</form>
		<ul id="myTab" class="nav nav-tabs">
			<li class="active" id="ticketli1"><a id="ticket1"
				href="#buyTicketReportData1" data-toggle="tab">上客进度表</a></li>
			<li id="ticketli2" style="display: none;"><a id="ticket2"
				href="#buyTicketReportData2" data-toggle="tab">上客进度表</a></li>
			<li id="ticketli3" style="display: none;"><a id="ticket3"
				href="#buyTicketReportData3" data-toggle="tab">上客进度表</a></li>
			<li id="ticketli4" style="display: none;"><a id="ticket4"
				href="#buyTicketReportData4" data-toggle="tab">上客进度表</a></li>
			<li id="ticketli5" style="display: none;"><a id="ticket5"
				href="#buyTicketReportData5" data-toggle="tab">上客进度表</a></li>
			<li id="ticketli6" style="display: none;"><a id="ticket6"
				href="#buyTicketReportData6" data-toggle="tab">上客进度表</a></li>
		</ul>
		<div id="wate" style="display: none;" align="center">
			<img src="/flash/wait.gif">
		</div>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="buyTicketReportData1">
				<table id="tableAir1"></table>
			</div>
			<div class="tab-pane fade" id="buyTicketReportData2">
				<table id="tableAir2"></table>
			</div>
			<div class="tab-pane fade" id="buyTicketReportData3">
				<table id="tableAir3"></table>
			</div>
			<div class="tab-pane fade" id="buyTicketReportData4">
				<table id="tableAir4"></table>
			</div>
			<div class="tab-pane fade" id="buyTicketReportData5">
				<table id="tableAir5"></table>
			</div>
			<div class="tab-pane fade" id="buyTicketReportData6">
				<table id="tableAir6"></table>
			</div>
		</div>
	</aside>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/buyTicketReport/js/buyTicketReportJS.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>