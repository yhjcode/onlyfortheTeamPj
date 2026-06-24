<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테마 수정하기</title>

    <style>
        .preview-text-wrap {
            white-space: pre-wrap;
            word-break: break-all;
            overflow-wrap: break-word;
        }
    </style>
</head>

<body class="bg-light">

<div class="container py-5">
    <h2 class="mb-4">테마 수정</h2>

    <div class="row">
        <div class="col-md-7">
            <form action="${pageContext.request.contextPath}/theme/updateAction"
                  method="POST"
                  enctype="multipart/form-data"
                  onsubmit="return validateThemeForm();">

                <input type="hidden" name="themeId" value="${theme.themeId}">
                <input type="hidden" name="oldThumbnail" value="${theme.thumbnail}">

                <div class="mb-3">
                    <label class="form-label">테마 제목 *</label>
                    <input type="text"
       name="title"
       id="input-title"
       class="form-control"
       value="${theme.title}"
       maxlength="33"
       required>

                    <div class="text-end mt-1">
                        <small id="titleCount" class="text-muted">0 / 33</small>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">부제목</label>
                    <input type="text"
       name="subtitle"
       id="input-subtitle"
       class="form-control"
       value="${theme.subtitle}"
       maxlength="33">

<div class="text-end mt-1">
    <small id="subtitleCount" class="text-muted">0 / 33</small>
</div>
</div>

                <div class="mb-3">
                    <label class="form-label">이미지 업로드 (변경 시 선택)</label>
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
                              rows="5">${theme.description}</textarea>

                    <div class="text-end mt-1">
                        <small id="contentCount" class="text-muted">0 / 4000</small>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">
                    수정 완료
                </button>
            </form>
        </div>

        <div class="col-md-5">
            <h5>실시간 미리보기</h5>

            <div class="card shadow-sm">
                <c:choose>
    <c:when test="${not empty theme.thumbnail}">
        <img id="preview-img"
             src="${pageContext.request.contextPath}/resources/upload/theme/${theme.thumbnail}"
             class="card-img-top"
             alt="미리보기"
             style="max-height:250px; object-fit:cover;">

        <div id="preview-img-box"
             style="display:none;">
        </div>
    </c:when>

    <c:otherwise>
        <div id="preview-img-box"
             class="card-img-top d-flex align-items-center justify-content-center"
             style="height:250px; background:#f5f5f5; color:#999; font-size:18px;">
            이미지를 선택하세요
        </div>

        <img id="preview-img"
             src=""
             alt=""
             style="display:none;">
    </c:otherwise>
</c:choose>

                <div class="card-body">
                    <h5 id="preview-title"
                        class="card-title preview-text-wrap">${theme.title}</h5>

                    <h6 id="preview-subtitle"
                        class="card-subtitle mb-2 text-muted preview-text-wrap">${theme.subtitle}</h6>

                    <p id="preview-content"
                       class="card-text preview-text-wrap">${theme.description}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const TITLE_MAX = 33;
    const SUBTITLE_MAX = 33;
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

    function updateCounts() {
        titleCount.innerText = titleInput.value.length + " / " + TITLE_MAX;
        subtitleCount.innerText = subtitleInput.value.length + " / " + SUBTITLE_MAX;
        contentCount.innerText = contentInput.value.length + " / " + CONTENT_MAX;

        toggleCountColor(titleCount, titleInput.value.length, TITLE_MAX);
        toggleCountColor(subtitleCount, subtitleInput.value.length, SUBTITLE_MAX);
        toggleCountColor(contentCount, contentInput.value.length, CONTENT_MAX);
    }

    function toggleCountColor(counter, length, max) {
        if (length > max) {
            counter.classList.remove("text-muted");
            counter.classList.add("text-danger");
        } else {
            counter.classList.remove("text-danger");
            counter.classList.add("text-muted");
        }
    }

    titleInput.addEventListener("input", function(e) {
        previewTitle.innerText = e.target.value;
        updateCounts();
    });

    subtitleInput.addEventListener("input", function(e) {
        previewSubtitle.innerText = e.target.value;
        updateCounts();
    });

    contentInput.addEventListener("input", function(e) {
        previewContent.innerText = e.target.value;
        updateCounts();
    });

    document.getElementById("input-img").addEventListener("change", function(e) {
        const file = e.target.files[0];

        const previewImg = document.getElementById("preview-img");
        const previewBox = document.getElementById("preview-img-box");

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
    function validateThemeForm() {
        const title = titleInput.value.trim();
        const subtitle = subtitleInput.value.trim();
        const content = contentInput.value;

        if (title.length === 0) {
            alert("테마 제목을 입력하세요.");
            return false;
        }

        if (title.length > TITLE_MAX) {
            alert("테마 제목은 최대 33자까지 입력 가능합니다.");
            return false;
        }

        if (subtitle.length > SUBTITLE_MAX) {
            alert("부제목은 최대 33자까지 입력 가능합니다.");
            return false;
        }

        if (content.length > CONTENT_MAX) {
            alert("테마 상세 내용은 최대 4000자까지 입력 가능합니다.");
            return false;
        }

        return true;
    }

    updateCounts();
</script>

</body>
</html>