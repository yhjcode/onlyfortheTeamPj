<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <h2 class="mb-4 fw-bold">레시피 작성</h2>
    
    <form action="${pageContext.request.contextPath}/recipe/write" method="post" enctype="multipart/form-data">
        <!-- Card-style form container with shadow and radius -->
        <div class="card shadow-sm border-0" style="border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.08) !important;">
            <div class="card-body p-4">
                <div class="row g-4">
                    <!-- 이미지 영역 (왼쪽) -->
                    <div class="col-md-4">
                        <label for="thumbnail" class="w-100 h-100 border rounded-3 d-flex align-items-center justify-content-center bg-light cursor-pointer" style="height: 250px; cursor: pointer;">
                            <div class="text-center text-muted">
                                <i class="bi bi-image" style="font-size: 3rem;"></i>
                                <div class="mt-2">이미지 업로드</div>
                            </div>
                            <input type="file" name="thumbnail" id="thumbnail" class="d-none">
                        </label>
                    </div>
                    
                    <!-- 입력 영역 (오른쪽) -->
                    <div class="col-md-8">
                        <div class="mb-3">
                            <label for="title" class="form-label fw-bold">요리 제목</label>
                            <input type="text" name="title" id="title" class="form-control" placeholder="요리 제목을 입력하세요" required>
                        </div>
                        <div class="mb-0">
                            <label for="description" class="form-label fw-bold">요리 소개</label>
                            <textarea name="description" id="description" class="form-control" rows="6" placeholder="이 요리에 대한 간단한 소개를 적어주세요."></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <button type="submit" class="btn btn-danger btn-lg px-5">등록</button>
            <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg px-5 ms-2">취소</a>
        </div>
    </form>
</div>
