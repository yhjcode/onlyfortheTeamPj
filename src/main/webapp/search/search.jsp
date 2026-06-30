<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="java.util.*" %>
<%@ page import="com.bggchef.dao.SearchDAO" %> 
<%@ page import="com.bggchef.dto.RecipeDTO" %> 
<%@ page import="com.bggchef.dto.ThemeDTO" %> 
<%@ page import="com.bggchef.dto.UserDTO" %>

<%-- 💡 [핵심 추가] 브라우저가 보낸 검색 데이터(파라미터)를 받아 DB를 조회하는 실제 연산 구역 --%>
<%
    // 1. 요청 파라미터 수집 및 방어 코드
    String searchType = request.getParameter("searchType");
    String keyword = request.getParameter("keyword");
    String strPage = request.getParameter("page");
    
    if (searchType == null || searchType.trim().isEmpty()) {
        searchType = "recipe";
    }
    if (keyword == null) {
        keyword = "";
    }
    
    int currentPage = (strPage != null && !strPage.equals("")) ? Integer.parseInt(strPage) : 1;
    int pageSize = 12; // 한 페이지에 보여줄 카드 개수 세팅
    
    // 2. DAO 객체 생성 및 데이터 조회
    SearchDAO searchDAO = new SearchDAO();
    int totalCount = 0;
    
    if ("recipe".equals(searchType)) {
        totalCount = searchDAO.getRecipeCount(keyword);
        List<RecipeDTO> recipes = searchDAO.searchRecipe(keyword, currentPage, pageSize);
        request.setAttribute("recipes", recipes); // 하단 ${recipes}와 연결
        
    } else if ("theme".equals(searchType)) {
        totalCount = searchDAO.getThemeCount(keyword);
        List<ThemeDTO> themes = searchDAO.searchTheme(keyword, currentPage, pageSize);
        request.setAttribute("themes", themes);   // 하단 ${themes}와 연결
        
    } else if ("user".equals(searchType)) {
        totalCount = searchDAO.getUserCount(keyword);
        List<UserDTO> users = searchDAO.searchUser(keyword, currentPage, pageSize);
        request.setAttribute("users", users);     // 하단 ${users}와 연결
    }
    
    // 3. 하단 페이징 처리를 위한 전체 페이지 수 계산
    int pageCount = (int) Math.ceil((double) totalCount / pageSize);
    
    // 4. EL 표현식(${...})이 꺼내쓸 수 있도록 request 영역에 데이터 바인딩
    request.setAttribute("searchType", searchType);
    request.setAttribute("keyword", keyword);
    request.setAttribute("totalCount", totalCount);
    request.setAttribute("pageCount", pageCount);
    request.setAttribute("currentPage", currentPage);
%>
<%-- 자바 핵심 로직 끝 --%>

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
                                                    <c:otherwise>0.0</c:otherwise>
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
                                                    <c:otherwise>0.0</c:otherwise>
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