<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<font size="2" color="gray"> <br> &emsp;当前位置:<a href="#">航线网络规划</a>》<a
	href="#">承运方信息</a>》<a href="#">在飞航线管理</a>
</font>
<br>
<br>
<aside>
	<table class="table">
		<tr>
			<td><input type="button" class="btn btn-success" value="添加"
				onclick="addflyingairrouteshow();"> <input type="button"
				class="btn btn-success" value="修改"
				onclick="updateflyingairrouteshow();"> <input type="button"
				class="btn btn-success" value="批量删除"
				onclick="batchdelflyingairroute();"></td>
			<td>
				<form id="searchflyingairrouteForm" method="post"
					enctype="application/x-www-form-urlencoded">
					航线名称: <input name="airroute" style="width: 120px"
						placeholder="请输入航线"> <input type="button"
						class="btn btn-success" name="mySbumit" id="btn" value="查询"
						onclick="searchflyingairroute();"></input>
				</form>
			</td>
		</tr>
	</table>
	<section class="content">
		<div class="row">
			<div class="col-md-12" id="flyingairroutelist"></div>
		</div>
	</section>
</aside>