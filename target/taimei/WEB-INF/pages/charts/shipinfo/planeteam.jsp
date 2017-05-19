<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
	href="#">承运方信息</a>》<a href="#">机队管理</a>
</font>
<br>
<br>
<aside>
	<table class="table">
		<tr>
			<td><input type="button" class="btn btn-success" value="添加"
				onclick="addplaneteamshow();"> <input type="button"
				class="btn btn-success" value="修改" onclick="updateplaneteamshow();">
				<input type="button" class="btn btn-success" value="批量删除"
				onclick="batchdelplaneteam();"></td>
			<td>
				<form id="searchplaneteamForm" method="post"
					enctype="application/x-www-form-urlencoded">
					机队名称: <input name="teamname" style="width: 120px"
						placeholder="请输入机队名称"> <input type="button"
						class="btn btn-success" value="查询" onclick="searchplaneteam();"></input>
				</form>
			</td>
		</tr>
	</table>
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<table id="planeteamlist"></table>
			</div>
		</div>
	</section>
</aside>