<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
	href="#">机场信息管理</a>》<a href="#">机场建设情况</a>
</font>
<br>
<br>
<aside>
	<table class="table">
		<tr>
			<td><input type="button" class="btn btn-success" value="添加"
				onclick="addbuidscheduleshow();"> <input type="button"
				class="btn btn-success" value="修改"
				onclick="updatebuidscheduleshow();"> <input type="button"
				class="btn btn-success" value="批量删除"
				onclick="batchdelbuidschedule();"></td>
			<td>
				<form id="searchbuidscheduleForm" method="post"
					enctype="application/x-www-form-urlencoded">
					机场名称: <input name="airportname" style="width: 120px"
						placeholder="请输入机场名称"> <input type="button"
						class="btn btn-success" value="查询" onclick="searchbuidschedule();">
				</form>
			</td>
		</tr>
	</table>
	<section class="content">
		<div class="row">
			<div class="col-md-12" id="buidschedulelist"></div>
		</div>
	</section>
</aside>