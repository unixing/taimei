$.fn.searchJson = function(){
	//定义一个json对象
	var paramObj = {};
	//获得from参数数组
	var paramArr = $(this).serializeArray();
	//遍历
	$.each(paramArr,function(i,data){
		//组装成json对象
		paramObj[data.name]=data.value;
		
	});
	//将组装好json对象返回给调用者
	return paramObj;
};
function searchData(data){
	return data += "&companyId="+$(window.parent.document.body).find("#myCompanyList").val();
};
//格式化数字函数，s为数字的字符串,n为保留的位数
function fomatDigit(s, n){  
	if(s!=null && typeof(s)!="undefined" && s!=0){
		if(n==0){
			   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")) + "";  
			   var l = s.split(".")[0].split("").reverse(),  
			   t = "";  
			   for(i = 0; i < l.length; i ++ )  
			   {  
			      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
			   }  
			   return t.split("").reverse().join("");  
		}else{
			   n = n > 0 && n <= 20 ? n : 2;  
			   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
			   var l = s.split(".")[0].split("").reverse(),  
			   r = s.split(".")[1];  
			   t = "";  
			   for(i = 0; i < l.length; i ++ )  
			   {  
			      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
			   }  
			   return t.split("").reverse().join("") + "." + r;  
		}
	}else{
		 return s;
	}
	
} 