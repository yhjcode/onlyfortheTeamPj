<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.recipe-desc {
    white-space: pre-wrap;
    word-break: break-all;
    overflow-wrap: anywhere;
    width: 100%;
    margin-left: 0;
    padding-left: 0;
}

.recipe-desc-wrapper {
    width: 100%;
    max-width: 100%;
    overflow: hidden;
}

.theme-desc {
    white-space: pre-wrap;
    word-break: break-all;
    overflow-wrap: anywhere;
    width: 100%;
    max-width: 100%;
    text-align: left !important;
    text-indent: 0 !important;
    margin-left: 0 !important;
    padding-left: 24px !important;
}
</style>

<!-- 테마 상단 정보 -->
<div class="text-center mb-5">
    <h2 class="fw-bold mb-3" style="font-size: 2.5rem;">
        <span class="text-danger">Theme:</span> ${theme.title}
    </h2>

    <c:if test="${not empty theme.thumbnail}">
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/resources/upload/theme/${theme.thumbnail}"
                 alt="${theme.title}"
                 style="max-width: 500px; border-radius: 15px;">
        </div>
    </c:if>

    <c:if test="${not empty theme.subtitle}">
        <h4 class="text-secondary mb-3">${theme.subtitle}</h4>
    </c:if>

    <div class="d-flex justify-content-center align-items-center gap-3 text-muted">
        <span><i class="bi bi-eye"></i> 조회수 ${theme.viewCount}</span>
        <span><i class="bi bi-calendar3"></i> ${theme.createdAt}</span>
    </div>
</div>

<!-- 테마 수정 / 삭제 버튼 -->
<div class="d-flex justify-content-end mb-4">
    <c:if test="${not empty loginUser and loginUser.userId eq theme.userId}">
        <div>
            <a href="${pageContext.request.contextPath}/theme/update?themeId=${theme.themeId}"
               class="btn px-4"
               style="background-color: white; border: 1px solid #ced4da; color: black;">
                수정
            </a>

            <a href="${pageContext.request.contextPath}/theme/delete?themeId=${theme.themeId}"
               class="btn btn-danger px-4"
               onclick="return confirm('정말 삭제하시겠습니까?');">
                삭제
            </a>
        </div>
    </c:if>
</div>

<!-- 요리 상세 목록 -->
<div class="section-card mb-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="section-title mb-0">
            <i class="bi bi-list-ul text-danger me-2"></i> 요리 상세 목록
        </h3>

        <c:if test="${not empty loginUser}">
            <button type="button"
                    class="btn btn-danger"
                    onclick="window.open('${pageContext.request.contextPath}/theme/myRecipeList?themeId=${theme.themeId}',
                                         'recipePopup',
                                         'width=700,height=600,scrollbars=yes')">
                내 레시피 추가
            </button>
        </c:if>
    </div>

    <!-- 테마 설명 -->
    <div class="mb-5 p-4 bg-light rounded-4 theme-desc"><c:choose><c:when test="${not empty theme.description}">${fn:trim(theme.description)}</c:when><c:otherwise>테마 소개글을 준비 중입니다.</c:otherwise></c:choose></div>

    <c:if test="${empty recipeList}">
        <div class="text-center text-muted py-5">
            아직 추가된 레시피가 없습니다.<br>
            내 레시피 추가 버튼을 눌러 레시피를 추가해보세요.
        </div>
    </c:if>

    <c:forEach var="recipe" items="${recipeList}">
<div class="mb-5 pb-5 position-relative"
     style="border-bottom: 2px solid #eaeaea !important;">

    <c:if test="${not empty recipe.thumbnail}">
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/resources/upload/recipe/${recipe.thumbnail}"
                 alt="${recipe.title}"
                 style="max-width: 300px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        </div>
    </c:if>

    <!-- 제목 + 버튼 -->
    <div class="d-flex justify-content-between align-items-start mb-3">

        <div style="flex:1; min-width:0; padding-right:15px;">
            <h4 class="text-dark mb-0"
    style="
        word-break: normal;
        overflow-wrap: anywhere;
        line-height:1.5;
        text-align:left;
        margin:0;
    ">
    ${recipe.title}
