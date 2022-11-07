<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<!-- Bootstrap 5.2.2 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<!-- Javascript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Font-Awesome Icons -->
	<script src="https://kit.fontawesome.com/9ddb6abce0.js" crossorigin="anonymous"></script> 
	
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Jua&display=swap" rel="stylesheet"><!-- 우아한 형제들 폰트 -->
		

<style type="text/css">
		body{
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
		@media screen and (max-width: 600px;){body{background-size: cover;: fixed}}
		/* #particles-js{
			height: 100%
		} */
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
		
		.loginBox{
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%,-50%);
			width: 350px;
			min-height: 200px;
			/* background: #000000; */
			border-radius: 10px;
			padding: 40px;
			box-sizing: border-box
		}
		.user{
			margin: 0 auto;
			display: block;
			margin-bottom: 20px
		}
		h3{
			margin: 0;
			padding: 0 0 20px;
			color: #59238F;
			text-align: center
		}
		.loginBox input{
			width: 100%;
			margin-bottom: 20px
		}
		.loginBox input[type="text"], .loginBox input[type="password"]{
			border: none;
			border-bottom: 2px solid #262626;
			outline: none;
			height: 40px;
			color: #59238F;
			background: transparent;
			font-size: 16px;
			padding-left: 20px;
			box-sizing: border-box
		}
		.loginBox input[type="text"]:hover, .loginBox input[type="password"]:hover{
			color: #000000;		/* 글자색 */
			border: 1px solid #42F3FA;
			box-shadow: 0 0 5px rgba(0,255,0,.3), 0 0 10px rgba(0,255,0,.2), 0 0 15px rgba(0,255,0,.1), 0 2px 0 black
		}
		.loginBox input[type="text"]:focus, .loginBox input[type="password"]:focus{
			border-bottom: 2px solid #42F3FA
		}
		.inputBox{
			position: relative
		}
		.inputBox span{
			position: absolute;
			top: 10px;
			color: #262626
		}
		.loginBox .login_button{
			border: none;
			outline: none;
			height: 40px;
			font-size: 16px;
			background: #59238F;
			color: #fff;
			border-radius: 20px;
			cursor: pointer
		}
		.loginBox a{
			color: #262626;
			font-size: 14px;
			font-weight: bold;
			text-decoration: none;
			text-align: center;
			display: block
		}
		a:hover, .pupple:hover{
			color: #00ffff
		}
		.signupBtn{
			color: #fff;
			border-radius: 20px;
		}
	
	</style>

</head>
<body>
	<!-- Upper Nav bar -->
	<%@include file="./topbar.jsp"%>
	<!-- end of Upper Nav bar -->

	<div class="container" align="center">

		<div class="loginBox bg-warning">
			<!-- <img class="user" src="https://i.ibb.co/yVGxFPR/2.png" height="100px" width="100px"> -->
			<img class="user" src="resources/images/pepe01.png" height="100px" width="100px">
			<h3>Log in here</h3>

			<!-- 로그인 실패시 뜨는 메시지 -->
			<c:if test="${result == 0 }">
				<div class="login_warn fw-bold text-primary">ID 또는 PASSWORD를<br/> 잘못 입력하셨습니다.</div>
			</c:if>

			<form id="login_form" method="post">
				<div class="inputBox">
					<input id="uname" type="text" name="u_id" placeholder="ID">
					<input id="pass" type="password" name="u_pw" placeholder="Password">
				</div>
				<input type="button" class="login_button text-center" value="Login">
			</form>
			<a href="#" onclick="alert('잘 생각해보세요. 술, 담배 줄이세요.')">Forget Password<br></a>
			<p class="h6 btn btn-sm btn-danger signupBtn " onclick="location.href='./register'">Sign-Up</p>
		</div>


	</div>
	
	<%-- <div class="wrapper">
		<form id="login_form" method="post">
			<div class="wrap">
				<div class="logo_wrap">
					<span>Log in</span>
				</div>
				<div class="login_wrap">
					<div class="id_wrap">
						<div class="id_input_box">
							<input class="id_input" name="u_id">
						</div>
					</div>
					<div class="pw_wrap">
						<div class="pw_input_box">
							<input class="pw_iput" name="u_pw">
						</div>
					</div>
					<c:if test="${result == 0 }">
						<div class="login_warn">ID 또는 PASSWORD 를 잘못 입력하셨습니다.</div>
					</c:if>
					<div class="login_button_wrap">
						<input type="button" class="login_button" value="로그인">
					</div>
				</div>
		</form>
	</div> --%>
	
	<script>
		/* 로그인 버튼 클릭 메서드 */
		$(".login_button").click(function()
		{
			/* 로그인 메서드 서버 요청 */
			$("#login_form").attr("action", "./login");
			$("#login_form").submit();
		});
	</script>
</body>
</html>
