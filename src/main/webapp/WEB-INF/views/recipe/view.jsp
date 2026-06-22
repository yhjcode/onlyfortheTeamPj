<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .recipe-view-wrap { max-width: 980px; margin: 0 auto; }
    .recipe-hero {
        background: #fff;
        border: 1px solid #e9ecef;
        border-radius: 12px;
        overflow: hidden;
        margin-bottom: 22px;
    }
    .recipe-hero-img {
        width: 100%;
        max-height: 520px;
        object-fit: cover;
        background: #f4f4f4;
    }
    .recipe-hero-empty {
        min-height: 320px;
        background: #f7f7f7;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #adb5bd;
        font-size: 4rem;
    }
    .recipe-hero-body { padding: 30px 36px; text-align: center; }
    .recipe-title {
        font-size: 2rem;
        line-height: 1.35;
        font-weight: 800;
        margin-bottom: 12px;
    }
    .recipe-desc {
        color: #6c757d;
        white-space: pre-line;
        margin-bottom: 18px;
    }
    .recipe-meta-list {
        display: flex;
        justify-content: center;
        gap: 18px;
        flex-wrap: wrap;
        margin-top: 20px;
    }
    .recipe-meta-item {
        min-width: 110px;
        color: #495057;
        font-weight: 700;
    }
    .recipe-meta-item i {
        display: block;
        font-size: 1.8rem;
        color: #dc3545;
        margin-bottom: 6px;
    }
    .recipe-view-section {
        background: #fff;
        border: 1px solid #e9ecef;
        border-radius: 12px;
        padding: 30px 36px;
        margin-bottom: 22px;
    }
    .recipe-view-section h3 {
        font-size: 1.35rem;
        font-weight: 800;
        color: var(--bggchef-primary);
        margin-bottom: 22px;
    }
    .ingredient-list {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 0 28px;
    }
    .ingredient-item {
        display: flex;
        justify-content: space-between;
        gap: 16px;
        border-bottom: 1px solid #f1f3f5;
        padding: 12px 0;
    }
    .ingredient-name { font-weight: 700; color: #343a40; }
    .ingredient-amount { color: #868e96; text-align: right; }
    .step-item {
        display: grid;
        grid-template-columns: 82px 1fr;
        gap: 22px;
        padding: 26px 0;
        border-bottom: 1px solid #f1f3f5;
    }
    .step-item:last-child { border-bottom: 0; }
    .step-no {
        width: 72px;
        height: 72px;
        border-radius: 50%;
        background: #dc3545;
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        font-weight: 800;
    }
    .step-content {
        font-size: 1.05rem;
        color: #343a40;
        white-space: pre-line;
        margin-bottom: 16px;
    }
    .step-img {
        width: 100%;
        max-width: 680px;
        border-radius: 8px;
        border: 1px solid #e9ecef;
        object-fit: cover;
    }
    @media (max-width: 768px) {
        .recipe-hero-body,
        .recipe-view-section { padding: 24px 18px; }
        .recipe-title { font-size: 1.55rem; }
        .ingredient-list { grid-template-columns: 1fr; }
        .step-item { grid-template-columns: 1fr; gap: 12px; }
        .step-no { width: 58px; height: 58px; font-size: 1rem; }
    }
</style>

<div class="recipe-view-wrap">
    <article class="recipe-hero">
        <c:choose>
            <c:when test="${not empty recipe.thumbnail}">
                <img class="recipe-hero-img"
                     src="${pageContext.request.contextPath}${recipe.thumbnail}"
                     alt="${fn:escapeXml(recipe.title)}">
            </c:when>
            <c:otherwise>
                <div class="recipe-hero-empty"><i class="bi bi-image"></i></div>
            </c:otherwise>
        </c:choose>

        <div class="recipe-hero-body">
            <div class="text-danger fw-bold mb-2">
                <c:out value="${recipe.categoryName}" />
            </div>

            <h2 class="recipe-title"><c:out value="${recipe.title}" /></h2>
            <div class="recipe-desc"><c:out value="${recipe.description}" /></div>

            <div class="text-muted">
                by <strong><c:out value="${recipe.nickname}" /></strong>
                <span class="mx-2">|</span>
                조회수 <c:out value="${recipe.viewCount}" />
            </div>

            <div class="recipe-meta-list">
                <div class="recipe-meta-item">
                    <i class="bi bi-people"></i>
                    <c:out value="${recipe.servings}" />인분
                </div>

                <div class="recipe-meta-item">
                    <i class="bi bi-clock"></i>
                    <c:out value="${recipe.cookTime}" />분
                </div>

                <div class="recipe-meta-item">
                    <i class="bi bi-bar-chart"></i>
                    <c:choose>
                        <c:when test="${recipe.difficulty == 1}">쉬움</c:when>
                        <c:when test="${recipe.difficulty == 2}">보통</c:when>
                        <c:otherwise>어려움</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </article>

    <section class="recipe-view-section">
        <h3>재료</h3>

        <div class="ingredient-list">
            <c:forEach var="ingredient" items="${ingredients}">
                <div class="ingredient-item">
                    <span class="ingredient-name"><c:out value="${ingredient.name}" /></span>
                    <span class="ingredient-amount"><c:out value="${ingredient.amount}" /></span>
                </div>
            </c:forEach>
        </div>
    </section>

    <section class="recipe-view-section">
        <h3>조리순서</h3>

        <c:forEach var="step" items="${steps}">
            <div class="step-item">
                <div class="step-no">Step<br><c:out value="${step.stepNo}" /></div>

                <div>
                    <div class="step-content"><c:out value="${step.content}" /></div>

                    <c:if test="${not empty step.imageUrl}">
                        <img class="step-img"
                             src="${pageContext.request.contextPath}${step.imageUrl}"
                             alt="Step ${step.stepNo} 이미지">
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </section>

    <div class="d-flex justify-content-between align-items-center mb-5">
        <a href="${pageContext.request.contextPath}/recipe/list"
           class="btn btn-outline-secondary px-4">
            목록
        </a>

        <c:if test="${not empty sessionScope.loginUser}">
            <c:if test="${isAuthor}">
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/recipe/edit?recipe_id=${recipe.recipeId}"
                       class="btn btn-outline-danger px-4">
                        수정
                    </a>

                    <form action="${pageContext.request.contextPath}/recipe/delete"
                          method="post"
                          onsubmit="return confirm('정말 삭제하시겠습니까?');">

                        <input type="hidden" name="recipe_id" value="${recipe.recipeId}">

                        <button type="submit" class="btn btn-danger px-4">
                            삭제
                        </button>
                    </form>
                </div>
            </c:if>
        </c:if>
    </div>
</div>

<!-- ================= 댓글 ================= -->
<div class="section-card mb-5 p-4" style="max-width:980px; margin:0 auto;">

    <h4 class="mb-4">
        <i class="bi bi-chat-dots text-danger me-2"></i>
        댓글
    </h4>

    <c:if test="${not empty sessionScope.loginUser}">
        <div class="mb-4">
            <div class="mb-3">
                <label class="form-label">별점</label>

                <div style="display:flex; align-items:center; gap:15px;">
                    <div id="starRating" style="font-size:32px; color:#ffc107;">
                        ★★★★★
                    </div>

                    <strong id="ratingText" style="font-size:20px;">
                        5.0
                    </strong>

                    <div style="display:flex; flex-direction:column; gap:2px;">
                        <button type="button"
                                onclick="changeRating(0.1)"
                                class="btn btn-secondary btn-sm"
                                style="width:40px;height:28px;padding:0;">
                            ▲
                        </button>

                        <button type="button"
                                onclick="changeRating(-0.1)"
                                class="btn btn-secondary btn-sm"
                                style="width:40px;height:28px;padding:0;">
                            ▼
                        </button>
                    </div>
                </div>

                <input type="hidden" id="commentRating" value="5.0">
            </div>

            <textarea id="commentContent"
                      class="form-control"
                      rows="3"
                      placeholder="댓글을 입력하세요"></textarea>

            <button type="button"
                    class="btn btn-danger mt-2"
                    onclick="addRecipeComment()">
                댓글 등록
            </button>
        </div>
    </c:if>

    <div id="commentList">
        <!-- AJAX 댓글 출력 -->
    </div>
</div>

<script>
const recipeId = "${recipe.recipeId}";
const contextPath = "${pageContext.request.contextPath}";
const loginUserId = "${sessionScope.loginUser != null ? sessionScope.loginUser.userId : ""}";

window.onload = function() {
    loadRecipeComments();
};

function loadRecipeComments() {
    fetch(contextPath + "/review/list?recipe_id=" + recipeId)
        .then(response => response.json())
        .then(data => {
            let html = "";

            data.forEach(function(comment) {
                const isReply = comment.parentReviewId != null;
                const marginStyle = isReply ? "margin-left:40px;" : "";

                html +=
                    '<div class="border-bottom py-3" style="' + marginStyle + '" id="comment-' + comment.reviewId + '">';

                if (!isReply && comment.rating != null) {
                    html += '<div class="text-warning mb-1">⭐ ' + comment.rating + ' / 5.0</div>';
                }

                html +=
                    '<div class="d-flex justify-content-between">' +
                        '<strong>' + (isReply ? "↳ " : "") + comment.nickname + '</strong>' +
                        '<small class="text-muted">' + comment.createdAt + '</small>' +
                    '</div>' +

                    '<div class="mt-2" id="comment-content-' + comment.reviewId + '">' +
                        comment.content +
                    '</div>';

                html += '<div class="mt-2">';

                if (loginUserId !== "" && !isReply) {
                    html +=
                        '<button type="button" class="btn btn-sm btn-outline-primary me-2" ' +
                            'onclick="showReplyForm(' + comment.reviewId + ')">' +
                            '답글' +
                        '</button>';
                }

              if (loginUserId !== "" && loginUserId === comment.userId) {
                    html +=
                      //  '<button type="button" class="btn btn-sm btn-outline-secondary me-2" ' +
                        //    'onclick="showEditComment(' + comment.reviewId + ')">' +
                     //       '수정' +
                    //    '</button>' +

                        '<button type="button" class="btn btn-sm btn-outline-danger" ' +
                            'onclick="deleteRecipeComment(' + comment.reviewId + ')">' +
                            '삭제' +
                        '</button>';
                }

                html += '</div>';

                if (!isReply) {
                    html +=
                        '<div id="reply-form-' + comment.reviewId + '" class="mt-3" style="display:none;">' +
                            '<textarea id="reply-content-' + comment.reviewId + '" class="form-control" rows="2" placeholder="답글을 입력하세요"></textarea>' +
                            '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="addReplyComment(' + comment.reviewId + ')">답글 등록</button>' +
                            '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="hideReplyForm(' + comment.reviewId + ')">취소</button>' +
                        '</div>';
                }

                html += '</div>';
            });

            document.getElementById("commentList").innerHTML = html;
        });
}

function addRecipeComment() {
    const content = document.getElementById("commentContent").value.trim();
    const rating = document.getElementById("commentRating").value;

    if (content === "") {
        alert("댓글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/review/list", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "action=insert" +
              "&recipe_id=" + recipeId +
              "&rating=" + encodeURIComponent(rating) +
              "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            document.getElementById("commentContent").value = "";
            loadRecipeComments();
        } else {
            alert("댓글 등록 실패: " + result);
        }
    });
}

function showReplyForm(reviewId) {
    document.getElementById("reply-form-" + reviewId).style.display = "block";
}

function hideReplyForm(reviewId) {
    document.getElementById("reply-form-" + reviewId).style.display = "none";
}

function addReplyComment(parentReviewId) {
    const content = document.getElementById("reply-content-" + parentReviewId).value.trim();

    if (content === "") {
        alert("답글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/review/list", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "action=insert" +
              "&recipe_id=" + recipeId +
              "&parentReviewId=" + parentReviewId +
              "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            loadRecipeComments();
        } else {
            alert("답글 등록 실패: " + result);
        }
    });
}

