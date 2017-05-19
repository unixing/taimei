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
			href="#">机场历史运营情况统计</a>
		</font><br>
		<br>
		<form id="DOW-searchForm">
			<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
			<font size="2" color="gray"> &emsp;统计年份: <select id="cc2"
				name="lcl_Dpt_Day" class="btn btn-default dropdown-toggle "
				style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
			</select> 机场:<input name="dpt_AirPt_Cd" value="<%=sessionValues %>"
				id="cityChoice" size="14"> 请选择出港/进港:<select name="state"
				class="btn btn-default dropdown-toggle "
				style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
					<option value="1">出港</option>
					<option value="0">进港</option>
			</select> [可选]航司:<input name="Cpy_Nm" placeholder='如:MU' size="4">
				<div class="checkbox">
					<table class="table table-mailbox">
						<tr class="unread">
							<td align="left" width="900">&emsp;走势分析: &emsp;<input
								type="checkbox" name="methodFlowCount" value="0"
								checked="checked">月流量汇总 &emsp;<input type="checkbox"
								name="allAmount" value="1" checked="checked">均班客量<br>
								&emsp;航段销售分析: &emsp;<input type="checkbox"
								name="airAmountRanking" value="2" checked="checked">航班量排行
								&emsp;<input type="checkbox" name="allAmountRanking" value="3"
								checked="checked">座收排行 &emsp;<input type="checkbox"
								name="SetIneRanking" value="4" checked="checked">客量排行
								&emsp;<input type="checkbox" name="amountRanking" value="5"
								checked="checked">客量占比 &emsp;<input type="checkbox"
								name="amountRatio" value="6" checked="checked">均班客量排行<br>
								&emsp;<a href="#" class="btn btn-success"
								onclick="advancedQuery();">查询</a>
							</td>
							<td align="right" class="unread"><input type="checkbox"
								checked="checked" id="check-all">全选<br></td>
						</tr>
					</table>
				</div>
			</font>
		</form>
		<section class="content">
			<div id="wate" style="display: none;" align="center">
				<img src="/flash/wait.gif">
			</div>
			<div class="row">
				<div class="col-md-6">
					<!-- 出港图形 -->
					<div id="main" style="height: 400px" align="center" hidden="hidden"></div>
				</div>
				<div class="col-md-6">
					<!--班次排行图形 -->
					<div id="EvenPort" style="height: 400px" align="center"
						hidden="hidden"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<!--流量图形 -->
					<div id="classRanking" style="height: 400px" align="center"
						hidden="hidden"></div>
				</div>
				<div class="col-md-6">
					<!--座公里收入排行图形 -->
					<div id="Set_Ktr_Ine" style="height: 400px" align="center"
						hidden="hidden"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<!--均班客量排行-->
					<div id="clz_Ktr_Rkg" style="height: 400px" align="center"
						hidden="hidden"></div>
				</div>
				<div class="col-md-6">
					<!--座公里收入排行图形 -->
					<div id="amountRatio" style="height: 400px" align="center"
						hidden="hidden"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<!--客量统计 -->
					<div id="guestamount" style="height: 400px" align="center"
						hidden="hidden"></div>
				</div>
			</div>
		</section>
	</aside>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/outport/js/outport.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>