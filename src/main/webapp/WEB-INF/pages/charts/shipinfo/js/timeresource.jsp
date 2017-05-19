<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addtimeresource(){
	if($("#terminal").val()==''){
		alert('请输入航站名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/timeresource_add',
		data:$('#addtimeresourceform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchtimeresource();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updatetimeresource(){
	if($("#uTerminal").val()==''){
		alert('请输入航站名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/timeresource_update',
		data:$('#updatetimeresourceform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchtimeresource();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdeltimeresource(){
	var row = $("#timeresourcelist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/timeresource_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchtimeresource();
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
function searchtimeresource(){
	$.ajax({
		url:'${pageContext.request.contextPath}/timeresource_search',
		data:$('#searchtimeresourceForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#timeresourcelist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 width:'4%',
		    		        	 align:'center',
		    		        	 checkbox:true
		    		         },{
		    		        	 field:'terminal',
		    		        	 title:'航站名称',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'proofreadAirline',
		    		        	 title:'校对航司',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'flightNbr',
		    		        	 title:'航班号',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'airRoute',
		    		        	 title:'航线',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planeType',
		    		        	 title:'飞机机型',
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
function addtimeresourceshow(){
	var operation = '';
	$("#timeresourcelist").empty();
	operation += '<form id="addtimeresourceform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">时刻信息添加</span><span onclick="closePage(\'timeresourcelist\',\'searchtimeresource\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>航站名称:</span><input name="terminal" id="terminal"/></li>';
	operation += '<li><span>校对航司:</span><input name="proofreadAirline"/></li>';
	operation += '<li><span>航班号:</span><input name="flightNbr"/></li>';
	operation += '<li><span>航线:</span><input name="airRoute"/></li>';
	operation += '<li><span>飞机机型:</span><input name="planeType"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addtimeresource()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#timeresourcelist").append(operation);
}
function updatetimeresourceshow(){
	var row = $("#timeresourcelist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#timeresourcelist").empty();
		operation += '<form id="updatetimeresourceform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">时刻信息修改</span><span onclick="closePage(\'timeresourcelist\',\'searchtimeresource\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>航站名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="terminal" id="uTerminal" value="'+row[0].terminal+'"/></li>';
		operation += '<li><span>校对航司:</span><input name="proofreadAirline" value="'+row[0].proofreadAirline+'"/></li>';
		operation += '<li><span>航班号:</span><input name="flightNbr" value="'+row[0].flightNbr+'"/></li>';
		operation += '<li><span>航线:</span><input name="airRoute" value="'+row[0].airRoute+'"/></li>';
		operation += '<li><span>飞机机型:</span><input name="planeType" value="'+row[0].planeType+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updatetimeresource()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#timeresourcelist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>