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
            <c:when test="${not empty recipe.thumbnail}"> <%--썸네일이미지가 있을땐 송출 --%>
                <img class="recipe-hero-img" src="${pageContext.request.contextPath}${recipe.thumbnail}" alt="${fn:escapeXml(recipe.title)}">
            </c:when>
            <c:otherwise>
                <div class="recipe-hero-empty"><i class="bi bi-image"></i></div> <%--없을땐 부트스트랩 이미지로 대체 --%>
            </c:otherwise>
        </c:choose>

        <div class="recipe-hero-body">
            <div class="text-danger fw-bold mb-2">
                <c:out value="${recipe.categoryName}" />  
            </div>
            <h2 class="recipe-title"><c:out value="${recipe.title}" /></h2>
            <div class="recipe-desc"><c:out value="${recipe.description}" /></div> 
            <div class="text-muted">   <%-- 텍스트 색을 연하게 만드는 부트스트랩 --%>
                by <strong><c:out value="${recipe.nickname}" /></strong>
                <span class="mx-2">|</span>
                조회수 <c:out value="${recipe.viewCount}" />               <%--       레시피정보:이름,설명,작성자이름등을 출력함   --%>
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
        </div>                                                                            <%--       레시피정보:몇인분인지,몇분걸리는지 요리난이도 등을 출력함   --%>
    </article> <%----------------------- 뷰페이지 첫번째 박스 끝--%>
    
    

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
    </section>          <%--       재료정보:  재료 종류, 수량  등을 출력함   --%>
    <%----------------------- 뷰페이지 두번째 박스 끝--%>
    
    

    <section class="recipe-view-section">
        <h3>조리순서</h3>
        <c:forEach var="step" items="${steps}">    <%--레시피에 존재하는 step수만큼 반복하며 순서번호,스텝당 설명, 사진을 모두 송출 --%>
            <div class="step-item">
                <div class="step-no">Step<br><c:out value="${step.stepNo}" /></div>
                <div>
                    <div class="step-content"><c:out value="${step.content}" /></div>
                    <c:if test="${not empty step.imageUrl}">
                        <img class="step-img" src="${pageContext.request.contextPath}${step.imageUrl}" alt="Step ${step.stepNo} 이미지">
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </section>  
        <%----------------------- 뷰페이지 세번째 박스 끝--%>



    <div class="d-flex justify-content-between align-items-center mb-5">
    <a href="${pageContext.request.contextPath}/recipe/list" class="btn btn-outline-secondary px-4">목록</a>
    
    <%-- 로그인 상태(sessionScope.loginUser가 비어있지 않을 때)일 때만 수정/삭제 버튼 박스를 출력 --%>
    <%-- 권한이 허가된 작성자 본인에게만 본문 수정/삭제 인터페이스 출력 --%>
<c:if test="${isAuthor}">
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/recipe/edit?recipe_id=${recipe.recipeId}" class="btn btn-outline-danger px-4">수정</a>
        
        <form action="${pageContext.request.contextPath}/recipe/delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
            <input type="hidden" name="recipe_id" value="${recipe.recipeId}">
            <button type="submit" class="btn btn-danger px-4">삭제</button>
        </form>
    </div>
</c:if>
    
    <%-- <c:if test="${not empty sessionScope.loginUser}">
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/recipe/edit?recipe_id=${recipe.recipeId}" class="btn btn-outline-danger px-4">수정</a>
            
            <form action="${pageContext.request.contextPath}/recipe/delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="recipe_id" value="${recipe.recipeId}">
                <button type="submit" class="btn btn-danger px-4">삭제</button>
            </form>
        </div>
    </c:if>--%>
</div>



</div>

<!-- ================= [댓글 기능 구현 구역] ================= -->
<div class="container mt-5" style="max-width: 800px;">
    <h4 class="mb-4">📢 레시피 리뷰 </h4>
    
    <!-- 댓글 작성 양식 -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h6 class="card-title fw-bold mb-3">리뷰 작성하기</h6>
            <div class="row g-2 mb-2">
                <!-- 평점 선택 (1점 ~ 5점) -->
                <div class="col-md-3">
                    <select id="review-rating" class="form-select">    <!--  평점 드롭다운 / review-rating아이디로 Ajax 연결    -->
                        <option value="5.0">⭐⭐⭐⭐⭐ (5점)</option>
                        <option value="4.0">⭐⭐⭐⭐ (4점)</option>
                        <option value="3.0">⭐⭐⭐ (3점)</option>
                        <option value="2.0">⭐⭐ (2점)</option>
                        <option value="1.0">⭐ (1점)</option>
                    </select>
                </div>
                <!-- 댓글 내용 입력창 -->
                <div class="col-md-9">                            <!--  리뷰 내용 입력  / review-content아익디로 Ajax 연결 -->
                    <textarea id="review-content" class="form-control" rows="2" placeholder="이 레시피에 대한 솔직한 리뷰를 남겨주세요!"></textarea> 
                </div>
            </div>
            <div class="text-end">
                <button type="button" id="btn-submit-review" class="btn btn-primary px-4">등록</button><!-- btn-submit-review에의해 등록버튼을 클릭하는 순간 Ajax 함수 호출됨 -->
            </div>
        </div>
    </div>
    
    <!-- json에서 파싱한 댓글목록을 이 div 박스에서 뿌림-->
    <div id="review-list-container" class="mb-4">  <!--  review-list-container 아이디로 Ajax함수 리턴값을 수신. -->
        
    </div>
