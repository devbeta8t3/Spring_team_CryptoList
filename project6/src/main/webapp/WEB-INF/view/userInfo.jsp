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

<style>

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
		<form id="userinfo_form" method="post">
			<div class="wrap">
				<div class="subjecet">
					<span>회원정보</span>
				</div>
				<div class="id_wrap">
					<div class="id_name">아이디</div>
					<div class="id_input_box">
						<input class="id_input" name="u_id" value="${user.u_id}" readonly="readonly">
					</div>
				</div>
				<div class="pw_wrap">
					<div class="pw_name">비밀번호</div>
					<div class="pw_input_box">
						<input type="password" class="pw_input" name="u_pw">
					</div>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
				</div>
				<div class="pwck_wrap">
					<div class="pwck_name">비밀번호 확인</div>
					<div class="pwck_input_box">
						<input type="password" class="pwck_input">
					</div>
					<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span> <span class="pwck_input_re_1">비밀번호가 일치합니다.</span> <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
				<div class="user_wrap">
					<div class="user_name">이름</div>
					<div class="user_input_box">
						<input class="user_input" name="u_name" value="${user.u_name}" readonly="readonly">
					</div>
					<span class="final_name_ck">이름을 입력해주세요.</span>
				</div>
				<div class="mail_wrap">
					<div class="mail_name">이메일</div>
					<div class="mail_input_box">
						<input type="email" class="mail_input" name="u_email" value="${user.u_email}" required>
					</div>
					<span class="final_mail_ck">이메일을 입력해주세요.</span>

					<div class="clearfix"></div>
				</div>
			</div>

			<span class="userupdate_button_wrap"> <input type="button" class="userupdate_button" value="회원수정" onclick="location.href='./userUpdate'">
			</span> <span class="userdelete_button_wrap"> <input type="button" class="userdelete_button" value="회원삭제" onclick="location.href='./userDelete'">
			</span>

		</form>
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
			$("#userinfo_form").attr("action", "./userDelete");
			$("#userinfo_form").submit();
		});
	</script>
</body>
</html>