<%@page import="org.ldd.ssm.crm.utils.UserContext"%>
<%@page import="java.util.List"%>
<%@page import="org.ldd.ssm.crm.domain.Menu"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>数聚空港</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta name="renderer" content="webkit"> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/systemCss/systemCss.css" rel="stylesheet"> --%>
    <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/bootstrap.css" rel="stylesheet">
    <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/animate.css" rel="stylesheet">
    <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/platform.css" rel="stylesheet">
    <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/coalesce.css" rel="stylesheet"/>
    <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/drawSimulateAirRoute.css" rel="stylesheet"/>
    <%-- <link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/warehouse.css" rel="stylesheet"/> --%>
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="/img/icon/logo.png" />
    <script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/jquery1.8.3.js"></script>
    <script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/ajaxfileupload.js"></script>
    <script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/bootstrap.js"></script>
    <script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/jquery.myConfirm.js"></script>
    <script language="javascript" type="text/javascript" src="http://fw.qq.com/ipaddress"></script> 
    <%@include file="/WEB-INF/pages/index/js/index.jsp"%>
</head>
<script type="text/javascript">
	var cityName = "<%=session.getAttribute("companyName_session")%>";
	var cityIata = '<%=session.getAttribute("companyItia_session")%>';
	 /* window.onload = getCurrentPermission(); */
	var menus = '<%=session.getAttribute("menuAll")%>';
	var menus2 = '<%=session.getAttribute("menu")%>';
	var ipness = <%=UserContext.getIpNess()%>;
</script>
<body onselectstart="return false" unselectable="return false">
<div class="pla-box container-fluid">
    <div id="container"></div>
    <div class="pla-head">
        <div class="pla-title">
           <!--  <h3>空港智家&nbsp;(+)</h3>
            <p>Airport Big DataService</p> -->
        </div>
        <div class="pla-spread">
            <ul>
                <li>&#xe694;</li>
                <li>统计
                    <ul class="pla-spread-statistical">
                        <li class="menu" id='_permissions_1'><a class="flagClass" href="/airline" target="new_frame">航线历史收益统计</a></li>
                        <li class="menu" id='_permissions_2'><a href="/outPort" target="new_frame">机场历史运营</a></li>
                        <li class="menu" id='_permissions_3'><a class="flagClass" href="totalFlyAnalysis" target="new_frame">共飞运营对比</a></li>
                    </ul>
                    <!-- <div class="pla-spread-indicate">&#xe60a;</div> -->
                </li>
                <li>报表
                    <ul class="pla-spread-statistical">
                        <li class="menu" id='_permissions_4'><a class="flagClass" href="/SourceDistribution" target="new_frame">客源组成</a></li>
                        <li class="menu" id='_permissions_5'><a class="flagClass" href="/buyTicketReport" target="new_frame">销售动态</a></li>
                        <li class="menu" id='_permissions_xx'><a class="flagClass" href="/SalesData/accountCheck" target="new_frame">销售数据</a></li>
                    </ul>
                    <!-- <div class="pla-spread-indicate">&#xe60a;</div> -->
                </li>
                <li>监控
                    <ul class="pla-spread-statistical">
                        <li class="menu" id='_permissions_6'><a href="/airline_dynamic" target="new_frame">航班动态</a></li>
                       <li class="menu" id='_permissions_7'><a href="/processTask" target="new_frame">时刻分布</a></li>
                    </ul>
                    <!-- <div class="pla-spread-indicate">&#xe60a;</div> -->
                </li>
               <!--  <li>客源分析</li> -->
            </ul>
        </div>
    </div>
    <div class="pla-tool">
        <%-- <ul>
            <li>
               ${companyName_session}市
            </li>
            <li>
                <span>&#xe670;</span>
                <span>${user_in_session.usrNm}</span>
                <div class='pla-tool-notice'>&#xe64b;</div>
                <ul class="pla-tool-account">
                    <li style="color: gray;">个人资料</li>
                    <li>系统设置</li>
                    <li style="color: gray;">手机APP</li>
                    <li style="color: gray;">消息</li>
                    <li>退出</li>
                </ul>
            </li>
            <li>
                <span>&#xe60b;</span>
                <span>工具</span>
                 <ul class="pla-tool-accounts">
                    <li>时刻查询</li>
                </ul>
            </li>
        </ul> --%>
        <div class="pla-tool-name">${companyName_session}市</div>
        <div class="pla-tool-useName">
        <div class="pla-tool-iList">
            <div class="pla-tool-img">
	            <%
	            	if(!"".equals(UserContext.getUser().getHeadPath())){
	             %>
                	<img class="small-head" src="${user_in_session.headPath}" >
                <%}else{ %>
                	<img class="small-head" src="/css/images/ph.jpg" >
                <%} %>
            </div>
            <div class="pla-tool-icon">&#xe64c;</div>
        </div>
            <div class="useName-n">${user_in_session.usrNm}</div>
            <ul class="se-list">
                <li class="sSettings" onclick="setting()">设置</li>
                <li>退出登录</li>
            </ul>
        </div>
        <div class="pla-tool-set">
            <div class="set-gj">工具</div>
            <ul class="useName-list">
                <li onclick='airLine()'>航司信息查询</li>
                <li onclick='cityQuery()'>城市信息查询</li>
                <li onclick='airQuery()'>机场信息查询</li>
                <li>航班号查询</li>
                <li id='global-routes'>全国航线视图</li>
                <%if(UserContext.getIpNess()){ %>
                	<li id="simulate-routes">模拟航线视图</li>
                <%} %>
            </ul>
        </div>
    </div>
    
