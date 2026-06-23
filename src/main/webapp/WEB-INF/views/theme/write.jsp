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

        .preview-text-wrap {
            white-space: pre-wrap;
            word-break: break-all;
            overflow-wrap: break-word;
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
                  enctype="multipart/form-data"
                  onsubmit="return validateThemeWriteForm();">

                <input type="hidden" name="themeId" value="0">

                <div class="mb-3">
                    <label class="form-label">테마 제목 *</label>
                    <input type="text"
                           name="title"
                           id="input-title"
                           class="form-control"
                           placeholder="제목을 입력하세요"
                           required>

                    <div class="text-end mt-1">
                        <small id="titleCount" class="text-muted">0 / 300</small>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">부제목</label>
                    <input type="text"
                           name="subtitle"
                           id="input-subtitle"
                           class="form-control">

                    <div class="text-end mt-1">
                        <small id="subtitleCount" class="text-muted">0 / 300</small>
                    </div>
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

                    <div class="text-end mt-1">
                        <small id="contentCount" class="text-muted">0 / 4000</small>
                    </div>
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
                <div id="preview-img-box"
     class="card-img-top d-flex align-items-center justify-content-center"
     style="height:200px; background:#f1f1f1; color:#999;">
    이미지 미리보기
</div>

<img id="preview-img"
     src=""
     class="card-img-top"
     alt="미리보기"
     style="display:none;">

                <div class="card-body">
                    <h5 id="preview-title"
                        class="card-title preview-text-wrap">
                        제목이 여기에 표시됩니다
                    </h5>

                    <h6 id="preview-subtitle"
                        class="card-subtitle mb-2 text-muted preview-text-wrap">
                    </h6>

                    <p id="preview-content"
                       class="card-text preview-text-wrap">
                        작성한 내용이 여기에 나타납니다.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
const TITLE_MAX = 300;
const SUBTITLE_MAX = 300;
const CONTENT_MAX = 4000;

const titleInput = document.getElementById("input-title");
const subtitleInput = document.getElementById("input-subtitle");
const contentInput = document.getElementById("input-content");

const titleCount = document.getElementById("titleCount");
const subtitleCount = document.getElementById("subtitleCount");
const contentCount = document.getElementById("contentCount");

const previewTitle = document.getElementById("preview-title");
const previewSubtitle = document.getElementById("preview-subtitle");
const previewContent = document.getElementById("preview-content");

function toggleCountColor(counter, length, max) {
    if (length > max) {
        counter.classList.remove("text-muted");
        counter.classList.add("text-danger");
    } else {
        counter.classList.remove("text-danger");
        counter.classList.add("text-muted");
    }
}

function updateCounts() {
    titleCount.innerText = titleInput.value.length + " / " + TITLE_MAX;
    subtitleCount.innerText = subtitleInput.value.length + " / " + SUBTITLE_MAX;
    contentCount.innerText = contentInput.value.length + " / " + CONTENT_MAX;

    toggleCountColor(titleCount, titleInput.value.length, TITLE_MAX);
    toggleCountColor(subtitleCount, subtitleInput.value.length, SUBTITLE_MAX);
    toggleCountColor(contentCount, contentInput.value.length, CONTENT_MAX);
}

titleInput.addEventListener("input", function(e) {
    previewTitle.innerText = e.target.value || "제목이 여기에 표시됩니다";
    updateCounts();
});

subtitleInput.addEventListener("input", function(e) {
    previewSubtitle.innerText = e.target.value;
    updateCounts();
});

contentInput.addEventListener("input", function(e) {
    previewContent.innerText = e.target.value || "작성한 내용이 여기에 나타납니다.";
    updateCounts();
});

document.getElementById("input-img").addEventListener("change", function(e) {
    const file = e.target.files[0];

    const previewBox = document.getElementById("preview-img-box");
    const previewImg = document.getElementById("preview-img");

    if (file) {
        const reader = new FileReader();

        reader.onload = function(event) {
            previewImg.src = event.target.result;
            previewImg.className = "card-img-top";
            previewImg.style.maxHeight = "250px";
            previewImg.style.objectFit = "cover";
            previewImg.style.display = "block";

            previewBox.classList.remove("d-flex");
            previewBox.classList.add("d-none");
            previewBox.style.display = "none";
        };

        reader.readAsDataURL(file);
    } else {
        previewImg.removeAttribute("src");
        previewImg.style.display = "none";

        previewBox.classList.remove("d-none");
        previewBox.classList.add("d-flex");
        previewBox.style.display = "flex";
    }
});

function validateThemeWriteForm() {
    const title = titleInput.value.trim();
    const subtitle = subtitleInput.value.trim();
    const content = contentInput.value;

    if (title.length === 0) {
        alert("테마 제목을 입력하세요.");
        return false;
    }

    if (title.length > TITLE_MAX) {
        alert("테마 제목은 최대 300자까지 입력 가능합니다.");
        return false;
    }

    if (subtitle.length > SUBTITLE_MAX) {
        alert("부제목은 최대 300자까지 입력 가능합니다.");
        return false;
    }

    if (content.length > CONTENT_MAX) {
        alert("테마 상세 내용은 최대 4000자까지 입력 가능합니다.");
        return false;
    }

    return true;
}

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

updateCounts();
</script>

</body>
</html>