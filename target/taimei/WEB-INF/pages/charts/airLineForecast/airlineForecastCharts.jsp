
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>


<table class="table">
	<tr style="width: 100%">
		<th style="text-align: center; vertical-align: middle;">飞行小时（往返）:</th>
		<th style="text-align: center; vertical-align: middle;"><input
			type="text" id="fly_time" style="width: 80px;"><input
			type="hidden" id="id"></th>
		<th style="text-align: center; vertical-align: middle;">小时成本:</th>
		<th style="text-align: center; vertical-align: middle;"><input
			type="text" id="fly_price" style="width: 100px;"></th>
		<th style="text-align: center; vertical-align: middle;">机型:</th>
		<th style="text-align: center; vertical-align: middle;"><input
			type="text" id="fly_type" style="width: 100px"></th>
		<th style="text-align: center; vertical-align: middle;">座位数:</th>
		<th style="text-align: center; vertical-align: middle;"><input
			type="text" id="fly_site" style="width: 100px"></th>
		<th style="text-align: center; vertical-align: middle;">班期:</th>
		<th style="text-align: center; vertical-align: middle;"><input
			type="text" id="fly_banqi" style="width: 100px"></th>
	</tr>
	<tr style="width: 100%">
		<th style="text-align: center; vertical-align: middle;">代理费（%）:</th>
		<th style="text-align: center; vertical-align: middle;" colspan="1"><input
			type="text" id="daili_price" style="width: 100px"></th>
		<th style="text-align: center; vertical-align: middle;">计划执行班次:</th>
		<th style="text-align: center; vertical-align: middle;" colspan="1"><input
			type="text" id="fly_banci" placeholder='往返为一次' style="width: 100px"></th>
		<th style="text-align: center; vertical-align: middle;">预编排时刻:</th>
		<th style="text-align: center; vertical-align: middle;" colspan="2"><input
			type="text" id="bp_time" style="width: 250px"></th>
		<th style="text-align: center; vertical-align: middle;">参考:</th>
		<th style="text-align: center; vertical-align: middle;" colspan="2"><input
			type="text" id="bark" style="width: 300px"></th>
	</tr>
</table>

<table style="display: none; width: 100%;" id="talTable"
	class="table table-bordered">
	<tr style="width: 100%">
		<th style="text-align: center; vertical-align: middle;"></th>
		<th style="text-align: center; vertical-align: middle;" id="aa"
			colspan="10"></th>
	</tr>
	<tr style="width: 100%">
		<td style="text-align: center; vertical-align: middle;" id="bb"
			rowspan="3"></td>
		<td style="text-align: center; vertical-align: middle;" id="cc"
			colspan="3"></td>
		<td style="text-align: center; vertical-align: middle;" id="dd"
			colspan="3"></td>
		<td style="text-align: center; vertical-align: middle;" id="ee"
			colspan="4"></td>
	</tr>
	<tr style="width: 100%">
		<td style="text-align: center; vertical-align: middle;" id="ff"
			rowspan="2"></td>
		<td style="text-align: center; vertical-align: middle;" id="gg"
			colspan="5"></td>
		<td style="text-align: center; vertical-align: middle;" id="hh"
			colspan="4"></td>
	</tr>
	<tr style="width: 100%">
		<td style="text-align: center; vertical-align: middle;" id="jj"></td>
		<td style="text-align: center; vertical-align: middle;" id="kk"></td>
		<td style="text-align: center; vertical-align: middle;" id="mm"></td>
		<td style="text-align: center; vertical-align: middle;" id="nn"></td>
		<td style="text-align: center; vertical-align: middle;" id="oo"></td>
		<td style="text-align: center; vertical-align: middle;" id="pp"></td>
		<td style="text-align: center; vertical-align: middle;" id="qq"></td>
		<td style="text-align: center; vertical-align: middle;" id="rr"></td>
		<td style="text-align: center; vertical-align: middle;" id="ss"></td>
	</tr>
	<tr style="width: 100%">
		<td style="text-align: center; vertical-align: middle;" id="tt"></td>
		<td style="text-align: center; vertical-align: middle;" id="uu"></td>
		<td style="text-align: center; vertical-align: middle;" id="vv"></td>
		<td style="text-align: center; vertical-align: middle;" id="xx"></td>
		<td style="text-align: center; vertical-align: middle;" id="yy"></td>
		<td style="text-align: center; vertical-align: middle;" id="zz"></td>
		<td style="text-align: center; vertical-align: middle;" id="aaa"></td>
		<td style="text-align: center; vertical-align: middle;" id="bbb"></td>
		<td style="text-align: center; vertical-align: middle;" id="ccc"></td>
		<td style="text-align: center; vertical-align: middle;" id="ddd"></td>
		<td style="text-align: center; vertical-align: middle;" id="eee"></td>
	</tr>

