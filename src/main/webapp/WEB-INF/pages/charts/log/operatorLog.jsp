<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>太美航空</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<%@include file="/WEB-INF/pages/common/css.jsp"%>
</head>
<body>
	<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">数据管理</a>》<a
		href="#">操作日志</a>
	</font>
	<br>
	<br>
	<aside>
		<form id="systemLog-searchForm" method="post"
			enctype="application/x-www-form-urlencoded">
			<table>
				<tr>
					<td colspan="2">操作人： <input name="opName" id="opName"
						type="text" style="width: 160px" /> 时间范围: <input type='text'
						width="60px;" id="startDate" name="startDate" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						id='datetimepicker1' /> - <input type='text' width="60px;"
						name="endDate" id="endDate" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						id='datetimepicker2' /> IP地址： <input name="opIp" id="opIp"
						type="text" style="width: 160px" />
					</td>
				</tr>
				<tr>
					<td style="width: 95%">操作结果： <select name="opresult"
						id="opresult" class="btn btn-default dropdown-toggle "
						style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
							<option value="0">所有</option>
							<option value="1">成功</option>
							<option value="2">失败</option>
					</select> 日志分类： <select name="logtype" id="logtype"
						class="btn btn-default dropdown-toggle "
						style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
							<option value="0">所有</option>
							<option value="1">登陆</option>
							<option value="2">功能访问</option>
							<option value="3">数据操作</option>
							<option value="5">系统信息</option>
					</select> 日志分级： <select name="logrank" id="logrank"
						class="btn btn-default dropdown-toggle "
						style="appearance: none; -moz-appearance: none; -webkit-appearance: none;">
							<option value="0">所有</option>
							<option value="1">信息</option>
							<option value="3">错误</option>
					</select> <input type="button" class="btn btn-success" name="mySbumit"
						id="btn" value="查询" onclick="getData();"></input>

					</td>
					<td style="width: 5%"><input type="button"
						class="btn btn-success" name="mySbumit" id="btn" value="清空日志"
						onclick="clearData();"></input></td>
				</tr>
			</table>
		</form>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<table id="logtable">
					</table>
				</div>
			</div>
		</section>
	</aside>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/log/js/operatorLogJS.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>