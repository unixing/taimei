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
</style>
<script type="text/javascript">
function selectAll(){
	$('#datalist :checkbox').attr('checked',$(obj).attr("checked"));
}
</script>
</head>
<body onload="search()">
	<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
		href="#">城市信息</a>
	</font>
	<br>
	<br>
	<aside>
		<table class="table">
			<tr>
				<td><input type="button" class="btn btn-success" value="添加"
					onclick="addshow();"> <input type="button"
					class="btn btn-success" value="修改" onclick="updateshow();">
					<input type="button" class="btn btn-success" value="批量删除"
					onclick="batchdel();"></td>
				<td>
					<form id="systemLog-searchForm" method="post"
						enctype="application/x-www-form-urlencoded">
						城市名称: <input name="cityName" style="width: 120px"
							placeholder="请输入城市名称"> <input type="button"
							class="btn btn-success" id="btn" value="查询" onclick="search();"></input>
					</form>
				</td>
			</tr>
		</table>
		<section class="content">
			<div class="row">
				<div class="col-md-12" id="datalist"></div>
			</div>
		</section>
	</aside>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/charts/cityinfo/js/cityinfo.jsp"%>
	<%@include file="/WEB-INF/pages/common/commonAjax.jsp"%>
</body>
</html>