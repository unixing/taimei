<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>共飞运营对比</title>
<link rel="stylesheet" type="text/css"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/publicsControls.css" />
<link rel="stylesheet" type="text/css" media="all"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/bootstrap.css">
<link rel="stylesheet" type="text/css" media="all"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/daterangepicker-bs3.css" />
<link rel="stylesheet" type="text/css"
	href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/operating.css" />
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/coalesce.css" rel="stylesheet">
<link href="/err/ed.css" rel="stylesheet">
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/TMcommon.css" rel="stylesheet">
<!--  <link href="/css/newPageCss/salesReports-new.css" rel="stylesheet"> -->
</head>

<body onselectstart="return false" unselectable="return false">
	<div class="lin-historical">
		<div class="sr-box-head">
			<div class="sr-box-head-classify">
				<ul>
					<li class="tltle-sel tltle-selI" id="_permissions_3">&#xe61a;<span>共飞运营对比</span></li>
					<li class="tltle-sel" title="航线历史收益统计" id="_permissions_1"><a
						class='page-fun-change' href="/airline">&#xe629;</a></li>
					<li class="tltle-sel" title="客源组成" id="_permissions_4"><a class='page-fun-change'
						href="/SourceDistribution">&#xe619;</a></li>
				</ul>
			</div>
			<div class="sr-box-head-inquire">
				<ul>
					<li style="position: relative"><span>航线</span><input
						type="text" id='cityChoice' placeholder="始发地"
						class="selectCity c-selectCity c-selectChange"></li>
					<li>&#xe65d;</li>
					<li style="position: relative"><input type="text"
						id='cityChoice2' placeholder="到达地"
						class="selectCity c-selectCity c-selectChange"></li>
					<!-- <li style="position: relative">
                    <span>日期</span><input type="text" placeholder="其实日期">
                </li>
                <li>&#xe632;</li>
                <li style="position: relative">
                    <input type="text" placeholder="结束日期">
                </li> -->
					<li style="position: relative"><span>日期</span><input
						type="text" readonly="readonly" style="width: 200px;"
						id='startEndDate' placeholder="起止日期"></li>
					<li style="position: relative"><span>经停地</span><input
						type="text" id='cityChoice3' placeholder="(可选)"
						class="selectCity c-selectCity c-selectChange-stp"></li>
					<!-- <li style="position: relative">
                    <span>航班号</span><input type="text" placeholder="(可选)">
                </li> -->
				</ul>
				<div class="sr-inquire-set">
					<input id='exceptionData' type="checkbox" checked="checked" >异常数据
				</div>
				<div id="pasDiv" class="sr-inquire-set">
					<input id='isIncloudPasstp' checked="checked" type="checkbox">含经停
				</div>
				<div class="sr-box-head-btn" onclick='send()'>查询</div>
			</div>
		</div>
		<div class="lin-historical-body">
			<div class="lin-historical-body-navigation">
			</div>			
			<div class="TMlackdata"><p><span>&#xe64a;</span>当前查询条件下，存在连续30天以上的数据缺失</p></div>
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
		<div class="SD-hd-null">
			<p>暂无该航线数据！<p>
		</div>
		
	</div>
	<script
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery1.8.3.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/role.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/echarts.js"></script>
	<script type="application/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/airport-controls.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/coalesce.js"
		type="text/javascript"></script>
	<script type="application/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/operating.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/jquery.mousewheel.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/moment.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/daterangepicker.js"></script>
</body>
</html>