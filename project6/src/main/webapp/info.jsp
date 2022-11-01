<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Coin Informations</title>
	
	<!-- Bootstrap 5.2.2 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	
	<!-- Font-Awesome Icons -->
	<script src="https://kit.fontawesome.com/9ddb6abce0.js" crossorigin="anonymous"></script> 
	
	<!-- Inner Style CSS -->
	<style type="text/css">
		/* 폰트 설정 */
		@font-face {
			src: url("./ROKG_R.TTF");
			font-family: "ROKG";
		}
		body {
			font-family: "ROKG", "맑은 고딕", verdana, san-serif;
		}
		#info, #info2, #info3 {
			font-family: "맑은 고딕", verdana, san-serif;
		}
		
		/* 내용 text 줄이기 */
		.reduce {
			width: 100%;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}
		
		.text-tomato {
			color: tomato;
		}
		.bg-tomato {
			background: tomato;
		}
				
		
	</style>
	
	
	<!-- Javascript -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	
	/* Request Parameter의 값 */
	function Request(){
		let requestParam ="";
		
		//getParameter 펑션
		this.getParameter = function(param){
			//현재 주소를 decoding
			let url = unescape(location.href); 
			//파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다. 
			let paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&"); 
		
			for(let i = 0 ; i < paramArr.length ; i++){
				let temp = paramArr[i].split("="); //파라미터 변수명을 담음
				if(temp[0].toUpperCase() == param.toUpperCase()){// 변수명과 일치할 경우 데이터 삽입
					requestParam = paramArr[i].split("=")[1]; 
					break;
				}
			}
			return requestParam;
		}
	}
	// Request 객체 생성
	let request = new Request();
	// symbol 파라메터 값을 얻기
	let reqSymbol = request.getParameter("cSymbol");
	
	
	/* API로 요청보내서 원하는 값 표시 */
	$(function() {
		//$('#id').on("click", 'tag', function() {	// 해당 문법은 dynamically created elements에서 동작하지 않는다
		//$(document).on('click', '#id tag', function(){	// 위의 문법이 안될 경우 이렇게 작성하자.
				
		const key = "3732d88b-29b4-466e-9750-d3d42ed051b3"; // Messari api key
			
		$.ajax({
			url : "https://data.messari.io/api/v1/assets/" +reqSymbol+ "/metrics",	// 요청 주소
			data : "assetKey=" +key,	//요청 파라미터
			type : "GET", //전송타입
			dataType : "json", //응답타입
			success : function(result) {	//통신 성공시 호출하는 함수
				//alert("요청에 의한 응답 성공 값 : " +result);
				console.log(result);
				metricParsing(result);	// 가독성 위해 따로 작성
			},
			error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
				alert('Getting data from server has failed.');
				//console.log("error : ", msg);
				//console.log("status : ", status);
			}
		});
		function metricParsing(result) {
			let str = "";
			//str = "result.data.name 넘어온 값: " +result.data.name; // for test (done)
			//console.log(str); // for test (done)
			//$("#testSymbol").empty().append(str); // for test (done)
			
			// Coin 이름, 랭킹
			let coinName = "<img src='https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/64/" +result.data.slug+ ".png' height='32' width='32' /><strong> " +result.data.name+ "</strong>";
			let coinRank = "Rank #" +result.data.marketcap.rank;
			$("#coinName").empty().append(coinName);
			$("#coinRank").empty().append(coinRank);
			
			// reddit
			$("#redditActive").empty().append("<small><strong>" +result.data.reddit.active_user_count.toLocaleString('ko-KR')+ "</strong></small>");
			$("#redditSubscrib").empty().append("<small><strong>" +result.data.reddit.subscribers.toLocaleString('ko-KR')+ "</strong></small>");
			
			// $("").empty().append();
			
			// 이름 ex) Etherium (ETH)
			let priceTitle = result.data.name+ " Price (" +result.data.symbol+ ")";
			$("#priceTitle").empty().append(priceTitle);
			// 현재가 USD
			let infoPrice = priceLength(result.data.market_data.price_usd);
			$("#infoPrice").empty().append("$" +infoPrice);
			let usd24 = parseFloat(result.data.market_data.percent_change_usd_last_24_hours);// number
			let usd24Text = usd24.toFixed(2);//string
			if (usd24 == 0){
				changeUsd24 = usd24Text+ "%";
				$("#usd24").empty().addClass("bg-secondary").addClass("text-light").append(changeUsd24);
			}
			if (usd24 > 0){
				changeUsd24 = "▲ " +usd24Text +"%"
				$("#usd24").empty().addClass("bg-success").addClass("text-light").append(changeUsd24);
			}
			if (usd24 < 0){
				changeUsd24 = "▼ " +usd24Text +"%";
				$("#usd24").empty().addClass("bg-danger").addClass("text-light").append(changeUsd24);
			}
			// 현재가 BTC
			let infoPriceBTC = result.data.market_data.price_btc.toFixed(8);
			$("#infoPriceBTC").empty().append(infoPriceBTC+ " BTC");
			let btc24 = parseFloat(result.data.market_data.percent_change_btc_last_24_hours);// number
			let btc24Text = btc24.toFixed(2);
			
			if (btc24 == 0){
				changeBTC24 = btc24Text+ "%";
				$("#btc24").empty().append(changeBTC24);
			}
			if (btc24 > 0){
				changeBTC24 = "▲ " +btc24Text+ "%";
				$("#btc24").empty().addClass("text-success").append(changeBTC24);
			}
			if (btc24 < 0){
				changeBTC24 = "▼ " +btc24Text+ "%";
				$("#btc24").empty().addClass("text-danger").append(changeBTC24);
			}
			// 현재가 ETH
			let infoPriceETH = result.data.market_data.price_eth.toFixed(8);
			$("#infoPriceETH").empty().append(infoPriceETH+ " ETH");
			let eth24 = parseFloat(result.data.market_data.percent_change_eth_last_24_hours);// number
			console.log(eth24);
			let eth24Text = eth24.toFixed(2);// string
			
			if (eth24 == 0){
				changeETH24 = eth24Text+ "%";
				$("#eth24").empty().append(changeETH24);
			}
			if (eth24 > 0){
				changeETH24 = "▲ " +eth24Text+ "%";
				$("#eth24").empty().addClass("text-success").append(changeETH24);
			}
			if (eth24 < 0){
				changeETH24 = "▼ " +eth24Text+ "%";
				$("#eth24").empty().addClass("text-danger").append(changeETH24);
			}
			
			// real volume
			$("#vol24").empty().append(result.data.market_data.real_volume_last_24_hours.toLocaleString('ko-KR', {maximumFractionDigits: 0})+ " USD");
			// volume
			$("#vol24simple").empty().append(result.data.market_data.volume_last_24_hours.toLocaleString('ko-KR', {maximumFractionDigits: 0})+ " USD");
			// m.cap
			$("#mCap").empty().append(result.data.marketcap.current_marketcap_usd.toLocaleString('ko-KR', {maximumFractionDigits: 0})+ " USD");
			$("#dom").empty().append(result.data.marketcap.marketcap_dominance_percent.toLocaleString('ko-KR', {maximumFractionDigits: 1})+ " %");
			
			// supply
			result.data.supply.annual_inflation_percent
			result.data.supply.circulating
			result.data.supply.y_plus10
			data.supply.y_2050
			
			// ath
			result.data.all_time_high.at
			result.data.all_time_high.price
			result.data.all_time_high.percent_down
			// cycle low
			result.data.cycle_low.at
			result.data.cycle_low.price
			result.data.cycle_low.percent_up
			
			
			// onchain
			result.data.on_chain_data.active_addresses
			result.data.on_chain_data.addresses_count
			result.data.on_chain_data.average_fee_native_units
			result.data.on_chain_data.average_fee_usd
			
			// roi
			result.data.roi_data.percent_change_eth_last_1_week
			result.data.roi_data.percent_change_last_1_month
			result.data.roi_data.percent_change_last_3_months
			result.data.roi_data.percent_change_last_1_year
			result.data.roi_data.percent_change_year_to_date
			// roi year
			result.data.roi_by_year["2011_usd_percent"]
			result.data.roi_by_year["2012_usd_percent"]
			result.data.roi_by_year["2013_usd_percent"]
			result.data.roi_by_year["2014_usd_percent"]
			result.data.roi_by_year["2015_usd_percent"]
			result.data.roi_by_year["2016_usd_percent"]
			result.data.roi_by_year["2017_usd_percent"]
			result.data.roi_by_year["2018_usd_percent"]
			result.data.roi_by_year["2019_usd_percent"]
			result.data.roi_by_year["2020_usd_percent"]
			result.data.roi_by_year["2021_usd_percent"]
			
		}
		
	});

	$(function() {
		
		const key = "3732d88b-29b4-466e-9750-d3d42ed051b3"; // Messari api key
			
		$.ajax({
			url : "https://data.messari.io/api/v2/assets/" +reqSymbol+ "/profile",	// 요청 주소
			data : "assetKey=" +key,	//요청 파라미터
			type : "GET", //전송타입
			dataType : "json", //응답타입
			success : function(result) {	//통신 성공시 호출하는 함수
				//alert("요청에 의한 응답 성공 값 : " +result);
				console.log(result);
				profileParsing(result);
			},
			error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
				alert('Getting data from server has failed.');
			}
			
		});
		function profileParsing(result) {
			let coinSymbol = result.data.symbol;
			let consensus = result.data.profile.economics.consensus_and_emission.consensus.general_consensus_mechanism;
			let cat = result.data.profile.general.overview.category;
			
			$("#coinSymbol").empty().append("<strong>" +coinSymbol+ "</strong>");
			$("#consensus").empty().append(consensus);
			$("#cat").empty().append(cat);
			
			// Organization
			if (result.data.profile.general.background.issuing_organizations != 0) {
				let org = "<span class='badge rounded-pill bg-success'>Organizations</span> ";
				for (index in result.data.profile.general.background.issuing_organizations) {
					orgName = result.data.profile.general.background.issuing_organizations[index].name
					orgLogo = result.data.profile.general.background.issuing_organizations[index].logo
					$("#org").append(org+ "<img src='" +orgLogo+ "' height='18' width='18'/>" +orgName+ " ");
				}
			}
			
			// Web site link
			let oLinkStr = ""; 
			for (index in result.data.profile.general.overview.official_links) {
				oLink = result.data.profile.general.overview.official_links[index].link
				oLinklName = result.data.profile.general.overview.official_links[index].name
				
				oLinkStr += "<a class='dropdown-item' href='" +oLink+ "' target=_blank><small>" +oLinklName+ " </small><i class='fa-solid fa-arrow-up-right-from-square'></i></a>";
			}
			//console.log(oLinkStr);// for test (완료)
			$("#oLink").empty().append(oLinkStr); 
			
			// 알려진 공격 및 취약점
			if (result.data.profile.technology.security.known_exploits_and_vulnerabilities.length != 0){
				
				let attackStr = "<span class='badge rounded-pill bg-danger mb-1'>알려진 공격 및 취약점</span><br/><div class='list-group'>";
				for (index in result.data.profile.technology.security.known_exploits_and_vulnerabilities) {
					date = result.data.profile.technology.security.known_exploits_and_vulnerabilities[index].date;
					title = result.data.profile.technology.security.known_exploits_and_vulnerabilities[index].title;
					type = result.data.profile.technology.security.known_exploits_and_vulnerabilities[index].type;
					details = result.data.profile.technology.security.known_exploits_and_vulnerabilities[index].details;
					
					attackStr += "<a href='' class='list-group-item list-group-item-action flex-column align-items-start border-danger'>";
					attackStr += "		<div class='d-flex w-100 justify-content-between'>";
					attackStr += "			<h5 class='mb-1'>" +title+ "</h5>";
					attackStr += "			<small>" +date+ "</small>";
					attackStr += "		</div>";
					attackStr += "		<p class='mb-0'>" +type+ "</p>";
					attackStr += "		<div class='reduce'><small>" +details+ "</small>";
					attackStr += "		</div>";
					attackStr += "</a>";
				}
				attackStr += "</div>";
				//console.log(attackStr);// for test (완료)
				$("#attack").empty().append(attackStr); 
			}
			
			
			
		}
	});
	
	// 가격(usd) 소수점 표시
	function priceLength(numberStr){
		
		let number = parseFloat(numberStr);
		let result = 0.0;
		// 가격이 100 이상이면 소수점 2자리까지 표시
		if (number >= 100){
			result = parseFloat(numberStr).toFixed(2);
		}
		// 100 > 가격 >= 10 이면 소수점 3자리까지 표시
		if (number < 100 & number >= 10){
			result = parseFloat(numberStr).toFixed(3);
		}
		// 10 > 가격 >= 1 이면 소수점 4자리까지 표시
		if (number < 10 & number >= 1){
			result = parseFloat(numberStr).toFixed(4);
		}
		// 가격이 1 미만이면 소수점 5자리까지 표시
		if (number < 1){
			result = parseFloat(numberStr).toFixed(5);
		}
					
		return result;
	}
	
	</script>


