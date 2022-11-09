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
			src: url("resources/fonts/ROKG_R.TTF");
			font-family: "ROKG";
		}
		body {
			font-family: "ROKG", "맑은 고딕", verdana, san-serif;
		}
		#info, #info2, #info3, #board_contents, #writeBox {
			font-family: "맑은 고딕", verdana, san-serif;
		}
		
		#board_area {
			border-radius: 25px;
			background: #CEF6F5;
		}
		
		
		/* 내용 text 줄이기 */
		.reduce {
			width: 100%;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}
		
		/* Tooltip */
		.tooltip {
			position: relative;
			display: inline-block;
			border-bottom: 1px dotted black;
		}
		
		.tooltip .tooltiptext {
			visibility: hidden;
			width: 120px;
			background-color: black;
			color: #fff;
			text-align: center;
			border-radius: 6px;
			padding: 5px 0;
		
			/* Position the tooltip */
			position: absolute;
			z-index: 1;
		}
		
		.tooltip:hover .tooltiptext {
			visibility: visible;
		}
		
		/* class 색깔 정의 */
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
	
	let sId = '<%=(String) session.getAttribute("sessionId")%>';
	let sName = '<%=(String) session.getAttribute("sessionName")%>';

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
				
		const key = "d9dafa20-7fc8-4cba-8179-b19bf8a1bff6"; // Messari api key
			
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
			
			// Board title
			$("#boardTitle").empty().append(" " +result.data.name);
			$("#boardTitleSymbol").empty().append("$" +result.data.symbol);
			
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
			if (result.data.symbol == "BTC"){
				$("#btc24").empty();
			}
			// 현재가 ETH
			let infoPriceETH = result.data.market_data.price_eth.toFixed(8);
			$("#infoPriceETH").empty().append(infoPriceETH+ " ETH");
			let eth24 = parseFloat(result.data.market_data.percent_change_eth_last_24_hours);// number
			//console.log(eth24);// 값 확인 (완료)
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
			if (result.data.symbol == "ETH"){
				$("#eth24").empty();
			}
			
			// real volume
			$("#vol24").empty().append(result.data.market_data.real_volume_last_24_hours.toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			// volume
			$("#vol24simple").empty().append(result.data.market_data.volume_last_24_hours.toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			// m.cap
			$("#mCap").empty().append(result.data.marketcap.current_marketcap_usd.toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			$("#dom").empty().append(result.data.marketcap.marketcap_dominance_percent.toLocaleString('ko-KR', {maximumFractionDigits: 1})+ " %");
			
			// supply
			if (result.data.supply.annual_inflation_percent != null){
				$("#supplyInflation").empty().append(result.data.supply.annual_inflation_percent.toFixed(4));
			}
			if (result.data.supply.circulating != null){
				$("#supplyCircul").empty().append(result.data.supply.circulating.toLocaleString('ko-KR', {maximumFractionDigits: 0})+ " <span class='text-muted'>" +result.data.symbol+ "</span>");
			}
			if (result.data.supply.y_plus10 != null){
				$("#supplyPlus10").empty().append(result.data.supply.y_plus10.toLocaleString('ko-KR', {maximumFractionDigits: 0})+ " <span class='text-muted'>" +result.data.symbol+ "</span>");
			}
			if (result.data.supply.y_2050 != null){
				$("#supplyY2050").empty().append(result.data.supply.y_2050.toLocaleString('ko-KR', {maximumFractionDigits: 0})+ " <span class='text-muted'>" +result.data.symbol+ "</span>");
			}
			
			// onchain
			if (result.data.on_chain_data.active_addresses != null){
				$("#addrActive").empty().append(" " +result.data.on_chain_data.active_addresses.toLocaleString('ko-KR'));
			}
			if (result.data.on_chain_data.addresses_count != null){
				$("#addrCnt").empty().append(" " +result.data.on_chain_data.addresses_count.toLocaleString('ko-KR'));
			}
			if (result.data.on_chain_data.block_height != null){
				$("#blockHeight").empty().append(" " +result.data.on_chain_data.block_height.toLocaleString('ko-KR'));
			}
			if (result.data.on_chain_data.average_block_interval != null){
				$("#blockInterval").empty().append(" " +result.data.on_chain_data.average_block_interval.toFixed(2));
			}
			if (result.data.on_chain_data.average_fee_usd != null){
				$("#feeUsd").empty().append(" " +result.data.on_chain_data.average_fee_usd.toLocaleString('ko-KR', {maximumFractionDigits: 4}));
			}
			if (result.data.on_chain_data.realized_marketcap_usd != null){
				$("#realizedMCap").empty().append(" " +result.data.on_chain_data.realized_marketcap_usd.toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			
			// ath
			if (result.data.all_time_high.at != null){
				$("#athAt").empty().append(" " +result.data.all_time_high.at.substr(0, 10));
			}
			if (result.data.all_time_high.price != null){
				$("#athPrice").empty().append(" " +priceLength(result.data.all_time_high.price));
			}
			if (result.data.all_time_high.percent_down != null){
				$("#athDown").empty().append(" " +result.data.all_time_high.percent_down.toFixed(2));
			}
			
			// cycle low
			if (result.data.cycle_low.at != null){
				$("#lowAt").empty().append(" " +result.data.cycle_low.at.substr(0, 10));
			}
			if (result.data.cycle_low.price != null){
				$("#lowPrice").empty().append(" " +priceLength(result.data.cycle_low.price));
			}
			if (result.data.cycle_low.percent_up != null){
				$("#lowUp").empty().append(" " +result.data.cycle_low.percent_up.toFixed(2));
			}
			
			// roi
			if (result.data.roi_data.percent_change_eth_last_1_week != null) {
				$("#roi1w").empty().append(result.data.roi_data.percent_change_eth_last_1_week.toLocaleString('ko-KR', {maximumFractionDigits: 2}));
			}
			if (result.data.roi_data.percent_change_last_1_month != null) {
				$("#roi1m").empty().append(result.data.roi_data.percent_change_last_1_month.toLocaleString('ko-KR', {maximumFractionDigits: 2}));
			}
			if (result.data.roi_data.percent_change_last_3_months != null) {
				$("#roi3m").empty().append(result.data.roi_data.percent_change_last_3_months.toLocaleString('ko-KR', {maximumFractionDigits: 2}));
			}
			if (result.data.roi_data.percent_change_last_1_year != null) {
				$("#roi1y").empty().append(result.data.roi_data.percent_change_last_1_year.toLocaleString('ko-KR', {maximumFractionDigits: 2}));
			}
			if (result.data.roi_data.percent_change_year_to_date != null) {
				$("#roiYTD").empty().append(result.data.roi_data.percent_change_year_to_date.toLocaleString('ko-KR', {maximumFractionDigits: 2}));
			}
			
			// roi year
			if (result.data.roi_by_year["2011_usd_percent"] != null) {
				$("#roi2011").empty().append(result.data.roi_by_year["2011_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2012_usd_percent"] != null) {
				$("#roi2012").empty().append(result.data.roi_by_year["2012_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2013_usd_percent"] != null) {
				$("#roi2013").empty().append(result.data.roi_by_year["2013_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2014_usd_percent"] != null) {
				$("#roi2014").empty().append(result.data.roi_by_year["2014_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2015_usd_percent"] != null) {
				$("#roi2015").empty().append(result.data.roi_by_year["2015_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2016_usd_percent"] != null) {
				$("#roi2016").empty().append(result.data.roi_by_year["2016_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2017_usd_percent"] != null) {
				$("#roi2017").empty().append(result.data.roi_by_year["2017_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2018_usd_percent"] != null) {
				$("#roi2018").empty().append(result.data.roi_by_year["2018_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2019_usd_percent"] != null) {
				$("#roi2019").empty().append(result.data.roi_by_year["2019_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2020_usd_percent"] != null) {
				$("#roi2020").empty().append(result.data.roi_by_year["2020_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
			if (result.data.roi_by_year["2021_usd_percent"] != null) {
				$("#roi2021").empty().append(result.data.roi_by_year["2021_usd_percent"].toLocaleString('ko-KR', {maximumFractionDigits: 0}));
			}
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
				for (index in result.data.profile.general.background.issuing_organizations) {
					orgName = result.data.profile.general.background.issuing_organizations[index].name
					orgLogo = result.data.profile.general.background.issuing_organizations[index].logo
					$("#org").append(" <img src='" +orgLogo+ "' height='18' width='18'/>" +orgName+ " ");
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
					
					attackStr += "<a href='' class='list-group-item list-group-item-action flex-column align-items-start border-danger' title='" +details+ "'>";
					attackStr += "		<div class='d-flex w-100 justify-content-between'>";
					attackStr += "			<h5 class='mb-1'>" +title+ "</h5>";
					attackStr += "			<small>" +date.substr(0, 10)+ "</small>";
					attackStr += "		</div>";
					attackStr += "		<p class='mb-0 fst-italic'>" +type+ "</p>";
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
			result = parseFloat(numberStr).toLocaleString('ko-KR', {maximumFractionDigits: 2}); // 1000단위 쉼표 & 소수점 자리수
		}
		// 100 > 가격 >= 10 이면 소수점 3자리까지 표시
		if (number < 100 & number >= 10){
			result = parseFloat(numberStr).toLocaleString('ko-KR', {maximumFractionDigits: 3});
		}
		// 10 > 가격 >= 1 이면 소수점 4자리까지 표시
		if (number < 10 & number >= 1){
			result = parseFloat(numberStr).toLocaleString('ko-KR', {maximumFractionDigits: 4});
		}
		// 가격이 1 미만이면 소수점 5자리까지 표시
		if (number < 1){
			result = parseFloat(numberStr).toLocaleString('ko-KR', {maximumFractionDigits: 5});
		}
					
		return result;
	}
	
	// Board 구역 내용 가져오기
	$(function() {
		console.log("Board 처리하는 jQuery. 이 페이지에 요청된 심볼");
		console.log(reqSymbol);
		
		$.ajax({
			url : "./board/getBoard/" +reqSymbol,	// 콘트롤러 주소 
			//data : JSON.stringify(BoardObj),	//요청 파라미터
			type : "GET", //전송타입
			//contentType:'application/json;charset=utf-8',
			dataType : "json", //응답타입
			//async : false,
			success : function(result){
				console.log(result);
				//alert('게시물 리스트를 가져왔습니다. ID:'+sId+' / Symbol:'+reqSymbol);
				boardShow(result);
			},
			error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
				alert('Getting data from server has failed.');
				console.log("error : ", msg);
				console.log("status : ", status);
			}
		});
	})
	// 게시물 출력
	function boardShow(result){
		
		let timeStamp;
		let dayTime;
		let boardStr = "";
		
		for (index in result){
			boardStr += "<div class='row my-1'>";
			boardStr += "	<div class='col col-2'>";
			if (sId == result[index].u_id){// 내 게시글이면 아이콘 다르게 표시
				boardStr += "		<img src='resources/images/pepe_rich.png' height='50' class='bg-warning rounded-5'>";
			} else {
				boardStr += "		<img src='resources/images/pepe_smile.png' height='50' class='bg-light rounded-5'>";
			}
			boardStr += "	</div>";
			if (sId == result[index].u_id){// 내 게시글이면 테두리 넣기
				boardStr += "	<div class='col col-8 bg-light border border-2 border-warning rounded-3'>";
			} else {
				boardStr += "	<div class='col col-10 bg-light rounded-3'>";
			}
			boardStr += "		<small>";
			if (sId == result[index].u_id){// 내 게시글이면 이름 뒤에 (me) 넣기
				boardStr += "		<span class='fw-bold'>" +result[index].u_name+ " <sup class='text-primary'>(me)</sup></span>";
			} else {
				boardStr += "		<span class='fw-bold'>" +result[index].u_name+ "</span>";
			}
			timeStamp = Number(result[index].c_date);
			dayTime = new Date(timeStamp);
			boardStr += "		<span class='float-end me-1'>" +dayTime.toLocaleString()+ "</span><br/>";
			boardStr += "		<span class=''>" +result[index].content+ "</span>";
			boardStr += "		</small>";
			boardStr += "	</div>";
			if (sId == result[index].u_id){// 내 게시글이면 삭제버튼 넣기
				boardStr += "	<div class='col col-2'>";
				boardStr += "		<button type='button' id='delBoardBtn' class='btn btn-sm btn-danger float-end' value='" +result[index].c_id+ "'>삭제</button>";
				boardStr += "	</div>";
			}
			boardStr += "</div>";
			
			// for test (done)
//			boardStr += "c_id:" +result[index].c_id+ " / "
//			boardStr += "u_id:" +result[index].u_id+ " / "
//			boardStr += "u_name:" +result[index].u_name+ " / "
//			boardStr += "symbol:" +result[index].symbol+ " / "
//			boardStr += "c_date:" +result[index].c_date+ " / "
//			boardStr += "c_update:" +result[index].c_update+ " / "
//			boardStr += "content:" +result[index].content
//			boardStr += "<hr/>"
		}
		$("#board_contents").empty().append(boardStr);
	}
	
	// 새 게시물 등록
	$(function() {
		
		$("#newBoardBtn").click(function(){
			
			let contentText = $("#contentText").val();
			console.log(contentText);// for test (done)
			let boardObj = { u_id:sId, u_name:sName, symbol:reqSymbol, content:contentText };
			 
			$.ajax({
				url : "./board/newBoard/",	// 콘트롤러 주소 
				data : JSON.stringify(boardObj),	//요청 파라미터
				type : "POST", //전송타입
				contentType:'application/json;charset=utf-8',
				//dataType : "json", //응답타입
				//async : false,
				success : function(result){
					console.log(result);
					alert('새 게시물을 등록했습니다. ID:'+sId+' / Name:'+sName+'/ Symbol:'+reqSymbol);
					$("#contentText").val('');// 입력폼 지우기
					
					// 게시글 등록 후 리스트 다시 받아오기
					$.ajax({
						url : "./board/getBoard/" +reqSymbol,	// 콘트롤러 주소 
						type : "GET", //전송타입
						dataType : "json", //응답타입
						success : function(result){
							boardShow(result);
						},
						error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
							alert('게시물 등록 후 게시물 리스트 받아오기 실패.');
							console.log("error : ", msg);
							console.log("status : ", status);
						}
					});
					
				},
				error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
					alert('Getting data from server has failed.');
					console.log("error : ", msg);
					console.log("status : ", status);
				}
			});
			
		});
		
	})
	
	// 게시물 삭제
	$(function() {
		
		$(document).on('click', '#delBoardBtn', function(){ // 동적으로 생성된 버튼은 이렇게 처리한다. $('#id') 불가
			
			let contentId = $("#delBoardBtn").attr("value");
			console.log(contentId);// for test (done)
			let boardObj = { c_id:contentId, symbol:reqSymbol };
			
			$.ajax({
				url : "./board/delBoard/",	// 콘트롤러 주소 
				data : JSON.stringify(boardObj),	//요청 파라미터
				type : "DELETE", //전송타입
				contentType:'application/json;charset=utf-8',
				//dataType : "json", //응답타입
				//async : false,
				success : function(result){
					console.log(result);
					alert('게시물을 삭제했습니다. ID:'+sId+' / Content ID:'+contentId+'/ Symbol:'+reqSymbol);
					
					// 게시글 등록 후 리스트 다시 받아오기
					$.ajax({
						url : "./board/getBoard/" +reqSymbol,	// 콘트롤러 주소 
						type : "GET", //전송타입
						dataType : "json", //응답타입
						success : function(result){
							boardShow(result);
						},
						error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
							alert('게시물 등록 후 게시물 리스트 받아오기 실패.');
							console.log("error : ", msg);
							console.log("status : ", status);
						}
					});
					
				},
				error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
					alert('DELETE - Getting data from server has failed.');
					console.log("error : ", msg);
					console.log("status : ", status);
				}
			});
			
		});
		
	})
	
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
			<div class="col-lg-4">
				<!-- Basic Info from api data -->
				<div id="info" class="mt-3">
				
					<p><span id="coinName" class="h2">coinName</span><button type="button" id="coinSymbol" class="btn btn-primary btn-sm mx-2">coinSymbol</button></p>
					<p>
						<span id="coinRank" class="badge bg-secondary mx-1">rank</span>
						<span id="consensus" class="badge bg-secondary mx-1">consensus</span>
						<span id="cat" class="badge bg-secondary mx-1">category</span>
					</p>
					<hr/>
					<!-- Organization -->
					<p><small><strong><span class="badge rounded-pill bg-dark">Organizations</span><span id="org"></span></strong></small></p>
					<p><!-- 웹사이트 링크 -->
						<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
							<button type="button" id="wSite" class="btn btn-sm btn-success py-0"><i class="fa-solid fa-link"></i> Web-site</button>
							<div class="btn-group" role="group">
								<button id="btnGroupDrop1" type="button" class="btn btn-sm btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
								<div id="oLink" class="dropdown-menu" aria-labelledby="btnGroupDrop1">
									<a class="dropdown-item" href="#">none</a>
									<a class="dropdown-item" href="#">none</a>
								</div>
							</div>
						</div>
					</p>
					<hr/>
					<div id="attack">
						<span class="badge rounded-pill bg-danger mb-1">알려진 공격 및 취약점 없음</span><i class="fa-solid fa-shield-halved text-primary"></i><br/>
					</div>
					<!-- Tooltips -->
					<!-- end of Tooltips -->
					
				</div>
				<!-- end of Basic Info from api data -->
			</div>
			
			<!-- Price, Supply, Onchain Info -->
			<div id="info2" class="col-lg-4">
				<!-- Price -->
				<div class="mt-3">
					<small><strong><span id="priceTitle" class="text-muted">priceTitle</span></strong></small><br/>
					<span id="infoPrice" class="h2 fw-bold">infoPrice</span> <button type="button" id="usd24" class="btn btn-sm mx-2">24h %</button><br/>
					<span id="infoPriceBTC" class="h5 fw-bold text-muted">infoPriceBTC</span><small><span id="btc24" class="fw-bold mx-2"></span></small><br/>
					<span id="infoPriceETH" class="h5 fw-bold text-muted">infoPriceETH</span><small><span id="eth24" class="fw-bold mx-2"></span></small><hr/>
				</div>
				<!-- Vol, M.Cap, Supply -->
				<div>
					<table>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2">Real Volume</span></small></td>
							<td class="text-end"><small><span id="vol24" class="fw-bold">real vol24</span><span class="text-muted fw-bold"> USD</span></small></td>
							<td><small><span class="badge bg-secondary mx-2">24h</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2">Volume</span></small></td>
							<td class="text-end"><small><span id="vol24simple" class="fw-bold">vol24</span><span class="text-muted fw-bold"> USD</span></small></td>
							<td><small><span class="badge bg-secondary mx-2">24h</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2">Market Cap.</span></small></td>
							<td class="text-end"><small><span id="mCap" class="fw-bold">mCap</span><span class="text-muted fw-bold"> USD</span></small></td>
							<td><small><span id="dom" class="badge bg-danger mx-2">dom.</span></small></td>
						</tr>
							
					</table>
					<table>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2">Supply</span></small></td>
							<td><small><span class="badge rounded-pill bg-warning">인플레이션</span></small></td>
							<td class="text-center"><small><span id="supplyInflation" class="fw-bold"> -</span><span class="text-muted fw-bold"> %</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2 invisible">Supply</span></small></td>
							<td><small><span class="badge rounded-pill bg-warning">유통량</span></small></td>
							<td><small><span id="supplyCircul" class="fw-bold">Circulation</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2 invisible">Supply</span></small></td>
							<td><small><span class="badge rounded-pill bg-warning">+10년</span></small></td>
							<td><small><span id="supplyPlus10" class="fw-bold"> -</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-dark mx-2 invisible">Supply</span></small></td>
							<td><small><span class="badge rounded-pill bg-warning">2050년</span></small></td>
							<td><small><span id="supplyY2050" class="fw-bold"> -</span></small></td>
						</tr>
					</table>
					<hr/>
				</div>
				<!-- Onchain info -->
				<div>
					<span class="badge rounded-pill bg-danger">Onchain</span><br/>
					<div class="mx-2">
						<small><span class="badge rounded-pill bg-tomato">활성 주소</span><span id="addrActive" class="fw-bold"> -</span></small>
						<small><span class="badge rounded-pill bg-tomato">전체 주소</span><span id="addrCnt" class="fw-bold"> -</span></small>
						<br/>
						<small><span class="badge rounded-pill bg-tomato">블록 높이</span><span id="blockHeight" class="fw-bold"> -</span></small>
						<small><span class="badge rounded-pill bg-tomato">블록 주기</span><span id="blockInterval" class="fw-bold"> -</span><span class="text-muted"> sec</span></small>
						<br/>
						<small><span class="badge rounded-pill bg-tomato">평균 수수료</span><span id="feeUsd" class="fw-bold"> -</span><span class="text-muted"> USD</span></small>
						<br/>
						<small><span class="badge rounded-pill bg-tomato">Realized Market Cap.</span><span id="realizedMCap" class="fw-bold"> -</span><span class="text-muted"> USD</span></small>
						<p/>
					</div>
				</div>
			</div>
			<!-- end fo Price, Supply, Onchain Info -->
			
			<!-- ROI Info -->
			<div id="info3" class="col-lg-4">
				<!-- ATH & Cycle-Low data -->
				<div class="mt-3">
					<small><strong><span class="text-muted">Price History</span></strong></small><br/>
					<table>
						<tr>
							<td><span class="badge rounded-pill bg-success">All Time High</span></td>
							<td>&nbsp</td>
							<td><span class="badge rounded-pill bg-danger">Cycle Low</span></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-success">Date</span><span id="athAt" class="fw-bold text-success"> athAt</span></small></td>
							<td>&nbsp</td>
							<td><small><span class="badge rounded-pill bg-danger">Date</span><span id="lowAt" class="fw-bold text-danger"> lowAt</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-success">Price</span><span id="athPrice" class="fw-bold text-success"> athPrice</span><span class="text-muted"> USD</span></small></td>
							<td>&nbsp</td>
							<td><small><span class="badge rounded-pill bg-danger">Price</span><span id="lowPrice" class="fw-bold text-danger"> lowPrice</span><span class="text-muted"> USD</span></small></td>
						</tr>
						<tr>
							<td><small><span class="badge rounded-pill bg-success">Down</span><span id="athDown" class="fw-bold text-success"> athDown</span><span class="text-muted"> %</span></small></td>
							<td>&nbsp</td>
							<td><small><span class="badge rounded-pill bg-danger">Up</span><span id="lowUp" class="fw-bold text-danger"> lowUp</span><span class="text-muted"> %</span></small></td>
						</tr>
					</table>
					<hr/>
				</div>
				
				<!-- ROI data -->
				<div>
					<table>
						<tr>
							<td colspan="2"><span class="badge rounded-pill bg-primary">ROI</span></td>
							<td>&nbsp&nbsp</td>
							<td colspan="2"><span class="badge rounded-pill bg-warning">ROI by year</span></td>
						</tr>
						<tr>
							<td class="align-top">
								<small><span class="badge rounded-pill bg-primary">1 week</span></small><br/>
								<small><span class="badge rounded-pill bg-primary">1 month</span></small><br/>
								<small><span class="badge rounded-pill bg-primary">3 months</span></small><br/>
								<small><span class="badge rounded-pill bg-primary">1 year</span></small><br/>
								<small><span class="badge rounded-pill bg-primary">YTD</span></small><br/>
							</td>
							<td class="align-top text-end">
								<small><span id="roi1w" class="fw-bold text-primary"> roi1w</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi1m" class="fw-bold text-primary"> roi1m</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi3m" class="fw-bold text-primary"> roi3m</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi1y" class="fw-bold text-primary"> roi1y</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roiYTD" class="fw-bold text-primary"> roiYTD</span><span class="text-muted"> %</span></small><br/>
							</td>
							<td>&nbsp</td>
							<td class="align-top">
								<small><span class="badge rounded-pill bg-warning">2011</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2012</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2013</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2014</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2015</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2016</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2017</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2018</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2019</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2020</span></small><br/>
								<small><span class="badge rounded-pill bg-warning">2021</span></small><br/>
							</td>
							<td class="align-top text-end">
								<small><span id="roi2011" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2012" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2013" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2014" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2015" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2016" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2017" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2018" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2019" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2020" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								<small><span id="roi2021" class="fw-bold"> -</span><span class="text-muted"> %</span></small><br/>
								
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- end of ROI Info -->
				
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
			  <div id="tradingview_f9f55" style="height: 330px;"></div>			<!-- 스타일 나중에 css에 작성-------------------todo -->
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
		<div id="board_area" class="col-sm-12 col-md-6 col-lg-4 px-1">
			<!-- 게시물 타이틀 -->
			<div id="boardTitleBox" class="h2 mt-3 mx-3 bg-light rounded-4 text-center">
				<span id="boardTitle"> Board</span>
				<span id="boardTitleSymbol" class="badge rounded-pill bg-secondary py-1"> SYMBOL</span>
				<span class="fw-bold fst-italic"> Talk </span><i class="fa-regular fa-comment-dots"></i>
			</div>
			
			<!-- 게시물 입력창 -->
			<div id="writeBox">
				<form id="writeForm" method="post">
					<div class="form-group">
						<label for="content" class="form-label mt-2 mb-1">
							<span class="badge rounded-pill bg-primary ms-1">내 의견 쓰기</span> 
							<i class="fa-solid fa-pen text-primary"></i>
						</label>
						<div class="row">
							<div class="col-10 pe-0">
			<!-- 로그인/비로그인 메뉴 분기 -->
			<c:choose>
				<c:when test="${user == null}"><!-- 비 로그인 -->
								<textarea class="form-control pe-0" id="contentText" name="content" rows="2" placeholder="로그인 후 작성할 수 있습니다." disabled></textarea>
							</div>
							<div class="col-2 d-grid ps-1">
								<input id="newBoardBtn" type="button" class="btn btn-lg btn-primary disabled" value="등록" />
							</div>
				</c:when>
				<c:otherwise><!-- 로그인 -->
								<textarea class="form-control pe-0" id="contentText" name="content" rows="2" placeholder="한글 200자 이내로 입력하세요."></textarea>
							</div>
							<div class="col-2 d-grid ps-1">
								<input id="newBoardBtn" type="button" class="btn btn-lg btn-primary" value="등록" />
							</div>
				</c:otherwise>
			</c:choose>
							
						</div>
					</div>
				</form>
				<hr/>
			</div>
			
			<!-- 게시물 -->
			<div id="board_contents" class="container " >
				<div class="row">
					<div class="col col-2">
						<!-- 내꺼면 이미지 다른거 쓰자: sessionId == result.u_id -->
						<img src="resources/images/pepe_rich.png" height="50" class="bg-light rounded-5">
					</div>
					<div class="col col-8 bg-light border border-2 border-warning rounded-3">
						<small>
						<span class="fw-bold">자오장펑 TEST</span>
						<span class="float-end me-1">2022-11-09</span>
						<br/>
						<span class="">정보가 없을때 표시되는 메시지 입니다. I just flex FTX.com Gazua~~</span>
						</small>
					</div>
					<div class="col col-2">
						<!-- 내꺼면 삭제버튼 나오게 하자: sessionId == result.u_id -->
						<button type="button" class="btn btn-sm btn-danger float-end" value="c_id">삭제</button>
					</div>
				</div>
			</div>
			<!-- end of 게시물 -->
			
			<!-- 게시물 테스트 -->
			<!-- 
			<div class="container">
				<div class="row">
					<div class="col col-2">
						내꺼면 이미지 다른거 쓰자: sessionId == result.u_id
						<img src="resources/images/pepe_rich.png" height="50" class="bg-light rounded-5">
					</div>
					<div class="col col-8 bg-light border border-2 border-warning rounded-3">
						<small>
						<span class="fw-bold">자오장펑 TEST</span>
						<span class="float-end me-1">2022-11-09</span>
						<br/>
						<span class="">I just flex FTX.com Gazua~~</span>
						</small>
					</div>
					<div class="col col-2">
						내꺼면 삭제버튼 나오게 하자: sessionId == result.u_id
						<button type="button" class="btn btn-sm btn-danger float-end" value="c_id">삭제</button>
					</div>
				</div>
			</div>
			 -->
			<!-- end of 게시물 테스트 -->
			
		</div>
		<!-- end of Board -->
		
	</div>
</div>

	
	
</body>
</html>