<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 - Coin List</title>
	
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
	#loginPage {
		background-image: url('resources/images/bg_doge_1920.jpg');
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-size: cover;
		color: white;
		height: 880px;
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


</head>

<body>

<!-- Upper Nav bar -->
<%@include file="./topbar.jsp"%>
<!-- end of Upper Nav bar -->

<div class="container-fluid">
	<div id="loginPage" class="row" >
		
		<div>
			<p class="h2 mt-5 text-center">로그인</p>
			<p class="text-center"> 빨리 빨리 로그인해.</p>
			<p class="text-center"><button type="button" class="btn btn-primary btn-lg" onclick="href:location='./list'">시작하기</button></p>
		</div>
		<!-- Login Box -->
		<div class="loginBox bg-warning"> <img class="user" src="https://i.ibb.co/yVGxFPR/2.png" height="100px" width="100px">
        	<h3>Log in here</h3>
        	<%
				// 로그인 실패시 표시되는 내용
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디, 비밀번호를 확인하세요");
					out.println("</div>");
				}
			%>
        	<form action="./list" method="post">
            	<div class="inputBox"> 
            		<input id="uname" type="text" name="id" placeholder="ID"> 
            		<input id="pass" type="password" name="password" placeholder="Password"> 
            	</div> 
            		<input type="submit" name="" value="Login">
        	</form> 
	        <a href="#" onclick="alert('잘 생각해보세요.')">Forget Password<br> </a>
	        <p class="h6 btn btn-sm btn-danger signupBtn " onclick="location.href='memberSignup.jsp'">Sign-Up</p>
    	</div>
		<!-- end of Login Box -->
	</div>
</div>

	
	
</body>
</html>