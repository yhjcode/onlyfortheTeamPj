<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테마 작성하기</title>
    <style>
        .recipe-item { border: 1px solid #ddd; padding: 10px; margin: 5px 0; border-radius: 5px; display: flex; justify-content: space-between; align-items: center; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <h2 class="mb-4">테마 작성</h2>
    <div class="row">
        <div class="col-md-7">
            <form action="${pageContext.request.contextPath}/theme/writeAction" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">테마 제목 *</label>
                    <input type="text" name="title" id="input-title" class="form-control" placeholder="제목을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">부제목</label>
                    <input type="text" name="subtitle" id="input-subtitle" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">포함할 레시피</label>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="openRecipePopup()">레시피 선택하기</button>
                    <div id="selectedRecipes" class="mt-2">
                        </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">이미지 업로드</label>
                    <input type="file" name="thumbnail" id="input-img" class="form-control" accept="image/*">
                </div>
                <div class="mb-3">
                    <label class="form-label">테마 상세 내용</label>
                    <textarea name="content" id="input-content" class="form-control" rows="5"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">등록</button>
            </form>
        </div>

        <div class="col-md-5">
            <h5>실시간 미리보기</h5>
            <div class="card shadow-sm">
                <img id="preview-img" src="https://via.placeholder.com/400x200" class="card-img-top" alt="미리보기">
                <div class="card-body">
                    <h5 id="preview-title" class="card-title">제목이 여기에 표시됩니다</h5>
                    <p id="preview-content" class="card-text" style="white-space: pre-wrap;">작성한 내용이 여기에 나타납니다.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. 레시피 선택 팝업 열기
    function openRecipePopup() {
        window.open('${pageContext.request.contextPath}/theme/myRecipeList', 'recipePopup', 'width=600,height=500,scrollbars=yes');
    }

    // 2. 팝업에서 호출할 함수 (선택한 레시피 목록 추가)
    function addRecipeToList(recipeId, title) {
        // 중복 체크
        if(document.getElementById('rec-' + recipeId)) {
            alert("이미 추가된 요리입니다.");
            return;
        }
        
        let container = document.getElementById('selectedRecipes');
        let div = document.createElement('div');
        div.id = 'rec-' + recipeId;
        div.className = "recipe-item";
        div.innerHTML = title + 
            '<input type="hidden" name="recipeIds" value="' + recipeId + '">' +
            '<button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove()">삭제</button>';
        container.appendChild(div);
    }

    // 3. 기존 미리보기 스크립트
    document.getElementById('input-title').addEventListener('input', function(e) {
        document.getElementById('preview-title').innerText = e.target.value;
    });

    document.getElementById('input-content').addEventListener('input', function(e) {
        document.getElementById('preview-content').innerText = e.target.value;
    });

    document.getElementById('input-img').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.getElementById('preview-img').src = event.target.result;
            }
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>