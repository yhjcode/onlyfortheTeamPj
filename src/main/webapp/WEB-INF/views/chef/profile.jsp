<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.bggchef.dto.UserDTO chefUser =
        (com.bggchef.dto.UserDTO) request.getAttribute("chefUser");

    String ctx = request.getContextPath();

    String profileImg = (chefUser.getProfileImg() != null && !chefUser.getProfileImg().isEmpty())
        ? ctx + "/resources/upload/profile/" + chefUser.getProfileImg()
        : "https://via.placeholder.com/80x80?text=User";

    String medal = chefUser.getMedalGrade() != null ? chefUser.getMedalGrade() : "브론즈";
%>

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
.page-hero.chef::after { content: '\F1B0'; /* bi-award-fill */ }
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
.mp-empty { text-align:center; padding:3rem 0; color:#adb5bd; font-size:14px; }
.mp-empty-icon { font-size:2.5rem; display:block; margin-bottom:8px; }
.mp-intro-wrap { margin-top:10px; }
.mp-intro-text { font-size:13px; color:#495057; line-height:1.6; white-space:pre-wrap; word-break:break-all; }
.mp-intro-empty { font-size:13px; color:#adb5bd; font-style:italic; }
.mp-mypage-link { font-size:12px; color:#DC3545; text-decoration:none; margin-left:6px; }
.mp-mypage-link:hover { text-decoration:underline; }
</style>

<!-- 히어로 배너 -->
<div class="page-hero chef">
    <h1><i class="bi bi-award-fill me-2"></i>셰프 페이지</h1>
    <p><%= chefUser.getNickname() %> 셰프의 레시피와 테마를 만나보세요</p>
</div>

<!-- 프로필 카드 -->
<div class="mp-profile-card">
    <img src="<%= profileImg %>" class="mp-avatar" alt="프로필"
         onerror="this.src='https://via.placeholder.com/80x80?text=User'">
    <div style="flex:1;min-width:0;">
        <div class="mp-name"><%= chefUser.getNickname() %></div>
        <div class="mp-email"><%= chefUser.getEmail() %></div>
        <span class="mp-medal">🏅 <%= medal %></span>
        <!-- 셰프 소개글 (읽기 전용) -->
        <div class="mp-intro-wrap">
            <c:choose>
                <c:when test="${not empty chefIntro}">
                    <span class="mp-intro-text">${chefIntro}</span>
                </c:when>
                <c:otherwise>
                    <span class="mp-intro-empty">소개글이 없습니다.</span>
                </c:otherwise>
            </c:choose>
            <%-- 본인이 자신의 프로필을 볼 때만 마이페이지로 이동 링크 표시 --%>
            <c:if test="${isOwner}">
                <a href="<%= ctx %>/user/mypage" class="mp-mypage-link">
                    <i class="bi bi-pencil"></i> 소개글 수정 (마이페이지)
                </a>
            </c:if>
        </div>
    </div>
</div>

<!-- 탭 버튼 -->
<div class="mp-tabs" id="cpTabs">
    <button type="button" class="mp-tab-btn active" data-pane="cp-pane-recipe">레시피</button>
    <button type="button" class="mp-tab-btn"        data-pane="cp-pane-theme">테마</button>
</div>

<!-- ─── 레시피 ─── -->
<div class="mp-pane active" id="cp-pane-recipe">
    <c:choose>
        <c:when test="${empty chefRecipes}">
            <div class="mp-empty">
                <span class="mp-empty-icon">🍳</span>
                아직 작성한 레시피가 없어요
            </div>
        </c:when>
        <c:otherwise>
            <div class="mp-grid">
                <c:forEach var="r" items="${chefRecipes}">
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

<!-- ─── 테마 ─── -->
<div class="mp-pane" id="cp-pane-theme">
    <c:choose>
        <c:when test="${empty chefThemes}">
            <div class="mp-empty">
                <span class="mp-empty-icon">🎨</span>
                아직 만든 테마가 없어요
            </div>
        </c:when>
        <c:otherwise>
            <div class="mp-grid">
                <c:forEach var="t" items="${chefThemes}">
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

<script>
document.addEventListener('DOMContentLoaded', function () {
    var tabs  = document.querySelectorAll('#cpTabs .mp-tab-btn');
    var panes = document.querySelectorAll('.mp-pane');

    tabs.forEach(function (btn) {
        btn.addEventListener('click', function () {
            tabs.forEach(function (b)  { b.classList.remove('active'); });
            panes.forEach(function (p) { p.classList.remove('active'); });
            btn.classList.add('active');
            var pane = document.getElementById(btn.getAttribute('data-pane'));
            if (pane) pane.classList.add('active');
        });
    });
});
</script>
