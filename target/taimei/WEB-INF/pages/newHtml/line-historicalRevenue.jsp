<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String flagpage = request.getParameter("flagpage");
 %>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>航线历史收益统计</title>
<link rel="stylesheet" type="text/css" href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/dateKJ.css" />
<link rel="stylesheet" type="text/css"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/publicsControls.css" />
<link rel="stylesheet" type="text/css" media="all"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/bootstrap.css">
<link rel="stylesheet" type="text/css" media="all"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/line_historical/daterangepicker-bs3.css" />
<link rel="stylesheet" type="text/css"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/lin-historical.css" />
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/line_historical/sy.css"
	rel="stylesheet/less">
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/coalesce.css" rel="stylesheet">
<link
	href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css"
	rel="stylesheet">
<link href="/err/ed.css" rel="stylesheet">
</head>
<script type="text/javascript">
var flagpage = <%=flagpage%>;
</script>
<body>
	<div class="lin-historical">
		<div class="sr-box-head">
			<div class="sr-box-head-classify">
				<ul>
					<li class='tltle-sel' title='共飞运营对比'><a
						class='page-fun-change' href='/totalFlyAnalysis'>&#xe61a;</a></li>
					<li class='tltle-sel tltle-selI'>&#xe629;<span>航线历史收益统计</span></li>
					<li class='tltle-sel' title='客源组成'><a class='page-fun-change'
						href='/SourceDistribution'>&#xe619;</a></li>
				</ul>
			</div>
			<div class="sr-box-head-inquire" id='sr-box-head-inquire'>
				<div class="_set-place-duplexing">
					<div class="_set-name">航线</div>
					<div class="_set-begin">
						<input type="text" id='cityChoice' placeholder="始发地"
							class="selectCity c-selectCity c-selectChange">
					</div>
					<div class="_set-change">&#xe65d;</div>
					<div class="_set-begin">
						<input type="text" id='cityChoice2' placeholder="到达地"
							class="selectCity c-selectCity c-selectChange">
					</div>
				</div>
				<div class="_set-time">
					<div class="_set-name">起止时间</div>
					<div class="_set-name-b">
						<input type="text" placeholder="时间" readonly="readonly"
							id='reservation'>
					</div>
				</div>
				<div class="_set-place">
					<div class="_set-name">经停地</div>
					<div class="_set-begin">
						<input type="text" id='cityChoice3' placeholder="可选"
							class="selectCity c-selectCity c-selectChange-stp">
					</div>
				</div>

				<div class="_set-flight">
					<div class="_set-name" id='flt_nbr_Count'>航班号</div>
					<div class="_set-list-set"></div>
				</div>
				<div class="_set-choose">
					<input id='exceptionData' checked="checked" type="checkbox">
					<div>异常数据</div>
				</div>
				<div class="_set-choose" id="divpas">
					<input id='isIncloudPasstp'  checked="checked"  onchange="getfly();" type="checkbox">
					<div>含经停</div>
				</div>
				<div class="_set-query">查询</div>
			</div>
		</div>
		<div class="lin-historical-body">
			<div class="lin-historical-body-navigation"></div>
			<div class="lin-historical-body-box">
				<div id="container1"></div>
				<div id="container2"></div>
				<div id="container3"></div>
				<div id="container4"></div>
			</div>
		</div>
		<div class="err">
			<div id='err-one'><img src="/err/errNodata.png" ></div>
        	<div id='err-two'><img src="/err/err2.png"></div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery1.8.3.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/echarts.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.fullcalendar.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/coalesce.js"
		type="text/javascript"></script>
	<script type="application/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/lin-historical.js"></script>
	<script type="application/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/airport-controls.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/moment.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/line_historical/daterangepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/line_historical/less.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/line_historical/month-chenge.js"></script>
</body>
</html>