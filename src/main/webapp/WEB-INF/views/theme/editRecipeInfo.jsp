<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <h3 class="fw-bold mb-4">レシピ情報を編集</h3>

    <form action="${pageContext.request.contextPath}/theme/editRecipeInfoAction"
          method="post"
          enctype="multipart/form-data"
          onsubmit="return validateRecipeForm();">

        <input type="hidden" name="recipeId" value="${recipe.recipeId}">
        <input type="hidden" name="themeId" value="${themeId}">
        <input type="hidden" name="oldThumbnail" value="${recipe.thumbnail}">

        <div class="card p-4 shadow-sm">

            <div class="mb-4 text-center">
                <label class="form-label d-block text-start">既存の写真</label>

                <c:if test="${not empty recipe.thumbnail}">
                    <img src="${pageContext.request.contextPath}/resources/upload/recipe/${recipe.thumbnail}"
                         style="max-width: 200px; border-radius: 10px;"
                         class="mb-3">
                </c:if>

                <input type="file"
                       name="thumbnail"
                       class="form-control">

                <small class="text-muted">
                    新しい写真を選択しなければ既存の写真が維持されます。
                </small>
            </div>

            <div class="mb-3">
                <label class="form-label">タイトル</label>

                <input type="text"
                       name="title"
                       id="title"
                       class="form-control"
                       value="${recipe.title}"
                       maxlength="66"
                       required>

                <div class="text-end mt-1">
                    <small id="titleCount" class="text-muted">0 / 66</small>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">説明</label>

                <textarea name="description"
                          id="description"
                          class="form-control"
                          rows="5"
                          maxlength="330">${recipe.description}</textarea>

                <div class="text-end mt-1">
                    <small id="descriptionCount" class="text-muted">0 / 330</small>
                </div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit"
                        class="btn btn-primary px-4">
                    編集完了
                </button>

                <a href="${pageContext.request.contextPath}/theme/view?themeId=${themeId}"
                   class="btn btn-secondary px-4">
                    キャンセル
                </a>
            </div>

        </div>
    </form>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const title = document.getElementById("title");
    const description = document.getElementById("description");

    const titleCount = document.getElementById("titleCount");
    const descriptionCount = document.getElementById("descriptionCount");

    function updateTitleCount() {
        titleCount.innerText = title.value.length + " / 66";

        if (title.value.length > 200) {
            titleCount.classList.remove("text-muted");
            titleCount.classList.add("text-danger");
        } else {
            titleCount.classList.remove("text-danger");
            titleCount.classList.add("text-muted");
        }
    }

    function updateDescriptionCount() {
        descriptionCount.innerText = description.value.length + " / 330";

        if (description.value.length > 330) {
            descriptionCount.classList.remove("text-muted");
            descriptionCount.classList.add("text-danger");
        } else {
            descriptionCount.classList.remove("text-danger");
            descriptionCount.classList.add("text-muted");
        }
    }

    title.addEventListener("input", updateTitleCount);
    description.addEventListener("input", updateDescriptionCount);

    updateTitleCount();
    updateDescriptionCount();
});

function validateRecipeForm() {
    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value;

    if (title.length === 0) {
        alert("タイトルを入力してください。");
        return false;
    }

    if (title.length > 66) {
        alert("タイトルは最大66文字まで入力できます。");
        return false;
    }

    if (description.length > 330) {
        alert("説明は最大330文字まで入力できます。");
        return false;
    }

    return true;
}
</script>