<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <h3 class="fw-bold mb-4">레시피 정보 수정</h3>
    
    <form action="${pageContext.request.contextPath}/theme/editRecipeInfoAction" method="post" enctype="multipart/form-data">
        <%-- hidden 필드를 가장 위에 배치 --%>
        <input type="hidden" name="recipeId" value="${recipe.recipeId}">
        <input type="hidden" name="themeId" value="${themeId}">
        <input type="hidden" name="oldThumbnail" value="${recipe.thumbnail}">
        
        <div class="card p-4 shadow-sm">
            <div class="mb-4 text-center">
                <label class="form-label d-block text-start">기존 사진</label>
                <img src="${pageContext.request.contextPath}/resources/upload/recipe/${recipe.thumbnail}" 
                     style="max-width: 200px; border-radius: 10px;" class="mb-3">
                <input type="file" name="thumbnail" class="form-control">
                <small class="text-muted">새 사진을 선택하지 않으면 기존 사진이 유지됩니다.</small>
            </div>
            
            <div class="mb-3">
                <label class="form-label">제목</label>
                <input type="text" name="title" class="form-control" value="${recipe.title}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">설명</label>
                <textarea name="description" class="form-control" rows="5">${recipe.description}</textarea>
            </div>

            <div class="mb-4">
                <label class="form-label">레시피 상세 링크 (URL)</label>
                <input type="url" name="recipeLink" class="form-control" 
                       value="${recipe.recipeLink}" placeholder="https://example.com/recipe">
            </div>
            
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">수정 완료</button>
                <a href="${pageContext.request.contextPath}/theme/view?themeId=${themeId}" class="btn btn-secondary px-4">취소</a>
            </div>
        </div>
    </form>
</div>