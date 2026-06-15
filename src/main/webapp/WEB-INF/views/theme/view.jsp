<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <div class="text-center mb-5">
        <h2 class="fw-bold mb-3" style="font-size: 2.5rem;"><span class="text-danger">Theme:</span> ${theme.title}</h2>
        <c:if test="${not empty theme.subtitle}">
            <h4 class="text-secondary mb-3">${theme.subtitle}</h4>
        </c:if>
        <div class="d-flex justify-content-center align-items-center gap-3 text-muted">
            <span><i class="bi bi-eye"></i> 조회수 ${theme.viewCount}</span>
            <span><i class="bi bi-calendar3"></i> ${theme.createdAt}</span>
        </div>
    </div>

    <%-- 상단 버튼 영역 --%>
    <div class="d-flex justify-content-between mb-4">
        <div>
            <c:if test="${not empty loginUser}">
                <button type="button" class="btn btn-outline-primary px-4" onclick="openAddRecipePopup()">+ 내 레시피 추가</button>
            </c:if>
        </div>
        <c:if test="${loginUser.userId == theme.userId}">
            <div>
                <a href="${pageContext.request.contextPath}/theme/update?themeId=${theme.themeId}" class="btn px-4" style="background-color: white; border: 1px solid #ced4da; color: black;">수정</a>
                <a href="${pageContext.request.contextPath}/theme/delete?themeId=${theme.themeId}" class="btn btn-danger px-4" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </div>
        </c:if>
    </div>

    <div class="section-card mb-5">
        <h3 class="section-title mb-4"><i class="bi bi-list-ul text-danger me-2"></i> 요리 상세 목록</h3>
        <div class="mb-5 p-4 bg-light rounded-4">
            <p class="mb-0 text-secondary" style="font-size: 18px; text-align: center;">${not empty theme.description ? theme.description : '테마 소개글을 준비 중입니다.'}</p>
        </div>
        
        <c:forEach var="recipe" items="${recipeList}" varStatus="status">
            <div class="mb-5 pb-5 position-relative" style="border-bottom: 2px solid #eaeaea !important;">
                
                <div class="text-center mb-4">
                    <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}">
                        <c:choose>
                            <c:when test="${not empty recipe.thumbnail}">
                                <img src="${pageContext.request.contextPath}/resources/upload/recipe/${recipe.thumbnail}" 
                                     alt="${recipe.title}" 
                                     style="max-width: 300px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                            </c:when>
                            <c:otherwise>
                                <div style="width: 300px; height: 200px; background-color: #eee; margin: 0 auto; display: flex; align-items: center; justify-content: center; border-radius: 15px;">
                                    이미지 없음
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>

                <c:if test="${not empty loginUser && loginUser.userId == recipe.userId}">
                    <div class="position-absolute" style="top: 0; right: 0;">
                        <button type="button" class="btn btn-sm btn-outline-secondary me-2" 
                                onclick="location.href='${pageContext.request.contextPath}/theme/editRecipeInfo?themeId=${theme.themeId}&recipeId=${recipe.recipeId}'">소개 수정</button>
                        
                        <form action="${pageContext.request.contextPath}/theme/removeRecipe" method="post" class="d-inline">
                            <input type="hidden" name="themeId" value="${theme.themeId}">
                            <input type="hidden" name="recipeId" value="${recipe.recipeId}">
                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('이 요리를 테마에서 제거하시겠습니까?');">X 삭제</button>
                        </form>
                    </div>
                </c:if>

                <div class="text-center">
                    <h4>
                        <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}" class="text-decoration-none text-dark">
                            ${recipe.title}
                        </a>
                    </h4>
                    <p class="text-muted mt-3" style="font-size: 1.1rem; white-space: pre-wrap;">
                        ${not empty recipe.description ? recipe.description : '작성된 소개글이 없습니다.'}
                    </p>
                    
                    <div class="mt-3 d-flex justify-content-center gap-2">
                        <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}" 
                           class="btn btn-outline-primary btn-sm px-3">레시피로 이동</a>
                           
                        <c:if test="${not empty recipe.recipeLink}">
                            <a href="${recipe.recipeLink}" target="_blank"
                               class="btn btn-outline-success btn-sm px-3">상세 레시피 바로가기</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    function openAddRecipePopup() {
        window.open('${pageContext.request.contextPath}/theme/myRecipeList?themeId=${theme.themeId}', 'AddRecipe', 'width=600,height=500');
    }
    
    // 팝업창에서 호출할 함수를 여기서 반드시 정의해야 합니다.
    function addRecipeWithDesc(recipeId, title, description) {
        // 실제 테마에 레시피를 추가하는 로직(예: AJAX 요청 또는 폼 자동 제출)이 필요합니다.
        // 현재는 데이터를 전달받고 성공 알림 후 새로고침합니다.
        alert(title + "이(가) 추가되었습니다.");
        window.location.reload();
    }
</script>