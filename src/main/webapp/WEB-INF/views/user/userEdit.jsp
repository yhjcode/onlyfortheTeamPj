<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.bggchef.dto.UserDTO loginUser =
        (com.bggchef.dto.UserDTO) session.getAttribute("loginUser");
%>
<style>
.bgg-card { background: var(--color-background-primary,#fff); border: 0.5px solid #e0e0e0; border-radius: 12px; padding: 2rem; max-width: 500px; margin: 2rem auto; }
.bgg-logo-area { text-align: center; margin-bottom: 1.5rem; }
.bgg-label { font-size: 13px; color: #666; margin-bottom: 6px; display: block; }
.bgg-input { width: 100%; padding: 10px 12px; border: 0.5px solid #ccc; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.15s; }
.bgg-input:focus { border-color: #C02121; box-shadow: 0 0 0 2px rgba(192,33,33,0.12); }
.bgg-input:disabled { background: #f5f5f5; color: #aaa; }
.bgg-btn { width: 100%; padding: 11px; background: #C02121; color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 500; cursor: pointer; margin-top: 8px; }
.bgg-btn:hover { background: #A31A1A; }
.bgg-row { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.bgg-danger-zone { margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid #f0f0f0; text-align: center; }
.bgg-danger-zone p { font-size: 13px; color: #aaa; margin-bottom: 10px; }
.bgg-withdraw-btn { font-size: 13px; color: #aaa; background: none; border: 1px solid #e0e0e0; border-radius: 8px; padding: 8px 20px; cursor: pointer; }
.bgg-withdraw-btn:hover { color: #C02121; border-color: #C02121; }
</style>

<div class="bgg-card">
    <div class="bgg-logo-area">
        <span style="font-size:2rem;">🍳</span>
        <div style="font-size:20px;font-weight:500;margin-top:6px;">会員情報の編集</div>
    </div>

    <c:if test="${not empty errorMsg}">
        <div style="background:#FCEBEB;color:#C02121;border-radius:8px;padding:10px 14px;font-size:13px;margin-bottom:14px;">${errorMsg}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/edit" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="bgg-label">ユーザーID（変更不可）</label>
            <input type="text" class="bgg-input" value="<%= loginUser.getUserId() %>" disabled>
        </div>
        <div class="bgg-row mb-3">
            <div>
                <label class="bgg-label">ニックネーム</label>
                <input type="text" name="nickname" class="bgg-input" value="<%= loginUser.getNickname() %>" required>
            </div>
            <div>
                <label class="bgg-label">電話番号</label>
                <input type="tel" name="phone" class="bgg-input" value="<%= loginUser.getPhone() != null ? loginUser.getPhone() : "" %>">
            </div>
        </div>
        <div class="mb-3">
            <label class="bgg-label">メール</label>
            <input type="email" name="email" class="bgg-input" value="<%= loginUser.getEmail() %>" required>
        </div>
        <div class="mb-3">
            <label class="bgg-label">生年月日</label>
            <input type="date" name="birthday" class="bgg-input" value="<%= loginUser.getBirthday() != null ? loginUser.getBirthday().toString() : "" %>">
        </div>
        <div class="mb-3">
            <label class="bgg-label">プロフィール写真</label>
            <input type="file" name="profileImg" class="bgg-input" accept="image/*" style="padding:7px 12px;">
        </div>
        <button type="submit" class="bgg-btn">変更を保存</button>
    </form>

    <div class="bgg-danger-zone">
        <p>おうちシェフのご利用を終了しますか？</p>
        <a href="${pageContext.request.contextPath}/user/withdraw">
            <button type="button" class="bgg-withdraw-btn">退会する</button>
        </a>
    </div>
</div>
