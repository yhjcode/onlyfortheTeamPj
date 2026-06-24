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
        
        word-break: break-all;      /*  텍스트가 박스 안에서만 출력되도록 세팅 */
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
                閲覧数 <c:out value="${recipe.viewCount}" />
            </div>

            <div class="recipe-meta-list">
                <div class="recipe-meta-item">
                    <i class="bi bi-people"></i>
                    <c:out value="${recipe.servings}" />人前
                </div>

                <div class="recipe-meta-item">
                    <i class="bi bi-clock"></i>
                    <c:out value="${recipe.cookTime}" />分
                </div>

                <div class="recipe-meta-item">
                    <i class="bi bi-bar-chart"></i>
                    <c:choose>
                        <c:when test="${recipe.difficulty == 1}">簡単</c:when>
                        <c:when test="${recipe.difficulty == 2}">普通</c:when>
                        <c:otherwise>難しい</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </article>

    <section class="recipe-view-section">
        <h3>食材</h3>

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
        <h3>調理手順</h3>

        <c:forEach var="step" items="${steps}">
            <div class="step-item">
                <div class="step-no">Step<br><c:out value="${step.stepNo}" /></div>

                <div>
                    <div class="step-content"><c:out value="${step.content}" /></div>

                    <c:if test="${not empty step.imageUrl}">
                        <img class="step-img"
                             src="${pageContext.request.contextPath}${step.imageUrl}"
                             alt="Step ${step.stepNo} 画像">
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </section>

    <div class="d-flex justify-content-between align-items-center mb-5">
        <a href="${pageContext.request.contextPath}/category/list"
           class="btn btn-outline-secondary px-4">
            一覧
        </a>

        <c:if test="${not empty sessionScope.loginUser}">
            <c:if test="${isAuthor}">
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/recipe/edit?recipe_id=${recipe.recipeId}"
                       class="btn btn-outline-danger px-4">
                        編集
                    </a>

                    <form action="${pageContext.request.contextPath}/recipe/delete"
                          method="post"
                          onsubmit="return confirm('本当に削除しますか？');">

                        <input type="hidden" name="recipe_id" value="${recipe.recipeId}">

                        <button type="submit" class="btn btn-danger px-4">
                            削除
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
        コメント
    </h4>

    <c:if test="${not empty sessionScope.loginUser}">
        <div class="mb-4">
            <div class="mb-3">
                <label class="form-label">評価</label>

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
                      placeholder="コメントを入力してください"></textarea>

            <button type="button"
                    class="btn btn-danger mt-2"
                    onclick="addRecipeComment()">   
                コメントを投稿
            </button>
        </div>
    </c:if>

    <div id="commentList">        <%-- AJAX 댓글 출력 메서드  --%>
     
    </div>
</div>

<script>
const recipeId = "${recipe.recipeId}"; // 서버의 recipe객체에서 recipeid에 해당하는 getter메서드를 찾아 호출 후 리턴값을 저장
const contextPath = "${pageContext.request.contextPath}"; // 이 사이트의 컨텍스트 패스를 저장(자바에서 제공하는 컨텍스트패스 객체를 이용)
const loginUserId = "${sessionScope.loginUser != null ? sessionScope.loginUser.userId : ""}"; // 자바의 삼항연산자를 EL로 표현/ 로그인 되어있으면 유저아이디를 getter로 가져오고 아니면 ""저장

window.onload = function() { // js와 크롬 연결
    loadRecipeComments();
};

