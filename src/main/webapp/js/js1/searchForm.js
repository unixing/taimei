
var thisflag=true;



var zyshj=0,zxsys=0,zzgl=0,zavgkzl=0,zavgzk=0,zsumrs=0,zsumtd=0,zsumsk=0;     //标题数据
var Allarr={};
var naviChip=0;
var longhongA= 0,longhongB= 0,longhongC=0;





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



$(".sales-check .lhead").on("click",function(){
		if($(this).attr("tag")==="off"){
			$(".sales-check").animate({"width":"100%"});
			$(".sales-check-co").show();
			$(this).attr("tag","on");
			$(".sales-check-close").css({"right":"19%","width":"80px"});
		}	
})
$(".sales-check-close").on("click",function(){			
	$(".sales-check").animate({"width":"200px"});
	$(".sales-check-co").hide();
	$(".sales-check .lhead").attr("tag","off");
	$(".sales-check-close").css({"right":"10%","width":"5px"});
})

//航段无数据动画
function SD_hd_null(){
    $("div.SD-hd-null").show();
    setTimeout(function(){
        $(".SD-hd-null").hide();
    }
    ,2000)
}







//报表改版——longhong、2017-5



//头部航段导航
function create_hd(hdata){
	longhongA= 0,longhongB= 0,longhongC=0;
	zyshj=0,zxsys=0,zzgl=0,zavgkzl=0,zavgzk=0,zsumrs=0,zsumtd=0,zsumsk=0;     //标题归0
	clearAllarr();
    $('.bc').text('实际班次：'+((typeof(hdata.success.executiveClass)=='undefined'||hdata.success.executiveClass==null||hdata.success.executiveClass=='')?0:$.digitization(hdata.success.executiveClass))+'班');
	var hddata= hdata.success.newmap;
	$(".sales-check-co ul.leglist").empty();
	naviChip=0;
	$.each(hddata.everyList,function(i,el){	//创建
		if(el.flyName.split("-").length<3 && el.flyName.indexOf("=")<0){			
			if(dataIsNull(el.dataMap.hasData)){	//根据客座量判断 
      		$(".sales-check-co ul.leglist").append("<li tag="+ el.flyCode +" isN='true'>"+ el.flyName.split("-")[0] + "<span>&#xe60e;</span>"+el.flyName.split("-")[1] + "</li>");
			}
			else{
      		$(".sales-check-co ul.leglist").append("<li class='TMnodata-opacity' tag="+ el.flyCode +" isN='false'>"+ el.flyName.split("-")[0] + "<span>&#xe60e;</span>"+el.flyName.split("-")[1] + "</li>");
			}
		}
	})
	
	
	
	//绑定航段单击事件
	$(".sales-check .leglist li").bind("click",function(){
		if($(this).attr("isN")=="true"){
			if($(this).hasClass("ck")){
				if(naviChip>1){
					$(this).removeClass("ck");
					naviChip-=1;
					reDrawChart(hddata,$(this).attr("tag"),"sub");
				}
			}
			else{
				$(this).addClass("ck");
				naviChip+=1;
				reDrawChart(hddata,$(this).attr("tag"),"add");
			}
		}
		else{
			
			SD_hd_null();
			return;
		}
	})
	$(".sales-check .lhead").click();    	//打开导航
	for(let a=0 ; a<$(".sales-check .leglist li").length ; a++){	//预全选
		if($(".sales-check .leglist li").eq(a).attr("isN")=="true"){
			$(".sales-check .leglist li").eq(a).click();			
		}
	}
}


function dataIsNull(d){//判断数据是否为空
	if(d=="" || d==null || d==undefined || d==0){
		return false
	}
	else{
		return true;
	}
}


function clearAllarr(){//重置数据数组
	for (var key in Allarr){
		Allarr[key]=[];
	}
}


