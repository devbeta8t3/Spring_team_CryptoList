<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>

<nav class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark">
	<div id="topBar" class="container-fluid">
		<a class="navbar-brand" href="#"><i class="fa-brands fa-bitcoin text-warning"></i> Crypto-List</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarColor03">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" href="./">Home<span class="visually-hidden">(current)</span></a></li>
				<li class="nav-item"><a class="nav-link" href="./list">TOP100</a></li>
				<!-- 로그인/비로그인 메뉴 분기 -->
				<c:choose>
					<c:when test="${empty sessionId}">
						<!-- 비로그인 메뉴 -->
					</c:when>
					<c:otherwise>
						<!-- 로그인 메뉴 -->
						<li class="nav-item"><a class="nav-link" href="./favor">즐겨찾기</a></li>
					</c:otherwise>	
				</c:choose>
				<!-- 추가 메뉴 및 드롭다운 메뉴를 위한 예비코드 -->
				<!-- 
				<li class="nav-item">
				<a class="nav-link" href="#">About</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">Action</a>
						<a class="dropdown-item" href="#">Another action</a>
						<a class="dropdown-item" href="#">Something else here</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Separated link</a>
					</div>
				</li>
				-->
				<!-- 추가 메뉴 예비코드 끝 -->
			</ul>
			<form class="d-flex">
				<c:choose>
					<c:when test="${empty sessionId}">
						<!-- 비로그인 메뉴 -->
						<button class="btn btn-primary my-2 my-sm-0 mx-2" type="button">로그인</button>
						<button class="btn btn-danger my-2 my-sm-0" type="button">회원가입</button>
					</c:when>
					<c:otherwise>
						<!-- 로그인 메뉴 -->
						<button class="btn btn-outline-success my-2 my-sm-0 mx-2"
							type="button">[김코인]님 접속중</button>
						<button class="btn btn-warning my-2 my-sm-0" type="button">회원정보</button>
						<button class="btn btn-danger my-2 my-sm-0" type="button">로그아웃</button>
					</c:otherwise>
				</c:choose>
			</form>
		</div>
	</div>
</nav>

