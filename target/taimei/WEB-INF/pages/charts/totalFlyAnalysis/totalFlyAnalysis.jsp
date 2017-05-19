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
<body style="background: white">
	<aside>
		<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
			href="#">共飞运营分析</a>
		</font><br>
		<br>
		<form id="DOW-searchForm">
			<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
			<font size="2" color="gray"> 日期范围: <input type='text'
				width="100px;" id="startDate" name="startDate" class="Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM'})" id='datetimepicker1' /> -
				<input type='text' width="100px;" id="endDate" name="endDate"
				class="Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM',onpicked:subbTime})"
				id='datetimepicker2' /> 始发地:<input name="dpt_AirPt_Cd"
				value="<%=sessionValues %>" id="cityChoice" size="14"
				readonly="readonly"> 到达地:<input name="Arrv_Airpt_Cd"
				placeholder='请选择机场' id="cityChoice2" size="14" readonly="readonly">
				[可选]经停地:<input name="pas_stp" placeholder='请选择机场' id="cityChoice3"
				size="14" readonly="readonly"> [可选]航司:<input name="hangsi"
				placeholder='如:MU' size="4">
				<div class="checkbox">
					<table class="table table-mailbox">
						<tr class="unread">
							<td align="left" width="900">&emsp;航段走势分析: &emsp;<input
								type="checkbox" name="flowCount" value="flowCount"
								checked="checked">流量汇总 &emsp;<input type="checkbox"
								name="allAmount" value="allAmount" checked="checked">均班客量<br>
								&emsp;共飞对比分析: &emsp;<input type="checkbox" name="flightNum"
								value="flightNum" checked="checked">航班量排行 &emsp;<input
								type="checkbox" name="raskRanking" value="raskRanking"
								checked="checked">座收排行 &emsp;<input type="checkbox"
								name="passengerRank" value="passengerRank" checked="checked">客量排行
								&emsp;<input type="checkbox" name="passengerCompared"
								value="passengerCompared" checked="checked">客量占比 &emsp;<input
								type="checkbox" name="allClassRank" value="allClassRank"
								checked="checked">均班客量排行<br> &emsp;<a href="#"
								class="btn btn-success" onclick="send();">查询</a>
							</td>
							<td align="right" class="unread"><input type="checkbox"
								id="check-all" checked="checked">全选<br></td>
						</tr>
					</table>
				</div>
			</font>
		</form>
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a id="abzs" onclick="abflowAsiay();"
				href="#abflowAsiay" data-toggle="tab">走势分析</a></li>
			<li><a id="bazs" onclick="baflowAsiay();" href="#baflowAsiay"
				data-toggle="tab">走势分析</a></li>
			<li><a id="abgf" onclick="abtotalflyAsiay();"
				href="#abtotalflyAsiay" data-toggle="tab">共飞对比分析</a></li>
			<li><a id="bagf" onclick="batotalflyAsiay();"
				href="#batotalflyAsiay" data-toggle="tab">共飞对比分析</a></li>
			<li><a id="abbagf" onclick="abbatotalflyAsiay();"
				href="#abbatotalflyAsiay" data-toggle="tab">共飞对比分析</a></li>
		</ul>
		<div id="wate" style="display: none;" align="center">
			<img src="/flash/wait.gif">
		</div>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade active in" id="abflowAsiay">
				<div class="row" id="abflowcharts"></div>
			</div>
			<div class="tab-pane fade" id="baflowAsiay">
				<div class="row" id="baflowcharts"></div>
			</div>
			<div class="tab-pane fade" id="abtotalflyAsiay">
				<div class="row" id="abtotalcharts"></div>
			</div>
			<div class="tab-pane fade" id="batotalflyAsiay">
				<div class="row" id="batotalcharts"></div>
			</div>
			<div class="tab-pane fade" id="abbatotalflyAsiay">
				<div class="row" id="abbatotalcharts"></div>
			</div>
		</div>
	</aside>

	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/totalFlyAnalysis/js/flowAnalysisJs.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/totalFlyAnalysis/js/totalFlyAnalysisJs.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>