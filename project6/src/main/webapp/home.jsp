<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<!-- Javascript -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	
	$(function() {
		//$('#aptListShown').on("click", 'a', function() {	// 해당 문법은 dynamically created elements에서 동작하지 않는다? https://stackoverflow.com/questions/32780644/selector-to-click-on-div-loaded-with-ajax-jquery
		//$(document).on('click', '#aptListShown a', function(){	// 값 넘어옴 (완료) ************************************* toto 이거 공부하기 $(document) vs $(선택자)
				
	
			const key = "3732d88b-29b4-466e-9750-d3d42ed051b3"; // Messari api key
				
			$.ajax({
				url : "https://data.messari.io/api/v1/assets/btc/metrics",	// 요청 주소
				data : "assetKey="+key,	//요청 파라미터
				type : "GET", //전송타입
				dataType : "json", //응답타입
				success : function(result) {	//통신 성공시 호출하는 함수
					//alert("요청에 의한 응답 성공 값 : " +result);
					console.log(result);
					jsonParsing(result);	// 가독성 위해 따로 작성
				},
				error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
					alert('Getting data from server has failed.');
					//console.log("error : ", msg);
					//console.log("status : ", status);
				}
				
			});
			function jsonParsing(result) {
				let symbolText = result.data.slug;
				$("#symbol").empty().append(symbolText);
			}
			
		//});
	});
	
	</script>


</head>

<body>
	<p>메사리 api GET 요청 test </p>
	<p>응답 type: <strong>json </strong></p>
	<hr/>
	<p>파싱된 문구: <span id="symbol">none</span></p>
	
</body>
</html>