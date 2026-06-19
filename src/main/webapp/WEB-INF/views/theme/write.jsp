<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테마 작성하기</title>

    <style>
        .selected-recipe-box {
            border: 1px solid #ddd;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            background-color: #fff;
        }

        .selected-recipe-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
    </style>
</head>

<body class="bg-light">

<div class="container py-5">
    <h2 class="mb-4">테마 작성</h2>

    <div class="row">
        <div class="col-md-7">

            <form action="${pageContext.request.contextPath}/theme/writeAction"
                  method="POST"
                  enctype="multipart/form-data">

                <input type="hidden" name="themeId" value="0">

                <div class="mb-3">
                    <label class="form-label">테마 제목 *</label>
                    <input type="text"
                           name="title"
                           id="input-title"
                           class="form-control"
                           placeholder="제목을 입력하세요"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">부제목</label>
                    <input type="text"
                           name="subtitle"
                           id="input-subtitle"
                           class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">이미지 업로드</label>
                    <input type="file"
                           name="thumbnail"
                           id="input-img"
                           class="form-control"
                           accept="image/*">
                </div>

                <div class="mb-3">
                    <label class="form-label">테마 상세 내용</label>
                    <textarea name="description"
                              id="input-content"
                              class="form-control"
                              rows="5"></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">포함할 레시피</label>

                    <button type="button"
        class="btn btn-secondary"
        onclick="window.open('${pageContext.request.contextPath}/theme/myRecipeList?themeId=0&mode=write',
                             'recipePopup',
                             'width=700,height=600,scrollbars=yes')">
    내 레시피 추가
</button>

                    <div id="selectedRecipeArea" class="mt-3"></div>
                </div>

                <button type="submit" class="btn btn-primary">
                    등록
                </button>
            </form>
        </div>

        <div class="col-md-5">
            <h5>실시간 미리보기</h5>

            <div class="card shadow-sm sticky-top" style="top: 20px;">
                <img id="preview-img"
                     src="https://via.placeholder.com/400x200"
                     class="card-img-top"
                     alt="미리보기">

                <div class="card-body">
                    <h5 id="preview-title" class="card-title">
                        제목이 여기에 표시됩니다
                    </h5>

                    <p id="preview-content"
                       class="card-text"
                       style="white-space: pre-wrap;">
                        작성한 내용이 여기에 나타납니다.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function addRecipeToWrite(recipeId, title) {
    var area = document.getElementById("selectedRecipeArea");

    if (document.getElementById("rec-" + recipeId)) {
        alert("이미 추가된 레시피입니다.");
        return;
    }

    var div = document.createElement("div");
    div.id = "rec-" + recipeId;
    div.className = "selected-recipe-box";

    div.innerHTML =
        '<div class="selected-recipe-header">' +
            '<strong>' + title + '</strong>' +
            '<button type="button" class="btn btn-danger btn-sm">삭제</button>' +
        '</div>' +
        '<input type="hidden" name="recipeIds" value="' + recipeId + '">' +
        '<input type="text" name="descriptions" class="form-control my-2" placeholder="이 레시피 소개글">';

    div.querySelector("button").onclick = function() {
        div.remove();
    };

    area.appendChild(div);
}
</script>

</body>
</html>