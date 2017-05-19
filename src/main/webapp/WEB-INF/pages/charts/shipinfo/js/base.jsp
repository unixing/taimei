<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addbase(){
	if($("#baseName").val()==''){
		alert('请输入城市名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/base_add',
		data:$('#addbaseform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchbase();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updatebase(){
	if($("#uBaseName").val()==''){
		alert('请输入城市名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/base_update',
		data:$('#updatebaseform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchbase();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdelbase(){
	var row = $("#baselist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/base_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchbase();
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
function searchbase(){
	$.ajax({
		url:'${pageContext.request.contextPath}/base_search',
		data:$('#searchbaseForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#baselist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 field:'baseName',
		    		        	 title:'基地名称',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'cityname',
		    		        	 title:'城市名称',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planeCount',
		    		        	 title:'飞机数量',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'planeType',
		    		        	 title:'机型',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'flyingRoutes',
		    		        	 title:'在线航线',
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
function addbaseshow(){
	var operation = '';
	$("#baselist").empty();
	operation += '<form id="addbaseform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">基地信息添加</span><span onclick="closePage(\'baselist\',\'searchbase\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>基地名称:</span><input name="baseName" id="baseName"/></li>';
	operation += '<li><span>城市名称:</span><input name="cityname"/></li>';
	operation += '<li><span>飞机数量:</span><input name="planeCount"/></li>';
	operation += '<li><span>机型:</span><input name="planeType"/></li>';
	operation += '<li><span>在线航线:</span><input name="flyingRoutes"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addbase()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#baselist").append(operation);
}
function updatebaseshow(){
	var row = $("#baselist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#baselist").empty();
		operation += '<form id="updatebaseform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">基地信息修改</span><span onclick="closePage(\'baselist\',\'searchbase\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>基地名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="baseName" value="'+row[0].baseName+'"/></li>';
		operation += '<li><span>城市名称:</span><input name="cityname" value="'+row[0].cityname+'"/></li>';
		operation += '<li><span>飞机数量:</span><input name="planeCount" value="'+row[0].planeCount+'"/></li>';
		operation += '<li><span>机型:</span><input name="planeType" value="'+row[0].planeType+'"/></li>';
		operation += '<li><span>在线航线:</span><input name="flyingRoutes" value="'+row[0].flyingRoutes+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updatebase()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#baselist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>