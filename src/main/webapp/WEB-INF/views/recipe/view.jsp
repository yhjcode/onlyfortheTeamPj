<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
//////////////////////////q박병준
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
    <c:if test="${not empty sessionScope.loginUser}">
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/recipe/edit?recipe_id=${recipe.recipeId}" class="btn btn-outline-danger px-4">수정</a>
            
            <form action="${pageContext.request.contextPath}/recipe/delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="recipe_id" value="${recipe.recipeId}">
                <button type="submit" class="btn btn-danger px-4">삭제</button>
            </form>
        </div>
    </c:if>
</div>



</div>

<!-- ================= [댓글 기능 구현 구역] ================= -->
<div class="container mt-5" style="max-width: 800px;">
    <h4 class="mb-4">📢 레시피 리뷰 / 댓글</h4>
    
    <!-- 댓글 작성 양식 -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h6 class="card-title fw-bold mb-3">리뷰 작성하기</h6>
            <div class="row g-2 mb-2">
                <!-- 평점 선택 (1점 ~ 5점) -->
                <div class="col-md-3">
                    <select id="review-rating" class="form-select">
                        <option value="5.0">⭐⭐⭐⭐⭐ (5점)</option>
                        <option value="4.0">⭐⭐⭐⭐ (4점)</option>
                        <option value="3.0">⭐⭐⭐ (3점)</option>
                        <option value="2.0">⭐⭐ (2점)</option>
                        <option value="1.0">⭐ (1점)</option>
                    </select>
                </div>
                <!-- 댓글 내용 입력창 -->
                <div class="col-md-9">
                    <textarea id="review-content" class="form-control" rows="2" placeholder="이 레시피에 대한 솔직한 리뷰를 남겨주세요!"></textarea>
                </div>
            </div>
            <div class="text-end">
                <button type="button" id="btn-submit-review" class="btn btn-primary px-4">등록</button>
            </div>
        </div>
    </div>
    
    <!-- 댓글 목록이 동적으로 출력될 단 하나의 영역 -->
    <div id="review-list-container" class="mb-4">
        <!-- Ajax 통신 후 자바스크립트가 여기에 댓글 카드를 채워 넣습니다. -->
    </div>
</div>

<!-- 부트스트랩 아이콘 스타일시트 경로 정상 수정 완료 -->
<link rel="stylesheet" href="https://jsdelivr.net">

<script>
// 페이지 로드가 완료되면 실행
document.addEventListener("DOMContentLoaded", function() {
    var currentRecipeId = "${recipe.recipeId}";
    
    // 1. 최초 목록 로드 호출
    loadReviews(currentRecipeId);
    
    // 2. 등록 버튼 클릭 이벤트 연결
    var submitBtn = document.getElementById("btn-submit-review");
    if (submitBtn) {
        submitBtn.addEventListener("click", function() {
            var contentInput = document.getElementById("review-content");
            var ratingInput = document.getElementById("review-rating");
            
            var content = contentInput.value.trim();
            var rating = ratingInput.value;
            
            if (!content) {
                alert("리뷰 내용을 입력해주세요.");
                contentInput.focus();
                return;
            }
            
            // 순수 자바스크립트 Form 데이터 조립
            var params = new URLSearchParams();
            params.append("recipe_id", currentRecipeId);
            params.append("content", content);
            params.append("rating", rating);
            
            // Fetch API를 이용한 Ajax POST 요청
            fetch("${pageContext.request.contextPath}/review/list", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: params.toString()
            })
            .then(function(response) { return response.text(); }) // 응답을 텍스트로 변환
            .then(function(result) {
                // 서블릿에서 넘어온 결과 텍스트의 공백 제거 후 비교
                if (result.trim() === "success") {
                    alert("리뷰가 등록되었습니다!");
                    contentInput.value = ""; // 입력창 비우기
                    loadReviews(currentRecipeId); // 목록 실시간 새로고침
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

// 댓글 목록을 불러오는 함수 (Fetch API 버전)
function loadReviews(recipeId) {
    fetch("${pageContext.request.contextPath}/review/list?recipe_id=" + recipeId)
        .then(function(response) { return response.json(); }) // 응답을 JSON 배열 객체로 변환
        .then(function(responseList) {
            var container = document.getElementById("review-list-container");
            var html = "";
            
            if (responseList.length > 0) {
                // 순수 자바스크립트 반복문 처리
                responseList.forEach(function(review) {
                    html += '<div class="card mb-3 shadow-sm">';
                    html += '  <div class="card-body">';
                    html += '    <div class="d-flex justify-content-between align-items-center mb-2">';
                    html += '      <div>';
                    html += '        <strong class="text-primary">' + review.nickname + '</strong> ';
                    html += '        <span class="text-muted small">(' + review.userId + ')</span>';
                    html += '      </div>';
                    html += '      <small class="text-secondary">' + review.createdAt + '</small>';
                    html += '    </div>';
                    html += '    <div class="mb-2 text-warning">';
                    html += '       <i class="bi bi-star-fill"></i> 평점: ' + parseFloat(review.rating).toFixed(1);
                    html += '    </div>';
                    html += '    <p class="card-text text-dark" style="white-space: pre-wrap;">' + review.content + '</p>';
                    html += '  </div>';
                    html += '</div>';
                });
            } else {
                html += '<div class="text-center py-4 text-muted border rounded bg-light">';
                html += '  <p class="mb-0">아직 작성된 리뷰가 없습니다. 첫 리뷰를 작성해 보세요!</p>';
                html += '</div>';
            }
            
            container.innerHTML = html; // 화면에 삽입
        })
        .catch(function(error) {
            console.error("리뷰 목록 로딩 실패 원인: ", error);
            document.getElementById("review-list-container").innerHTML = '<p class="text-danger">리뷰를 불러오는 중 오류가 발생했습니다.</p>';
        });
}
</script>
<!-- ======================================================== -->
