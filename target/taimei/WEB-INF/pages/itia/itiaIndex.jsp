<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<%@include file="/WEB-INF/pages/common/css.jsp"%>
<link
	href="${pageContext.request.contextPath}/css/bootstrap-editable/bootstrap-editable.css"
	rel="stylesheet" type="text/css">
<style type="text/css">
.cover {
	position: fixed;
	top: 0px;
	right: 0px;
	bottom: 0px;
	filter: alpha(opacity = 60);
	background-color: #777;
	z-index: 1002;
	left: 0px;
	display: none;
	opacity: 0.5;
	-moz-opacity: 0.5;
}
</style>
</head>
<body>
<body>
	<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">数据管理</a>》<a
		href="#">三字码补齐</a>
	</font>
	<h2 align="center" style="color: red">请注意,暂时只支持Execl文件,请选择正确的数据源上传
		如下:</h2>
	<div class="container" align="center">
		<input id="file" type="file" class="btn btn-warning" name="file">
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/NullExcel">
			<input type="submit" class="btn btn-warning" value="下载上传数据文件表头模板">
		</form>
		<input id="upload_file" class="btn btn-danger" type="button"
			onclick="itia();" value="验证数据">
	</div>
	<h2 align="center" style="color: red">这里将显示无YB运价和航距的数据</h2>
	<div class="col-md-12">
		<table id="example2" class="table table-bordered table-hover"
			data-toggle="table">
			<thead>
				<tr>
					<th data-field="voyageCode" data-editable="true"
						data-sortable="true">航段三字码</th>
					<th data-field="voyageName" data-editable="true"
						data-sortable="true">城市-城市</th>
					<th data-field="yBFare" data-editable="true" data-sortable="true">YB运价</th>
					<th data-field="sailingDistance" data-editable="true"
						data-sortable="true">航距</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="systemdictionaryDlg-bottons" align="center">
		<a href="javascript:void(0)" class="btn btn-success" onclick="save();">确定上传</a>
		<a href="javascript:void(0)" class="btn btn-info" onclick="cancel();">取消上传</a>
	</div>
	<div id="cover" class="cover" align="center">
		<h1>
			<font color="#D9D919">请等待数据的验证</font>
		</h1>
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/itia/js/itia.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>
