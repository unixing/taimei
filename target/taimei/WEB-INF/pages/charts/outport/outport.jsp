<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>销售报表</title>
<link href="/css/newPageCss/salesReports.css" rel="stylesheet">
<link href="/css/newPageCss/dateKJ.css" rel="stylesheet">
<link href="/css/newPageCss/salesReports-day.css" rel="stylesheet">
</head>

<body>
	<% 
				Object sessionValues=session.getAttribute("companyName_session"); 
			%>
	<input name="dpt_AirPt_Cd" hidden="hidden" value="<%=sessionValues%>"
		id="cityChoice" size="14">
	<div class="sr-box-body-report">
		<ul>
			<li id="li1" class="liset" style="padding-top: 170px;"
				onclick='getAirPortData(0);'><div>进港</div></li>
			<li id="li2" style="padding-top: 170px;" onclick='getAirPortData(1);'><div>出港</div></li>
		</ul>
	</div>
	<div class="sr-box">
		<div class="sr-box-head">
			<div class="sr-box-head-classify">
				<ul>
					<li class="tltle-sel">&#xe629;</li>
					<li class="tltle-sel tltle-selI"> <span>历史运营统计</span>
					</li>
					<li class="tltle-sel">&#xe62a;</li>
					<li class="tltle-sel">&#xe62b;</li>
				</ul>
			</div>
			<div class="sr-box-head-inquire" style="margin-right: 0;">
				<ul>
					<li><span>统计年份:</span> <select id="cc2" name="lcl_Dpt_Day"
						class="btn"
						style="-moz-appearance: none; padding: 0px 44px; border-width: 0px; height: 20px;">
					</select></li>
				</ul>
				<div class="sr-box-head-btn" onclick="getData()">查询</div>
			</div>
		</div>

		<div class="sr-box-body">
			<div class="sr-box-body-chart">
				<div class="sr-box-body-chart-income Income-table"
					style="height: 100%; width: 1711px">
					<table>
						<tr>
							<th>
								<div id="main" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
							<th>
								<div id="EvenPort" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
						</tr>
						<tr>
							<th>
								<div id="classRanking" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
							<th>
								<div id="Set_Ktr_Ine" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
						</tr>
						<tr>
							<th>
								<div id="clz_Ktr_Rkg" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
							<th>
								<div id="amountRatio" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
						</tr>
						<tr>
							<th>
								<div id="guestamount" style="height: 300px; width: 750px"
									align="center"></div>
							</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/outport/js/outport.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>

</body>
</html>