<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		
<style>

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
	
	@font-face{
	src: url("resources/fonts/ROKG_R.TTF");
	font-family: "ROKG"; 
	}
	body, .badge {
		font-family: "ROKG", "맑은 고딕", verdana, san-serif;
	}
	.wrapper {
		font-family: 'Jua', san-serif;
	}
	.formRadius{
		border-radius: 20px;
	}
	
	/* 아이디 중복 검사  */
	.id_input_re_1 {
		color: green;
		display: none;
	}
	
	.id_input_re_2 {
		color: red;
		display: none;
	}
	
	/* 비밀번호 확인 일치 유효성 검사 */
	.pwck_input_re_1 {
		color: green;
		display: none;
	}
	
	.pwck_input_re_2 {
		color: red;
		display: none;
	}
	
	/* 유효성 검사 문구 */
	.final_id_ck {
		display: none;
	}
	
	.final_pw_ck {
		display: none;
	}
	
	.final_pwck_ck {
		display: none;
	}
	
	.final_name_ck {
		display: none;
	}
	
	.final_mail_ck {
		display: none;
	}
	
	.final_addr_ck {
		display: none;
	}
	
	.id_name {
		dilplay: block;
	}
</style>
</head>

<body>
	<!-- Upper Nav bar -->
	<%@include file="./topbar.jsp"%>
	<!-- end of Upper Nav bar -->

	<div class="wrapper">
	
		<div class="jumbotron bg-success bg-opacity-25">
			<div class="container ">
				<h1 class="display-3 pt-3 text-light">회원정보 수정</h1>
			</div>
		</div>
		
		<div class="container bg-warning pt-4 pb-3 formRadius">
			<!-- 회원 입력 양식 -->
			<form id="userinfo_form" method="post" class="form-horizontal">
				<div class="wrap">
					<div class="id_wrap form-group row justify-content-center mb-2">
						<label class="col-lg-2 col-md-4 col-sm-2 text-lg-end text-md-end text-sm-end text-start">아이디</label>
						<div class="id_input_box col-lg-4 col-md-6 col-sm-6">
							<input class="id_input form-control" name="u_id" value="${user.u_id}" readonly>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2"><span class="badge rounded-pill bg-secondary">*수정불가</span></div>
					</div>
					<div class="pw_wrap form-group row justify-content-center mb-2">
						<label class="col-lg-2 col-md-4 col-sm-2 text-lg-end text-md-end text-sm-end text-start">비밀번호</label>
						<div class="pw_input_box col-lg-4 col-md-6 col-sm-6">
							<input type="password" class="pw_input form-control" name="u_pw" placeholder="Password" required>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2"><span class="badge rounded-pill bg-danger">*Required</span></div>
						<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
					</div>
					<div class="pwck_wrap form-group row justify-content-center mb-2">
						<label class="col-lg-2 col-md-4 col-sm-2 text-lg-end text-md-end text-sm-end text-start">비밀번호 확인</label>
						<div class="pwck_input_box col-lg-4 col-md-6 col-sm-6">
							<input type="password" class="pwck_input form-control" placeholder="Confirm password" required>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2"><span class="badge rounded-pill bg-danger">*Required</span></div>
						<span class="final_pwck_ck text-center">비밀번호 확인을 입력해주세요.</span> <span class="pwck_input_re_1 text-center">비밀번호가 일치합니다.</span> <span class="pwck_input_re_2 text-center">비밀번호가 일치하지 않습니다.</span>
					</div>
					<div class="user_wrap form-group row justify-content-center mb-2">
						<label class="col-lg-2 col-md-4 col-sm-2 text-lg-end text-md-end text-sm-end text-start">이름</label>
						<div class="user_input_box col-lg-4 col-md-6 col-sm-6">
							<input class="user_input form-control" name="u_name" value="${user.u_name}" readonly>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2"><span class="badge rounded-pill bg-secondary">*수정불가</span></div>
						<span class="final_name_ck">이름을 입력해주세요.</span>
					</div>
					<div class="mail_wrap form-group row justify-content-center mb-2">
						<label class="col-lg-2 col-md-4 col-sm-2 text-lg-end text-md-end text-sm-end text-start">이메일</label>
						<div class="mail_input_box col-lg-4 col-md-6 col-sm-6">
							<input type="email" class="mail_input form-control" name="u_email" value="${user.u_email}" required>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2"><span class="badge rounded-pill bg-danger">*Required</span></div>
						<span class="final_mail_ck">이메일을 입력해주세요.</span>
	
						<div class="clearfix"></div>
					</div>
				</div>
				
				<div class="join_button_wrap">
					<div class="mail_wrap form-group row justify-content-center mb-2">
						<div class="col-lg-2 col-md-4 col-sm-2 text-lg-end text-md-end text-sm-end text-start"></div>
						<div class="mail_input_box col-sm-4 row">
							<input type="button" class="userupdate_button btn btn-success col-6" value="회원수정" onclick="location.href='./userUpdate'">
							<input type="button" class="userdelete_button btn btn-danger col-6" value="회원탈퇴" onclick="location.href='./userDelete'">
						</div>
						<div class="col-lg-2 col-md-2 col-sm-2"></div> 
					</div>
				</div>
			</form>
			
		</div>
	</div>

	<script>
		/* 유효성 검사 통과유무 변수 */
		var pwCheck = false; // 비번
		var pwckCheck = false; // 비번 확인
		var pwckcorCheck = false; // 비번 확인 일치 확인
		var nameCheck = false; // 이름
		var mailCheck = false; // 이메일

		$(document).ready(function()
		{
			//회원가입 버튼(회원가입 기능 작동)
			$(".userupdate_button").click(function()
			{
				/* 입력값 변수 */
				var pw = $('.pw_input').val(); // 비밀번호 입력란
				var pwck = $('.pwck_input').val(); // 비밀번호 확인 입력란
				var name = $('.user_input').val(); // 이름 입력란
				var mail = $('.mail_input').val(); // 이메일 입력란

				/* 비밀번호 빈칸 유효성 검사 */
				if (pw == "")
				{
					$('.final_pw_ck').css('display', 'block');
					pwCheck = false;
				} else
				{
					$('.final_pw_ck').css('display', 'none');
					pwCheck = true;
				}

				/* 비밀번호 빈칸 확인 유효성 검사 */
				if (pwck == "")
				{
					$('.final_pwck_ck').css('display', 'block');
					pwckCheck = false;
				} else
				{
					$('.final_pwck_ck').css('display', 'none');
					pwckCheck = true;
				}

				/* 이름 빈칸 유효성 검사 */
				if (name == "")
				{
					$('.final_name_ck').css('display', 'block');
					nameCheck = false;
				} else
				{
					$('.final_name_ck').css('display', 'none');
					nameCheck = true;
				}

				/* 이메일 빈칸 유효성 검사 */
				if (mail == "")
				{
					$('.final_mail_ck').css('display', 'block');
					mailCheck = false;
				} else
				{
					$('.final_mail_ck').css('display', 'none');
					mailCheck = true;
				}

				/* 최종 유효성 검사 후 회원수정 메서드 실행 */
				if (pwCheck && pwckCheck && pwckcorCheck && nameCheck && mailCheck)
				{
					$("#userinfo_form").attr("action", "./userUpdate");
					$("#userinfo_form").submit();
					alert("회원정보 수정이 완료되었습니다.");
				}
				return false;
			});
		});

		/* 비밀번호 확인 일치 유효성 검사 */
		$('.pwck_input').on("propertychange change keyup paste input", function()
		{
			var pw = $('.pw_input').val();
			var pwck = $('.pwck_input').val();
			$('.final_pwck_ck').css('display', 'none');

			if (pw == pwck)
			{
				$('.pwck_input_re_1').css('display', 'block');
				$('.pwck_input_re_2').css('display', 'none');
				pwckcorCheck = true;
			} else
			{
				$('.pwck_input_re_1').css('display', 'none');
				$('.pwck_input_re_2').css('display', 'block');
				pwckcorCheck = false;
			}
		});

		/* 회원삭제 메서드 */
		$(".userdelete_button").click(function()
		{
			/* 회원삭제 메서드 서버 요청 */
			alert('회원 탈퇴를 진행합니다. 개인정보는 저장되지 않습니다.');
			$("#userinfo_form").attr("action", "./userDelete");
			$("#userinfo_form").submit();
		});
	</script>
</body>
</html>