<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Coin Informations</title>
	
	<!-- Bootstrap 5.2.2 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	
	<!-- Inner Style CSS -->
	<style type="text/css">
	
	@font-face{
		src: url("./ROKG_R.TTF");
		font-family: "ROKG"; 
	}
	body {
		font-family: "ROKG", "맑은 고딕", verdana, san-serif;
	}
	#info {
		font-family: "맑은 고딕", verdana, san-serif;
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
			let symbolText = "";
			str = "result.data.name 넘어온 값: " +result.data.name; // for test
			coinName = "<img src='https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/64/" +result.data.slug+ ".png' height='32' width='32' /><strong> " +result.data.name+ "</strong>";
			coinRank = "Rank #" +result.data.marketcap.rank;
			console.log(str);
			$("#coinName").empty().append(coinName);
			$("#coinRank").empty().append(coinRank);
			
			$("#testSymbol").empty().append(str); // for test
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
			
			for (index in result.data.profile.general.background.issuing_organizations) {
				orgName = result.data.profile.general.background.issuing_organizations[index].name
				orgLogo = result.data.profile.general.background.issuing_organizations[index].logo
				$("#org").append("<img src='" +orgLogo+ "' height='18' width='18'/>" +orgName);
			}
			
			let oLinkStr = ""; 
			for (index in result.data.profile.general.overview.official_links) {
				oLink = result.data.profile.general.overview.official_links[index].link
				oLinklName = result.data.profile.general.overview.official_links[index].name
				
				oLinkStr += "<a class='dropdown-item' href='" +oLink+ "'>" +oLinklName+ "</a>";
			}
			$("#oLink").empty().append();
			console.log(oLinkStr);
			
			console.log(consensus);
			$("#coinSymbol").empty().append(coinSymbol);
			$("#consensus").empty().append(consensus);
			$("#cat").empty().append(cat);
		}
	});
		
	</script>


</head>

<body>

<!-- Upper Nav bar -->
<%@include file="./topbar.jsp"%>
<!-- end of Upper Nav bar -->

<div class="container-fluid">
	<div class="row">
	
		<!-- Infomations -->
		<div class="col-sm-12 col-md-6 col-lg-8 px-1">
			
			<!-- Info from api data -->
			<div id="info" class="mt-3">
			
				<p><span id="coinName" class="h2">coinName</span><button type="button" id="coinSymbol" class="btn btn-primary btn-sm mx-2">coinSymbol</button></p>
				<p>
					<span id="coinRank" class="badge bg-secondary mx-1">rank</span>
					<span id="consensus" class="badge bg-secondary">rank</span>
					<span id="cat" class="badge bg-secondary">category</span>
				</p>
				<p>Organizations: <span id="org"></span></p>
				<p>
					<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
						<button type="button" class="btn btn-success">Web-site</button>
						<div class="btn-group" role="group">
							<button id="btnGroupDrop1" type="button" class="btn btn-sm btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
							<div id="oLink" class="dropdown-menu" aria-labelledby="btnGroupDrop1">
								<a class="dropdown-item" href="#">coinmarketcap.com</a>
								<a class="dropdown-item" href="#">Dropdown link</a>
							</div>
						</div>
					</div>
					</p>
					<p>응답 type: <strong>json </strong></p>
				<hr/>
				<p id="testSymbol">Loading...</p>
				
				
			</div>
			<!-- end of Info from api data -->
			
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