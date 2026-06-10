<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <div class="text-center mb-5">
        <h2 class="fw-bold mb-3" style="font-size: 2.5rem;">
            <span class="text-danger">Theme:</span> ${theme.title}
        </h2>
        <div class="d-flex justify-content-center align-items-center gap-3 text-muted">
            <span><i class="bi bi-eye"></i> 조회수 ${theme.viewCount}</span>
            <span><i class="bi bi-calendar3"></i> ${theme.createdAt}</span>
        </div>
    </div>

    <div class="section-card mb-5">
        <h3 class="section-title mb-4">
            <i class="bi bi-list-ul text-danger me-2"></i> <span class="accent">테마 관련</span> 요리 상세 목록
        </h3>
        <!-- 테마 설명 영역 -->
       <div class="mb-5 p-4 bg-light rounded-4">
    <p class="mb-0 text-secondary" 
       style="font-size: 18px; 
              white-space: pre-line; 
              line-height: 1.8; 
              word-break: keep-all; 
              text-align: center; 
              letter-spacing: -0.3px;">
        ${not empty theme.description ? theme.description : '테마 소개글을 준비 중입니다.'}
    </p>
</div>
        
        <c:forEach var="recipe" items="${recipeList}" varStatus="status">
            <div class="mb-5 pb-5" style="border-bottom: 2px solid #eaeaea !important;">
                <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}" class="text-decoration-none text-dark d-flex flex-column align-items-center text-center w-100">
                    <div class="mb-3" style="width: 200px; height: 150px; border-radius: 10px; overflow: hidden;">
                        <c:choose>
                            <c:when test="${not empty recipe.thumbnail}">
                                <img src="${pageContext.request.contextPath}/resources/upload/recipe/${recipe.thumbnail}" class="w-100 h-100" style="object-fit: cover;" alt="${recipe.title}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://picsum.photos/seed/recipe${recipe.recipeId}/400/400" class="w-100 h-100" style="object-fit: cover;" alt="${recipe.title}">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="w-100">
                        <h4 class="fw-bold mb-2">${recipe.title}</h4>
                        
                        <div class="mt-2">
                            <span class="btn btn-sm btn-outline-danger">레시피 보기</span>
                        </div>
                        
                        <p class="text-muted mt-3 mb-0 mx-auto" 
   style="font-size: 20px; font-weight: 500; white-space: pre-wrap; line-height: 1.7; text-align: center; max-width: 600px; word-break: keep-all;">
    ${not empty recipe.description ? recipe.description : '작성된 요리 소개가 없습니다.'}
</p>
                    </div>
                </a>
            </div> </c:forEach>
        
        <c:if test="${empty recipeList}">
            <div class="text-center text-muted py-4">
                현재 이 테마에 등록된 요리가 없습니다.
            </div>
        </c:if>
    </div>

    <div class="section-card">
        <h3 class="section-title mb-4">
            <i class="bi bi-chat-dots-fill text-danger me-2"></i> <span class="accent">테마</span> 댓글
        </h3>
        
        <div class="comment-form mb-5 p-4 border rounded-4 bg-light">
            <form action="${pageContext.request.contextPath}/theme/comment" method="post">
                <input type="hidden" name="themeId" value="${theme.themeId}">
                <div class="d-flex align-items-center gap-3 w-100">
                    <textarea name="content" class="form-control flex-grow-1" placeholder="테마에 대한 의견을 남겨주세요." rows="2"></textarea>
                    <button class="btn btn-danger px-4" type="submit" style="height: 58px; flex-shrink: 0;">등록</button>
                </div>
            </form>
        </div>

        <div class="comment-list">
            <%-- 댓글 목록이 있으면 여기에 반복문 추가 --%>
            <div class="text-center py-4 text-muted">
                아직 등록된 댓글이 없습니다. 첫 번째 댓글을 남겨보세요!
            </div>
        </div>
    </div>

    <div class="text-center mt-5 mb-4">
        <a href="${pageContext.request.contextPath}/theme/list" class="btn btn-outline-secondary">목록으로 돌아가기</a>
    </div>
</div>