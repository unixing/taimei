<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addbuidschedule(){
	if($("#bAirportName").val()==''){
		alert('请输入机场名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/buidschedule_add',
		data:$('#addbuidscheduleform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchbuidschedule();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updatebuidschedule(){
	if($("#bUAirportName").val()==''){
		alert('请输入机场名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/buidschedule_update',
		data:$('#updatebuidscheduleform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchbuidschedule();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdelbuidschedule(){
	var row = $("#buidschedulelist").bootstrapTable('getSelections');
	if(row.length>0){
		var ids = '';
		for(var i=0;i<row.length;i++){
			if(i==0){
				ids +=row[i].id;
			}else{
				ids +=','+row[i].id
			}
		}
		$.ajax({
			url:'${pageContext.request.contextPath}/buidschedule_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchbuidschedule();
					}
				}else{
					alert('后台操作异常');
				}
			}
		});
	}else{
		alert('请选择一条数据');
	}
}
function searchbuidschedule(){
	$.ajax({
		url:'${pageContext.request.contextPath}/buidschedule_search',
		data:$('#searchbuidscheduleForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#buidschedulelist").bootstrapTable("destroy").bootstrapTable({
					data:list,
		    		sidePagination:'server',
		    		pageNumber:1,                       
		            pageSize: 10,                       
		            pageList: [10, 25, 50, 100],
		    		columns:[
		    		         {
		    		        	 field:'id',
		    		        	 visible:false,
		    		         },{
		    		        	 title:'选择',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		        	 checkbox:true
		    		         },{
		    		        	 field:'airportName',
		    		        	 title:'机场名称',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'initBuidDate',
		    		        	 title:'初建时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'acceptDate',
		    		        	 title:'验收时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'revisedDate',
		    		        	 title:'校飞时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'testFlightDate',
		    		        	 title:'试飞时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planedShipDate',
		    		        	 title:'通航时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'destination',
		    		        	 title:'通航城市',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'targetThroughput',
		    		        	 title:'吞吐量',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'awardingPolicy',
		    		        	 title:'奖励政策',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         }
		    		         
   		         	]
				});
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function addbuidscheduleshow(){
	var operation = '';
	$("#buidschedulelist").empty();
	operation += '<form id="addbuidscheduleform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">机场进度信息添加</span><span onclick="closePage(\'buidschedulelist\',\'searchbuidschedule\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>机场名称:</span><input name="airportName" id="bAirportName"/></li>';
	operation += '<li><span>初建时间:</span><input name="initBuidDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
	operation += '<li><span>验收时间:</span><input name="acceptDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
	operation += '<li><span>校飞时间:</span><input name="revisedDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
	operation += '<li><span>试飞时间:</span><input name="testFlightDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li><span>通航时间:</span><input name="planedShipDate" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
	operation += '<li><span>通航城市:</span><input name="destination"/></li>';
	operation += '<li><span>吞吐量:</span><input name="targetThroughput"/></li>';
	operation += '<li><span>奖励政策:</span><input name="awardingPolicy"/></li>';
	operation += '</ul><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addbuidschedule()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#buidschedulelist").append(operation);
}
function updatebuidscheduleshow(){
	var row = $("#buidschedulelist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#buidschedulelist").empty();
		operation += '<form id="updatebuidscheduleform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">机场进度信息修改</span><span onclick="closePage(\'buidschedulelist\',\'searchbuidschedule\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>机场名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="airportName" id="bUAirportName" value="'+row[0].airportName+'"/></li>';
		operation += '<li><span>初建时间:</span><input name="initBuidDate" value="'+row[0].initBuidDate+'" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
		operation += '<li><span>验收时间:</span><input name="acceptDate" value="'+row[0].acceptDate+'" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
		operation += '<li><span>校飞时间:</span><input name="revisedDate" value="'+row[0].revisedDate+'" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
		operation += '<li><span>试飞时间:</span><input name="testFlightDate" value="'+row[0].testFlightDate+'" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li><span>通航时间:</span><input name="planedShipDate" value="'+row[0].planedShipDate+'" onfocus="WdatePicker({dateFmt: \'yyyy-MM-dd HH:mm:ss\'})"/></li>';
		operation += '<li><span>通航城市:</span><input name="destination" value="'+row[0].destination+'"/></li>';
		operation += '<li><span>吞吐量:</span><input name="targetThroughput" value="'+row[0].targetThroughput+'"/></li>';
		operation += '<li><span>奖励政策:</span><input name="awardingPolicy" value="'+row[0].awardingPolicy+'"/></li>';
		operation += '</ul><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updatebuidschedule()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#buidschedulelist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>