<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<script type="text/javascript">
		window.onload=function(){
			 $('#opName').bind('keypress',function(event){
		            if(event.keyCode == "13"){
		            	getData();
		            }
		     });
			 $('#opIp').bind('keypress',function(event){
		            if(event.keyCode == "13"){
		            	getData();
		            }
		     });
			 getData();
		};
		function clearData(){
			if(window.confirm('你确定要清空日志吗？')){
				$.ajax({
			        type:'post',
			        url:'${pageContext.request.contextPath}/deleteAllOperatorLog',//请求数据的地址	
			        data:null,
			        success:function(data){
			        	 getData();
			        }
			    });
             }else{
                return false;
   			}
		}
		
		function getData(){
			var custormersearchForm;
//	 		拿到form表单对象
			custormersearchForm = $("#systemLog-searchForm");
//	 		调用自定义方法, 内部处理好数据结构拿到json数据对象
			var searchJson = custormersearchForm.searchJson();
			var queryParams = function(params) {
				return {
					limit: params.limit,   //页面大小
		            offset: params.offset,  //页码
		            opresult : searchJson.opresult,
		            opName : searchJson.opName,
		            logtype : searchJson.logtype,
		            logrank : searchJson.logrank,
		            opIp : searchJson.opIp,
		            startDate : searchJson.startDate,
		            endDate : searchJson.endDate,
		            order: params.order,
		            ordername: params.sort
				};
			};
				$('#logtable').bootstrapTable("destroy");
				$('#logtable').bootstrapTable({
		            url: '${pageContext.request.contextPath}/operatorLogList',
		            striped: true,
		            pagination: true,
		            pageList: [10,50,200],
		            pageSize:10,
		            pageNumber:1,
		            showExport: false, //是否显示导出
        			exportDataType: "basic",
		            queryParams:queryParams,
		            queryParamsType: "limit",
		            sidePagination:'server',//设置为服务器端分页
		            columns:[
						{
						field: 'userName',
						title: '操作人',
						width: '80',
						},
						{
						field: 'opTime',
						title: '操作时间',
						width: '80',
						},    
						{
						field: 'opIp',
						title: '访问IP',
						width: '80',
						}, 
						{
						field: 'methodName',
						title: '访问功能',
						width: '80',
						}, 
						{
						field: 'opResult',
						title: '操作结果',
						width: '80',
						}, 
						{
						field: 'logType',
						title: '日志类型',
						width: '80',
						}, 
						{
						field: 'logRank',
						title: '日志级别',
						width: '80',
						}, 
						{
						field: 'params',
						title: '查询的参数',
						width: '80',
						}
						]
		        });
     };
	</script>