function reDrawChart(data,hd,type){		//重绘图表
  $.each(data.everyList,function(i,el){
      if(hd==el.flyCode){
    	  if(pageflag=="week" || pageflag=="month"){
    		  mad(el,type);
    	  }
    	  else if(pageflag=="season"){
    		  //newmid(el,yearText,type);
    	  }
    	  else if(pageflag=="year"){
    		  //
    	  }
      }
  })
}
function mad(d,type){		//数据封装
    if(d!=null){
    	let an=(typeof(d.dataMap.hbys)=='undefined'||d.dataMap.hbys==null||d.dataMap.hbys=='')?0.00:$.digitization(d.dataMap.hbys);    	
    	let bn=(typeof(d.dataMap.xsys)=='undefined'||d.dataMap.xsys==null||d.dataMap.xsys=='')?0.00:$.digitization(d.dataMap.xsys);
    	let cn=(typeof(d.dataMap.zgl)=='undefined'||d.dataMap.zgl==null||d.dataMap.zgl=='')?0.00:d.dataMap.zgl
    	let dn=(typeof(d.dataMap.kzl)=='undefined'||d.dataMap.kzl==null||d.dataMap.kzl=='')?0.00+'%':d.dataMap.kzl+'%';
    	let en=(typeof(d.dataMap.zk)=='undefined'||d.dataMap.zk==null||d.dataMap.zk=='')?0.00+'%':d.dataMap.zk+'%';
    	let fn=$.digitization(((typeof(d.dataMap.skzrs)=='undefined'||d.dataMap.skzrs==null||d.dataMap.skzrs=='')?0:parseInt(d.dataMap.skzrs))+((typeof(d.dataMap.stzrs)=='undefined'||d.dataMap.stzrs==null||d.dataMap.stzrs=='')?0:parseInt(d.dataMap.stzrs)));
    	//标题数据
    	
    	if(type=="add"){
    		zyshj += toNum(an);
    		zxsys += toNum(bn);
    		zzgl += parseFloat(cn);
    		zavgkzl += toNum(dn);
    		zavgzk += toNum(en);
    		zsumrs += toNum(fn);
    		zsumtd+=(typeof(d.dataMap.stzrs)=='undefined'||d.dataMap.stzrs==null||d.dataMap.stzrs=='')?0:parseInt(d.dataMap.stzrs);
    		zsumsk+=(typeof(d.dataMap.skzrs)=='undefined'||d.dataMap.skzrs==null||d.dataMap.skzrs=='')?0:parseInt(d.dataMap.skzrs);
    	}
    	else if(type=="sub"){
    		zyshj -= toNum(an);    		
    		zxsys -= toNum(bn); 
    		zzgl -= parseFloat(cn);
    		zavgkzl -= toNum(dn);
    		zavgzk -= toNum(en);
    		zsumrs -= toNum(fn);
    		zsumtd -= (typeof(d.dataMap.stzrs)=='undefined'||d.dataMap.stzrs==null||d.dataMap.stzrs=='')?0:parseInt(d.dataMap.stzrs);
    		zsumsk -= (typeof(d.dataMap.skzrs)=='undefined'||d.dataMap.skzrs==null||d.dataMap.skzrs=='')?0:parseInt(d.dataMap.skzrs);
    	}
    	
        $('#allIncome').text(formatNumber(zyshj,2,1));	//总营收
        $('#hourIncome').text(formatNumber(zxsys/naviChip,2,1));
        $('#raskIncome').text(parseFloat(zzgl/naviChip).toFixed(2));
        $('#allAvgPlf').text(parseFloat(zavgkzl/naviChip).toFixed(2) +'%');
        $('#allAvgDis').text(parseFloat(zavgzk/naviChip).toFixed(2) +'%');
        $("#allTotalPC").text(formatNumber(zsumrs,0,1));
//      $('.bc').text('计划班次：'+((typeof(data.success.planClass)=='undefined'||data.success.planClass==null||data.success.planClass=='')?0:$.digitization(data.success.planClass))+'班/实际班次：'+((typeof(data.success.executiveClass)=='undefined'||data.success.executiveClass==null||data.success.executiveClass=='')?0:$.digitization(data.success.executiveClass))+'班');
        legentArray = [];
        var incomeArray = [];
        var plfArray = [];
        var disArray = [];
        pcArray = [];
        var hourIncomeArray = [];
        var raskArray = [];
        var incomeOldArray = [];
        var plfOldArray = [];
        var disOldArray = [];
        pcOldArray = [];
        pcFit = [];
        pcGrp = [];
        pcOldFit = [];
        pcOldGrp = [];
        weekDataArray = [];
        pieArray = [zsumtd,zsumsk];
        var showContentArray = new Map();
        monthDataArray=[];
        //monthDataArray[keys] = [parseInt(obj.grp_Nbr),parseInt(obj.wak_tol_Nbr)];
        if(d.dataMap.data!=null){
            for(var key in d.dataMap.data){
                var axis = key;
            	if(pageflag=="week"){
                    var axises = axis.split('-'); 
                    legentArray.push(axises[1]+'\n'+titleList[parseInt(axises[0])-1]);
                    
            	}
            	else if(pageflag=="month"){
                    var axises = axis.split('.'); 
                    legentArray.push(parseInt(axis.split('.')[1]));                
            	}
                var obj = d.dataMap.data[key];                
                var nowTipArr=[];
                if(type=="add"){
                    longhongA += Number(obj.hbys);                	
                    longhongB += Number(obj.xssr);                	
                    longhongC += Number(obj.set_Ktr_Ine);                	
                }
                else{
                    longhongA -= Number(obj.hbys);
                    longhongB -= Number(obj.xssr);
                    longhongC -= Number(obj.set_Ktr_Ine);
                }
                nowTipArr.push($.digitization(obj.hbys));
                nowTipArr.push($.digitization(obj.xssr));
                nowTipArr.push($.digitization(obj.set_Ktr_Ine));                
//                var newTipArr=aArrAdd(tipToNumArr(nowTipArr),type,"tipArr");
                var newTipArr=oArrComp(tipToNumArr(nowTipArr),type,"tipArr");
                //oArrCompSum
                

            	if(pageflag=="week"){
                    showContentArray[axises[1]+'\n'+titleList[parseInt(axises[0])-1]] = '航班营收：'+formatNumber(longhongA,2,1)+'<br/>小时营收：'+formatNumber(newTipArr[1]/naviChip,2,1)+'<br/>座公里收入：'+formatNumber(newTipArr[2]/naviChip,2,1);
                }
            	else if(pageflag=="month"){
                    let keys=parseInt(axis.split('.')[1]);
                    monthDataArray[keys] = [parseInt(obj.grp_Nbr),parseInt(obj.wak_tol_Nbr)];
                    showContentArray[parseInt(axis.split('.')[1])] = '航班营收：'+formatNumber(newTipArr[0],2,1)+'<br/>小时营收：'+formatNumber(newTipArr[1]/naviChip,2,1)+'<br/>座公里收入：'+formatNumber(newTipArr[2]/naviChip,2,1);         
            	}
                
                incomeArray.push(parseFloat(obj.hbys).toFixed(2));
                hourIncomeArray.push(obj.xssr);
                raskArray.push(obj.set_Ktr_Ine);
                plfArray.push(parseFloat(obj.pjkzl).toFixed(2));
                disArray.push(parseFloat(obj.avg_Dct).toFixed(2));
                pcFit.push(parseInt(obj.wak_tol_Nbr));
                pcGrp.push(parseInt(obj.grp_Nbr));
                weekDataArray[axises[1]] = [parseInt(obj.grp_Nbr),parseInt(obj.wak_tol_Nbr)];
                pcArray.push(parseInt(obj.grp_Nbr)+parseInt(obj.wak_tol_Nbr));
            }
            //console.log(nowTipArr)
            if(d.dataMap.olddata!=null){
                for(var key in d.dataMap.olddata){
                    var obj = d.dataMap.olddata[key];
                    incomeOldArray.push(parseFloat(obj.hbys).toFixed(2));                    
                    plfOldArray.push(parseFloat(obj.pjkzl).toFixed(2));
                    disOldArray.push(parseFloat(obj.avg_Dct).toFixed(2));
                    pcOldFit.push(parseInt(obj.wak_tol_Nbr));
                    pcOldGrp.push(parseInt(obj.grp_Nbr));
                    pcOldArray.push(parseInt(obj.grp_Nbr)+parseInt(obj.wak_tol_Nbr));
                }
            }else{
                for(var i=0; i<raskArray.length;i++){
                    incomeOldArray.push(parseFloat(0).toFixed(2));
                    plfOldArray.push(parseFloat(0).toFixed(2));
                    disOldArray.push(parseFloat(0).toFixed(2));
                    pcOldFit.push(parseFloat(0).toFixed(2));
                    pcOldGrp.push(parseFloat(0).toFixed(2));
                    pcOldArray.push(parseFloat(0).toFixed(2));
                }
            }
            theNewCurve("income",legentArray,aArrAdd(incomeArray,type,"ys"),aArrAdd(incomeOldArray,type,"oys"),showContentArray);
            
            
            theCurve("avg_set_ine",legentArray,oArrComp(plfArray,type,"kzl"),oArrComp(plfOldArray,type,"okzl"));
            
            
            
            theCurve("person_dct",legentArray,oArrComp(disArray,type,"zk"),oArrComp(disOldArray,type,"ozk"));
            
            barThourthReport(pcname,legentArray,aArrAdd(pcArray,type,"rs"),aArrAdd(pcOldArray,type,"ors"));		//柱状图
            pieFivthReport(piename,pieArray);	//饼图
            
//          monthThourthReport(pcname,legentArray,aArrAdd(pcArray,type,"rs"),aArrAdd(pcOldArray,type,"ors"));
            //monthFivthReport(piename,pieArray);
            changew();  //重新计算大小
        }else{
            var name="income"; //收入信息
            theNewCurve(name,legentArray,incomeArray,incomeOldArray,showContentArray);
            var name="avg_set_ine"; //综合客座率
            theCurve(name,legentArray,plfArray,plfOldArray);
            var name="person_dct"; //平均折扣
            theCurve(name,legentArray,disArray,disOldArray);
//            var name="p-number";   //人数-柱状图
            barThourthReport(pcname,legentArray,pcArray,pcOldArray);
//            var name="combined";   //人数-饼图
            pieFivthReport(piename,pieArray);
        }
    }    
}


