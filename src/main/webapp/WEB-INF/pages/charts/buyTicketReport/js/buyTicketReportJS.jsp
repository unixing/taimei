<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<script type="text/javascript">
		var flight = "";
		window.onload = function(){ 
			var object = parent.supData;
			flight = object.flight;
			if(flight!=null&&flight!=''&&flight!="undefined"){
				var lane = object.lane;
				var dpt = flight.split("/");
				$('#flt_nbr_Count').val(dpt[0]);
				var nowdate=new Date();
				$('#datetimepicker4').val(addDate(nowdate,-1));
				$('#datetimepicker5').val(addDate(nowdate,30));
				send();
			}
		};
		
		function addDate(date,days){ 
			var d=new Date(date); 
			d.setDate(d.getDate()+days); 
			var month=d.getMonth()+1; 
			var day = d.getDate(); 
			if(month<10){ 
			month = "0"+month; 
			} 
			if(day<10){ 
			day = "0"+day; 
			} 
			var val = d.getFullYear()+"-"+month+"-"+day; 
			return val; 
		}
			//查询方法
			function send(){
				buyTicketReportData();
				$("#tableAir1").bootstrapTable("destroy");
				$("#tableAir2").bootstrapTable("destroy");
				$("#tableAir3").bootstrapTable("destroy");
				$("#tableAir4").bootstrapTable("destroy");
				$("#tableAir5").bootstrapTable("destroy");
				$("#tableAir6").bootstrapTable("destroy");
				$("#ticket1").html("上客进度表");
				$("#ticketli2").css('display', 'none');
				$("#ticketli3").css('display', 'none');
				$("#ticketli4").css('display', 'none');
				$("#ticketli5").css('display', 'none');
				$("#ticketli6").css('display', 'none');
			}
			//得到上客进度表数据
			function buyTicketReportData(){
				var custormersearchForm;
				custormersearchForm = $("#DOW-searchForm");
				var searchJson = custormersearchForm.searchJson();
				if(""!=searchJson.startTime&&""!=searchJson.endTime&&""!=searchJson.flt_nbr_Count){
					$.ajax({
						beforeSend: function(){
							$('#myTabContent').hide();
							$("#wate").attr("style","display: block;");
				        },
				        complete:function(){
				        	$("#wate").attr("style","display: none;");
				        	$('#myTabContent').show();
				        },
	        	        type:'post',
	        	        url:'${pageContext.request.contextPath}/getBuyTicketReportData',
	        	        data:searchJson,
	        	        success:function(data){
	        	        	var i =1;
	        	        	var isempty = true;
	        	        	for (var key in data) {
	        	        		isempty = false;
	        	        	}
	        	        	if(!isempty){
	        	        		for(var key in data)  {
		        	        		$("#ticketli"+i).css('display', 'block');
		        	        		$("#ticket"+i).html(key+"上客进度表");
		        	        		createTableData(i,data[key]);
		        	        		i++;
		        	        	} 
	        	        	}else{
	        	        		var abc = [];
	        	        		createTableData(i,abc);
	        	        	}
	        	        	
	        	        }
	        	    }); 
				}else{
					alert("请检查查询条件");
				}
			}
			//创建表格
			function createTableData(index,datasorce){
				$("#tableAir"+index+"").bootstrapTable({
					data: datasorce,         
		            method: 'get',                      
		            cache: false,  
		            showFooter:false,
		            showColumns: false,
		            dataType: "json",
		            pagination: false, 
		            width: "100%",
		            queryParams: null,
		            sidePagination: "server",          
		            pageNumber:1,                       
		            pageSize: 10,                       
		            pageList: [10, 25, 50, 100],  
		            columns:[
						{
						field: 'progress02',
						title: '0-2天进度',
						},
						{
						field: 'progress06',
						title: '0-6天进度',
						},
						{
						field: 'progress011',
						title: '0-11天进度',
						width:'80'
						},    
						{
						field: 'fltNumDate',
						title: '航班日期&nbsp&nbsp&nbsp&nbsp',
						width:'80'
						}, 
						{
						field: 'dow',
						title: 'DOW&nbsp&nbsp&nbsp',
						width:'80'
						},
						{field: 'progressf1',title: '-1'},
						{field: 'progress0',title: '0'},
						{field: 'progress1',title: '1'},
						{field: 'progress2',title: '2'},
						{field: 'progress3',title: '3'},
						{field: 'progress4',title: '4'},
						{field: 'progress5',title: '5'},
						{field: 'progress6',title: '6'},
						{field: 'progress7',title: '7'},
						{field: 'progress8',title: '8'},
						{field: 'progress9',title: '9'},
						{field: 'progress10',title: '10'},
						{field: 'progress11',title: '11'},
						{field: 'progress12',title: '12'},
						{field: 'progress13',title: '13'},
						{field: 'progress14',title: '14'},
						{field: 'progress15',title: '15'},
						{field: 'progress16',title: '16'},
						{field: 'progress17',title: '17'},
						{field: 'progress18',title: '18'},
						{field: 'progress19',title: '19'},
						{field: 'progress20',title: '20'},
						{field: 'progress21',title: '21'},
						{field: 'progress22',title: '22'},
						{field: 'progress23',title: '23'},
						{field: 'progress24',title: '24'},
						{field: 'progress25',title: '25'},
						{field: 'progress26',title: '26'},
						{field: 'progress27',title: '27'},
						{field: 'progress28',title: '28'},
						{field: 'progress29',title: '29'},
						{field: 'progress30',title: '30'},
						{field: 'progressd30',title: '>30'}
						]
		       		 });
			}
			
		</script>
