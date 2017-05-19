<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addflyingairroute(){
	if($("#airRoute").val()==''){
		alert('请输入航线');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/flyingairroute_add',
		data:$('#addform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchflyingairroute();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updateflyingairroute(){
	if($("#uAirRoute").val()==''){
		alert('请输入航线');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/flyingairroute_update',
		data:$('#updateform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchflyingairroute();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdelflyingairroute(){
	var row = $("#flyingairroutelist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/flyingairroute_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchflyingairroute();
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
function searchflyingairroute(){
	$.ajax({
		url:'${pageContext.request.contextPath}/flyingairroute_search',
		data:$('#searchflyingairrouteForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#flyingairroutelist").bootstrapTable("destroy").bootstrapTable({
					data:list,
					cache: false,  
		            showFooter:false,
		            showColumns: false,
		            dataType: "json",
		            pagination: false, 
		            width: "100%",
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
		    		        	 field:'airRoute',
		    		        	 title:'航线',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'airRouteType',
		    		        	 title:'航线类型',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'schedule',
		    		        	 title:'班期',
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
function addflyingairrouteshow(){
	var operation = '';
	$("#flyingairroutelist").empty();
	operation += '<form id="addform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">航线信息添加</span><span onclick="closePage(\'flyingairroutelist\',\'searchflyingairroute\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>航线:</span><input name="airRoute" id="airRoute"/></li>';
	operation += '<li><span>航线类型:</span><input name="airRouteType"/></li>';
	operation += '<li><span>班期:</span><input name="schedule"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addflyingairroute()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#flyingairroutelist").append(operation);
}
function updateflyingairrouteshow(){
	var row = $("#flyingairroutelist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#flyingairroutelist").empty();
		operation += '<form id="updateform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">航线信息修改</span><span onclick="closePage(\'flyingairroutelist\',\'searchflyingairroute\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>城市名:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="airRoute" id="uAirRoute" value="'+row[0].airRoute+'"/></li>';
		operation += '<li><span>航线类型:</span><input name="airRouteType" value="'+row[0].airRouteType+'"/></li>';
		operation += '<li><span>班期:</span><input name="schedule" value="'+row[0].schedule+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updateflyingairroute()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#flyingairroutelist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>