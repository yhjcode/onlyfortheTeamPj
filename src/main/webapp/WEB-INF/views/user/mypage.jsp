<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.bggchef.dto.UserDTO loginUser =
        (com.bggchef.dto.UserDTO) session.getAttribute("loginUser");

    String ctx = request.getContextPath();

    String profileImg = (loginUser.getProfileImg() != null && !loginUser.getProfileImg().isEmpty())
        ? ctx + "/resources/upload/profile/" + loginUser.getProfileImg()
        : "https://via.placeholder.com/80x80?text=User";

    String medal = loginUser.getMedalGrade() != null ? loginUser.getMedalGrade() : "브론즈";
%>
<c:set var="ctx" value="<%= ctx %>"/>

<style>
.page-hero {
    background: linear-gradient(135deg, var(--bggchef-primary) 0%, #FF6B6B 100%);
    color: white;
    border-radius: 14px;
    padding: 36px 40px;
    margin-bottom: 32px;
    position: relative;
    overflow: hidden;
}
.page-hero::after {
    font-family: "bootstrap-icons";
    position: absolute;
    right: 40px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 120px;
    opacity: 0.12;
    line-height: 1;
}
.page-hero.mypage::after { content: '\F4E5'; /* bi-person-circle */ }
.page-hero h1 { font-size: 1.9rem; font-weight: 800; margin: 0 0 6px; }
.page-hero p  { margin: 0; opacity: 0.9; font-size: 1rem; }

.mp-profile-card { background:#fff; border:1px solid #e9ecef; border-radius:16px; padding:1.5rem 2rem; display:flex; align-items:center; gap:1.4rem; margin-bottom:2rem; }
.mp-avatar { width:80px; height:80px; border-radius:50%; object-fit:cover; border:2px solid #DC3545; flex-shrink:0; }
.mp-name  { font-size:18px; font-weight:600; margin-bottom:3px; }
.mp-email { font-size:13px; color:#6c757d; }
.mp-medal { display:inline-block; background:#fff5f5; color:#A32D2D; font-size:12px; padding:3px 10px; border-radius:20px; margin-top:6px; }
.mp-actions { margin-left:auto; display:flex; flex-direction:column; align-items:flex-end; gap:8px; }
.mp-edit-btn { color:#DC3545; background:#fff5f5; border-radius:50%; width:38px; height:38px; display:flex; align-items:center; justify-content:center; font-size:1.1rem; text-decoration:none; }
.mp-edit-btn:hover { background:#ffd6d6; }
.mp-withdraw-link { font-size:12px; color:#adb5bd; text-decoration:none; }
.mp-withdraw-link:hover { color:#DC3545; }
.mp-tabs { display:flex; flex-wrap:wrap; border-bottom:2px solid #e9ecef; margin-bottom:1.5rem; }
.mp-tab-btn { padding:10px 18px; font-size:14px; color:#888; background:none; border:none; border-bottom:2px solid transparent; margin-bottom:-2px; cursor:pointer; }
.mp-tab-btn:hover { color:#DC3545; }
.mp-tab-btn.active { color:#DC3545; font-weight:600; border-bottom-color:#DC3545; }
.mp-pane { display:none; }
.mp-pane.active { display:block; }
.mp-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(190px,1fr)); gap:16px; }
.mp-card { border:1px solid #e9ecef; border-radius:10px; overflow:hidden; text-decoration:none; color:inherit; display:block; }
.mp-card:hover { box-shadow:0 4px 12px rgba(0,0,0,.1); color:inherit; }
.mp-card img { width:100%; height:140px; object-fit:cover; display:block; }
.mp-card-body { padding:10px 12px; }
.mp-card-title { font-size:14px; font-weight:500; margin-bottom:4px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
.mp-card-meta { font-size:12px; color:#6c757d; }
.mp-review-item { padding:14px 0; border-bottom:1px solid #f0f0f0; }
.mp-review-item:last-child { border-bottom:none; }
.mp-recipe-link { font-size:13px; color:#DC3545; margin-bottom:4px; }
.mp-recipe-link a { color:#DC3545; text-decoration:none; }
.mp-writer { font-size:12px; color:#888; margin-bottom:4px; }
.mp-content { font-size:14px; }
.mp-meta { font-size:12px; color:#adb5bd; margin-top:5px; }
.mp-empty { text-align:center; padding:3rem 0; color:#adb5bd; font-size:14px; }
.mp-empty-icon { font-size:2.5rem; display:block; margin-bottom:8px; }
.mp-intro-wrap { margin-top:10px; }
.mp-intro-text { font-size:13px; color:#495057; line-height:1.6; white-space:pre-wrap; word-break:break-all; }
.mp-intro-empty { font-size:13px; color:#adb5bd; font-style:italic; }
.mp-intro-edit-btn { font-size:12px; color:#DC3545; background:none; border:none; padding:0; cursor:pointer; margin-left:6px; }
.mp-intro-edit-btn:hover { text-decoration:underline; }
.mp-intro-form { display:none; margin-top:6px; }
.mp-intro-form textarea { width:100%; font-size:13px; border:1px solid #dee2e6; border-radius:8px; padding:8px 10px; resize:vertical; }
.mp-intro-form .btn-save { font-size:12px; padding:3px 12px; }
</style>

<!-- 히어로 배너 -->
<div class="page-hero mypage">
    <h1><i class="bi bi-person-circle me-2"></i>마이페이지</h1>
    <p>나의 레시피와 활동을 한눈에 확인하세요</p>
</div>

<!-- 프로필 카드 -->
<div class="mp-profile-card">
    <img src="<%= profileImg %>" class="mp-avatar" alt="프로필"
         onerror="this.src='https://via.placeholder.com/80x80?text=User'">
    <div style="flex:1;min-width:0;">
        <div class="mp-name"><%= loginUser.getNickname() %></div>
        <div class="mp-email"><%= loginUser.getEmail() %></div>
        <span class="mp-medal">🏅 <%= medal %></span>
        <!-- 셰프 소개글 -->
        <div class="mp-intro-wrap">
            <c:choose>
                <c:when test="${not empty chefIntro}">
                    <span class="mp-intro-text" id="introText">${chefIntro}</span>
                </c:when>
                <c:otherwise>
                    <span class="mp-intro-empty" id="introText">소개글을 작성해 보세요.</span>
                </c:otherwise>
            </c:choose>
            <button type="button" class="mp-intro-edit-btn" id="introEditBtn" title="소개글 수정">
                <i class="bi bi-pencil"></i> 수정
            </button>
            <div class="mp-intro-form" id="introForm">
                <textarea id="introTextarea" rows="3" maxlength="1000" placeholder="나를 소개하는 글을 입력하세요 (최대 1000자)">${chefIntro}</textarea>
                <div class="d-flex justify-content-end gap-2 mt-1">
                    <button type="button" class="btn btn-outline-secondary btn-sm btn-save" id="introCancelBtn">취소</button>
                    <button type="button" class="btn btn-danger btn-sm btn-save" id="introSaveBtn">저장</button>
                </div>
            </div>
        </div>
    </div>
    <div class="mp-actions">
        <a href="<%= ctx %>/user/edit" class="mp-edit-btn" title="정보 수정">
            <i class="bi bi-pencil-fill"></i>
        </a>
        <a href="<%= ctx %>/user/withdraw" class="mp-withdraw-link">정보 수정</a>
    </div>
</div>

<!-- 탭 버튼 -->
<div class="mp-tabs" id="mpTabs">
    <button type="button" class="mp-tab-btn active" data-pane="mp-pane-recipe">내 레시피</button>
    <button type="button" class="mp-tab-btn"        data-pane="mp-pane-review">내가 쓴 댓글</button>
    <button type="button" class="mp-tab-btn"        data-pane="mp-pane-replies">내 글에 달린 댓글</button>
    <button type="button" class="mp-tab-btn"        data-pane="mp-pane-theme">내 테마</button>
    <button type="button" class="mp-tab-btn"        data-pane="mp-pane-favorite">즐겨찾기</button>
</div>

<!-- ─── 내 레시피 ─── -->
<div class="mp-pane active" id="mp-pane-recipe">
    <c:choose>
        <c:when test="${empty myRecipes}">
            <div class="mp-empty">
                <span class="mp-empty-icon">🍳</span>
                아직 작성한 레시피가 없어요<br>
                <a href="<%= ctx %>/recipe/write" class="btn btn-danger btn-sm mt-3">첫 레시피 작성하기</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="mp-grid">
                <c:forEach var="r" items="${myRecipes}">
                    <a href="<%= ctx %>/recipe/view?id=${r.recipeId}" class="mp-card">
                        <img src="${pageContext.request.contextPath}/resources/upload/recipe/${r.thumbnail}"
                             alt="${r.title}" loading="lazy"
                             onerror="this.src='https://via.placeholder.com/200x140?text=No+Image'">
                        <div class="mp-card-body">
                            <div class="mp-card-title">${r.title}</div>
                            <div class="mp-card-meta">
                                <c:if test="${r.avgRating != null}">⭐ ${r.avgRating} &nbsp;</c:if>
                                👁 ${r.viewCount} &nbsp; 📅 ${r.createdAt}
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- ─── 내가 쓴 댓글 ─── -->
<div class="mp-pane" id="mp-pane-review">
    <c:choose>
        <c:when test="${empty myReviews}">
            <div class="mp-empty"><span class="mp-empty-icon">💬</span>아직 작성한 댓글이 없어요</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="rv" items="${myReviews}">
                <div class="mp-review-item">
                    <div class="mp-recipe-link">
                        📄 <a href="<%= ctx %>/recipe/view?id=${rv.recipeId}">${rv.recipeTitle}</a>
                    </div>
                    <div class="mp-content">${rv.content}</div>
                    <div class="mp-meta">
                        <c:if test="${rv.rating != null}">⭐ ${rv.rating} · </c:if>${rv.createdAt}
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- ─── 내 글에 달린 댓글 ─── -->
<div class="mp-pane" id="mp-pane-replies">
    <c:choose>
        <c:when test="${empty repliesToMe}">
            <div class="mp-empty"><span class="mp-empty-icon">📬</span>내 레시피에 달린 댓글이 없어요</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="rv" items="${repliesToMe}">
                <div class="mp-review-item">
                    <div class="mp-recipe-link">
                        📄 <a href="<%= ctx %>/recipe/view?id=${rv.recipeId}">${rv.recipeTitle}</a>
                    </div>
                    <div class="mp-writer">👤 ${rv.nickname}</div>
                    <div class="mp-content">${rv.content}</div>
                    <div class="mp-meta">
                        <c:if test="${rv.rating != null}">⭐ ${rv.rating} · </c:if>${rv.createdAt}
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- ─── 내 테마 ─── -->
<div class="mp-pane" id="mp-pane-theme">
    <c:choose>
        <c:when test="${empty myThemes}">
            <div class="mp-empty"><span class="mp-empty-icon">🎨</span>아직 만든 테마가 없어요</div>
        </c:when>
        <c:otherwise>
            <div class="mp-grid">
                <c:forEach var="t" items="${myThemes}">
                    <div class="mp-card">
                        <img src="${pageContext.request.contextPath}/resources/upload/theme/${t.thumbnail}"
                             alt="${t.title}" loading="lazy"
                             onerror="this.src='https://via.placeholder.com/200x140?text=No+Image'">
                        <div class="mp-card-body">
                            <div class="mp-card-title">${t.title}</div>
                            <div class="mp-card-meta">👁 ${t.viewCount} &nbsp; 📅 ${t.createdAt}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- ─── 즐겨찾기 ─── -->
<div class="mp-pane" id="mp-pane-favorite">
    <c:choose>
        <c:when test="${empty myFavorites}">
            <div class="mp-empty"><span class="mp-empty-icon">⭐</span>아직 즐겨찾기한 레시피가 없어요</div>
        </c:when>
        <c:otherwise>
            <div class="mp-grid">
                <c:forEach var="f" items="${myFavorites}">
                    <a href="<%= ctx %>/recipe/view?id=${f.recipeId}" class="mp-card">
                        <img src="${pageContext.request.contextPath}/resources/upload/recipe/${f.thumbnail}"
                             alt="${f.recipeTitle}" loading="lazy"
                             onerror="this.src='https://via.placeholder.com/200x140?text=No+Image'">
                        <div class="mp-card-body">
                            <div class="mp-card-title">${f.recipeTitle}</div>
                            <div class="mp-card-meta">📅 ${f.createdAt}</div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {

    // ── 소개글 인라인 편집 ──
    var introText     = document.getElementById('introText');
    var introEditBtn  = document.getElementById('introEditBtn');
    var introForm     = document.getElementById('introForm');
    var introTextarea = document.getElementById('introTextarea');
    var introSaveBtn  = document.getElementById('introSaveBtn');
    var introCancelBtn = document.getElementById('introCancelBtn');

    introEditBtn.addEventListener('click', function () {
        introText.style.display    = 'none';
        introEditBtn.style.display = 'none';
        introForm.style.display    = 'block';
        introTextarea.focus();
    });

    introCancelBtn.addEventListener('click', function () {
        introForm.style.display    = 'none';
        introText.style.display    = '';
        introEditBtn.style.display = '';
    });

    introSaveBtn.addEventListener('click', function () {
        var intro = introTextarea.value.trim();
        fetch('<%= ctx %>/user/intro', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            body: 'intro=' + encodeURIComponent(intro)
        })
        .then(function (r) { return r.json(); })
        .then(function (data) {
            if (data.ok) {
                if (intro) {
                    introText.className = 'mp-intro-text';
                    introText.textContent = intro;
                } else {
                    introText.className = 'mp-intro-empty';
                    introText.textContent = '소개글을 작성해 보세요.';
                }
                introForm.style.display    = 'none';
                introText.style.display    = '';
                introEditBtn.style.display = '';
            } else {
                alert(data.msg || '저장에 실패했습니다.');
            }
        })
        .catch(function () { alert('저장 중 오류가 발생했습니다.'); });
    });

    // ── 탭 전환 ──
    var tabs  = document.querySelectorAll('#mpTabs .mp-tab-btn');
    var panes = document.querySelectorAll('.mp-pane');

    tabs.forEach(function (btn) {
        btn.addEventListener('click', function () {
            tabs.forEach(function (b) { b.classList.remove('active'); });
            panes.forEach(function (p) { p.classList.remove('active'); });
            btn.classList.add('active');
            var pane = document.getElementById(btn.getAttribute('data-pane'));
            if (pane) pane.classList.add('active');
        });
    });
});
</script>
