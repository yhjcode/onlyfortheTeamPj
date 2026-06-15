<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테마 수정하기</title>
</head>
<body class="bg-light">

<div class="container py-5">
    <h2 class="mb-4">테마 수정</h2>
    <div class="row">
        <div class="col-md-7">
            <form action="${pageContext.request.contextPath}/theme/updateAction" method="POST" enctype="multipart/form-data">
                
                <input type="hidden" name="themeId" value="${theme.themeId}">
                <input type="hidden" name="oldThumbnail" value="${theme.thumbnail}">

                <div class="mb-3">
                    <label class="form-label">테마 제목 *</label>
                    <input type="text" name="title" id="input-title" class="form-control" value="${theme.title}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">부제목</label>
                    <input type="text" name="subtitle" id="input-subtitle" class="form-control" value="${theme.subtitle}">
                </div>
                <div class="mb-3">
                    <label class="form-label">이미지 업로드 (변경 시 선택)</label>
                    <input type="file" name="thumbnail" id="input-img" class="form-control" accept="image/*">
                </div>
                <div class="mb-3">
                    <label class="form-label">테마 상세 내용</label>
                    <textarea name="content" id="input-content" class="form-control" rows="5">${theme.description}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">수정 완료</button>
            </form>
        </div>

        <div class="col-md-5">
            <h5>실시간 미리보기</h5>
            <div class="card shadow-sm">
                <img id="preview-img" 
                     src="${not empty theme.thumbnail ? pageContext.request.contextPath.concat('/resources/upload/theme/').concat(theme.thumbnail) : 'https://via.placeholder.com/400x200'}" 
                     class="card-img-top" alt="미리보기">
                <div class="card-body">
                    <h5 id="preview-title" class="card-title">${theme.title}</h5>
                    <h6 id="preview-subtitle" class="card-subtitle mb-2 text-muted">${theme.subtitle}</h6>
                    <p id="preview-content" class="card-text" style="white-space: pre-wrap;">${theme.description}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. 제목 동기화
    document.getElementById('input-title').addEventListener('input', function(e) {
        document.getElementById('preview-title').innerText = e.target.value;
    });

    // 2. ★ 부제목 동기화 코드 추가
    document.getElementById('input-subtitle').addEventListener('input', function(e) {
        document.getElementById('preview-subtitle').innerText = e.target.value;
    });

    // 3. 내용 동기화
    document.getElementById('input-content').addEventListener('input', function(e) {
        document.getElementById('preview-content').innerText = e.target.value;
    });

    // 4. 이미지 미리보기
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