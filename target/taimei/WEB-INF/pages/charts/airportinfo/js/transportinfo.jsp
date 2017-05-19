<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addtransportinfo(){
	if($("#transportName").val()==''){
		alert('请输入交通工具名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/transportinfo_add',
		data:$('#addtransportinfoform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchtransportinfo();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updatetransportinfo(){
	if($("#uTransportName").val()==''){
		alert('请输入交通工具名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/transportinfo_update',
		data:$('#updatetransportinfoform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchtransportinfo();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdeltransportinfo(){
	var row = $("#transportinfolist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/transportinfo_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchtransportinfo();
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
function searchtransportinfo(){
	$.ajax({
		url:'${pageContext.request.contextPath}/transportinfo_search',
		data:$('#searchtransportinfoForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#transportinfolist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 field:'transportName',
		    		        	 align:'center',
		    		        	 title:'工具名称',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'transportType',
		    		        	 align:'center',
		    		        	 title:'工具类型',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'airportName',
		    		        	 align:'center',
		    		        	 title:'机场名称',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'runningTime',
		    		        	 title:'发车时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'offRunningTime',
		    		        	 title:'收车时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'intervalTime',
		    		        	 title:'发车间隔',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'sigleTripTime',
		    		        	 title:'单程时间',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'hyperbolic',
		    		        	 title:'运行线路',
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
function addtransportinfoshow(){
	var operation = '';
	$("#transportinfolist").empty();
	operation += '<form id="addtransportinfoform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">交通工具信息添加</span><span onclick="closePage(\'transportinfolist\',\'searchtransportinfo\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>工具名称:</span><input name="transportName" id="transportName"/></li>';
	operation += '<li><span>工具类型:</span><input name="transportType"/></li>';
	operation += '<li><span>机场名称:</span><input name="airportName"/></li>';
	operation += '<li><span>发车时间:</span><input name="runningTime"/></li>';
	operation += '<li><span>收车时间:</span><input name="offRunningTime"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li><span>间隔时间:</span><input name="intervalTime"/>分钟</li>';
	operation += '<li><span>单程时间:</span><input name="sigleTripTime"/>分钟</li>';
	operation += '<li><span>运行线路:</span><input name="hyperbolic"/></li>';
	operation += '</ul><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addtransportinfo()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#transportinfolist").append(operation);
}
function updatetransportinfoshow(){
	var row = $("#transportinfolist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#transportinfolist").empty();
		operation += '<form id="updatetransportinfoform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">交通工具修改</span><span onclick="closePage(\'transportinfolist\',\'searchtransportinfo\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>工具名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="transportName" id="uTransportName" value="'+row[0].transportName+'"/></li>';
		operation += '<li><span>工具类型:</span><input name="transportType" value="'+row[0].transportType+'"/></li>';
		operation += '<li><span>机场名称:</span><input name="airportName" value="'+row[0].airportName+'"/>分钟</li>';
		operation += '<li><span>发车时间:</span><input name="runningTime" value="'+row[0].runningTime+'"/></li>';
		operation += '<li><span>收车时间:</span><input name="offRunningTime" value="'+row[0].offRunningTime+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li><span>间隔时间:</span><input name="intervalTime" value="'+row[0].intervalTime+'"/>分钟</li>';
		operation += '<li><span>单程时间:</span><input name="sigleTripTime" value="'+row[0].sigleTripTime+'"/>分钟</li>';
		operation += '<li><span>运行线路:</span><input name="hyperbolic" value="'+row[0].hyperbolic+'"/></li>';
		operation += '</ul><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updatetransportinfo()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#transportinfolist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>