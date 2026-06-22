<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 								카테고리 이전 틀
<div class="container py-4">
    <div class="section-card mb-4">
        <h2 class="section-title">
            레시피 <span class="accent">분류</span>
        </h2>
        <p class="text-muted mt-2">다양한 카테고리별로 원하는 레시피를 찾아보세요.</p>
    </div>

    <div class="row g-4">
        <c:forEach var="l" items="${listL}">
            <div class="col-12">
                <div class="section-card">
                    <h4 class="mb-4 pb-2 border-bottom">
                        <i class="bi bi-tag-fill text-danger me-2"></i>${l.name}
                    </h4>
                    <div class="d-flex flex-wrap gap-2">
                        <c:forEach var="m" items="${mapM[l.categorylId]}">
                            <a href="${pageContext.request.contextPath}/recipe/list?categorymId=${m.categorymId}" 
                               class="category-chip">
                                ${m.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
--%>

<%-- 카테고리 리스트 페이지!!	상단에 카테고리 분류하고 리스트 조회수,최신순,평점순 버튼 만들것  --%>

<section>									<%-- 카테고리 섹션 --%>
<hr><div align="center"><h3><b>나중에 카테고리 들어갈 자리</b></h3></div>
<hr>


</section>									<%-- 카테고리 섹션 끝 --%>
<section>									<%-- 레시피 리스트 섹션 --%>
<h2 class="mb-4">레시피 목록</h2>

<div class="categoryrecipe" align="right">
	<input type="button" value="최신순" class="active" onclick="location.href='${pageContext.request.contextPath}/category/list?sort=desc'">
	<input type="button" value="조회수순" onclick="location.href='${pageContext.request.contextPath}/category/list?sort=view'">
	<input type="button" value="평점순" onclick="location.href='${pageContext.request.contextPath}/category/list?sort=avg'">

</div>
<div class="row g-3">
    <!-- TODO: c:forEach로 레시피 카드 반복  레시피카드 하나부터 만들어보고 반복문 돌리기.-->
    <%-- <p class="text-muted">레시피 카드 목록이 여기에 표시됩니다.</p>--%>

    <div class="row g-4 mt-2">
            <c:forEach var="descRecipe" items="${descRe}">
                <div class="col-md-4 col-lg-3">
                    <div class="recipe-card shadow-soft" onclick="location.href='${pageContext.request.contextPath}/category/list?recipeId=${descRecipe.recipeId}'">
                        <div class="recipe-card-img-wrap">
                            <c:choose> 
                            <c:when test="${not empty descRecipe.thumbnail}">
                                <img src="${pageContext.request.contextPath}${descRecipe.thumbnail}" class="recipe-card-img" alt="${descRecipe.title}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://picsum.photos/seed/theme${descRecipe.recipeId}/400/300" class="recipe-card-img" alt="${descRecipe.title}">
                            </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="recipe-card-body">
                            <h5 class="recipe-card-title">${descRecipe.title}</h5>
                            <p class="recipe-meta text-truncate">${descRecipe.description}</p>
                            <div class="recipe-meta">
                                    <span class="rating">
                                        <i class="bi bi-star-fill"></i> 
                                        ${descRecipe.avgRating}
                                    </span> 
                                    <span><i class="bi bi-eye"></i> ${descRecipe.viewCount}</span> 
                                    <span><i class="bi bi-person-fill"></i>${descRecipe.nickname }</span>
                                </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty descRe}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted">등록된 레시피가 없습니다.</p>
                </div>
            </c:if>
    
    		
    		
    		
    
</div>
</section>									<%-- 레시피 리스트 섹션 끝 --%>



