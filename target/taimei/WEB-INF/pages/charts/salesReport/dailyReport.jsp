<%@ page language="java" contentType="text/html; charset=UTF-8"%>
日期：
<input id="dailyReportDate" type='text' width="100px;" name="startDate"
	class="Wdate" onfocus="WdatePicker({onpicked:getAllTime})"
	value="${defaultDate }" />
总飞行时间：
<input id="flyTime" type='text' width="50px;" name="flyTime" value=""
	onchange="dailyReport();" />
小时成本：
<input id="hourPrice" type='text' width="50px;" name="hourPrice"
	value="" onchange="dailyReport();" />
<table id="dailyReportTable">

</table>

