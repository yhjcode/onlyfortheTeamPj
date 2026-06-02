<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row justify-content-center">
    <div class="col-md-5">
        <h2 class="mb-4 text-center">로그인</h2>
        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="mb-3"><input type="text" name="userId" class="form-control" placeholder="아이디" required></div>
            <div class="mb-3"><input type="password" name="password" class="form-control" placeholder="비밀번호" required></div>
            <button type="submit" class="btn btn-danger w-100">로그인</button>
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/user/join">회원가입</a> ·
                <a href="${pageContext.request.contextPath}/user/findPw">비밀번호 찾기</a>
            </div>
        </form>
    </div>
</div>
