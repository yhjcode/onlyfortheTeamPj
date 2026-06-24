<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menu" value="search" scope="request"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<section class="section-card position-relative">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="section-title">
            <i class="bi bi-search text-danger me-2"></i>
            <c:choose>
                <c:when test="${not empty keyword}">
                    '<span class="accent"><c:out value="${keyword}"/></span>' 検索結果
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${searchType == 'theme'}"><span class="accent">テーマ全体</span> 検索結果</c:when>
                        <c:when test="${searchType == 'user'}"><span class="accent">シェフ全体</span> 検索結果</c:when>
                        <c:otherwise><span class="accent">レシピ全体</span> 検索結果</c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </h3>
        <span class="text-muted">
            <c:choose>
                <c:when test="${searchType == 'theme'}">全${totalCount}件のテーマ</c:when>
                <c:when test="${searchType == 'user'}">全${totalCount}名のシェフ</c:when>
                <c:otherwise>全${totalCount}件のレシピ</c:otherwise>
            </c:choose>
        </span>
    </div>

    <%-- 레시피 검색 결과 --%>
    <c:if test="${searchType == 'recipe'}">
        <div class="row g-3">
            <c:choose>
                <c:when test="${empty recipes}">
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3 text-muted">検索キーワードに一致するレシピがありません。<br>別のキーワードをお試しください。</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="r" items="${recipes}">
                        <div class="col-md-3 col-6">
                            <a href="${pageContext.request.contextPath}/recipe/view?id=${r.recipeId}">
                                <div class="recipe-card">
                                    <div class="recipe-card-img-wrap">
                                        <c:choose>
                                            <c:when test="${not empty r.thumbnail}">
                                                <img class="recipe-card-img" src="${pageContext.request.contextPath}${r.thumbnail}" alt="${r.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="recipe-card-img" src="https://placehold.co/400x400/dee2e6/6c757d?text=No+Image" alt="${r.title}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="recipe-card-body">
                                        <h6 class="recipe-card-title">${r.title}</h6>
                                        <div class="recipe-meta">
                                            <span class="rating">
                                                <i class="bi bi-star-fill"></i>
                                                <c:choose>
                                                    <c:when test="${r.avgRating != null and r.avgRating > 0}"><fmt:formatNumber value="${r.avgRating}" pattern="0.0"/></c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span><i class="bi bi-eye"></i> ${r.viewCount}</span>
                                            <span><i class="bi bi-person-fill"></i> <c:out value="${not empty r.nickname ? r.nickname : '名無しシェフ'}"/></span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <%-- 테마 검색 결과 --%>
    <c:if test="${searchType == 'theme'}">
        <div class="row g-3">
            <c:choose>
                <c:when test="${empty themes}">
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3 text-muted">検索キーワードに一致するテーマがありません。<br>別のキーワードをお試しください。</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="t" items="${themes}">
                        <div class="col-md-3 col-6">
                            <a href="${pageContext.request.contextPath}/theme/view?themeId=${t.themeId}">
                                <div class="recipe-card">
                                    <div class="recipe-card-img-wrap">
                                        <c:choose>
                                            <c:when test="${not empty t.thumbnail}">
                                                <img class="recipe-card-img" src="${pageContext.request.contextPath}${t.thumbnail}" alt="${t.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="recipe-card-img" src="https://placehold.co/400x400/dee2e6/6c757d?text=No+Image" alt="${t.title}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="recipe-card-body">
                                        <h6 class="recipe-card-title">${t.title}</h6>
                                        <div class="recipe-meta">
                                            <span><i class="bi bi-eye"></i> ${t.viewCount}</span>
                                            <span><i class="bi bi-person-fill"></i> <c:out value="${not empty t.nickname ? t.nickname : '名無しシェフ'}"/></span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <%-- 셰프 검색 결과 --%>
    <c:if test="${searchType == 'user'}">
        <div class="row g-3">
            <c:choose>
                <c:when test="${empty users}">
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3 text-muted">検索キーワードに一致するシェフがいません。<br>別のキーワードをお試しください。</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="u" items="${users}">
                        <c:set var="medalColor" value="#6c757d"/>
                        <c:if test="${u.medalGrade == '골드'}"><c:set var="medalColor" value="#DAA520"/></c:if>
                        <c:if test="${u.medalGrade == '실버'}"><c:set var="medalColor" value="#A9A9A9"/></c:if>
                        <c:if test="${u.medalGrade == '브론즈'}"><c:set var="medalColor" value="#CD7F32"/></c:if>
                        <div class="col-md-3 col-6">
                            <a href="${pageContext.request.contextPath}/chef/profile?userId=${u.userId}">
                                <div class="recipe-card">
                                    <div class="recipe-card-img-wrap">
                                        <c:choose>
                                            <c:when test="${not empty u.profileImg}">
                                                <img class="recipe-card-img" src="${pageContext.request.contextPath}${u.profileImg}" alt="${u.nickname}">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="recipe-card-img" src="https://placehold.co/400x400/dee2e6/6c757d?text=Chef" alt="${u.nickname}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="recipe-card-body text-center">
                                        <h6 class="recipe-card-title">${u.nickname}</h6>
                                        <div class="recipe-meta justify-content-center">
                                            <span class="rating"><i class="bi bi-star-fill"></i>
                                                <c:choose>
                                                    <c:when test="${u.avgRating != null and u.avgRating > 0}"><fmt:formatNumber value="${u.avgRating}" pattern="0.0"/></c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span><i class="bi bi-award-fill" style="color:${medalColor}"></i> ${u.medalGrade}</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <%-- 페이징 --%>
    <c:if test="${totalCount > 0}">
        <div class="pagination-container" style="text-align:center; margin-top:40px; display:flex; justify-content:center; gap:5px; align-items:center;">
            <c:forEach begin="1" end="${pageCount}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <input type="button" value="${i}" class="active" style="font-weight:bold;" disabled>
                    </c:when>
                    <c:otherwise>
                        <input type="button" value="${i}"
                               onclick="location.href='?searchType=${searchType}&keyword=${keyword}&page=${i}'">
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </c:if>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
