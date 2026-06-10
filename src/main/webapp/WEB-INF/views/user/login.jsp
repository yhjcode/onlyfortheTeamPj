<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.bgg-card { background: var(--color-background-primary, #fff); border: 0.5px solid #e0e0e0; border-radius: 12px; padding: 2rem; max-width: 440px; margin: 2rem auto; }
.bgg-logo-area { text-align: center; margin-bottom: 1.5rem; }
.bgg-logo-icon { font-size: 2rem; display: block; margin-bottom: 6px; }
.bgg-logo-title { font-size: 20px; font-weight: 500; color: #222; }
.bgg-logo-sub { font-size: 13px; color: #888; margin-top: 4px; }
.bgg-label { font-size: 13px; color: #666; margin-bottom: 6px; display: block; }
.bgg-input { width: 100%; padding: 10px 12px; border: 0.5px solid #ccc; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.15s; }
.bgg-input:focus { border-color: #C02121; box-shadow: 0 0 0 2px rgba(192,33,33,0.12); }
.bgg-btn { width: 100%; padding: 11px; background: #C02121; color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 500; cursor: pointer; margin-top: 8px; }
.bgg-btn:hover { background: #A31A1A; }
.bgg-links { text-align: center; font-size: 13px; color: #888; margin-top: 14px; }
.bgg-links a { color: #C02121; text-decoration: none; }
.bgg-error { background: #FCEBEB; color: #C02121; border-radius: 8px; padding: 10px 14px; font-size: 13px; margin-bottom: 14px; }
</style>

<div class="bgg-card">
    <div class="bgg-logo-area">
        <span class="bgg-logo-icon">🍳</span>
        <div class="bgg-logo-title">방구석셰프들</div>
        <div class="bgg-logo-sub">우리집만의 레시피 공유</div>
    </div>

    <c:if test="${not empty errorMsg}">
        <div class="bgg-error">${errorMsg}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/login" method="post">
        <div class="mb-3">
            <label class="bgg-label">아이디</label>
            <input type="text" name="userId" class="bgg-input" placeholder="아이디를 입력하세요" value="${param.userId}" required>
        </div>
        <div class="mb-3">
            <label class="bgg-label">비밀번호</label>
            <input type="password" name="password" class="bgg-input" placeholder="비밀번호를 입력하세요" required>
        </div>
        <button type="submit" class="bgg-btn">로그인</button>
    </form>

    <div class="bgg-links">
        <a href="${pageContext.request.contextPath}/user/join">회원가입</a>
    </div>
</div>
