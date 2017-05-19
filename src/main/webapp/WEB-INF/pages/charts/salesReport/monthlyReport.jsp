<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<input id="monthlyReportDate" type='text' width="100px;"
	name="startDate" class="Wdate"
	onfocus="WdatePicker({dateFmt:'yyyy-MM',onpicked:monthlyReport})"
	value="${defaultMonth }" />

<table id="monthlyReportTable">

</table>
