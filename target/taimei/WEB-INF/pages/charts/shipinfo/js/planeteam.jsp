<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addplaneteam(){
	if($("#teamName").val()==''){
		alert('请输入机队名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/planeteam_add',
		data:$('#addplaneteamform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchplaneteam();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updateplaneteam(){
	if($("#uTeamName").val()==''){
		alert('请输入机队名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/planeteam_update',
		data:$('#updateplaneteamform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchplaneteam();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdelplaneteam(){
	var row = $("#planeteamlist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/planeteam_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchplaneteam();
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
function searchplaneteam(){
	$.ajax({
		url:'${pageContext.request.contextPath}/planeteam_search',
		data:$('#searchplaneteamForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#planeteamlist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 field:'teamName',
		    		        	 title:'机队名称',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planeCount',
		    		        	 title:'飞机数量',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planeType',
		    		        	 title:'飞机机型',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planeAge',
		    		        	 title:'飞机机龄',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'flyerCount',
		    		        	 title:'飞行员数量',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'teamLevel',
		    		        	 title:'机队等级',
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
function addplaneteamshow(){
	var operation = '';
	$("#planeteamlist").empty();
	operation += '<form id="addplaneteamform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">机队信息添加</span><span onclick="closePage(\'planeteamlist\',\'searchplaneteam\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>机队名称:</span><input name="teamName" id="teamName"/></li>';
	operation += '<li><span>飞机数量:</span><input name="planeCount"/></li>';
	operation += '<li><span>飞机机型:</span><input name="planeType"/></li>';
	operation += '<li><span>飞机机龄:</span><input name="planeAge"/></li>';
	operation += '<li><span>飞行员数量:</span><input name="flyerCount"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li><span>机队等级:</span><input name="teamLevel"/></li>';
	operation += '</ul><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addplaneteam()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#planeteamlist").append(operation);
}
function updateplaneteamshow(){
	var row = $("#planeteamlist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#planeteamlist").empty();
		operation += '<form id="updateplaneteamform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">机队信息修改</span><span onclick="closePage(\'planeteamlist\',\'searchplaneteam\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>机队名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="teamName" id="uTeamName" value="'+row[0].teamName+'"/></li>';
		operation += '<li><span>飞机数量:</span><input name="planeCount" value="'+row[0].planeCount+'"/></li>';
		operation += '<li><span>飞机类型:</span><input name="planeType" value="'+row[0].planeType+'"/></li>';
		operation += '<li><span>飞机机龄:</span><input name="planeAge" value="'+row[0].planeAge+'"/></li>';
		operation += '<li><span>飞行员数量:</span><input name="flyerCount" value="'+row[0].flyerCount+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li><span>机队等级:</span><input name="teamLevel" value="'+row[0].teamLevel+'"/></li>';
		operation += '</ul><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updateplaneteam()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#planeteamlist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>