function aArrAdd(arr,type,name){	//相加减
	var newArr=[];
	if(Allarr[name]==undefined || Allarr[name].length==0){
		Allarr[name]=arr;
		newArr=arrToNumArr(arr);
	}
	else if(type=="add"){
		for(let i=0;i<Allarr[name].length;i++){
			arr=arrToNumArr(arr);
			Allarr[name][i] += arr[i];
			newArr[i]=parseInt(Allarr[name][i]);
		}		
	}
	else{	//sub
		for(let i=0;i<Allarr[name].length;i++){
			Allarr[name][i] -=arr[i];
			newArr[i]=parseInt(Allarr[name][i]);
		}		
	}
	return newArr;
}

//不封装玩什么面向对象？？？
function oArrComp(arr,type,name){	//求和后平均
	var newArr=[];	
	if(Allarr[name]==undefined  ||  Allarr[name].length==0 ){
		Allarr[name]=arrToNumArr(arr);
		newArr=arrToNumArr(arr);
	}
	else if(type=="add"){		//add
		for(let i=0;i<Allarr[name].length;i++){
			arr=arrToNumArr(arr);
			Allarr[name][i] += arr[i];
			newArr[i]=parseFloat(Allarr[name][i]/naviChip).toFixed(2);
		}
	}
	else{		//sub
		for(let i=0;i<Allarr[name].length;i++){
			Allarr[name][i] -=arr[i];
			newArr[i]=parseFloat(Allarr[name][i]/naviChip).toFixed(2);
		}		
	}
	return newArr;
}



