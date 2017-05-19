<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String flagpage = request.getParameter("flagpage");
 %>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>销售数据</title>
<link rel="stylesheet" type="text/css" media="all"
    href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/bootstrap.css">
<link rel="stylesheet" type="text/css"
    href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/dateKJ.css" />  
<link rel="stylesheet" type="text/css" media="all"
    href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/line_historical/daterangepicker-bs3.css" />
<link rel="stylesheet" type="text/css"
    href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/lin-historical.css" />    
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/line_historical/sy.css"
    rel="stylesheet/less">     
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/coalesce.css" rel="stylesheet">
<link href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/err/ed.css" rel="stylesheet">
<link href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/TMcommon.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"href="/css/css<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageCss/account-check/account-check.css" />
</head>
<script type="text/javascript">
var flagpage = <%=flagpage%>;
</script>
<body>
    <div class="lin-historical">
        <div class="sr-box-head">
            <div class="sr-box-head-classify">
                <ul>
             	    <li class='tltle-sel' title='销售报表' id="_permissions_13"><a class='page-fun-change' href='/salesReport'>&#xe628;</a></li>
                    <li class='tltle-sel' title='航线历史收益统计' id="_permissions_1"><a class='page-fun-change' href='/airline'>&#xe629;</a></li>
                    <li class='tltle-sel' title='销售动态' id="_permissions_5"><a class='page-fun-change' href='/buyTicketReport'>&#xe624;</a></li>
                    <li class='tltle-sel tltle-selI' id="_permissions_8">&#xe688;<span>销售数据</span></li>
                </ul>
            </div>
            <div class="sr-box-head-inquire" id='sr-box-head-inquire'>
                
                <div class="_set-flight">
                    <div class="_set-name" id='flt_nbr_Count'>航班号</div>
                    <div class="_set-list-set"><input id="SD-head-inquire" type="text" placeholder="如MU1234"></div>
                </div>
                <div class="_set-time">
                    <div class="_set-name">起止时间</div>
                    <div class="_set-name-b">
                        <input type="text" readonly="readonly"
                            id='reservation' placeholder="起止日期">
                    </div>
                </div>
                <div class="_set-place-duplexing">
                    <div class="_set-name">航线</div>
                    <div class="SD-set-list-title"></div>
                    <div class="SD-airportNam">
                    	<ul>
                     	<li>123</li>
                    		<li>123</li>
                    	</ul>
                    </div>
                </div>

                <div class="_set-query">查询</div>
            </div>
        </div>  
        
        <!-- 左侧导航栏目 -->
        <div class="lin-historical-body-navigation">
        </div>
        <div id="scroll-bar" style="top:0 px;"></div>
        <!-- 主区域 -->
    <div class="SD-src-main">      
	<div id="SD-cover"></div>
	<div class="lin-historical-body-box">
		<div class="lin-historical-body-bar"></div>
	</div>
    <a name="backtop"></a>
        <!-- 数据显示区域 -->
        <div class="SD-view">
            <div class="SD-view-header">
                <ul class="SD-ul-title" id="SD-head-title">
                    <li>
                        时间<br>
                        <span class="sumDetail">---</span>
                    </li>
                    <li>
                        航班号<br>
                        <span class="sumDetail">---</span>
                    </li>
                    <li>
                        平均折扣（%）<br>
                        <span class="sumDetail">---</span>
                    </li>
                    <li>
                        客量（人）<br>
                        <span class="sumDetail">---</span>
                    </li>
                    <li>
                        票面和（元）<br>
                        <span class="sumDetail">---</span>
                    </li>
                    <a class="SD-outer" title="导出所有航段数据">
                    	导出详情
                    	<div class="SD-print-link">
                    	</div>
                    </a>
                </ul>
            </div>
            <div class="SD-view-table">
                <!-- 航段选择器 -->
                <div class="SD-view-t-label" id="SD-table-head">
                    <ul>
                    </ul>
                </div>              
                <!-- 表格区域 -->
                <div class="SD-view-body">
                    <ul class="SD-ul-title" id="SD-min-list">
                        <li>
                            平均折扣(%)<br>
                            <span>---</span>
                        </li>
                        <li>
                            票面和（元）<br>
                            <span>---</span>
                        </li>
                        <li id="personNum">
                            客量（人）<br>
                            <span>---</span>
                        </li>
                        <li>
                            平均票价（元）<br>
                            <span>---</span>
                        </li>
                        
                    </ul>

                    <div class="SD-table-sum">

                        <table class="sum-table" id="SD-sum-tableA">
                            <tr>                                
                                <th>舱位</th>
                            </tr>
                            <tr>                                
                                <th>人数</th>
                            </tr>
                            <tr>                                
                                <th>收入</th>
                            </tr>
                        </table>

                        <table class="sum-table" id="SD-sum-tableB">
                            <tr>                                
                                <th>舱位</th>
                            </tr>
                            <tr>                                
                                <th>人数</th>
                            </tr>
                            <tr>                                
                                <th>收入</th>
                            </tr>
                        </table>
                    </div>
                    <div class="SD-table-detail">
                        <!-- 详情表表头 -->
                        <div class="detail-table-head" id="detail-table-head">
                            <table class="sum-table">
                                <tr>                                
                                    <td>承运人</td>
                                    <td><span id="date_sort">航班日期    ↓</span></td>
                                    <td>航班号</td>
                                    <td>航段</td>
                                    <td>公司</td>
                                    <td>票号</td>
                                    <td>旅客类型</td>
                                    <td><span id="cw_sort">舱位    ↑↓</span></td>
                                    <td><span id="price_sort">票款    ↑↓</span></td>
                                </tr>
                            </table>
                        </div>
                        <!-- 详情表表体 -->
                        <table class="sum-table" id="SD-detail-table">
                        </table>
                        <!-- 表格底部导航 -->
                        <div class="table-nav">
                            <!-- 目录 -->
                            <p class="currpage-info">
                                当前显示第 <span class="nav-startTr"></span> - <span class="nav-endTr"></span> 条数据，总共 <span class="nav-totalTr"></span> 条数据
                            </p>
                            <!-- 分页 -->
                              <div class="table-nav-menu">                                
                                <div id="nav-long">
                                <span></span>
                                </div>
                            </div>
                        </div>
                        <!-- 回到顶部 -->
                        <div class="back-to-top" title="回到顶部"></div>
                    </div>
                </div>
                </div>
            </div>
        </div>
        <!-- 无数据时 -->        
		<div class="err">
			<div id='err-one'><img src="/err/errNodata.png" ></div>
        	<div id='err-two'><img src="/err/err2.png"></div>
		</div>
		<div class="SD-hd-null">
			<p>暂无该航段数据！<p>
		</div>
    </div>
    <script
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery1.8.3.js"></script>
    <script type="text/javascript"
		src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/role.js"></script>
    
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/salesReportJS/jquery.fullcalendar.js"></script>
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/coalesce.js"
        type="text/javascript"></script>
<%--       <script type="application/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/lin-historical.js"></script>  --%>   --%>
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/bootstrap.min.js"></script>
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/moment.js"></script>
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/yj-scroll-bar.js"></script>
     <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/line_historical/daterangepicker.js"></script>
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/line_historical/less.min.js"></script> <%-- 
    <script type="text/javascript"
        src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/line_historical/month-chenge.js"></script> --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/account-check/laypage.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/js<%=request.getSession().getServletContext().getAttribute("versionn") %>/newPageJs/account-check/account-check.js"></script>
</body>
</html>