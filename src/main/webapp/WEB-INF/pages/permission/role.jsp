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
}

ul li {
	list-style-type: none;
	float: left;
	line-height: 35px;
	text-indent: 10px;
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

.show_title {
	height: 27px;
	line-height: 22px;
	width: 100%;
	background: url(../images/bg01.gif) repeat-x left bottom;
	float: left;
	text-align: right;
	border-bottom: 1px solid #ccc;
}

.show_content ul {
	width: 100%;
	float: left;
	text-decoration: none;
	text-align: center;
	color: #000;
}

.mask {
	margin-top: 0 auto;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: 0.6;
	top: 0;
	filter: alpha(opacity = 60);
	left: 0;
	display: block;
	position: absolute;
	z-index: 10;
	display: none;
}

.warp {
	width: 960px;
	height: 1350px;
	margin: 0 auto;
	position: relative;
	z-index: 11;
	display: none;
}

.show_content {
	width: 96%;
	height: 90%;
	margin: 40px auto;
	background: #fff;
	position: relative;
	z-index: 11;
}

.hide_btn {
	float: right;
	cursor: pointer;
	font-style: normal;
	padding-right: 10px;
	color: #fff;
	font-weight: bold;
}

.show_title b {
	display: block;
	float: left;
	padding-left: 27px;
	background: url(../images/bg02.gif) no-repeat 5px 4px;
	color: #fff;
}
</style>
<script type="text/javascript">
function selectAll(){
	$('#datalist :checkbox').attr('checked',$(obj).attr("checked"));
}
</script>
</head>
<body onload="search()">
	<div class="mask"></div>
	<div class="warp">
		<div class="show_content"></div>
	</div>
	<div class="base_content">
		<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
			href="#">角色列表</a>
		</font><br>
		<br>
		<aside>
			<table class="table">
				<tr>
					<td><input type="button" class="btn btn-success" value="添加"
						onclick="addshow();"> <input type="button"
						class="btn btn-success" value="修改" onclick="updateshow();">
						<input type="button" class="btn btn-success" value="删除"
						onclick="del();"> <input type="button"
						class="btn btn-success" value="设置权限" onclick="setPermission();">
					</td>
					<td>
						<form id="systemLog-searchForm" method="post"
							enctype="application/x-www-form-urlencoded">
							角色名称: <input name="name" style="width: 120px"
								placeholder="请输入角色名称"> <input type="button"
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
	</div>
	<%@include file="/WEB-INF/pages/common/common.jsp"%>
	<%@include file="/WEB-INF/pages/permission/js/role.jsp"%>
	<%@include file="/WEB-INF/pages/permission/js/common.jsp"%>
	<script type="text/javascript">
$(document).on('change','input[type="checkbox"]',function(e){
	 var checked = $(this).prop("checked"),
   container = $(this).parent(),
   siblings = container.siblings();

	container.find('input[type="checkbox"]').prop({
	  //indeterminate: false,
	  checked: checked
	});
	
	function checkSiblings(el) {
	
	  var parent = el.parent().parent(),
	      all = true;
	
	  el.siblings().each(function() {
	    return all = ($(this).children('input[type="checkbox"]').prop("checked") === checked);
	  });
	
	  if (all && checked) {
	
	    parent.children('input[type="checkbox"]').prop({
	      //indeterminate: false,
	      checked: checked
	    });
	
	    checkSiblings(parent);
	
	  } else if (all && !checked) {
	
	    parent.children('input[type="checkbox"]').prop("checked", checked);
	    //parent.children('input[type="checkbox"]').prop("indeterminate", (parent.find('input[type="checkbox"]:checked').length > 0));
	    checkSiblings(parent);
	
	  } else {
	
	    el.parents("td").children('input[type="checkbox"]').prop({
	      //indeterminate: true,
	      //checked: false
	      checked:true
	    });
	
	  }
	
	}
	
	checkSiblings(container);
});
</script>
</body>
</html>