function loadRecipeComments() {
    fetch(contextPath + "/review/list?recipe_id=" + recipeId)
    //fetch(`${contextPath}/review/list?recipe_id=${recipeId}`) //템플릿 리터럴
    
        .then(response => response.json())                                          // 응답받은 json을 자바스크립트 배열(작성자id/댓글내용/별점 등 댓글테이블 행)단위로 data에 저장
        .then(data => {
            let html = "";

            
            // 받은json의 수만큼 반복하며 조건문의 충족여부에(댓글json인지 대댓글json인지) 따라 선택적으로 html을 누적해나간다
            
            
            
            data.forEach(function(comment) {                                       // json의 개수만큼 comment 함수 실행(let html에 분기결과에 따라 누적)
                const isReply = comment.parentReviewId != null;               //isReply = boolean / 즉 null이아니면 true(대댓글) / 이 json이 대댓글인지 댓글인지 확인
                const marginStyle = isReply ? "margin-left:40px;" : "";          //대댓글이면 마진값으로 댓글과 간격으로 구분

                html +=
                    '<div class="border-bottom py-3" style="' + marginStyle + '" id="comment-' + comment.reviewId + '">';

                if (!isReply && comment.rating != null) {                         //이json이 댓글json이면 별점세팅 태그를 html에 누적
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

                if (loginUserId !== "" && !isReply) {                                                        // 로그인도 됐고 대댓글도 아니라면
                    html +=
                        '<button type="button" class="btn btn-sm btn-outline-primary me-2" ' +
                            'onclick="showReplyForm(' + comment.reviewId + ')">' +                 //返信버튼을 띄우고 이걸 누르면 showReplyForm(' + comment.reviewId + ')메서드 호출
                            '返信' +
                        '</button>';
                }

                if (loginUserId !== "" && loginUserId === comment.userId) { // 로그인을 했고 로그인유저의 id가 이 json이 갖고있는 userid와 문자가 일치하고 자료형도 일치하는가?
                    html +=                                                                                                                                             //(로그인한 유저와 이 댓글을 쓴 유저가 같은 사람인지 확인)
                        '<button type="button" class="btn btn-sm btn-outline-secondary me-2" ' +
                            'onclick="showEditComment(' + comment.reviewId + ')">' +
                            '編集' +
                        '</button>' +                                                       // 맞으면 편집, 삭제버튼도 추가로 송출

                        '<button type="button" class="btn btn-sm btn-outline-danger" ' +
                            'onclick="deleteRecipeComment(' + comment.reviewId + ')">' +
                            '削除' +
                        '</button>';
                }

                html += '</div>';

                if (!isReply) {                                                                // 이 json이 댓글이라면 실행
                    html +=
                        '<div id="reply-form-' + comment.reviewId + '" class="mt-3" style="display:none;">' +
                            '<textarea id="reply-content-' + comment.reviewId + '" class="form-control" rows="2" placeholder="返信を入力してください"></textarea>' +
                            '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="addReplyComment(' + comment.reviewId + ')">返信する</button>' +
                            '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="hideReplyForm(' + comment.reviewId + ')">キャンセル</button>' +
                        '</div>';
                }

                html += '</div>';
            });

            document.getElementById("commentList").innerHTML = html;                 // html로 누적받은 태그들을 id = commentlist인 태그에 뿌림
        });
}




function addRecipeComment() {   //댓글 작성메서드 
    const content = document.getElementById("commentContent").value.trim();           //textarea에 입력받은 댓글내용 앞뒤 공백 제거 후 const content 에 저장
    const rating = document.getElementById("commentRating").value;                       //별점데이터 저장

    if (content === "") {
        alert("コメントを入力してください。");                                                      // 댓글이 없으면 경고알림
        return;
    }

    fetch(contextPath + "/review/list", {                                                          //서버의 컨트롤러에 dopost/reivew/list매핑값을 찾아서 해더에 해당하는 데이터 형식으로 바디값을 전송
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: "action=insert" +
              "&recipe_id=" + recipeId +
              "&rating=" + encodeURIComponent(rating) +
              "&content=" + encodeURIComponent(content)
    })
    
    
    
    //응답
    .then(response => response.text())                 // db 댓글테이블에 저장 성공했는지 실패했는지 텍스트로 구분
    .then(result => {
        if (result.trim() === "success") {
            document.getElementById("commentContent").value = "";  // 성공했으면 textarea는 비우고 하단에 댓글,대댓글 목록 뿌림
            loadRecipeComments();
        } else {
            alert("コメントの投稿に失敗しました：" + result);  // 서버로부터의 응답이 "success"가 아니면 실패매세지 알람, 원인을 result에 저장후 출력
        }
    });
}



function showReplyForm(reviewId) { // 返信버튼을 클릭하면 해당 댓글id에 해당하는 대댓글 입력창이 뜸(style.display = "block";으로 숨김해제)
    document.getElementById("reply-form-" + reviewId).style.display = "block";
}

function hideReplyForm(reviewId) { // 캔슬버튼 눌렀을떄 
    document.getElementById("reply-form-" + reviewId).style.display = "none";
}

function addReplyComment(parentReviewId) {   // 댓글의 대댓글을 작성하는 메서드
    const content = document.getElementById("reply-content-" + parentReviewId).value.trim();

    if (content === "") {
        alert("返信を入力してください。");
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
            alert("返信の投稿に失敗しました：" + result);
        }
    });
}





