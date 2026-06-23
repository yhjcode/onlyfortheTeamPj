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
        <div class="bgg-logo-title">会員登録</div>
        <div class="bgg-logo-sub">一緒に料理を楽しもう</div>
    </div>

    <c:if test="${not empty errorMsg}">
        <div class="bgg-error">${errorMsg}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/join" method="post" enctype="multipart/form-data" id="joinForm">
        <div class="mb-3">
            <label class="bgg-label">ユーザーID</label>
            <div class="bgg-id-wrap">
                <input type="text" name="userId" id="userId" class="bgg-input" placeholder="ユーザーID（英数字）" required>
                <button type="button" class="bgg-check-btn" onclick="checkUserId()">重複確認</button>
            </div>
            <div class="bgg-id-msg" id="userIdMsg"></div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">ニックネーム</label>
            <input type="text" name="nickname" class="bgg-input" placeholder="ニックネーム" required>
        </div>
        <div class="mb-3">
            <label class="bgg-label">パスワード</label>
            <input type="password" name="password" id="pw" class="bgg-input" placeholder="パスワード（8文字以上）" minlength="8" required>
        </div>
        <div class="mb-3">
            <label class="bgg-label">パスワード確認</label>
            <input type="password" id="pwConfirm" class="bgg-input" placeholder="パスワードを再入力" required>
            <div class="bgg-id-msg" id="pwMsg"></div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">メール</label>
            <input type="email" name="email" class="bgg-input" placeholder="example@email.com" required>
        </div>
        <div class="bgg-row mb-3">
            <div>
                <label class="bgg-label">生年月日</label>
                <input type="date" name="birthday" class="bgg-input">
            </div>
            <div>
                <label class="bgg-label">電話番号</label>
                <input type="tel" name="phone" id="phone" class="bgg-input" placeholder="010-0000-0000" maxlength="13">
            </div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">プロフィール写真</label>
            <input type="file" name="profileImg" class="bgg-input" accept="image/*" style="padding: 7px 12px;">
        </div>
        <button type="submit" class="bgg-btn" id="submitBtn">登録する</button>
    </form>

    <div class="bgg-links">
        すでにアカウントをお持ちですか？ <a href="${pageContext.request.contextPath}/user/login">ログイン</a>
    </div>
</div>

<script>
var idChecked = false;

function checkUserId() {
    var userId = document.getElementById('userId').value.trim();
    var msg = document.getElementById('userIdMsg');
    if (!userId) { msg.textContent = 'ユーザーIDを入力してください。'; msg.className = 'bgg-id-msg ng'; return; }

    fetch('${pageContext.request.contextPath}/user/checkId?userId=' + encodeURIComponent(userId))
        .then(function(r){ return r.json(); })
        .then(function(data){
            if (data.available) {
                msg.textContent = '使用可能なユーザーIDです。';
                msg.className = 'bgg-id-msg ok';
                idChecked = true;
            } else {
                msg.textContent = 'すでに使用されているユーザーIDです。';
                msg.className = 'bgg-id-msg ng';
                idChecked = false;
            }
        });
}

document.getElementById('userId').addEventListener('input', function(){ idChecked = false; document.getElementById('userIdMsg').textContent = ''; });
document.getElementById('pwConfirm').addEventListener('input', function(){
    var msg = document.getElementById('pwMsg');
    if (this.value === document.getElementById('pw').value) {
        msg.textContent = 'パスワードが一致しています。'; msg.className = 'bgg-id-msg ok';
    } else {
        msg.textContent = 'パスワードが一致しません。'; msg.className = 'bgg-id-msg ng';
    }
});

document.getElementById('phone').addEventListener('input', function() {
    var digits = this.value.replace(/\D/g, '').slice(0, 11);
    if (digits.length > 7) {
        this.value = digits.slice(0, 3) + '-' + digits.slice(3, 7) + '-' + digits.slice(7);
    } else if (digits.length > 3) {
        this.value = digits.slice(0, 3) + '-' + digits.slice(3);
    } else {
        this.value = digits;
    }
});

document.getElementById('joinForm').addEventListener('submit', function(e){
    if (!idChecked) { e.preventDefault(); alert('ユーザーIDの重複確認を行ってください。'); return; }
    var pw = document.getElementById('pw').value;
    var pwc = document.getElementById('pwConfirm').value;
    if (pw !== pwc) { e.preventDefault(); alert('パスワードが一致しません。'); return; }
    var phone = document.getElementById('phone').value;
    if (phone && !/^\d{3}-\d{4}-\d{4}$/.test(phone)) {
        e.preventDefault();
        alert('電話番号は 010-0000-0000 の形式で入力してください。');
    }
});
</script>