</div>

<!-- 부트스트랩 아이콘 스타일시트 경로 정상 수정 완료 -->
<!-- <link rel="stylesheet" href="https://jsdelivr.net">-->






<script>
// 세션의 로그인 유저 ID 동기화 처리
const currentUserId = '${sessionScope.loginUser != null ? sessionScope.loginUser.userId : ""}';

document.addEventListener("DOMContentLoaded", function() {   // html페이지 로드가 완료되면 실행
    var currentRecipeId = "${recipe.recipeId}"; 
    
    // 댓글 목록 불러오기 실행
    if (currentRecipeId) {
        loadReviews(currentRecipeId);    
    }
    
    var submitBtn = document.getElementById("btn-submit-review"); 
    if (submitBtn) {
        submitBtn.addEventListener("click", function() {
            var contentInput = document.getElementById("review-content");
            var ratingInput = document.getElementById("review-rating");
            
            var content = contentInput.value.trim(); 
            var rating = ratingInput.value;
            
            if (!currentUserId) {
                alert("로그인이 필요한 서비스입니다.");
                return;
            }
            
            if (!content) {
                alert("리뷰 내용을 입력해주세요.");
                contentInput.focus();
                return;
            }
            
            var params = new URLSearchParams(); 
            params.append("action", "insert"); // 등록 구분자 명시
            params.append("recipe_id", currentRecipeId); 
            params.append("content", content);
            params.append("rating", rating);
            
            fetch("${pageContext.request.contextPath}/review/list", {  
                method: "POST", 
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded" 
                },
                body: params.toString() 
            })
            .then(function(response) { return response.text(); })        
            .then(function(result) {                                           
                if (result.trim() === "success") {
                    alert("리뷰가 등록되었습니다!");
                    contentInput.value = ""; 
                    loadReviews(currentRecipeId); 
                } else {
                    alert("등록에 실패했습니다. 서버 메시지: " + result);
                }
            })
            .catch(function(error) {
                console.error("리뷰 등록 실패: ", error);
            });
        });
    }
});

