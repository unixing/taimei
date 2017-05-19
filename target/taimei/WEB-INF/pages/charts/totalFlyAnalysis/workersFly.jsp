<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>太美航空</title>
<link href="/css/workersFly.css" rel="stylesheet">
<script src="/js/jquery1.8.3.js"></script>
<script src="/js/airport-controls.js"></script>
<script type="text/javascript" src="/js/city/city-data.js"></script>
<script type="text/javascript" src="/js/city/hzw-city-picker.min.js"></script>
<script src="/js/searchForm.js"></script>
<script type="text/javascript" src="/echarts/echarts.js"></script>
<script src="/js/workersFly.js"></script>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body style="background: white">
	<form id="DOW-searchForm">
		<% 
	Object sessionValues=session.getAttribute("companyName_session"); 
%>
		<div class="psc-sr-head">
			<h1>共飞运营分析</h1>
			<div class="psc-sr-head-selects">
				<ul class="psc-sr-head-select">
					<li><input class="selectCity" name="dpt_AirPt_Cd"
						id="cityChoice" type="text" placeholder="出发城市" tag="tag" /> <span>&#xe620;</span>
						<input class="selectCity" name="Arrv_Airpt_Cd" id="cityChoice2"
						type="text" placeholder="到达城市" />
						<div class="airport-controls">
							<ul class="airport-controls-head">
								<li>热门城市</li>
								<li tag="A.B.C.D">ABCD</li>
								<li tag="E.F.G.H">EFGH</li>
								<li tag="I.J.K.L.M">IJKLM</li>
								<li tag="N.O.P.Q.R.S">NOPQRS</li>
								<li tag="T.U.V.W">TUVW</li>
								<li tag="X.Y.Z">XYZ</li>
							</ul>
							<div class="airport-controls-hot citySelection">
								<span>北京首都</span> <span>广州白云</span> <span>上海浦东</span> <span>上海虹桥</span>
								<span>成都双流</span> <span>深圳宝安</span> <span>昆明长水</span> <span>西安咸阳</span>
								<span>重庆江北</span> <span>杭州萧山</span> <span>厦门高崎</span> <span>南京禄口</span>
								<span>武汉天河</span> <span>沈阳桃仙</span> <span>青岛流亭</span> <span>福州长乐</span>
								<span>三亚凤凰</span> <span>天津滨海</span>
							</div>
							<div class="airport-controls-cont"></div>
						</div>
						<div class="screen-controls">
							<ul class="screen-controls-one">
								<li>成都双流</li>
								<li>(<strong>CT</strong>U)
								</li>
								<li>chengdushuangliu</li>
							</ul>
						</div></li>
					<li><input id="startDate" name="startDate" type="text"
						onclick="WdatePicker({dateFmt:'yyyy-MM'})" placeholder="日期范围" /><input
						id="endDate" name="endDate"
						onclick="WdatePicker({dateFmt:'yyyy-MM'})" type="text"
						placeholder="日期范围" /></li>
					<li><span>经停点</span> <input name="pas_stp" class="selectCity"
						id="cityChoice3" type="text"></li>
					<li><span>航司</span> <input type="text"></li>
					<li onclick="send()">查询</li>
				</ul>
			</div>
		</div>
	</form>
	<div class="psc-sr-icon">
		<ul>
			<li>
				<!-- <p><span>海口</span>&#xe622;<span>泸州</span></p> -->
				<h4 id="abzs">走势趋势</h4>
				<div class="abzs" style="border-bottom: 2px solid #69caff;">
					<div onclick="abflowAsiay();">&#xe600;</div>
				</div>
			</li>
			<li>
				<!-- <p><span>泸州</span>&#xe622;<span>海口</span></p> -->
				<h4 id="bazs">走势趋势</h4>
				<div class="bazs">
					<div onclick="baflowAsiay();">&#xe624;</div>
				</div>
			</li>
			<li>
				<!-- <p><span>海口</span>&#xe622;<span>泸州</span></p> -->
				<h4 id="abgf">共飞对比</h4>
				<div class="abgf">
					<div onclick="abtotalflyAsiay();">&#xe623;</div>
				</div>
			</li>
			<li>
				<!-- <p><span>海口</span>&#xe622;<span>泸州</span></p> -->
				<h4 id="bagf">共飞对比</h4>
				<div class="bagf">
					<div onclick="batotalflyAsiay();">&#xe623;</div>
				</div>
			</li>
			<li>
				<!-- <p><span>海口</span>&#xe622;<span>泸州</span></p> -->
				<h4 id="abbagf">共飞对比</h4>
				<div class="abbagf">
					<div onclick="abbatotalflyAsiay();">&#xe623;</div>
				</div>
			</li>
		</ul>
	</div>
	<div class="tab-pane fade active in" id="abflowcharts">
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<!-- <div  class="psc-sr-body-ranking psc-sr-body-box">
        <div></div>
        <div></div>
    </div>
    <div class="psc-sr-body-zszRanking"></div>
    <div class="psc-sr-body-klRanking"></div> -->
	</div>
	<div class="psc-sr-body" id="baflowcharts">
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
	</div>
	<div class="psc-sr-body" id="abtotalcharts">
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
	</div>
	<div class="psc-sr-body" id="batotalcharts">
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
	</div>
	<div class="psc-sr-body" id="abbatotalcharts">
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
		<div class="psc-sr-body-charts psc-sr-body-box">
			<div></div>
			<div></div>
		</div>
	</div>
</html>