<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<br>
<section>									<%-- 카테고리 섹션 --%>
<hr>
<div class=categorybutton>
<c:forEach var="cbutton" items="${button}">
<input type="button" value="${cbutton.categoryL}" onclick="location.href='${pageContext.request.contextPath}/category/list?sort=${currentsort}&categoryId=${cbutton.categoryId}'"
 class="${currentcategory eq cbutton.categoryId ? 'active' : ''}">
</c:forEach>								<%-- 카테고리 버튼 끝 --%>
</div>										
<hr>
</section>									<%-- 카테고리 섹션 끝 --%>
		
<section>
<div class="avgbutton">										<%-- 평점 버튼 섹션 --%>
 <button><i class="bi bi-star-fill" style="color:#FFC107"></i> 5 ~ 4.5	</button>	
<c:forEach var="avg" begin="1" end="8">
  <button><i class="bi bi-star-fill" style="color:#FFC107"></i>
  <fmt:formatNumber value="${4.9 - (avg * 0.5)}" pattern="0.0" />
   ~ 
  <fmt:formatNumber value="${5 - (avg / 2) - 0.5}" pattern="0.0" />
</button>

</c:forEach>
 <button><i class="bi bi-star-fill" style="color:#FFC107"></i> 0.5 이하</button>
</div>	
</section>									<%-- 평점 버튼 섹션 끝 --%>

<section>									<%-- 레시피 리스트 섹션 --%>
<h2 class="mb-4">레시피 목록</h2>

<div class="categoryrecipe" align="right">
	<input type="button" value="최신순" class="${empty param.sort || param.sort == 'desc' ? 'active' : ''}"
	 onclick="location.href='${pageContext.request.contextPath}/category/list?sort=desc&categoryId=${currentcategory}'">
	<input type="button" value="조회수순" class="${param.sort == 'view' ? 'active' : ''}"
	 onclick="location.href='${pageContext.request.contextPath}/category/list?sort=view&categoryId=${currentcategory}'">
	<input type="button" value="평점순" class="${param.sort == 'avg' ? 'active' : ''}"
	 onclick="location.href='${pageContext.request.contextPath}/category/list?sort=avg&categoryId=${currentcategory}'">
</div>
<br>
<div class="row g-3">
    <!-- TODO: c:forEach로 레시피 카드 반복  레시피카드 하나부터 만들어보고 반복문 돌리기.-->
    <%-- <p class="text-muted">레시피 카드 목록이 여기에 표시됩니다.</p>--%>

    <div class="row g-4 mt-2">
            <c:forEach var="descRecipe" items="${descRe}">
                <div class="col-md-4 col-lg-3">
                    
                    <div class="recipe-card shadow-soft" onclick="location.href='${pageContext.request.contextPath}/recipe/view?=${descRecipe.recipeId}'">
                        <div class="recipe-card-img-wrap">
                            <c:choose> 
                            <c:when test="${not empty descRecipe.thumbnail}">
                                <img src="${pageContext.request.contextPath}/resources/upload/recipe/${descRecipe.thumbnail}" class="recipe-card-img" alt="${descRecipe.title}">
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
    
    
</div></div>
</section>									<%-- 레시피 리스트 섹션 끝 --%>
<section>
<div class="pagination-container" style="text-align: center; margin-top: 20px;">
    
    <c:if test="${paging.startPage > 1}">  
        <a href="?page=${paging.startPage - 1}&sort=${currentsort}&categoryId=${currentcategory}">[이전]</a>
    </c:if>

    <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
        <c:choose>
            <c:when test="${i == paging.currentPage}">
                <strong style="color: red; margin: 0 5px;">${i}</strong>
            </c:when>
            <c:otherwise>	
                <a href="?page=${i}&sort=${currentsort}&categoryId=${currentcategory}" style="margin: 0 5px;">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${paging.endPage < paging.totalPage}">  
        <a href="?page=${paging.endPage + 1}&sort=${currentsort}&categoryId=${currentcategory}">[다음]</a>
    </c:if>
</div>
</section>



