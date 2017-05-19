<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>太美航空</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
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
<body onload="searchbase();">
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#base" data-toggle="tab"
			onclick="searchbase();">基地管理</a></li>
		<li><a href="#saledptinfo" data-toggle="tab"
			onclick="searchsaledptinfo();">驻外营业部管理</a></li>
		<li><a href="#planeteam" data-toggle="tab"
			onclick="searchplaneteam();">机队管理</a></li>
		<li><a href="#timeresource" data-toggle="tab"
			onclick="searchtimeresource();">时刻资源管理</a></li>
		<li><a href="#flyingairroute" data-toggle="tab"
			onclick="searchflyingairroute();">在飞航线管理</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="base">
			<%@include file="/WEB-INF/pages/charts/shipinfo/base.jsp"%>
		</div>
		<div class="tab-pane fade" id="saledptinfo">
			<%@include file="/WEB-INF/pages/charts/shipinfo/saledptinfo.jsp"%>
		</div>
		<div class="tab-pane fade" id="planeteam">
			<%@include file="/WEB-INF/pages/charts/shipinfo/planeteam.jsp"%>
		</div>
		<div class="tab-pane fade" id="timeresource">
			<%@include file="/WEB-INF/pages/charts/shipinfo/timeresource.jsp"%>
		</div>
		<div class="tab-pane fade" id="flyingairroute">
			<%@include file="/WEB-INF/pages/charts/shipinfo/flyingairroute.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/shipinfo/js/base.jsp"%>
	<%@include file="/WEB-INF/pages/charts/shipinfo/js/flyingairroute.jsp"%>
	<%@include file="/WEB-INF/pages/charts/shipinfo/js/planeteam.jsp"%>
	<%@include file="/WEB-INF/pages/charts/shipinfo/js/saledptinfo.jsp"%>
	<%@include file="/WEB-INF/pages/charts/shipinfo/js/timeresource.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>