</table>
<table id="tableData" class=" table table-bordered">
	<thead>
		<tr>
			<th data-field="id"
				style="text-align: center; vertical-align: middle; display: none;">序号</th>
			<th data-field="doTime"
				style="text-align: center; vertical-align: middle;">执行时间</th>
			<th data-field="hangduan" width="500px;"
				style="text-align: center; vertical-align: middle;">航段</th>
			<th data-field="hangju"
				style="text-align: center; vertical-align: middle;">航距</th>
			<th data-field="yc_price"
				style="text-align: center; vertical-align: middle;">Y舱价格</th>
			<th data-field="qwtdjg_price"
				style="text-align: center; vertical-align: middle;">切位团队价</th>
			<th data-field="f_flag"
				style="text-align: center; vertical-align: middle;">150%</th>
			<th data-field="y_flag"
				style="text-align: center; vertical-align: middle;">100%</th>
			<th data-field="b_flag"
				style="text-align: center; vertical-align: middle;">90%</th>
			<th data-field="h_flag"
				style="text-align: center; vertical-align: middle;">85%</th>
			<th data-field="k_flag"
				style="text-align: center; vertical-align: middle;">80%</th>
			<th data-field="l_flag"
				style="text-align: center; vertical-align: middle;">75%</th>
			<th data-field="m_flag"
				style="text-align: center; vertical-align: middle;">70%</th>
			<th data-field="q_flag"
				style="text-align: center; vertical-align: middle;">65%</th>
			<th data-field="x_flag"
				style="text-align: center; vertical-align: middle;">60%</th>
			<th data-field="u_flag"
				style="text-align: center; vertical-align: middle;">55%</th>
			<th data-field="e_flag"
				style="text-align: center; vertical-align: middle;">50%</th>
			<th data-field="z_flag"
				style="text-align: center; vertical-align: middle;">45%</th>
			<th data-field="t_flag"
				style="text-align: center; vertical-align: middle;">40%</th>
			<th data-field="v_flag"
				style="text-align: center; vertical-align: middle;">35%</th>
			<th data-field="g_flag"
				style="text-align: center; vertical-align: middle;">30%</th>
			<th data-field="o_flag"
				style="text-align: center; vertical-align: middle;">25%</th>
			<th data-field="s_flag"
				style="text-align: center; vertical-align: middle;">0%</th>
			<th data-field="qp_flag"
				style="text-align: center; vertical-align: middle;">团队折扣</th>
			<th data-field="qt_flag"
				style="text-align: center; vertical-align: middle;">特殊</th>
			<th data-field="strshj"
				style="text-align: center; vertical-align: middle;">散团人数合计</th>
			<th data-field="skzrs"
				style="text-align: center; vertical-align: middle;">散客总人数</th>
			<th data-field="skzys"
				style="text-align: center; vertical-align: middle;">散客总营收</th>
			<th data-field="tdzys"
				style="text-align: center; vertical-align: middle;">团队总营收</th>
			<th data-field="dlf"
				style="text-align: center; vertical-align: middle;">代理费</th>
			<th data-field="zglsr"
				style="text-align: center; vertical-align: middle;">座公里收入</th>
			<th data-field="pjzk"
				style="text-align: center; vertical-align: middle;">平均折扣</th>
			<th data-field="stzys"
				style="text-align: center; vertical-align: middle;">散团总营收</th>
			<th data-field="xsys"
				style="text-align: center; vertical-align: middle;">小时营收</th>
			<th data-field="zhkzl"
				style="text-align: center; vertical-align: middle;">综合客座率</th>
			<th data-field="jbbt"
				style="text-align: center; vertical-align: middle;">均班补贴/含代理费</th>
			<th data-field="nbt"
				style="text-align: center; vertical-align: middle;">总补贴/含代理费</th>
			<th data-field="ttl"
				style="text-align: center; vertical-align: middle;">吞吐量</th>
		</tr>
	</thead>
</table>

