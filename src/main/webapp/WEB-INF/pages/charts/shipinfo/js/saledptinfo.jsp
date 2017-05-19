<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function addsaledptinfo(){
	if($("#dptName").val()==''){
		alert('请输入部门名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/saledptinfo_add',
		data:$('#addsaledptinfoform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchsaledptinfo();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function updatesaledptinfo(){
	if($("#uDptName").val()==''){
		alert('请输入部门名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/saledptinfo_update',
		data:$('#updatesaledptinfoform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					searchsaledptinfo();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdelsaledptinfo(){
	var row = $("#saledptinfolist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/saledptinfo_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						searchsaledptinfo();
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
function searchsaledptinfo(){
	$.ajax({
		url:'${pageContext.request.contextPath}/saledptinfo_search',
		data:$('#searchsaledptinfoForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#saledptinfolist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 field:'dptName',
		    		        	 title:'部门名称',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'address',
		    		        	 title:'地址',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'linkman',
		    		        	 title:'联系人',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'contactWay',
		    		        	 title:'联系方式',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'whetherLocalBase',
		    		        	 title:'是否同城基地',
		    		        	 align:'center',
		    		        	 width:'4%',
		    		         },{
		    		        	 field:'mapDisplay',
		    		        	 title:'地图显示',
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
function addsaledptinfoshow(){
	var operation = '';
	$("#saledptinfolist").empty();
	operation += '<form id="addsaledptinfoform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">部门信息添加</span><span onclick="closePage(\'saledptinfolist\',\'searchsaledptinfo\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>部门名称:</span><input name="dptName" id="dptName"/></li>';
	operation += '<li><span>地址:</span><input name="address"/></li>';
	operation += '<li><span>联系人:</span><input name="linkman"/></li>';
	operation += '<li><span>联系方式:</span><input name="contactWay"/></li>';
	operation += '<li><span>是否同城基地:</span><input name="whetherLocalBase"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li><span>地图显示:</span><input name="mapDisplay"/></li>';
	operation += '</ul><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="addsaledptinfo()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#saledptinfolist").append(operation);
}
function updatesaledptinfoshow(){
	var row = $("#saledptinfolist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#saledptinfolist").empty();
		operation += '<form id="updatesaledptinfoform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">部门信息修改</span><span onclick="closePage(\'saledptinfolist\',\'searchsaledptinfo\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>部门名称:</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="dptName" id="uDptName" value="'+row[0].dptName+'"/></li>';
		operation += '<li><span>地址:</span><input name="address" value="'+row[0].address+'"/></li>';
		operation += '<li><span>联系人:</span><input name="linkman" value="'+row[0].linkman+'"/></li>';
		operation += '<li><span>联系方式:</span><input name="contactWay" value="'+row[0].contactWay+'"/></li>';
		operation += '<li><span>是否同城基地:</span><input name="whetherLocalBase" value="'+row[0].whetherLocalBase+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li><span>地图显示:</span><input name="mapDisplay" value="'+row[0].mapDisplay+'"/></li>';
		operation += '</ul><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="updatesaledptinfo()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#saledptinfolist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>