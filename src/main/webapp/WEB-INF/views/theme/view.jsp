<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 테마 상단 정보 -->
<div class="text-center mb-5">
    <h2 class="fw-bold mb-3" style="font-size: 2.5rem;">
        <span class="text-danger">Theme:</span> ${theme.title}
    </h2>

    <%-- 테마 대표 이미지는 있을 때만 출력 --%>
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

<!-- 테마 수정 / 삭제 버튼: 테마 작성자만 -->
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

        <%-- 로그인한 사람은 누구나 자기 레시피 추가 가능 --%>
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
    <div class="mb-5 p-4 bg-light rounded-4">
        <c:choose>
            <c:when test="${not empty theme.description}">
                ${theme.description}
            </c:when>
            <c:otherwise>
                테마 소개글을 준비 중입니다.
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 레시피가 없을 때 -->
    <c:if test="${empty recipeList}">
        <div class="text-center text-muted py-5">
            아직 추가된 레시피가 없습니다.<br>
            내 레시피 추가 버튼을 눌러 레시피를 추가해보세요.
        </div>
    </c:if>

    <!-- 레시피 목록 -->
    <c:forEach var="recipe" items="${recipeList}">
        <div class="mb-5 pb-5 position-relative"
             style="border-bottom: 2px solid #eaeaea !important;">

            <!-- 기존 레시피 이미지: 있을 때만 출력 -->
            <c:if test="${not empty recipe.thumbnail}">
                <div class="text-center mb-4">
                    <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}">
                        <img src="${pageContext.request.contextPath}/resources/upload/recipe/${recipe.thumbnail}"
                             alt="${recipe.title}"
                             style="max-width: 300px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                    </a>
                </div>
            </c:if>

            <!-- 레시피 소개 수정 / 삭제: 해당 레시피를 추가한 사용자만 -->
            <c:if test="${not empty loginUser and loginUser.userId eq recipe.userId}">
                <div class="position-absolute" style="top: 0; right: 0;">
                    <button type="button"
                            class="btn btn-sm btn-outline-secondary me-2"
                            onclick="location.href='${pageContext.request.contextPath}/theme/editRecipeInfo?themeId=${theme.themeId}&recipeId=${recipe.recipeId}'">
                        소개 수정
                    </button>

                    <form action="${pageContext.request.contextPath}/theme/removeRecipe"
                          method="post"
                          class="d-inline">
                        <input type="hidden" name="themeId" value="${theme.themeId}">
                        <input type="hidden" name="recipeId" value="${recipe.recipeId}">

                        <button type="submit"
                                class="btn btn-sm btn-outline-danger"
                                onclick="return confirm('이 요리를 테마에서 제거하시겠습니까?');">
                            X 삭제
                        </button>
                    </form>
                </div>
            </c:if>

            <div class="text-center">
                <h4>
                    <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}"
                       class="text-decoration-none text-dark">
                        ${recipe.title}
                    </a>
                </h4>

                <!-- 테마에 추가할 때 입력한 소개글 -->
                <p class="text-muted mt-3"
                   style="font-size: 1.1rem; white-space: pre-wrap;">
                    <c:choose>
                        <c:when test="${not empty recipe.description}">
                            ${recipe.description}
                        </c:when>
                        <c:otherwise>
                            작성된 소개글이 없습니다.
                        </c:otherwise>
                    </c:choose>
                </p>

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

function loadThemeComments() {
    fetch(contextPath + "/theme/comment/list?themeId=" + themeId)
        .then(response => response.json())
        .then(data => {
            let html = "";

            data.forEach(function(comment) {
            	const isReply = comment.parentReviewId != null;
                const marginStyle = isReply ? "margin-left:40px;" : "";

                html +=
                    '<div class="border-bottom py-3" style="' + marginStyle + '" id="comment-' + comment.commentId + '">' +
                        '<div class="d-flex justify-content-between">' +
                            '<strong>' + (isReply ? "↳ " : "") + comment.nickname + '</strong>' +
                            '<small class="text-muted">' + comment.createdAt + '</small>' +
                        '</div>' +

                        '<div class="mt-2" id="comment-content-' + comment.commentId + '">' +
                            comment.content +
                        '</div>';

                html += '<div class="mt-2">';

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

                html +=
                    '<div id="reply-form-' + comment.commentId + '" class="mt-3" style="display:none;">' +
                        '<textarea id="reply-content-' + comment.commentId + '" class="form-control" rows="2" placeholder="답글을 입력하세요"></textarea>' +
                        '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="addReplyComment(' + comment.commentId + ')">답글 등록</button>' +
                        '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="hideReplyForm(' + comment.commentId + ')">취소</button>' +
                    '</div>';

                html += '</div>';
            });

            document.getElementById("commentList").innerHTML = html;
        });
}

function addThemeComment() {
    const content = document.getElementById("commentContent").value.trim();

    if (content === "") {
        alert("댓글을 입력하세요.");
        return;
    }

    fetch(contextPath + "/theme/comment/add", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "themeId=" + themeId + "&content=" + encodeURIComponent(content)
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "success") {
            document.getElementById("commentContent").value = "";
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
    const oldContent = contentDiv.innerText;

    contentDiv.innerHTML =
        '<textarea id="edit-comment-' + commentId + '" class="form-control" rows="3">' +
            oldContent +
        '</textarea>' +
        '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="updateThemeComment(' + commentId + ')">저장</button>' +
        '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="loadThemeComments()">취소</button>';
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
        body: "commentId=" + commentId + "&content=" + encodeURIComponent(content)
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