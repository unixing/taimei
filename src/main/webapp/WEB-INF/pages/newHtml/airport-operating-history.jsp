<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>历史运营统计</title>
<link rel="stylesheet" type="text/css"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/publicsControls.css" />
<link rel="stylesheet" type="text/css"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/airport-operating-history.css" />
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/coalesce.css" rel="stylesheet">
<link href="/err/ed.css" rel="stylesheet">
</head>
<body onselectstart="return false" unselectable="return false">
	<div class="lin-historical">
		<div class="sr-box-head">
			<div class="sr-box-head-classify">
				<ul>
					<li class="tltle-sel tltle-selI" id="_permissions_2">&#xe629;<span>历史运营统计</span></li>
					<li class="tltle-sel" title="航班动态" id="_permissions_6"><a class='page-fun-change'
						href="/airline_dynamic">&#xe665;</a></li>
					<li class="tltle-sel" title="时刻分布" id="_permissions_7"><a class='page-fun-change'
						href="/processTask">&#xe666;</a></li>
				</ul>
			</div>
			<div class="sr-box-head-inquire">
				<ul>
					<li style="position: relative"><span>机场</span><input
						type="text" id='cityChoice' placeholder="机场名"
						class="selectCity c-selectCity c-selectChange"></li>
					<li style="position: relative"><span>航司</span><input
						type="text" id='cpy_Nm' placeholder="如MU(可选)"></li>
				</ul>
				<div class="sr-box-head-btn" onclick='send()'>查询</div>
			</div>
		</div>
		<div class="lin-historical-body">
			<div class="lin-historical-body-navigation">
				<div class="Into set"></div>
				<div class="Out"></div>
			</div>
			<div class="lin-historical-body-box">
				<div id="inTrafficAnalysis"></div>
				<div id="analysis"></div>
				<div id="averageA"></div>
				<div id="kttr"></div>
				<div id="rp10"></div>
				<div id="tracpq10"></div>
				<div id="routes"></div>
				<div id="de-guest10"></div>
				<div id="deshift10"></div>
				<div id="sDepartment"></div>
			</div>
			<div class="reportErr">
				<div id='err-one'><img src="/err/errNodata.png" ></div>
        		<div id='err-two'><img src="/err/err2.png"></div>
			</div>
			<div id="scroll-bar"></div>
			<div class="lin-historical-time">
				<h3 class="right-title">机场记录运营情况统计</h3>
				<div class="sr-box-body-date-head">
					<ul class="set-years">
						<li onclick="lastyears()">&#xe663;</li>
						<li id="years"></li>
						<li onclick="nextyears()">&#xe664;</li>
					</ul>
				</div>
				<div class="sr-box-body-date-body"></div>
				<div class="air-weather">
					<div >
						<div id="weather" style="font-size: 16px;">
							<p class="ptxt"></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery1.8.3.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/role.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/echarts.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/coalesce.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/airport-controls.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/AdminLTE/myWeather.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/airport-operating-history.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/jquery.mousewheel.js"></script>
</body>
</html>