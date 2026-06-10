<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.bgg-card { background: var(--color-background-primary, #fff); border: 0.5px solid #e0e0e0; border-radius: 12px; padding: 2rem; max-width: 500px; margin: 2rem auto; }
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
.bgg-row { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.bgg-error { background: #FCEBEB; color: #C02121; border-radius: 8px; padding: 10px 14px; font-size: 13px; margin-bottom: 14px; }
.bgg-id-wrap { display: flex; gap: 8px; }
.bgg-id-wrap .bgg-input { flex: 1; }
.bgg-check-btn { white-space: nowrap; padding: 10px 14px; background: #fff; color: #C02121; border: 1px solid #C02121; border-radius: 8px; font-size: 13px; cursor: pointer; }
.bgg-check-btn:hover { background: #FCEBEB; }
.bgg-id-msg { font-size: 12px; margin-top: 5px; }
.bgg-id-msg.ok { color: #28a745; }
.bgg-id-msg.ng { color: #C02121; }
</style>

<div class="bgg-card">
    <div class="bgg-logo-area">
        <span class="bgg-logo-icon">🍳</span>
        <div class="bgg-logo-title">회원가입</div>
        <div class="bgg-logo-sub">함께 요리하는 즐거움</div>
    </div>

    <c:if test="${not empty errorMsg}">
        <div class="bgg-error">${errorMsg}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/join" method="post" enctype="multipart/form-data" id="joinForm">
        <div class="mb-3">
            <label class="bgg-label">아이디</label>
            <div class="bgg-id-wrap">
                <input type="text" name="userId" id="userId" class="bgg-input" placeholder="아이디 (영문, 숫자)" required>
                <button type="button" class="bgg-check-btn" onclick="checkUserId()">중복확인</button>
            </div>
            <div class="bgg-id-msg" id="userIdMsg"></div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">닉네임</label>
            <input type="text" name="nickname" class="bgg-input" placeholder="닉네임" required>
        </div>
        <div class="mb-3">
            <label class="bgg-label">비밀번호</label>
            <input type="password" name="password" id="pw" class="bgg-input" placeholder="비밀번호 (8자 이상)" minlength="8" required>
        </div>
        <div class="mb-3">
            <label class="bgg-label">비밀번호 확인</label>
            <input type="password" id="pwConfirm" class="bgg-input" placeholder="비밀번호 재입력" required>
            <div class="bgg-id-msg" id="pwMsg"></div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">이메일</label>
            <input type="email" name="email" class="bgg-input" placeholder="example@email.com" required>
        </div>
        <div class="bgg-row mb-3">
            <div>
                <label class="bgg-label">생년월일</label>
                <input type="date" name="birthday" class="bgg-input">
            </div>
            <div>
                <label class="bgg-label">연락처</label>
                <input type="tel" name="phone" class="bgg-input" placeholder="010-0000-0000">
            </div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">프로필 사진</label>
            <input type="file" name="profileImg" class="bgg-input" accept="image/*" style="padding: 7px 12px;">
        </div>
        <button type="submit" class="bgg-btn" id="submitBtn">가입하기</button>
    </form>

    <div class="bgg-links">
        이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/user/login">로그인</a>
    </div>
</div>

<script>
var idChecked = false;

function checkUserId() {
    var userId = document.getElementById('userId').value.trim();
    var msg = document.getElementById('userIdMsg');
    if (!userId) { msg.textContent = '아이디를 입력하세요.'; msg.className = 'bgg-id-msg ng'; return; }

    fetch('${pageContext.request.contextPath}/user/checkId?userId=' + encodeURIComponent(userId))
        .then(function(r){ return r.json(); })
        .then(function(data){
            if (data.available) {
                msg.textContent = '사용 가능한 아이디입니다.';
                msg.className = 'bgg-id-msg ok';
                idChecked = true;
            } else {
                msg.textContent = '이미 사용 중인 아이디입니다.';
                msg.className = 'bgg-id-msg ng';
                idChecked = false;
            }
        });
}

document.getElementById('userId').addEventListener('input', function(){ idChecked = false; document.getElementById('userIdMsg').textContent = ''; });
document.getElementById('pwConfirm').addEventListener('input', function(){
    var msg = document.getElementById('pwMsg');
    if (this.value === document.getElementById('pw').value) {
        msg.textContent = '비밀번호가 일치합니다.'; msg.className = 'bgg-id-msg ok';
    } else {
        msg.textContent = '비밀번호가 일치하지 않습니다.'; msg.className = 'bgg-id-msg ng';
    }
});

document.getElementById('joinForm').addEventListener('submit', function(e){
    if (!idChecked) { e.preventDefault(); alert('아이디 중복확인을 해주세요.'); return; }
    var pw = document.getElementById('pw').value;
    var pwc = document.getElementById('pwConfirm').value;
    if (pw !== pwc) { e.preventDefault(); alert('비밀번호가 일치하지 않습니다.'); }
});
</script>
