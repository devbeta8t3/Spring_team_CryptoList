<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- Bootstrap 5.2.2 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	
	<!-- Javascript -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	
 	$(function() {
		//$('#id').on("click", 'tag', function() {	// 해당 문법은 dynamically created elements에서 동작하지 않는다
		//$(document).on('click', '#id tag', function(){	// 위의 문법이 안될 경우 이렇게 작성하자.
				
	
		const key = "3732d88b-29b4-466e-9750-d3d42ed051b3"; // Messari api key
			
		$.ajax({
			url : "https://data.messari.io/api/v2/assets",	// 요청 주소
			data : "assetKey=" +key+ "&limit=10",	//요청 파라미터
			type : "GET", //전송타입
			dataType : "json", //응답타입
			success : function(result) {	//통신 성공시 호출하는 함수
				//alert("요청에 의한 응답 성공 값 : " +result);
				console.log(result);
				infoParsing(result);	// 가독성 위해 따로 작성
			},
			error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
				alert('Getting data from server has failed.');
				//console.log("error : ", msg);
				//console.log("status : ", status);
			}
			
		});
		function infoParsing(result) {
			let str = "";
			let symbolText = "";
			
			for (index in result.data){
				
				rankText = result.data[index].metrics.marketcap.rank;// rank
				nameText = result.data[index].name;// name
				symbolText = result.data[index].symbol;// 심볼
				priceText = result.data[index].metrics.market_data.price_usd;// 심볼
				mcapText = result.data[index].metrics.marketcap.current_marketcap_usd;// 심볼
				
				str += "<tr>";
				str += "<td>" +rankText+ "</td>";
				str += "<th scope='row'>" +nameText+ " " +symbolText+ "</th>";
				str += "<td>" +priceText+ "</td>";
				str += "<td>" +priceText+ "</td>";
				str += "</tr>";
			}
			$("#assetList").empty().append(str);
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
		<div class="col-sm-12 col-md-6 col-lg-6 px-1">
			
			<!-- Info from api data -->
			<div id="info" class="bg-success">
			
				<p class="h2">Infomations</p>
				<p>메사리 api GET 요청 test </p>
				<p>응답 type: <strong>json </strong></p>
				<hr/>
				
				
				
			</div>
			<!-- end of Info from api data -->
			
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container bg-primary">
			  <div id="tradingview_47af1" style="height: 400px;"></div>			<!-- 스타일 나중에 css에 작성-------------------todo -->
			  <div class="tradingview-widget-copyright">Chart by TradingView</div>
			  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
			  <script type="text/javascript">
				  // https://www.tradingview.com/widget/advanced-chart/
				  // ajax success 함수에 집어넣자 ------------------------------------------- todo
				  new TradingView.widget(
				  {
				  "autosize": true,
				  //"width": 900,
				  //"height": 400,
				  "symbol": "BINANCE:BTCUSDT",
				  "interval": "D",// 1, 3, 5, 15, 30, 60, 120, 240, D, W (숫자는 분단위)
				  "timezone": "Asia/Seoul",
				  "theme": "light",// light, dark
				  "style": "1",
				  "locale": "en",
				  "toolbar_bg": "#f1f3f6",
				  "enable_publishing": false,
				  "allow_symbol_change": true,
				  "container_id": "tradingview_47af1"
				  });
			  </script>
			</div>
			<!-- TradingView Widget END -->
			
		</div>
		<!-- end of Infomations -->
		
		
		<!-- Board -->
		<div class="col-sm-12 col-md-6 col-lg-6 bg-warning px-1">
			<p class="h2">Board</p>
		</div>
		<!-- Board -->
		
	</div>
</div>

	
	
</body>
</html>