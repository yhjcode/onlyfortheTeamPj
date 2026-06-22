<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.bggchef.dto.UserDTO loginUser =
        (com.bggchef.dto.UserDTO) session.getAttribute("loginUser");
%>
<style>
.bgg-card { background: #fff; border: 0.5px solid #e0e0e0; border-radius: 12px; padding: 2rem; max-width: 440px; margin: 2rem auto; }
.bgg-logo-area { text-align: center; margin-bottom: 1.5rem; }
.bgg-warn-box { background: #fff8f0; border: 1px solid #ffd6a5; border-radius: 10px; padding: 1rem 1.2rem; margin-bottom: 1.5rem; font-size: 13px; color: #7d4e00; }
.bgg-warn-box ul { margin: 8px 0 0 0; padding-left: 1.2rem; }
.bgg-warn-box li { margin-bottom: 4px; }
.bgg-label { font-size: 13px; color: #666; margin-bottom: 6px; display: block; }
.bgg-input { width: 100%; padding: 10px 12px; border: 0.5px solid #ccc; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.15s; }
.bgg-input:focus { border-color: #C02121; box-shadow: 0 0 0 2px rgba(192,33,33,0.12); }
.bgg-btn-danger { width: 100%; padding: 11px; background: #C02121; color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 500; cursor: pointer; margin-top: 8px; }
.bgg-btn-danger:hover { background: #A31A1A; }
.bgg-btn-cancel { width: 100%; padding: 11px; background: #fff; color: #666; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; cursor: pointer; margin-top: 8px; }
.bgg-btn-cancel:hover { background: #f5f5f5; }
.bgg-error { background: #FCEBEB; color: #C02121; border-radius: 8px; padding: 10px 14px; font-size: 13px; margin-bottom: 14px; }
</style>

<div class="bgg-card">
    <div class="bgg-logo-area">
        <span style="font-size:2rem;">⚠️</span>
        <div style="font-size:20px;font-weight:500;margin-top:6px;">退会</div>
        <div style="font-size:13px;color:#888;margin-top:4px;"><%= loginUser.getNickname() %>さん、本当に退会しますか？</div>
    </div>

    <div class="bgg-warn-box">
        <strong>退会前にご確認ください</strong>
        <ul>
            <li>退会すると、すべての個人情報が削除されます。</li>
            <li>投稿したレシピとコメントはそのまま残ります。</li>
            <li>退会後、同じIDでの再登録はできません。</li>
        </ul>
    </div>

    <c:if test="${not empty errorMsg}">
        <div class="bgg-error">${errorMsg}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/withdraw" method="post">
        <div class="mb-3">
            <label class="bgg-label">パスワード確認</label>
            <input type="password" name="password" class="bgg-input" placeholder="現在のパスワードを入力してください" required>
        </div>
        <button type="submit" class="bgg-btn-danger"
                onclick="return confirm('本当に退会しますか？この操作は取り消せません。')">
            退会する
        </button>
        <a href="${pageContext.request.contextPath}/user/mypage">
            <button type="button" class="bgg-btn-cancel">キャンセル</button>
        </a>
    </form>
</div>
