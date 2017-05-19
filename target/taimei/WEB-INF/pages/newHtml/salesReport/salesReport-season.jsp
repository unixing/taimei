<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>销售报表</title>
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/salesReport-season.css" rel="stylesheet">
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/salesReports.css" rel="stylesheet">
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/coalesce.css" rel="stylesheet">
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/salesReports-new.css" rel="stylesheet">
<link href="/err/ed.css" rel="stylesheet">
</head>
<body>
	<div class="sr-box">
		<div class="sr-box-head">
			<div class="sr-box-head-classify">
				<ul>
					<li class="tltle-sel tltle-selI"> <span>销售报表</span>
					</li>
					<li class="tltle-sel" title="航线历史运营统计"><a
						class='page-fun-change' href="/airline?flagpage=1">&#xe629;</a></li>
					<li class="tltle-sel" title="销售动态"><a class='page-fun-change'
						href="/buyTicketReport">&#xe624;</a></li>
					<li class='tltle-sel' title='销售数据'><a class='page-fun-change'
						href='/SalesData/accountCheck'>&#xe688;</a></li>
				</ul>
			</div>
			<div class="sr-box-head-inquire">
				<div class="_set-place-duplexing">
					<div class="_set-name">航线</div>
					<div class="_set-begin">
						<input type="text" id="cityChoice" placeholder="始发地"
							class="selectCity c-selectCity c-selectChange">
					</div>
					<div class="_set-change">&#xe65d;</div>
					<div class="_set-begin">
						<input type="text" id="cityChoice2" placeholder="到达地"
							class="selectCity c-selectCity c-selectChange">
					</div>
				</div>
				<div class="_set-place">
					<div class="_set-name">经停</div>
					<div class="_set-begin">
						<input type="text" id="cityChoice3" placeholder="可选"
							class="selectCity c-selectCity c-selectChange-stp">
					</div>
				</div>
				<div class="_set-flight">
					<div class="_set-name">航班号</div>
					<div id="flt_nbr_Count" class="_set-list-set"></div>
				</div>
				<div class="_set-choose">
					<input type="checkbox" id="exceptionData" value="on"
						checked="checked">
					<div>异常数据</div>
				</div>
				<div class="_set-query">查询</div>
			</div>
		</div>
		<div class="sr-box-body">
			<div class="sr-box-body-report">
				<ul>
					<li onclick="changeSalesReport(0)"><p>&#xe678;</p>
						<div>日报</div></li>
					<li onclick="changeSalesReport(1)"><p>&#xe88c;</p>
						<div>周报</div></li>
					<li onclick="changeSalesReport(2)"><p>&#xe88d;</p>
						<div>月报</div></li>
					<li onclick="changeSalesReport(3)" class="set-liset"><p>&#xe820;</p>
						<div>季报</div></li>
					<li onclick="changeSalesReport(4)"><p>&#xe679;</p>
						<div>年报</div></li>
				</ul>
			</div>
			<div class="sr-box-body-chart dddd">
				<div class="sr-box-body-chart-income Income-table">
					<p class="p-height">
						收入<span>（元）</span>
					</p>
					<div class="d-height sr-year-char1">
						<div class="information-head">
							<p>季营收合计</p>
							<div id="seasonIncome"></div>
						</div>
						<div class="information-head">
							<p>季小时营收</p>
							<div id="hourIncome"></div>
						</div>
						<div class="information-head">
							<p>季座公里收入</p>
							<div id="raskIncome"></div>
						</div>
					</div>
					<div id="income" class="graph-table"></div>
				</div>
				<div class="sr-box-body-chart-income guest-table">
					<p class="p-height">平均客座率</p>
					<div class="d-height sr-year-char2">
						<div class="information-head">
							<p>季平均客座率</p>
							<div id="seasonAvgPlf"></div>
						</div>
					</div>
					<div id="avg_set_ine" class="graph-table"></div>
				</div>
				<div class="sr-box-body-chart-income guest-table">
					<p class="p-height">总人数</p>
					<div class="d-height sr-year-char3">
						<div class="information-head">
							<p>季总人数/总班数</p>
							<div id="seasonTotalPC"></div>
						</div>
					</div>
					<div id="person_dct" class="graph-table"></div>
				</div>
				<div class="sr-box-body-chart-income guest-table">
					<p class="p-height">均班人数</p>
					<div class="d-height sr-year-char4">
						<div class="information-head">
							<p>季均班人数/总班数</p>
							<div id="seasonAvgPC"></div>
						</div>
					</div>
					<div id="person_avg" class="graph-table"></div>
				</div>
			</div>
			<div class="reportErr">
    			<div id='err-one'><img src="/err/errNodata.png" ></div>
        		<div id='err-two'><img src="/err/err2.png"></div>
			</div>


			<div class="sr-box-body-date">
				<div class="sr-box-body-date-head">
					<ul class="set-years">
						<li onclick="lastyear(this)">&#xe648;</li>
						<li id="year"></li>
						<li onclick="nextyear(this)">&#xe648;</li>
					</ul>
				</div>
				<ul class="sr-box-body-date-body">
					<li class="list">
						<h3>2014</h3>
						<p>夏秋</p>
						<div>2014-3-30至2014-10-25</div>
					</li>
					<li>
						<h3>2014-2015</h3>
						<p>冬春</p>
						<div>2014-10-26至2015-3-28</div>
					</li>
					<li>
						<h3>2015</h3>
						<p>夏秋</p>
						<div>2016-3-29至2016-10-31</div>
					</li>
					<li>
						<h3>2015-2016</h3>
						<p>冬春</p>
						<div>2015-11-01至2016-3-26</div>
					</li>
					<li>
						<h3>2016</h3>
						<p>夏秋</p>
						<div>2016-3-27至2016-10-29</div>
					</li>
					<li>
						<h3>2016-2017</h3>
						<p>冬春</p>
						<div>2016-10-30至2017-3-25</div>
					</li>
				</ul>
				<div class="sr-box-body-date-footer">
					<ul id="income-set">
						<li class='checkBtn' id="goFltNbr"></li>
						<li class='checkBtn checkFlt'>往返</li>
						<li class='checkBtn' id="backFltNbr"></li>
					</ul>
					<div class="bc"></div>
					<div class="change-line">
						<div class="change-line-f">
							<p id="departureItia"></p>
							<div id="departureCity"></div>
						</div>
						<div class="change-line-o">
							<p id="passItia"></p>
							<div id="passCity"></div>
						</div>
						<div class="change-line-l">
							<p id="arriveItia"></p>
							<div id="arriveCity"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery1.8.3.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/echarts.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/coalesce.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.fullcalendar.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/salesReport-season.js"></script>
	<script type="application/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/airport-controls.js"></script>
</body>
</html>