</h4>
        </div>

        <c:if test="${not empty loginUser and loginUser.userId eq recipe.userId}">
            <div style="white-space:nowrap; flex-shrink:0;">

                <button type="button"
                        class="btn btn-sm btn-outline-secondary me-2"
                        onclick="location.href='${pageContext.request.contextPath}/theme/editRecipeInfo?themeId=${theme.themeId}&recipeId=${recipe.recipeId}'">
                    소개 수정
                </button>

                <form action="${pageContext.request.contextPath}/theme/removeRecipe"
                      method="post"
                      class="d-inline">

                    <input type="hidden"
                           name="themeId"
                           value="${theme.themeId}">

                    <input type="hidden"
                           name="recipeId"
                           value="${recipe.recipeId}">

                    <button type="submit"
                            class="btn btn-sm btn-outline-danger"
                            onclick="return confirm('이 요리를 테마에서 제거하시겠습니까?');">
                        X 삭제
                    </button>

                </form>

            </div>
        </c:if>

    </div>

    <!-- 설명 -->
    <div class="recipe-desc-wrapper">

        <c:choose>

            <c:when test="${not empty recipe.description}">
                <p class="text-muted mt-3 recipe-desc"
   style="font-size:1.1rem; text-align:left;">${fn:trim(recipe.description)}</p>
            </c:when>

            <c:otherwise>
                <p class="text-muted mt-3 recipe-desc"
   style="font-size:1.1rem; text-align:left;">작성된 소개글이 없습니다.</p>            </c:otherwise>

        </c:choose>

    </div>

    <!-- 버튼 -->
    <div class="mt-3 d-flex justify-content-center gap-2">

        <a href="${pageContext.request.contextPath}/recipe/view?id=${recipe.recipeId}"
           class="btn btn-outline-primary btn-sm px-3">
            레시피로 이동
        </a>

        <c:if test="${not empty recipe.recipeLink}">
            <a href="${recipe.recipeLink}"
               target="_blank"
               class="btn btn-outline-success btn-sm px-3">
                상세 레시피 바로가기
            </a>
        </c:if>

    </div>

</div>
    </c:forEach>

</div>

<!-- ================= 댓글 ================= -->
<div class="section-card mb-5 p-4">

    <h4 class="mb-4">
        <i class="bi bi-chat-dots text-danger me-2"></i>
        댓글
    </h4>

    <c:if test="${not empty loginUser}">
        <div class="mb-4">

            <div class="mb-3">
                <label class="form-label">별점</label>

                <div style="display:flex; align-items:center; gap:15px;">
                    <div id="starRating"
                         style="font-size:32px; color:#ffc107; cursor:pointer; user-select:none;">
                        ★★★★★
                    </div>

                    <strong id="ratingText" style="font-size:20px;">5.0</strong>
                </div>

                <input type="hidden" id="commentRating" value="5.0">
            </div>

            <textarea id="commentContent"
                      class="form-control"
                      rows="3"
                      placeholder="댓글을 입력하세요"></textarea>

            <button type="button"
                    class="btn btn-danger mt-2"
                    onclick="addThemeComment()">
                댓글 등록
            </button>
        </div>
    </c:if>

    <div id="commentList">
        <!-- AJAX 댓글 출력 -->
    </div>

</div>

<script>
const themeId = "${theme.themeId}";
const contextPath = "${pageContext.request.contextPath}";
const loginUserId = "${loginUser.userId}";

window.onload = function() {
    loadThemeComments();
};

window.addEventListener("DOMContentLoaded", function() {
    initDragStarRating();
});

function initDragStarRating() {
    const starRating = document.getElementById("starRating");
    const ratingText = document.getElementById("ratingText");
    const ratingInput = document.getElementById("commentRating");

    if (!starRating || !ratingText || !ratingInput) {
        return;
    }

    let isDragging = false;
    let currentRating = 5.0;

    function calculateRating(event) {
        const rect = starRating.getBoundingClientRect();
        const x = event.clientX - rect.left;
        let rating = (x / rect.width) * 5;

        rating = Math.ceil(rating * 2) / 2;

        if (rating < 0.5) rating = 0.5;
        if (rating > 5.0) rating = 5.0;

        return rating;
    }

    function updateRating(rating) {
        currentRating = rating;

        ratingInput.value = rating.toFixed(1);
        ratingText.innerText = rating.toFixed(1);

        let stars = "";

        for (let i = 1; i <= 5; i++) {
            if (rating >= i) {
                stars += "★";
            } else if (rating >= i - 0.5) {
                stars += "⯪";
            } else {
                stars += "☆";
            }
        }

        starRating.innerText = stars;
    }

    starRating.addEventListener("mousedown", function(event) {
        isDragging = true;
        updateRating(calculateRating(event));
    });

    starRating.addEventListener("mousemove", function(event) {
        if (isDragging) {
            updateRating(calculateRating(event));
        }
    });

    document.addEventListener("mouseup", function() {
        isDragging = false;
    });

    starRating.addEventListener("click", function(event) {
        updateRating(calculateRating(event));
    });

    updateRating(currentRating);
}

