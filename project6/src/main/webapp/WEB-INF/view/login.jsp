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

<style>
</style>

</head>
<body>
	<!-- Upper Nav bar -->
	<%@include file="./topbar.jsp"%>
	<!-- end of Upper Nav bar -->

	<div class="wrapper">
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
	</div>
	</div>
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