// 댓글 목록을 불러오는 함수
function loadReviews(recipeId) {
    fetch("${pageContext.request.contextPath}/review/list?recipe_id=" + recipeId)  
        .then(function(response) { return response.json(); }) 
        .then(function(responseList) {                           
            var container = document.getElementById("review-list-container");
            var html = "";
            
            if (responseList.length > 0) { 
                responseList.forEach(function(review) {  
                    html += '<div class="card mb-3 shadow-sm" id="review-card-' + review.reviewId + '">';
                    html += '  <div class="card-body">';
                    html += '    <div class="d-flex justify-content-between align-items-center mb-2">';
                    html += '      <div>';
                    html += '        <strong class="text-primary">' + review.nickname + '</strong> ';
                    html += '        <span class="text-muted small">(' + review.userId + ')</span>';
                    html += '      </div>';
                    html += '      <small class="text-secondary">' + review.createdAt + '</small>';
                    html += '    </div>';
                    
                    // 기본 텍스트 영역
                    html += '    <div id="display-area-' + review.reviewId + '">';
                    html += '      <div class="mb-2 text-warning">';
                    html += '         <i class="bi bi-star-fill"></i> 평점: ' + parseFloat(review.rating).toFixed(1);
                    html += '      </div>';
                    html += '      <p class="card-text text-dark" style="white-space: pre-wrap;">' + review.content + '</p>';
                    html += '    </div>';
                    
                    // 숨겨진 수정 폼 영역
                    html += '    <div id="edit-area-' + review.reviewId + '" class="d-none mt-2">';
                    html += '      <div class="row g-2 mb-2">';
                    html += '        <div class="col-md-3">';
                    html += '          <select id="edit-rating-' + review.reviewId + '" class="form-select form-select-sm">';
                    html += '            <option value="5.0">⭐⭐⭐⭐⭐ (5점)</option>';
                    html += '            <option value="4.0">⭐⭐⭐⭐ (4점)</option>';
                    html += '            <option value="3.0">⭐⭐⭐ (3점)</option>';
                    html += '            <option value="2.0">⭐⭐ (2점)</option>';
                    html += '            <option value="1.0">⭐ (1점)</option>';
                    html += '          </select>';
                    html += '        </div>';
                    html += '        <div class="col-md-9">';
                    html += '          <textarea id="edit-content-' + review.reviewId + '" class="form-control form-control-sm" rows="2">' + review.content + '</textarea>';
                    html += '        </div>';
                    html += '      </div>';
                    html += '      <div class="text-end">';
                    html += '        <button type="button" class="btn btn-sm btn-success me-1 px-3" onclick="submitUpdate(' + review.reviewId + ', ' + recipeId + ')">수정완료</button>';
                    html += '        <button type="button" class="btn btn-sm btn-secondary px-3" onclick="toggleEditMode(' + review.reviewId + ', false)">취소</button>';
                    html += '      </div>';
                    html += '    </div>';
                    
                    // 권한 비교 검증 조건문 (글자 그대로 일치 유도)
                    if (currentUserId !== "" && currentUserId === review.userId) {
                        html += '    <div class="text-end mt-2" id="btn-group-' + review.reviewId + '">';
                        html += '      <button type="button" class="btn btn-sm btn-outline-secondary me-1 py-0 px-2" onclick="toggleEditMode(' + review.reviewId + ', true)">수정</button>';
                        html += '      <button type="button" class="btn btn-sm btn-outline-danger py-0 px-2" onclick="deleteReview(' + review.reviewId + ', ' + recipeId + ')">삭제</button>';
                        html += '    </div>';
                    }
                    
                    html += '  </div>';
                    html += '</div>';         
                });                              
            } else {
                html += '<div class="text-center py-4 text-muted border rounded bg-light">';
                html += '  <p class="mb-0">아직 작성된 리뷰가 없습니다. 첫 리뷰를 작성해 보세요!</p>';
                html += '</div>';
            }
            
            container.innerHTML = html; 
        })
        .catch(function(error) {
            console.error("리뷰 목록 로딩 실패 원인: ", error);
        });
}

// 수정 모드 활성화/비활성화 토글
function toggleEditMode(reviewId, isEdit) {
    var displayArea = document.getElementById("display-area-" + reviewId);
    var editArea = document.getElementById("edit-area-" + reviewId);
    var btnGroup = document.getElementById("btn-group-" + reviewId);
    
    if (isEdit) {
        displayArea.classList.add("d-none");
        if(btnGroup) btnGroup.classList.add("d-none");
        editArea.classList.remove("d-none");
    } else {
        displayArea.classList.remove("d-none");
        if(btnGroup) btnGroup.classList.remove("d-none");
        editArea.classList.add("d-none");
    }
}

// 수정 완료 전송
function submitUpdate(reviewId, recipeId) {
    var contentInput = document.getElementById("edit-content-" + reviewId);
    var ratingInput = document.getElementById("edit-rating-" + reviewId);
    
    var content = contentInput.value.trim();
    var rating = ratingInput.value;
    
    if (!content) {
        alert("수정할 내용을 입력해 주세요.");
        contentInput.focus();
        return;
    }
    
    var params = new URLSearchParams();
    params.append("action", "update"); // 수정 작업 표시
    params.append("review_id", reviewId);
    params.append("content", content);
    params.append("rating", rating);
    
    fetch("${pageContext.request.contextPath}/review/list", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: params.toString()
    })
    .then(function(response) { return response.text(); })
    .then(function(result) {
        if (result.trim() === "success") {
            alert("리뷰가 수정되었습니다.");
            loadReviews(recipeId); 
        } else {
            alert("수정에 실패했습니다. 서버 메시지: " + result);
        }
    })
    .catch(function(error) {
        console.error("리뷰 수정 오류: ", error);
    });
}

// 삭제 처리 전송
function deleteReview(reviewId, recipeId) {
    if (!confirm("정말로 이 리뷰를 삭제하시겠습니까?")) {
        return; 
    }
    
    var params = new URLSearchParams();
    params.append("action", "delete"); // 삭제 작업 표시
    params.append("review_id", reviewId);
    
    fetch("${pageContext.request.contextPath}/review/list", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: params.toString()
    })
    .then(function(response) { return response.text(); })
    .then(function(result) {
        if (result.trim() === "success") {
            alert("리뷰가 삭제되었습니다.");
            loadReviews(recipeId); 
        } else {
            alert("삭제에 실패했습니다. 서버 메시지: " + result);
        }
    })
    .catch(function(error) {
        console.error("리뷰 삭제 오류: ", error);
    });
}
</script>


<!-- ======================================================== -->