function loadThemeComments() {
    fetch(contextPath + "/theme/comment/list?themeId=" + themeId)
        .then(response => response.json())
        .then(data => {
            let html = "";

            data.forEach(function(comment) {
                const isReply = comment.parentReviewId != null;
                const marginStyle = isReply ? "margin-left:40px;" : "";

                html +=
                    '<div class="border-bottom py-3" style="' + marginStyle + '" id="comment-' + comment.commentId + '">';

                if (!isReply && comment.rating != null) {
                    html += '<div class="text-warning mb-1">⭐ ' + comment.rating + ' / 5.0</div>';
                }

                html +=
                    '<div class="d-flex justify-content-between">' +
                        '<strong>' + (isReply ? "↳ " : "") + comment.nickname + '</strong>' +
                        '<small class="text-muted">' + comment.createdAt + '</small>' +
                    '</div>' +

                    '<div class="mt-2" id="comment-content-' + comment.commentId + '">' +
                        comment.content +
                    '</div>';

                html += '<div class="mt-2" id="button-area-' + comment.commentId + '">';

                if (loginUserId !== "" && !isReply) {
                    html +=
                        '<button type="button" class="btn btn-sm btn-outline-primary me-2" ' +
                            'onclick="showReplyForm(' + comment.commentId + ')">' +
                            '답글' +
                        '</button>';
                }

                if (loginUserId !== "" && loginUserId === comment.userId) {
                    html +=
                        '<button type="button" class="btn btn-sm btn-outline-secondary me-2" ' +
                            'onclick="showEditComment(' + comment.commentId + ')">' +
                            '수정' +
                        '</button>' +

                        '<button type="button" class="btn btn-sm btn-outline-danger" ' +
                            'onclick="deleteThemeComment(' + comment.commentId + ')">' +
                            '삭제' +
                        '</button>';
                }

                html += '</div>';

                if (!isReply) {
                    html +=
                        '<div id="reply-form-' + comment.commentId + '" class="mt-3" style="display:none;">' +
                            '<textarea id="reply-content-' + comment.commentId + '" class="form-control" rows="2" placeholder="답글을 입력하세요"></textarea>' +
                            '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="addReplyComment(' + comment.commentId + ')">답글 등록</button>' +
                            '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="hideReplyForm(' + comment.commentId + ')">취소</button>' +
                        '</div>';
                }

                html += '</div>';
            });

            document.getElementById("commentList").innerHTML = html;
        });
}

function addThemeComment() {
    const content = document.getElementById("commentContent").value.trim();
    const rating = document.getElementById("commentRating").value;

    if (content === "") {
        alert("댓글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/theme/comment/add", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "themeId=" + themeId +
              "&rating=" + encodeURIComponent(rating) +
              "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            document.getElementById("commentContent").value = "";
            document.getElementById("commentRating").value = "5.0";
            document.getElementById("ratingText").innerText = "5.0";
            document.getElementById("starRating").innerText = "★★★★★";
            loadThemeComments();
        } else {
            alert("댓글 등록 실패");
        }
    });
}

function showReplyForm(commentId) {
    document.getElementById("reply-form-" + commentId).style.display = "block";
}

function hideReplyForm(commentId) {
    document.getElementById("reply-form-" + commentId).style.display = "none";
}

function addReplyComment(parentReviewId) {
    const content = document.getElementById("reply-content-" + parentReviewId).value.trim();

    if (content === "") {
        alert("답글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/theme/comment/add", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "themeId=" + themeId +
              "&parentReviewId=" + parentReviewId +
              "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            loadThemeComments();
        } else {
            alert("답글 등록 실패");
        }
    });
}

function showEditComment(commentId) {
    const contentDiv = document.getElementById("comment-content-" + commentId);
    const buttonDiv = document.getElementById("button-area-" + commentId);

    const oldContent = contentDiv.innerText;

    contentDiv.innerHTML =
        '<textarea id="edit-comment-' + commentId + '" class="form-control" rows="3">' +
            oldContent +
        '</textarea>';

    buttonDiv.innerHTML =
        '<button type="button" class="btn btn-sm btn-danger me-2" onclick="updateThemeComment(' + commentId + ')">' +
            '저장' +
        '</button>' +
        '<button type="button" class="btn btn-sm btn-secondary" onclick="loadThemeComments()">' +
            '취소' +
        '</button>';
}

function updateThemeComment(commentId) {
    const content = document.getElementById("edit-comment-" + commentId).value.trim();

    if (content === "") {
        alert("댓글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/theme/comment/update", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "commentId=" + commentId +
              "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            loadThemeComments();
        } else {
            alert("댓글 수정 실패");
        }
    });
}

function deleteThemeComment(commentId) {
    if (!confirm("댓글을 삭제하시겠습니까?")) {
        return;
    }

    fetch(contextPath + "/theme/comment/delete", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "commentId=" + commentId
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            loadThemeComments();
        } else {
            alert("댓글 삭제 실패");
        }
    });
}
</script>