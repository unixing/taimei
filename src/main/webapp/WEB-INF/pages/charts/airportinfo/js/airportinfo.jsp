<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addairportinfo(){
	if($("#airportName").val()==''){
		alert('请输入机场名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/airportinfo_add',
		data:$('#addairportinfoform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchairportinfo();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updateairportinfo(){
	if($("#uAirportName").val()==''){
		alert('请输入机场名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/airportinfo_update',
		data:$('#updateairportinfoform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchairportinfo();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdelairportinfo(){
	var row = $("#airportinfolist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/airportinfo_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchairportinfo();
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
function searchairportinfo(){
	$.ajax({
		url:'${pageContext.request.contextPath}/airportinfo_search',
		data:$('#searchairportinfoForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#airportinfolist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 align:'center',
		    		        	 title:'机场名称',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'runwayLength',
		    		        	 title:'跑道长度',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'runwayWidth',
		    		        	 title:'跑道宽度',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'airportLevel',
		    		        	 title:'机场等级',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'fireRating',
		    		        	 title:'消防等级',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'canStopType',
		    		        	 title:'停降机型',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'airportType',
		    		        	 title:'机场类型',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'climaticChanges',
		    		        	 title:'气候变化规律',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'clearanceCondition',
		    		        	 title:'净空条件',
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
function addairportinfoshow(){
	var operation = '';
	$("#airportinfolist").empty();
	operation += '<form id="addairportinfoform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">'
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">机场信息添加</span><span onclick="closePage(\'airportinfolist\',\'searchairportinfo\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>机场名称:</span><input name="airportName" id="airportName"/></li>';
	operation += '<li><span>跑道长度:</span><input name="runwayLength"/>米</li>';
	operation += '<li><span>跑道宽度:</span><input name="runwayWidth"/>米</li>';
	operation += '<li><span>机场等级:</span><input name="airportLevel"/></li>';
	operation += '<li><span>消防等级:</span><input name="fireRating"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li><span>停降机型:</span><input name="canStopType"/></li>';
	operation += '<li><span>机场类型:</span><input name="airportType"/></li>';
	operation += '<li><span>气候变化规律:</span><input name="climaticChanges"/></li>';
	operation += '<li><span>净空条件:</span><input name="clearanceCondition"/></li>';
	operation += '</ul><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addairportinfo()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#airportinfolist").append(operation);
}
function updateairportinfoshow(){
	var row = $("#airportinfolist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#airportinfolist").empty();
		operation += '<form id="updateairportinfoform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">'
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">机场信息修改</span><span onclick="closePage(\'airportinfolist\',\'searchairportinfo\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>机场名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="airportName" id="uAirportName" value="'+row[0].airportName+'"/></li>';
		operation += '<li><span>跑道长度:</span><input name="runwayLength" value="'+row[0].runwayLength+'"/>米</li>';
		operation += '<li><span>跑道宽度:</span><input name="runwayWidth" value="'+row[0].runwayWidth+'"/>米</li>';
		operation += '<li><span>机场等级:</span><input name="airportLevel" value="'+row[0].airportLevel+'"/></li>';
		operation += '<li><span>消防等级:</span><input name="fireRating" value="'+row[0].fireRating+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li><span>停降机型:</span><input name="canStopType" value="'+row[0].canStopType+'"/></li>';
		operation += '<li><span>机场类型:</span><input name="airportType" value="'+row[0].airportType+'"/></li>';
		operation += '<li><span>气候变化规律:</span><input name="climaticChanges" value="'+row[0].climaticChanges+'"/></li>';
		operation += '<li><span>净空条件:</span><input name="clearanceCondition" value="'+row[0].clearanceCondition+'"/></li>';
		operation += '</ul><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updateairportinfo()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#airportinfolist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>