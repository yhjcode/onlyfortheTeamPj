<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript" src="imsi.js"></script>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>방구석셰프들 - 우리집만의 레시피 공유</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
</head>
<body>
    <!-- 상단 헤더 -->
    <header class="bggchef-header">
        <div class="container">
            <div class="row align-items-center g-3">
                <!-- 로고 -->
                <div class="col-md-2 col-12 text-center text-md-start">
                    <a href="${pageContext.request.contextPath}/main" class="bggchef-logo">
                        <span class="logo-icon">🍳</span>방구석셰프들
                    </a>
                </div>

                <!-- 중앙 검색바 -->
               
                <div class="col-md-7 col-12">
                  
                    <form action="${pageContext.request.contextPath}/search/search.jsp" method="get" class="bggchef-search"><%-- onsubmit="return checkSearch()" --%>
                    <div class="select d-flex align-items-center">
                   <select name="searchType" class="form-select bggchef-select">
                    		<option value="recipe" selected>레시피</option>
                    		<option value="theme">추천테마</option>
                   			<option value="user">쉐프</option></select>	
                    		&nbsp;&nbsp;
                        <input type="search" name="keyword" placeholder="레시피, 재료, 셰프를 검색하세요" value="${param.keyword}">
                        <button type="submit" aria-label="검색"><i class="bi bi-search"></i></button></div>
                    </form>
                </div>

                <!-- 우측 액션 -->
                <div class="col-md-3 col-12">
                    <div class="bggchef-actions justify-content-md-end justify-content-center">
                        <c:choose>
                            <c:when test="${empty sessionScope.loginUser}">
                                <a href="${pageContext.request.contextPath}/user/login" class="bggchef-icon-btn" title="로그인">
                                    <i class="bi bi-person"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/user/join" class="btn btn-danger rounded-pill px-3">회원가입</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/mypage" class="bggchef-icon-btn" title="마이페이지">
                                    <i class="bi bi-person-fill"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/recipe/write" class="bggchef-icon-btn write" title="레시피 작성">
                                    <i class="bi bi-pencil-fill"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/user/logout" class="text-muted small" style="font-size: 0.85rem;">로그아웃</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- GNB (글로벌 네비게이션) -->
    <nav class="bggchef-gnb">
        <div class="container">
            <ul class="nav">
                <li class="nav-item"><a class="nav-link ${menu == 'main' ? 'active' : ''}" href="${pageContext.request.contextPath}/main">추천</a></li>
                <li class="nav-item"><a class="nav-link ${menu == 'category' ? 'active' : ''}" href="${pageContext.request.contextPath}/category/list">분류</a></li>
                <li class="nav-item"><a class="nav-link ${menu == 'ranking' ? 'active' : ''}" href="${pageContext.request.contextPath}/ranking/daily">랭킹</a></li>
                <li class="nav-item"><a class="nav-link ${menu == 'theme' ? 'active' : ''}" href="${pageContext.request.contextPath}/theme/list">추천테마</a></li>
            </ul>
        </div>
    </nav>

    <main class="container py-4">