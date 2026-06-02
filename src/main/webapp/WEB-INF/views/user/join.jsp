<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row justify-content-center">
    <div class="col-md-6">
        <h2 class="mb-4 text-center">회원가입</h2>
        <form action="${pageContext.request.contextPath}/user/join" method="post" enctype="multipart/form-data">
            <div class="mb-3"><label class="form-label">아이디</label><input type="text" name="userId" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">비밀번호</label><input type="password" name="password" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">닉네임</label><input type="text" name="nickname" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">이메일</label><input type="email" name="email" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">생년월일</label><input type="date" name="birthday" class="form-control"></div>
            <div class="mb-3"><label class="form-label">연락처</label><input type="tel" name="phone" class="form-control" placeholder="010-1234-5678"></div>
            <div class="mb-3"><label class="form-label">프로필 사진</label><input type="file" name="profileImg" class="form-control" accept="image/*"></div>
            <button type="submit" class="btn btn-danger w-100">가입하기</button>
        </form>
    </div>
</div>