<!--     【首页样式】增加右侧查询图标    2017-3-29 -->
    <div class="pla-search">
    	<span class="pla-search-icon">
    	&#xe691;
    	<span>
    	<div class="pla-search-panel">
    	<div class="pla-search-panel-head">航班号 <span>&#xe648;</span></div>
    	<div class="pla-search-panel-body">
    		<input id="pla-search-id" type="text">
		</div>
    	</div>
    </div>
    <div class="pla-zoom">
        <div>&#xe60d;</div>
        <div>&#xe60e;</div>
    </div>
    <div class="pla-data">
        <div class="material-fact-cityMaterial">
            <div class="material-fact-cityTime"></div>
            <p class="material-fact-cityName"><span id="cityName"></span>机场</p>
        </div>
        <div class="material-fact-cityBody">
        </div>
        <div class="material-fact-install">
            <div class="material-fact-installBox">
                <div class="indicators">
                    <div class="indicators-title">
                        <span>首页指标事件维度选择：</span>
                    </div>
                    <div>
                        <label><input name="Fruit" type="radio" value="" id="yesterday"/>最近1天</label>
                        <label><input name="Fruit" type="radio" value="" id="sevenDay"/>最近7天</label>
                        <label><input name="Fruit" type="radio" value=""  id="thirtyDay"/>最近30天</label>
                    </div>
                </div>
                <div class="indicators">
                    <div class="indicators-title">
                        <span>航班统计范围：</span>
                    </div>
                    <div>
                        <label><input name="range" type="radio" value="" id="allFlights"/>所有航班</label>
                        <label><input name="range" type="radio" value="" id="focusFlights"/>关注航班</label>
                    </div>
                </div>
                <div class="indicators">
                    <div class="indicators-title">
                        <span>数据统计范围：</span>
                    </div>
                    <div>
                        <label><input type="checkbox" value="" id="station"/>包含过站</label>
                        <label><input type="checkbox" value="" id="jiltFly"/>包含甩飞</label>
                    </div>
                </div>
                <div class="indicators">
                    <div class="indicators-title">
                        <span class="indicators-tip">关注指标（不超过4个）：</span>
                    </div>
                    <div>
                        <label><input class="jruit" name="Jruit" type="checkbox" value=""  id="guestAmount"/><span>客量</span></label>
                        <label><input class="jruit" name="Jruit" type="checkbox" value="" id="shift"/><span>班次</span></label>
                        <label><input class="jruit" name="Jruit" type="checkbox" value="" id="income"/><span>收入</span></label>
                        <label><input class="jruit" name="Jruit" type="checkbox" value="" id="passengerVolume"/><span>均班客量</span></label></br>
                        <label><input class="jruit" name="Jruit" type="checkbox" value="" id="classIncome"/><span>均班收入</span></label>
                        <label><input class="jruit" name="Jruit" type="checkbox" value="" id="loadFactors"/><span>综合客座率</span></label>
                        <label><input class="jruit" name="Jruit" type="checkbox" value="" id="airportPunctuality"/><span>机场准点率</span></label>
                    </div>
                </div>
                <div class="indicators-bth">
                    <div class="indicators-bth-t">确定</div>
                    <div class="indicators-bth-f">取消</div>
                </div>
            </div>
            <div class="material-fact-installS">&#xe67f;</div>
            <div class="material-fact-installF">&#xe67e;</div>
        </div>
    </div>
    <div class="pla-tog">
        <div>展开信息</div>
        <div>&#xe610;</div>
    </div>
   	<div id="air"></div>
    <div class="pla-supernatant" >
        <div class="pla-supernatant-cont">
            <iframe id="pages" name="new_frame"></iframe>
        </div>
        <span class="pla-supernatant-del">&#xe84b;</span>
    </div>
    <div class="pla-promptBox">
		<div class="pla-prompTip"></div>
		<div class="pla-prompRight">
			<div class="pla-prompRight-box"></div>
			<div class="pla-prompRight-sj">&#xe663;</div>
		</div>
 	</div>
 	<div id="change-container">
 	<!-- 增加详情页面 2017-3-13 -->
 	
 	<div class="their-own" id="their-ownA" >
        <div class="their-own-title">
            <h2 class="their-own-airName"></h2>
            <div class="their-own-title-code">
                <div>ICAO代码:<span class="their-own-icao" id="their-icao"></span></div>
                <div>IATA代码:<span class="their-own-iata"></span></div>
            </div>
            <!--   切换按钮     -->
            <div class="air-change-btn">
        	    <span class="change-turnIcon"></span>
        	    <span class="change-turnIcon1"></span>
        	</div>
        </div>
        <div class="their-own-body">
            <div class="their-own-body-flight-level">
                <div>
                    <p>飞行区等级</p>
                    <div class="their-own-flyLevel"></div>
                </div>
                <div>
                    <p>跑道数量（条）</p>
                    <div class="their-own-trackN"></div>
                </div>
            </div>
            <div class="their-own-body-flight-level">
                <div id="their-own-body-flying" title="点击后可绘制该机场在飞航线">
                    <p>在飞航线（条）</p>
                    <div><div class="their-own-zLine"></div><span class = 'yearr1'></span></div>
                </div>
                <div>
                    <p>机场标高（米）</p>
                    <div class="their-own-airLevel"></div>
                </div>
            </div>
            <div class="their-own-body-line-size">
            	<div></div>
                <div>国内航线<span class="their-own-nLine"></span></div>
                <div>国际航线<span class="their-own-wirLevel"></span></div>
            </div>
            <div class="their-own-body-peoples">
                <p>旅客吞吐量(人)</p>
                <div><div class="their-own-peos"></div><span class = 'yearr2'></span></div>
            </div>
        </div>
    </div>
    <!-- 背部 -->
    <div class="their-own" id="their-ownB"> 
 	    <div class="their-own-title">
            <h2 class="their-own-airName"></h2>
            <div class="their-own-title-code">
                <div>ICAO代码:<span class="their-own-icao"></span></div>
                <div>IATA代码:<span class="their-own-iata"></span></div>
            </div>
            <div class="air-change-btn">
        	    <span class="change-turnIcon"></span>
        	    <span class="change-turnIcon1"></span>
        	</div>
        </div>
        <div>
       		<div class="their-own-body">
	            <div class="their-txt-area" >
	            	<p id="their-txt-pull">
	            	</p>
            	</div>
	        </div>
        </div>
    </div>
 	</div>
    </div>
 	
    <div class="pla-btn">
        <div class="pla-btn-switch" tag="line">&#xe668;</div>
        <div class="pla-btn-switch_line" tag="line">&#xe800;</div>
        <div class="pla-btn-flight">&#xe66c;</div>
        <div class="pla-btn-trend">&#xe669;</div>
        <div class="pla-btn-national">&#xe68a;</div>
        <div class="pla-btn-simulate">&#xe6b0;</div>
        <p class="pla-btn-prompt">切换到机场视图</p>
    </div>
    <div id="airFlightt" style="display:none; position:absolute;right:50px;bottom: 134px;">
    	<ul style="">
    		<li class="air_flight" style=" display: flex;">
    			<div style="color: white;padding: 0px 10px;display: flex;justify-content: center;align-items: center;font-size: 12px;">
    				起始地:
    			</div>
    			<div>
    				<input id='startcity' class="air_flight_input" style="border: none; background-color: white; padding: 0; font-size: 12px;border-radius: 4px;">
    			</div>
    		</li>
    		<li class="air_flight" style=" display: flex;">
    			<div  style="color: white;padding: 0px 10px;display: flex;justify-content: center;align-items: center;font-size: 12px;">
    				经停地:
    			</div>
    			<div>
    				<input id='pascity1' class="air_flight_input" style="border: none; background-color: white; padding: 0; font-size: 12px;border-radius: 4px;">
    			</div>
    		</li>
    		<li class="air_flight" style=" display: flex;">
    			<div style="color: white;padding: 0px 10px;display: flex;justify-content: center;align-items: center;font-size: 12px;">
    				经停地:
    			</div>
    			<div>
    				<input id='pascity2' class="air_flight_input" style="border: none; background-color: white; padding: 0; font-size: 12px;border-radius: 4px;">
    			</div>
    		</li>
    		<li class="air_flight" style=" display: flex;">
    			<div style="color: white;padding: 0px 10px;display: flex;justify-content: center;align-items: center;font-size: 12px;">
    				到达地:
    			</div>
    			<div>
    				<input id='endcity' class="air_flight_input" style="border: none; background-color: white; padding: 0; font-size: 12px;border-radius: 4px;">
    			</div>
    		</li>
    	</ul>
    	<div style='display:flex;flex-direction: row; justify-content:center'>
    		<div style="width: 60px;height: 26px;" id="airsubmit" class='personal-information-determine information-qe nice-btn-lBlue'>确定</div>
    	 	<div style="width: 60px;height: 26px;" id = "quexiao" class='personal-information-cancel information-of cancel-btn-ordinary'>取消</div> 
    	</div>
    </div>
    <div id='line-kg'>
    	<ul class='line-icon'>
    		<li><img alt="" src="./images/platform/61.png">在飞航线</li>
    		<li><img alt="" src="./images/platform/60.png">无数据航线</li>
    		<li><div id='turnLine' class='iskg iskg0'><span class='turn-off'>&#xe695;</span></div>历史航线</li>
    	</ul>
    </div>
    <div id='line-kg2'>
    </div>
    <div class="pla-ranking"></div>
    <div class="simulateRoutes"></div>
