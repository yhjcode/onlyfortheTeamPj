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
    <style>
        .write-menu-wrap { position: relative; display: inline-flex; }
        .write-menu-box {
            display: none;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            top: calc(100% + 8px);
            background: #fff;
            border: 1px solid #e8e8e8;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.13);
            min-width: 172px;
            z-index: 9999;
            overflow: hidden;
        }
        .write-menu-box.open { display: block; }
        .write-menu-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 13px 18px;
            color: #333;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: background 0.15s;
        }
        .write-menu-item:hover { background: #fff5f5; color: #dc3545; }
        .write-menu-item + .write-menu-item { border-top: 1px solid #f0f0f0; }
    </style>
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
                    		<option value="recipe" ${param.searchType eq 'recipe' ? 'selected' : ''}>레시피</option>
                    		<option value="theme" ${param.searchType eq 'theme' ? 'selected' : ''}>추천테마</option>
                   			<option value="user" ${param.searchType eq 'user' ? 'selected' : ''}>쉐프</option></select>	
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
                                <div class="write-menu-wrap" id="writeMenuWrap">
                                    <button type="button" class="bggchef-icon-btn write" title="글 작성" id="writeMenuBtn">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <div class="write-menu-box" id="writeMenuBox">
                                        <a href="${pageContext.request.contextPath}/recipe/write" class="write-menu-item">
                                            <i class="bi bi-journal-richtext"></i>레시피 작성하기
                                        </a>
                                        <a href="${pageContext.request.contextPath}/theme/write" class="write-menu-item">
                                            <i class="bi bi-collection"></i>테마 작성하기
                                        </a>
                                    </div>
                                </div>
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

    <script>
    (function() {
        var btn = document.getElementById('writeMenuBtn');
        var box = document.getElementById('writeMenuBox');
        if (!btn) return;
        btn.addEventListener('click', function(e) {
            e.stopPropagation();
            box.classList.toggle('open');
        });
        document.addEventListener('click', function() {
            box.classList.remove('open');
        });
    })();
    </script>

    <main class="container py-4">