</head>

<body>

<!-- Upper Nav bar -->
<%@include file="./topbar.jsp"%>
<!-- end of Upper Nav bar -->

<div class="container-fluid">
	<div class="row">
	
		<!-- Infomations -->
		<div class="row col-sm-12 col-md-6 col-lg-8 px-1">
			<div class="col-lg-4 border border-secondary">
				<!-- Basic Info from api data -->
				<div id="info" class="mt-3">
				
					<p><span id="coinName" class="h2">coinName</span><button type="button" id="coinSymbol" class="btn btn-primary btn-sm mx-2">coinSymbol</button></p>
					<p>
						<span id="coinRank" class="badge bg-secondary mx-1">rank</span>
						<span id="consensus" class="badge bg-secondary mx-1">consensus</span>
						<span id="cat" class="badge bg-secondary mx-1">category</span>
					</p>
					<hr/>
					<p><small><strong><span id="org"></span></strong></small></p>
					<p><!-- 웹사이트 링크 -->
						<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
							<button type="button" id="wSite" class="btn btn-sm btn-success py-0">Web-site Link</button>
							<div class="btn-group" role="group">
								<button id="btnGroupDrop1" type="button" class="btn btn-sm btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
								<div id="oLink" class="dropdown-menu" aria-labelledby="btnGroupDrop1">
									<a class="dropdown-item" href="#">none</a>
									<a class="dropdown-item" href="#">none</a>
								</div>
							</div>
						</div>
						<!-- Reddit -->
						<i class="fa-brands fa-reddit fa-2xl text-tomato mx-2"></i>
						<i class="fa-regular fa-thumbs-up text-tomato"></i><span id="redditActive" class="text-tomato">Active</span>
						<i class="fa-solid fa-user text-tomato"></i><span id="redditSubscrib" class="text-tomato">Subscribers</span>
					</p>
					<hr/>
					<div id="attack"><span class='badge rounded-pill bg-danger mb-1'>알려진 공격 및 취약점 없음</span><br/></div>
				</div>
				<!-- end of Basic Info from api data -->
			</div>
			
			<!-- Price, Supply, Onchain Info -->
			<div id="info2" class="col-lg-4 border border-secondary">
				<!-- Price -->
				<div>
					<small><strong><span id="priceTitle" class="text-muted">priceTitle</span></strong></small><br/>
					<span id="infoPrice" class="h2 fw-bold">infoPrice</span> <button type="button" id="usd24" class="btn btn-sm mx-2">24h %</button><br/>
					<span id="infoPriceBTC" class="h5 fw-bold text-muted">infoPriceBTC</span><small><span id="btc24" class="fw-bold mx-2"></span></small><br/>
					<span id="infoPriceETH" class="h5 fw-bold text-muted">infoPriceETH</span><small><span id="eth24" class="fw-bold mx-2"></span></small><hr/>
				</div>
				<!-- Vol, M.Cap, Supply -->
				<div>
					<small><span class="badge rounded-pill bg-dark mx-2">Real Volume</span><span id="vol24" class="fw-bold">real vol24</span><span class="badge bg-secondary mx-2">24h</span></small><br/>
					<small><span class="badge rounded-pill bg-dark mx-2">&nbsp&nbsp Volume &nbsp&nbsp</span><span id="vol24simple" class="fw-bold">vol24</span><span class="badge bg-secondary mx-2">24h</span></small><br/>
					<small><span class="badge rounded-pill bg-dark mx-2">Market Cap.</span><span id="mCap" class="fw-bold">mCap</span><span id="dom" class="badge bg-danger mx-2">dom.</span></small><br/>
					<small><span class="badge rounded-pill bg-dark mx-2">Supply</span><span id="supply">supply</span></small><br/>
				</div>
			</div>
			<!-- end fo Price, Supply, Onchain Info -->
			
			<!-- ROI Info -->
			<div id="info3" class="col-lg-4 border border-secondary">
				<p>세번째</p>
			</div>
			<!-- end of ROI Info -->
			
				
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
			  <div id="tradingview_f9f55" style="height: 300px;"></div>			<!-- 스타일 나중에 css에 작성-------------------todo -->
			  <div class="tradingview-widget-copyright">Chart by TradingView</div>
			  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
			  <script type="text/javascript">
				  new TradingView.widget(
				  {
				  "autosize": true,
				  "symbol": "BINANCE:" +reqSymbol+ "USDT",
				  "interval": "D",
				  "timezone": "Asia/Seoul",
				  "theme": "light",
				  "style": "1",
				  "locale": "en",
				  "toolbar_bg": "#f1f3f6",
				  "enable_publishing": false,
				  "allow_symbol_change": true,
				  "container_id": "tradingview_f9f55"
				  });
			  </script>
			</div>
			<!-- TradingView Widget END -->
			
		</div>
		<!-- end of Infomations -->
		
		
		<!-- Board -->
		<div class="col-sm-12 col-md-6 col-lg-4 bg-warning px-1">
			<p class="h2">Board</p>
		</div>
		<!-- Board -->
		
	</div>
</div>

	
	
</body>
</html>