</div>
<script type="text/javascript">
	var array1 = JSON.parse(menus);
	var array2 = JSON.parse(menus2);
	
	var result = [];
	for(var i = 0; i < array2.length; i++){
	    var obj = array2[i];
	    var num = obj.id;
	    var isExist = false;
	    for(var j = 0; j < array1.length; j++){
	        var aj = array1[j];
	        var n = aj.id;
	        if(n == num){
	            isExist = true;
	            break;
	        }
	    }
	    if(!isExist){
	        result.push(obj);
	    }
	}
	var _permissions=result;
	_permissions=[];
	
	
	_permissions.forEach(function(val){
		if(val.id==1){
			$('#_permissions_'+val.id).css({'display':'none'});
		}else if(val.id==2){
			$('#_permissions_'+val.id).css({'display':'none'});
		}else if(val.id==3){
			$('#_permissions_'+val.id).css({'display':'none'});
		}else if(val.id==4){
			$('#_permissions_'+val.id).css({'display':'none'});
		}else if(val.id==5){
			$('#_permissions_'+val.id).css({'display':'none'});
		}else if(val.id==6){
			$('#_permissions_'+val.id).css({'display':'none'});
		}else if(val.id==7){
			$('#_permissions_'+val.id).css({'display':'none'});
		}
	});
</script>	
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/echarts.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/PointChange.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/platform-map.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/eCenter.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/world.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/platform.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=TDmhTStuIIhX3LsAf3bNZV60SZoloqdC"></script>
<script type="text/javascript" src="/echarts/build/dist3/bmap.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/jquery.mousewheel.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/homepage/setting.js"></script>
<script type="text/javascript" src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/yj-scroll-bar.js"></script>
<script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/vue_two/dist/build.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/AdminLTE/myWeather.js"></script>
<script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/air-change.js"></script>
<script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/coalesce.js"></script>
<script src="/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/drawSimulateAirRoute.js"></script>
</body>


</html>