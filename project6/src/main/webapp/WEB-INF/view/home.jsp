<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Welcome to Coin-list</title>
	
	<!-- Bootstrap 5.2.2 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	
	<!-- Javascript -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<!-- Font-Awesome Icons -->
	<script src="https://kit.fontawesome.com/9ddb6abce0.js" crossorigin="anonymous"></script> 
	
	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Jua&display=swap" rel="stylesheet"><!-- 우아한 형제들 폰트 -->
		
	<style>
	body {
		margin: 0;
		padding: 0;
		background: url(resources/images/bg_doge_1920.jpg) no-repeat;
		height: 100vh;
		/* font-family: sans-serif; */
		background-size: cover;
		background-repeat: no-repeat;
		background-position: center;
		overflow: hidden
	}
	
	@font-face{
		src: url("/resources/ROKG_R.TTF");
		font-family: "ROKG"; 
	}
	body {
		font-family: "ROKG", "맑은 고딕", verdana, san-serif;
	}
	#topBar {
		font-family: 'Jua', san-serif;
	}
		
	</style>
	
	<%--
		session.setAttribute("sessionId", "aaa");	// 테스트를 위한 세션정보 강제 입력
	--%>


</head>

<body>

<!-- Upper Nav bar -->
<%@include file="./topbar.jsp"%>
<!-- end of Upper Nav bar -->

<div class="container-fluid">
	<div id="homeWelcome" class="row" >
		<!-- Welcome -->
		<div>
			<p class="h2 mt-5 text-center text-light">Welcome</p>
			<p class="text-center text-light"> Crypto List에 오신 것을 환영합니다.</p>
			<p class="text-center text-light"> 암호화폐 랭킹과 정보를 이용하세요.</p>
			<p class="text-center text-light"> 회원으로 등록하시면 즐겨찾기 메뉴를 이용할 수 있습니다.</p>
			<p class="text-center">
				<button type="button" class="btn btn-primary btn-lg" onclick="href:location='./list'">시작하기</button>
			</p>
		</div>
		<!-- end of Welcome -->
	</div>
</div>
	
</body>
</html>