<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>テーマを投稿する</title>

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
    <h2 class="mb-4">テーマ投稿</h2>

    <div class="row">
        <div class="col-md-7">

            <form action="${pageContext.request.contextPath}/theme/writeAction"
                  method="POST"
                  enctype="multipart/form-data">

                <input type="hidden" name="themeId" value="0">

                <div class="mb-3">
                    <label class="form-label">テーマタイトル *</label>
                    <input type="text"
                           name="title"
                           id="input-title"
                           class="form-control"
                           placeholder="タイトルを入力してください"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">サブタイトル</label>
                    <input type="text"
                           name="subtitle"
                           id="input-subtitle"
                           class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">画像アップロード</label>
                    <input type="file"
                           name="thumbnail"
                           id="input-img"
                           class="form-control"
                           accept="image/*">
                </div>

                <div class="mb-3">
                    <label class="form-label">テーマ詳細内容</label>
                    <textarea name="description"
                              id="input-content"
                              class="form-control"
                              rows="5"></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">含めるレシピ</label>

                    <button type="button"
        class="btn btn-secondary"
        onclick="window.open('${pageContext.request.contextPath}/theme/myRecipeList?themeId=0&mode=write',
                             'recipePopup',
                             'width=700,height=600,scrollbars=yes')">
    マイレシピを追加
</button>

                    <div id="selectedRecipeArea" class="mt-3"></div>
                </div>

                <button type="submit" class="btn btn-primary">
                    登録
                </button>
            </form>
        </div>

        <div class="col-md-5">
            <h5>リアルタイムプレビュー</h5>

            <div class="card shadow-sm sticky-top" style="top: 20px;">
                <img id="preview-img"
                     src="https://via.placeholder.com/400x200"
                     class="card-img-top"
                     alt="プレビュー">

                <div class="card-body">
                    <h5 id="preview-title" class="card-title">
                        タイトルがここに表示されます
                    </h5>

                    <p id="preview-content"
                       class="card-text"
                       style="white-space: pre-wrap;">
                        入力した内容がここに表示されます。
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
        alert("すでに追加済みのレシピです。");
        return;
    }

    var div = document.createElement("div");
    div.id = "rec-" + recipeId;
    div.className = "selected-recipe-box";

    div.innerHTML =
        '<div class="selected-recipe-header">' +
            '<strong>' + title + '</strong>' +
            '<button type="button" class="btn btn-danger btn-sm">削除</button>' +
        '</div>' +
        '<input type="hidden" name="recipeIds" value="' + recipeId + '">' +
        '<input type="text" name="descriptions" class="form-control my-2" placeholder="このレシピの紹介文">';

    div.querySelector("button").onclick = function() {
        div.remove();
    };

    area.appendChild(div);
}
</script>

</body>
</html>
