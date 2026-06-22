<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <h3 class="fw-bold mb-4">レシピ情報を編集</h3>

    <form action="${pageContext.request.contextPath}/theme/editRecipeInfoAction" method="post" enctype="multipart/form-data">
        <%-- hidden 필드를 가장 위에 배치 --%>
        <input type="hidden" name="recipeId" value="${recipe.recipeId}">
        <input type="hidden" name="themeId" value="${themeId}">
        <input type="hidden" name="oldThumbnail" value="${recipe.thumbnail}">

        <div class="card p-4 shadow-sm">
            <div class="mb-4 text-center">
                <label class="form-label d-block text-start">既存写真</label>
                <img src="${pageContext.request.contextPath}${recipe.thumbnail}"
                     style="max-width: 200px; border-radius: 10px;" class="mb-3">
                <input type="file" name="thumbnail" class="form-control">
                <small class="text-muted">新しい写真を選択しない場合、既存の写真が維持されます。</small>
            </div>

            <div class="mb-3">
                <label class="form-label">タイトル</label>
                <input type="text" name="title" class="form-control" value="${recipe.title}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">説明</label>
                <textarea name="description" class="form-control" rows="5">${recipe.description}</textarea>
            </div>

            <div class="mb-4">
                <label class="form-label">レシピ詳細リンク（URL）</label>
                <input type="url" name="recipeLink" class="form-control"
                       value="${recipe.recipeLink}" placeholder="https://example.com/recipe">
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">変更を保存</button>
                <a href="${pageContext.request.contextPath}/theme/view?themeId=${themeId}" class="btn btn-secondary px-4">キャンセル</a>
            </div>
        </div>
    </form>
</div>