function showEditComment(reviewId) {           // 댓글 편집버튼을 클릭했을때 호출되는 메서드
	
	
	const buttons = event.target.parentElement;
	buttons.style.display = "none";                                  // 편집버튼 눌렀을때 하단에 보존,켄슬만 남기고 삭제,편집버튼은 지우도록 수정한 부븐
	
	
    const contentDiv = document.getElementById("comment-content-" + reviewId);  // 기존 댓글을 contentDiv에 저장
    const oldContent = contentDiv.innerText; // contentDiv를 oldContent 에 백업

    contentDiv.innerHTML =
        '<textarea id="edit-comment-' + reviewId + '" class="form-control" rows="3">' +    // contentDiv에 아래 html태그를 저장(수정전용 html태그들)
            oldContent +
        '</textarea>' +
        '<button type="button" class="btn btn-sm btn-danger mt-2 me-2" onclick="updateRecipeComment(' + reviewId + ')">保存</button>' +
        '<button type="button" class="btn btn-sm btn-secondary mt-2" onclick="loadRecipeComments()">キャンセル</button>';
}





function updateRecipeComment(reviewId) {                        //댓글 편집버튼을 눌렀을때 편집메서드에 의해 호출된 보존버튼을 클릭하면 호출되는 수정한 댓글내용 저장메서드
    const content = document.getElementById("edit-comment-" + reviewId).value.trim(); // 수정받은 댓글내용을 앞뒤 공백 제거후 const content에 저장

    if (content === "") {
        alert("コメントを入力してください。");
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
            loadRecipeComments();                                 // 수정한 댓글이 db댓글 테이블에 저장됐으면 댓글목록을 뿌리는 메서드 호출로 댓글목록 리셋
        } else {
            alert("コメントの編集に失敗しました：" + result);
        }
    });
}





function deleteRecipeComment(reviewId) {  // 로그인 했고 로그인 세션의 userid == json데이터 내부 userid와 같을 경우 보여지는 편집,삭제 버튼중 삭제버튼을 클릭 한 순간 호출되는 삭제메서드
    if (!confirm("コメントを削除しますか？")) {
        return;                                              //confirm메세지에서 취소를 누르면 이 삭제메서드 중지(return)
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
            loadRecipeComments();                       // review id에 해당하는 행을 삭제 성공했으면 댓글 목록을 새로고침(페이지새로고침x)
        } else {
            alert("コメントの削除に失敗しました：" + result);
        }
    });
}




function changeRating(amount) { //별점 수정
    let rating = parseFloat(document.getElementById("commentRating").value);
    rating = Math.round((rating + amount) * 10) / 10;

    if (rating < 0.1) rating = 0.1;
    if (rating > 5.0) rating = 5.0;

    document.getElementById("commentRating").value = rating.toFixed(1);
    document.getElementById("ratingText").innerText = rating.toFixed(1);

    updateStars(rating);
}

function updateStars(rating) {  //별점
    const fullStars = Math.floor(rating);
    let stars = "";

    for (let i = 1; i <= 5; i++) {
        stars += i <= fullStars ? "★" : "☆";
    }

    document.getElementById("starRating").innerText = stars;
}
</script>