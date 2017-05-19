<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/wbox/wbox.js"></script>
<script type="text/javascript">
		function save(){
			showMask();
			$.get("${pageContext.request.contextPath}/saveFare",function(data){
				if(data.success){
					$("#cover").hide();
					$('#example2').bootstrapTable('destroy');
					alert(data.message);
			 	}
			});
		};
		function cancel(){
			$.get("${pageContext.request.contextPath}/externalCancel",function(data){
				$('#example2').bootstrapTable('destroy');
				alert("成功取消");
			});
		};
	</script>
<script type="text/javascript">
	function showMask(){
		$('body').css("overflow","hidden")
		$("#cover").show();
		};
	function itia(){
		var data = new FormData();
		var cars = $("#cars").val();	
		var outAndOnAir = $("#outAndOnAir").val();	
		data.append('file', $("#file")[0].files[0]);
		showMask();
		$.ajax({
			data : data,
			url : "${pageContext.request.contextPath}/itiaChech?cars="+cars,
			type : 'post',
			contentType : false,
			processData : false,
			success : function(data) {
				if(data.success){
					alert(data.message);
					$("#cover").hide();
					$.ajax({
		                type: "get",
		                url:"${pageContext.request.contextPath}/itiaUpdate",
		                dataType: "json",
		                success: function (Json) {
		                	$('#example2').bootstrapTable('destroy').bootstrapTable({
		    	        	    data:Json,
		    	        	    pagination: true,                   //是否显示分页（*）
		    	                sortable: true,                     //是否启用排序
		    	                sortOrder: "asc",                   //排序方式
		    	                sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
		    	                search: true,
		    	                pageNumber: 1,                       //初始化加载第一页，默认第一页
		    	                pageSize: 10,
		    	                pageList: [10, 25, 50, 100,"ALL"], 
		    	        	    onEditableSave: function (field, row, oldValue, $el) {
		    	        	    	console.debug(row);
		    	        	    	if(!/^[0-9]*$/.test(row.yBFare)||!/^[0-9]*$/.test(row.sailingDistance)){
		    	        	            alert("请输入数字!");
		    	        	        }else{
			    	                    $.ajax({
			    	                        type: "post",
			    	                        url: "${pageContext.request.contextPath}/saveITIA",
			    	                        data: row,
			    	                        success: function (data, status) {
			    	                           
			    	                        },
			    	                        error: function () {
			    	                        },
			    	                        complete: function () {
	
			    	                        }
	
			    	                    });
		    	        	        }
		    	                }
		    	        	    
		    	        	});
		                }
		            });
				var file = $("#file") ;
				file.after(file.clone().val(""));      
				file.remove(); 
				}
			},
			error : function() {
			}
		});
	};
	
	</script>