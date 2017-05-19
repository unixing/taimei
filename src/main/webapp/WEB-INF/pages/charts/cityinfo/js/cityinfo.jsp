<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
function add(){
	if($("#acityName").val()==''){
		alert('请输入城市名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/cityinfo_add',
		data:$('#addform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					search();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function update(){
	if($("#ucityName").val()==''){
		alert('请输入城市名称');
		return;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/cityinfo_update',
		data:$('#updateform').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				alert(data.msg);
				if(data.opResult=='0'){
					search();
				}
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function batchdel(){
	var row = $("#datalist").bootstrapTable('getSelections');
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
			url:'${pageContext.request.contextPath}/cityinfo_batchdel',
			data:{
				ids:ids
			},
			type:'post',
			success:function(data){
				if(data!=null){
					alert(data.msg);
					if(data.opResult=='0'){
						search();
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
function search(){
	$.ajax({
		url:'${pageContext.request.contextPath}/cityinfo_search',
		data:$('#systemLog-searchForm').serialize(),
		type:'post',
		success:function(data){
			if(data!=null){
				var list = data.info;
				$("#datalist").bootstrapTable("destroy").bootstrapTable({
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
		    		        	 width:'8%',
		    		        	 checkbox:true
		    		         },{
		    		        	 field:'cityname',
		    		        	 title:'城市名',
		    		        	 width:'8%',
		    		         },{
		    		        	 field:'economy',
		    		        	 title:'经济（单位：元）',
		    		        	 width:'8%',
		    		         },{
		    		        	 field:'population',
		    		        	 title:'人口',
		    		        	 width:'8%',
		    		         },{
		    		        	 field:'percapita',
		    		        	 title:'人均（单位：元）',
		    		        	 width:'8%',
		    		         },{
		    		        	 field:'structure',
		    		        	 title:'结构',
		    		        	 width:'8%',
		    		         },{
		    		        	 field:'traffic',
		    		        	 title:'交通',
		    		        	 width:'8%',
		    		         },{
		    		        	 field:'area',
		    		        	 title:'面积（单位：km^2）'
		    		        	 ,width:'8%',
		    		         },{
		    		        	 field:'popedom',
		    		        	 title:'辖区',
		    		        	 width:'8%',
		    		         }
		    		         
   		         	]
				});
			}else{
				alert('后台操作异常');
			}
		}
	});
}
function addshow(){
	var operation = '';
	$("#datalist").empty();
	operation += '<form id="addform">';
	operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
	operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">城市信息添加</span><span onclick="closePage(\'datalist\',\'search\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
	operation += '<div class="content"><ul>';
	operation += '<li><span>城市名：</span><input name="cityname"/></li>';
	operation += '<li><span>经&nbsp;&nbsp;&nbsp;济:</span><input name="economy"/>元</li>';
	operation += '<li><span>人&nbsp;&nbsp;&nbsp;口:</span><input name="population"/></li>';
	operation += '<li><span>人&nbsp;&nbsp;&nbsp;均:</span><input name="percapita"/>元</li>';
	operation += '<li><span>结&nbsp;&nbsp;&nbsp;构:</span><input name="structure"/></li>';
	operation += '</ul><div class="clear"></div><ul>';
	operation += '<li><span>交&nbsp;&nbsp;&nbsp;通:</span><input name="traffic"/></li>';
	operation += '<li><span>面&nbsp;&nbsp;&nbsp;积:</span><input name="area"/>km^2</li>';
	operation += '<li><span>辖&nbsp;&nbsp;&nbsp;区:</span><input name="popedom"/></li>';
	operation += '</ul><ul>';
	operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="添加" onclick="add()"></li>';
	operation += '</li></ul></div></div></form>';
	$("#datalist").append(operation);
}
function updateshow(){
	var row = $("#datalist").bootstrapTable('getSelections');
	if(row.length==1){
		var operation = '';
		$("#datalist").empty();
		operation += '<form id="updateform">';
		operation += '<div class="addorupdate" style="border: 1px solid #dedede;">';
		operation += '<div class="title" style="background: #f2f0f1; width:100%;height:30px"><span style="line-height: 30px; font-weight: bold;color:#999798;">城市信息修改</span><span onclick="closePage(\'datalist\',\'search\');" style="font-weight:bold;float:right;line-height:30px;color:#999798;cursor:pointer;margin-right:5px;">关闭</span></div>';
		operation += '<div class="content"><ul>';
		operation += '<li><span>城市名：</span><input type="hidden" name="id" value="'+row[0].id+'"/><input name="cityname" value="'+row[0].cityname+'"/></li>';
		operation += '<li><span>结&nbsp;&nbsp;&nbsp;构:</span><input name="economy" value="'+row[0].economy+'"/>元</li>';
		operation += '<li><span>人&nbsp;&nbsp;&nbsp;口:</span><input name="population" value="'+row[0].population+'"/></li>';
		operation += '<li><span>人&nbsp;&nbsp;&nbsp;均:</span><input name="percapita" value="'+row[0].percapita+'"/>元</li>';
		operation += '<li><span>结&nbsp;&nbsp;&nbsp;构:</span><input name="structure" value="'+row[0].structure+'"/></li>';
		operation += '</ul><div class="clear"></div><ul>';
		operation += '<li><span>交&nbsp;&nbsp;&nbsp;通:</span><input name="traffic" value="'+row[0].traffic+'"/></li>';
		operation += '<li><span>面&nbsp;&nbsp;&nbsp;积:</span><input name="area" value="'+row[0].area+'"/>km^2</li>';
		operation += '<li><span>辖&nbsp;&nbsp;&nbsp;区:</span><input name="popedom" value="'+row[0].popedom+'"/></li>';
		operation += '</ul><ul>';
		operation += '<li style="width:100%; text-align: center;"><input class="btn btn-success" type="button" value="修改" onclick="update()"></li>';
		operation += '</li></ul></div></div></form>';
		$("#datalist").append(operation);
	}else{
		alert('请选择一条数据');
	}
}
</script>