function showEditComment(reviewId) {
    const contentDiv = document.getElementById("comment-content-" + reviewId);
    const oldContent = contentDiv.innerText;

    contentDiv.innerHTML =
        '<textarea id="edit-comment-' + reviewId + '" class="form-control" rows="3">' +
            oldContent +
        '</textarea>' +
        '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="updateRecipeComment(' + reviewId + ')">저장</button>' +
        '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="loadRecipeComments()">취소</button>';
}

function updateRecipeComment(reviewId) {
    const content = document.getElementById("edit-comment-" + reviewId).value.trim();

    if (content === "") {
        alert("댓글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/review/list", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "action=update" +
              "&review_id=" + reviewId +
              "&rating=5.0" +
              "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            loadRecipeComments();
        } else {
            alert("댓글 수정 실패: " + result);
        }
    });
}

function deleteRecipeComment(reviewId) {
    if (!confirm("댓글을 삭제하시겠습니까?")) {
        return;
    }

    fetch(contextPath + "/review/list", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "action=delete&review_id=" + reviewId
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            loadRecipeComments();
        } else {
            alert("댓글 삭제 실패: " + result);
        }
    });
}

function changeRating(amount) {
    let rating = parseFloat(document.getElementById("commentRating").value);
    rating = Math.round((rating + amount) * 10) / 10;

    if (rating < 0.1) rating = 0.1;
    if (rating > 5.0) rating = 5.0;

    document.getElementById("commentRating").value = rating.toFixed(1);
    document.getElementById("ratingText").innerText = rating.toFixed(1);

    updateStars(rating);
}

function updateStars(rating) {
    const fullStars = Math.floor(rating);
    let stars = "";

    for (let i = 1; i <= 5; i++) {
        stars += i <= fullStars ? "★" : "☆";
    }

    document.getElementById("starRating").innerText = stars;
}
</script>