<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- ===================================================
     랭킹 페이지 - 레시피 랭킹 + 셰프 랭킹 (탭 구조)
     =================================================== -->

<style>
.ranking-hero {
    background: linear-gradient(135deg, var(--bggchef-primary) 0%, #FF6B6B 100%);
    color: white;
    border-radius: 14px;
    padding: 36px 40px;
    margin-bottom: 32px;
    position: relative;
    overflow: hidden;
}
.ranking-hero::after {
    content: '\F66D'; /* bi-trophy */
    font-family: "bootstrap-icons";
    position: absolute;
    right: 40px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 120px;
    opacity: 0.12;
    line-height: 1;
}
.ranking-hero h1 {
    font-size: 1.9rem;
    font-weight: 800;
    margin: 0 0 6px;
}
.ranking-hero p {
    margin: 0;
    opacity: 0.9;
    font-size: 1rem;
}

/* 상위 탭 (레시피 / 셰프) */
.ranking-main-tabs .nav-link {
    font-size: 1rem;
    font-weight: 600;
    padding: 10px 28px;
    border-radius: 30px;
    color: var(--bggchef-muted);
    border: 2px solid var(--bggchef-border);
    background: white;
    transition: all 0.2s;
}
.ranking-main-tabs .nav-link.active,
.ranking-main-tabs .nav-link:hover {
    background: var(--bggchef-primary);
    border-color: var(--bggchef-primary);
    color: white;
}

/* 하위 탭 (조회수 / 평점) */
.ranking-sub-tabs {
    border-bottom: 2px solid var(--bggchef-border);
    margin-bottom: 20px;
}
.ranking-sub-tabs .nav-link {
    color: var(--bggchef-muted);
    font-weight: 600;
    padding: 10px 20px;
    border: none;
    border-bottom: 3px solid transparent;
    border-radius: 0;
    margin-bottom: -2px;
    transition: all 0.15s;
}
.ranking-sub-tabs .nav-link.active {
    color: var(--bggchef-primary);
    border-bottom-color: var(--bggchef-primary);
    background: transparent;
}
.ranking-sub-tabs .nav-link:hover:not(.active) {
    color: var(--bggchef-text);
    background: transparent;
}

/* 랭킹 아이템 공통 */
.ranking-item {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 14px 12px;
    border-radius: 10px;
    text-decoration: none;
    color: var(--bggchef-text);
    transition: background 0.15s;
}
.ranking-item:hover {
    background: var(--bggchef-primary-light);
    color: var(--bggchef-text);
}
.ranking-item + .ranking-item {
    border-top: 1px solid var(--bggchef-border);
}

/* 순위 번호 */
.rank-num {
    min-width: 44px;
    text-align: center;
    font-size: 1.05rem;
    font-weight: 700;
    flex-shrink: 0;
}
.rank-medal { font-size: 1.6rem; line-height: 1; }
.rank-plain { color: var(--bggchef-muted); }

/* 레시피 썸네일 */
.recipe-thumb {
    width: 76px;
    height: 76px;
    border-radius: 10px;
    overflow: hidden;
    flex-shrink: 0;
    background: var(--bggchef-primary-light);
    display: flex;
    align-items: center;
    justify-content: center;
}
.recipe-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* 셰프 프로필 */
.chef-avatar-sm {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    overflow: hidden;
    flex-shrink: 0;
    background: var(--bggchef-primary-light);
    border: 2px solid var(--bggchef-border);
    display: flex;
    align-items: center;
    justify-content: center;
}
.chef-avatar-sm img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* 통계 값 */
.rank-stat-primary {
    font-weight: 700;
    color: var(--bggchef-primary);
    font-size: 0.95rem;
    white-space: nowrap;
}
.rank-stat-secondary {
    font-size: 0.82rem;
    color: var(--bggchef-muted);
    white-space: nowrap;
}

/* 빈 상태 */
.ranking-empty {
    text-align: center;
    padding: 60px 20px;
    color: var(--bggchef-muted);
}
.ranking-empty i { font-size: 2.5rem; margin-bottom: 12px; display: block; }

/* 상위 3위 강조 행 */
.rank-top-1 { background: linear-gradient(to right, #FFFAE8, white); }
.rank-top-2 { background: linear-gradient(to right, #F6F6F6, white); }
.rank-top-3 { background: linear-gradient(to right, #FFF3EC, white); }
.rank-top-1:hover { background: linear-gradient(to right, #FFF0C0, var(--bggchef-primary-light)); }
.rank-top-2:hover { background: linear-gradient(to right, #EBEBEB, var(--bggchef-primary-light)); }
.rank-top-3:hover { background: linear-gradient(to right, #FFE8D8, var(--bggchef-primary-light)); }
</style>

<!-- 헤더 배너 -->
<div class="ranking-hero">
    <h1><i class="bi bi-trophy-fill me-2"></i>BGGChef 랭킹</h1>
    <p>인기 레시피와 활발한 셰프들을 한눈에 확인하세요</p>
</div>

<!-- ───── 상위 탭: 레시피 랭킹 | 셰프 랭킹 ───── -->
<ul class="nav ranking-main-tabs justify-content-center gap-2 mb-4" id="mainRankTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="recipe-tab"
                data-bs-toggle="pill" data-bs-target="#recipe-pane"
                type="button" role="tab" aria-selected="true">
            <i class="bi bi-journal-richtext me-1"></i> 레시피 랭킹
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="chef-tab"
                data-bs-toggle="pill" data-bs-target="#chef-pane"
                type="button" role="tab" aria-selected="false">
            <i class="bi bi-person-heart me-1"></i> 셰프 랭킹
        </button>
    </li>
</ul>

<div class="tab-content" id="mainRankTabContent">

    <!-- ═══════════════════════════════════════════
         레시피 랭킹 패널
         ═══════════════════════════════════════════ -->
    <div class="tab-pane fade show active" id="recipe-pane" role="tabpanel">
        <div class="section-card">
            <!-- 하위 탭: 조회수 | 평점 -->
            <ul class="nav ranking-sub-tabs" id="recipeSubTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="recipe-view-tab"
                            data-bs-toggle="tab" data-bs-target="#recipe-view-pane"
                            type="button" role="tab">
                        <i class="bi bi-eye me-1"></i> 조회수 순위
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="recipe-rating-tab"
                            data-bs-toggle="tab" data-bs-target="#recipe-rating-pane"
                            type="button" role="tab">
                        <i class="bi bi-star me-1"></i> 평점 순위
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="recipeSubTabContent">

                <!-- 조회수 기준 레시피 목록 -->
                <div class="tab-pane fade show active" id="recipe-view-pane" role="tabpanel">
                    <c:choose>
                        <c:when test="${empty recipesByView}">
                            <div class="ranking-empty">
                                <i class="bi bi-inbox"></i>등록된 레시피가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ranking-list">
                                <c:forEach var="r" items="${recipesByView}" varStatus="vs">
                                    <a href="${pageContext.request.contextPath}/recipe/detail?id=${r.recipeId}"
                                       class="ranking-item
                                              ${vs.index == 0 ? 'rank-top-1' : vs.index == 1 ? 'rank-top-2' : vs.index == 2 ? 'rank-top-3' : ''}">
                                        <!-- 순위 -->
                                        <div class="rank-num">
                                            <c:choose>
                                                <c:when test="${vs.index == 0}"><span class="rank-medal">🥇</span></c:when>
                                                <c:when test="${vs.index == 1}"><span class="rank-medal">🥈</span></c:when>
                                                <c:when test="${vs.index == 2}"><span class="rank-medal">🥉</span></c:when>
                                                <c:otherwise><span class="rank-plain">${vs.index + 1}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- 썸네일 -->
                                        <div class="recipe-thumb">
                                            <c:choose>
                                                <c:when test="${not empty r.thumbnail}">
                                                    <img src="${pageContext.request.contextPath}/resources/upload/recipe/${r.thumbnail}"
                                                         alt="${r.title}">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-image text-muted fs-5"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- 제목 / 셰프 -->
                                        <div class="flex-grow-1" style="min-width:0;">
                                            <div class="fw-semibold text-truncate" style="max-width:420px;">${r.title}</div>
                                            <div class="text-muted small mt-1">
                                                <i class="bi bi-person me-1"></i>${r.nickname}
                                            </div>
                                        </div>
                                        <!-- 조회수 / 평점 -->
                                        <div class="text-end">
                                            <div class="rank-stat-primary">
                                                <i class="bi bi-eye me-1"></i>
                                                <fmt:formatNumber value="${r.viewCount}" type="number"/>
                                            </div>
                                            <c:if test="${r.avgRating != null}">
                                                <div class="rank-stat-secondary mt-1">
                                                    <i class="bi bi-star-fill text-warning me-1"></i>
                                                    <fmt:formatNumber value="${r.avgRating}" pattern="0.0"/>
                                                </div>
                                            </c:if>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 평점 기준 레시피 목록 -->
                <div class="tab-pane fade" id="recipe-rating-pane" role="tabpanel">
                    <c:choose>
                        <c:when test="${empty recipesByRating}">
                            <div class="ranking-empty">
                                <i class="bi bi-inbox"></i>평점이 등록된 레시피가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ranking-list">
                                <c:forEach var="r" items="${recipesByRating}" varStatus="vs">
                                    <a href="${pageContext.request.contextPath}/recipe/detail?id=${r.recipeId}"
                                       class="ranking-item
                                              ${vs.index == 0 ? 'rank-top-1' : vs.index == 1 ? 'rank-top-2' : vs.index == 2 ? 'rank-top-3' : ''}">
                                        <div class="rank-num">
                                            <c:choose>
                                                <c:when test="${vs.index == 0}"><span class="rank-medal">🥇</span></c:when>
                                                <c:when test="${vs.index == 1}"><span class="rank-medal">🥈</span></c:when>
                                                <c:when test="${vs.index == 2}"><span class="rank-medal">🥉</span></c:when>
                                                <c:otherwise><span class="rank-plain">${vs.index + 1}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="recipe-thumb">
                                            <c:choose>
                                                <c:when test="${not empty r.thumbnail}">
                                                    <img src="${pageContext.request.contextPath}/resources/upload/recipe/${r.thumbnail}"
                                                         alt="${r.title}">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-image text-muted fs-5"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex-grow-1" style="min-width:0;">
                                            <div class="fw-semibold text-truncate" style="max-width:420px;">${r.title}</div>
                                            <div class="text-muted small mt-1">
                                                <i class="bi bi-person me-1"></i>${r.nickname}
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <div class="rank-stat-primary">
                                                <i class="bi bi-star-fill text-warning me-1"></i>
                                                <fmt:formatNumber value="${r.avgRating}" pattern="0.0"/>
                                            </div>
                                            <div class="rank-stat-secondary mt-1">
                                                <i class="bi bi-eye me-1"></i>
                                                <fmt:formatNumber value="${r.viewCount}" type="number"/>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div><!-- /recipeSubTabContent -->
        </div><!-- /section-card -->
    </div><!-- /recipe-pane -->


    <!-- ═══════════════════════════════════════════
         셰프 랭킹 패널
         ═══════════════════════════════════════════ -->
    <div class="tab-pane fade" id="chef-pane" role="tabpanel">
        <div class="section-card">
            <!-- 하위 탭: 조회수 합산 | 평점 평균 -->
            <ul class="nav ranking-sub-tabs" id="chefSubTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="chef-view-tab"
                            data-bs-toggle="tab" data-bs-target="#chef-view-pane"
                            type="button" role="tab">
                        <i class="bi bi-bar-chart me-1"></i> 조회수 합산 순위
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="chef-rating-tab"
                            data-bs-toggle="tab" data-bs-target="#chef-rating-pane"
                            type="button" role="tab">
                        <i class="bi bi-star me-1"></i> 평점 평균 순위
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="chefSubTabContent">

                <!-- 조회수 합산 기준 셰프 목록 -->
                <div class="tab-pane fade show active" id="chef-view-pane" role="tabpanel">
                    <c:choose>
                        <c:when test="${empty chefsByView}">
                            <div class="ranking-empty">
                                <i class="bi bi-inbox"></i>등록된 셰프가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ranking-list">
                                <c:forEach var="c" items="${chefsByView}" varStatus="vs">
                                    <a href="${pageContext.request.contextPath}/chef/profile?userId=${c.userId}"
                                       class="ranking-item
                                              ${vs.index == 0 ? 'rank-top-1' : vs.index == 1 ? 'rank-top-2' : vs.index == 2 ? 'rank-top-3' : ''}">
                                        <!-- 순위 -->
                                        <div class="rank-num">
                                            <c:choose>
                                                <c:when test="${vs.index == 0}"><span class="rank-medal">🥇</span></c:when>
                                                <c:when test="${vs.index == 1}"><span class="rank-medal">🥈</span></c:when>
                                                <c:when test="${vs.index == 2}"><span class="rank-medal">🥉</span></c:when>
                                                <c:otherwise><span class="rank-plain">${vs.index + 1}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- 프로필 이미지 -->
                                        <div class="chef-avatar-sm">
                                            <c:choose>
                                                <c:when test="${not empty c.profileImg}">
                                                    <img src="${pageContext.request.contextPath}/resources/upload/profile/${c.profileImg}"
                                                         alt="${c.nickname}">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-person text-muted fs-4"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- 닉네임 / 레시피 수 -->
                                        <div class="flex-grow-1" style="min-width:0;">
                                            <div class="fw-bold text-truncate">${c.nickname}</div>
                                            <div class="text-muted small mt-1">
                                                <i class="bi bi-journal-text me-1"></i>레시피 ${c.recipeCount}개
                                            </div>
                                        </div>
                                        <!-- 조회수 합산 / 평점 평균 -->
                                        <div class="text-end">
                                            <div class="rank-stat-primary">
                                                <i class="bi bi-eye me-1"></i>
                                                <fmt:formatNumber value="${c.totalViewCount}" type="number"/>
                                            </div>
                                            <c:if test="${c.avgRating != null}">
                                                <div class="rank-stat-secondary mt-1">
                                                    <i class="bi bi-star-fill text-warning me-1"></i>
                                                    <fmt:formatNumber value="${c.avgRating}" pattern="0.0"/>
                                                </div>
                                            </c:if>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 평점 평균 기준 셰프 목록 -->
                <div class="tab-pane fade" id="chef-rating-pane" role="tabpanel">
                    <c:choose>
                        <c:when test="${empty chefsByRating}">
                            <div class="ranking-empty">
                                <i class="bi bi-inbox"></i>평점이 등록된 셰프가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ranking-list">
                                <c:forEach var="c" items="${chefsByRating}" varStatus="vs">
                                    <a href="${pageContext.request.contextPath}/chef/profile?userId=${c.userId}"
                                       class="ranking-item
                                              ${vs.index == 0 ? 'rank-top-1' : vs.index == 1 ? 'rank-top-2' : vs.index == 2 ? 'rank-top-3' : ''}">
                                        <div class="rank-num">
                                            <c:choose>
                                                <c:when test="${vs.index == 0}"><span class="rank-medal">🥇</span></c:when>
                                                <c:when test="${vs.index == 1}"><span class="rank-medal">🥈</span></c:when>
                                                <c:when test="${vs.index == 2}"><span class="rank-medal">🥉</span></c:when>
                                                <c:otherwise><span class="rank-plain">${vs.index + 1}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="chef-avatar-sm">
                                            <c:choose>
                                                <c:when test="${not empty c.profileImg}">
                                                    <img src="${pageContext.request.contextPath}/resources/upload/profile/${c.profileImg}"
                                                         alt="${c.nickname}">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-person text-muted fs-4"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex-grow-1" style="min-width:0;">
                                            <div class="fw-bold text-truncate">${c.nickname}</div>
                                            <div class="text-muted small mt-1">
                                                <i class="bi bi-journal-text me-1"></i>레시피 ${c.recipeCount}개
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <div class="rank-stat-primary">
                                                <i class="bi bi-star-fill text-warning me-1"></i>
                                                <fmt:formatNumber value="${c.avgRating}" pattern="0.0"/>
                                            </div>
                                            <div class="rank-stat-secondary mt-1">
                                                <i class="bi bi-eye me-1"></i>
                                                <fmt:formatNumber value="${c.totalViewCount}" type="number"/>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div><!-- /chefSubTabContent -->
        </div><!-- /section-card -->
    </div><!-- /chef-pane -->

</div><!-- /mainRankTabContent -->
