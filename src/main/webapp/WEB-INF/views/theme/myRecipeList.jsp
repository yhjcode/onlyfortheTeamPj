<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 레시피 선택</title>

<style>
body {
    font-family: 'Pretendard', sans-serif;
    background-color: #f4f4f9;
    padding: 20px;
    color: #333;
}

h3 {
    border-bottom: 2px solid #333;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.recipe-item {
    background: #fff;
    padding: 15px;
    margin-bottom: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

.recipe-info {
    margin-bottom: 10px;
    font-weight: bold;
}

.desc-input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
}

.select-btn {
    padding: 8px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    background-color: #333;
    color: white;
    font-weight: bold;
}

.close-btn {
    background-color: #999;
    margin-top: 20px;
}
</style>
</head>

<body>

<h3>내 레시피 선택</h3>

<c:choose>
    <c:when test="${not empty myRecipeList}">

        <c:forEach var="recipe" items="${myRecipeList}">

            <c:choose>

                <%-- write.jsp에서 열린 경우 --%>
                <c:when test="${param.mode eq 'write'}">
                    <div class="recipe-item">
                        <div class="recipe-info">
                            <a href="${pageContext.request.contextPath}/recipe/view?id=${recipe.recipeId}"
                               target="_blank">
                                ${recipe.title}
                            </a>
                        </div>

                        <button type="button"
                                class="select-btn write-select-btn"
                                data-recipe-id="${recipe.recipeId}"
                                data-recipe-title="${recipe.title}">
                            선택
                        </button>
                    </div>
                </c:when>

                <%-- theme/view.jsp에서 열린 경우 --%>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/theme/addRecipeAction"
                          method="post"
                          class="recipe-item">

                        <input type="hidden" name="themeId" value="${param.themeId}">
                        <input type="hidden" name="recipeId" value="${recipe.recipeId}">

                        <div class="recipe-info">
                            <a href="${pageContext.request.contextPath}/recipe/view?id=${recipe.recipeId}"
                               target="_blank">
                                ${recipe.title}
                            </a>
                        </div>

                        <input type="text"
       name="description"
       class="desc-input"
       placeholder="테마 소개글 입력"
       maxlength="330"
       oninput="updateThemeCount(this)">

<div style="text-align:right; margin-bottom:10px;">
    <small class="theme-count">0 / 330</small>
</div>

                        <button type="submit" class="select-btn">
                            선택
                        </button>
                    </form>
                </c:otherwise>

            </c:choose>

        </c:forEach>

    </c:when>

    <c:otherwise>
        <div style="text-align:center; padding:20px;">
            등록된 레시피가 없습니다.
        </div>
    </c:otherwise>
</c:choose>

<div style="text-align:center;">
    <button type="button"
            class="select-btn close-btn"
            onclick="window.close()">
        닫기
    </button>
</div>

<script>
function updateThemeCount(input) {
    const max = 330;

    if (input.value.length > max) {
        input.value = input.value.substring(0, max);
    }

    const form = input.closest("form");
    const countEl = form.querySelector(".theme-count");

    countEl.innerText = input.value.length + " / " + max;
}
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('write-select-btn')) {
        var recipeId = e.target.getAttribute('data-recipe-id');
        var title = e.target.getAttribute('data-recipe-title');

        if (window.opener && typeof window.opener.addRecipeToWrite === 'function') {
            window.opener.addRecipeToWrite(recipeId, title);
            window.close();
        } else {
            alert("부모 창의 addRecipeToWrite 함수를 찾을 수 없습니다.");
        }
    }
});
</script>

</body>
</html>