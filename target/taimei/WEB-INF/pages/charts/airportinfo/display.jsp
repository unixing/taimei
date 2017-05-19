<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>太美航空</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<%@include file="/WEB-INF/pages/common/css.jsp"%>
<style type="text/css">
.clear {
	clear: both;
}

ul {
	width: 100%;
	height: 35px;
	border-bottom: 1px solid #dedede;
}

ul li {
	list-style-type: none;
	float: left;
	line-height: 35px;
	text-indent: 10px;
	width: 19%;
}

ul li input {
	line-height: 22px;
	width: 150px;
	border: 1px solid #dedede;
}

ul li span {
	font-size: 16px;
	font-weight: bold;
}

.nav li a {
	padding: 7px 10px;
}
</style>
</head>
<body onload="searchbuidschedule();">
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#buidschedule" data-toggle="tab"
			onclick="searchbuidschedule();">机场建设进度管理</a></li>
		<li><a href="#airportinfo" data-toggle="tab"
			onclick="searchairportinfo();">机场管理</a></li>
		<li><a href="#transportinfo" data-toggle="tab"
			onclick="searchtransportinfo();">交通工具信息</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="buidschedule">
			<%@include file="/WEB-INF/pages/charts/airportinfo/buidschedule.jsp"%>
		</div>
		<div class="tab-pane fade" id="airportinfo">
			<%@include file="/WEB-INF/pages/charts/airportinfo/airportinfo.jsp"%>
		</div>
		<div class="tab-pane fade" id="transportinfo">
			<%@include file="/WEB-INF/pages/charts/airportinfo/transportinfo.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/airportinfo/js/airportinfo.jsp"%>
	<%@include file="/WEB-INF/pages/charts/airportinfo/js/buidschedule.jsp"%>
	<%@include
		file="/WEB-INF/pages/charts/airportinfo/js/transportinfo.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>