function oArrCompA(arr,type,name){	//求和后平均
	var newArr=[];	
	if(Allarr[name]==undefined  ||  Allarr[name].length==0 ){
		Allarr[name]=arrToNumArr(arr);
		newArr=arrToNumArr(arr);
	}
	else if(type=="add"){		//add
		arr=arrToNumArr(arr);
		for(let i=0;i<Allarr[name].length;i++){
			Allarr[name][i] += arr[i];
			newArr[i]=parseFloat(Allarr[name][i]/2).toFixed(2);
		}
	}
	return newArr;
}


function oArrCompSum(arr,type,name){	//求和后返回和
	var newArr=[];	
	if(Allarr[name]==undefined  ||  Allarr[name].length==0 ){
		Allarr[name]=arrToNumArr(arr);
		newArr=arrToNumArr(arr);
	}
	else if(type=="add"){		//add
		for(let i=0;i<Allarr[name].length;i++){
			arr=arrToNumArr(arr);
			Allarr[name][i] += arr[i];
			newArr[i]=parseFloat(Allarr[name][i]).toFixed(2);
		}
	}
	else{		//sub
		for(let i=0;i<Allarr[name].length;i++){
			Allarr[name][i] -=arr[i];
			newArr[i]=parseFloat(Allarr[name][i]).toFixed(2);
		}		
	}
	return newArr;
}

function arrToNumArr(arr){//数字化数组
	for(let i=0;i<arr.length;i++){
		arr[i]=Number(arr[i]);
	}
	return arr;
}


function tipToNumArr(arr){//格式化表1 tip
	for(let i=0;i<arr.length;i++){
		arr[i]=toNum(arr[i]);
	}
	return arr;
}

function toNum(nn){//数字化数字	
	let n=nn;
	nn=nn.toString();
	if(nn.indexOf(",")>-1){
		n = parseFloat(nn.replace(/,/g,""));
	}	
	else if(nn.indexOf("%")>-1){
		n = parseFloat(nn.replace(/%/g,""));
	}
	return Number(n);
}




function formatNumber(num,cent,isThousand) {
    num = num.toString().replace(/\$|\,/g,'');
 
    // 检查传入数值为数值类型
     if(isNaN(num))
      num = "0";
 
    // 获取符号(正/负数)
    sign = (num == (num = Math.abs(num)));
 
    num = Math.floor(num*Math.pow(10,cent)+0.50000000001); // 把指定的小数位先转换成整数.多余的小数位四舍五入
    cents = num%Math.pow(10,cent);       // 求出小数位数值
    num = Math.floor(num/Math.pow(10,cent)).toString();  // 求出整数位数值
    cents = cents.toString();        // 把小数位转换成字符串,以便求小数位长度
 
    // 补足小数位到指定的位数
    while(cents.length<cent)
     cents = "0" + cents;
 
    if(isThousand) {
     // 对整数部分进行千分位格式化.
     for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
      num = num.substring(0,num.length-(4*i+3))+','+ num.substring(num.length-(4*i+3));
    }
 
    if (cent > 0)
     return (((sign)?'':'-') + num + '.' + cents);
    else
     return (((sign)?'':'-') + num);
   }



