<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <h2 class="mb-4 fw-bold">테마 요리 등록</h2>
    
    <form action="${pageContext.request.contextPath}/theme/write" method="post" enctype="multipart/form-data">
        <!-- Card-style form container -->
        <div class="card shadow-sm border-0" style="border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05) !important;">
            <div class="card-body p-4">
                <div class="row g-4">
                    <!-- 왼쪽: 이미지 영역 -->
                    <div class="col-md-4">
                        <label for="thumbnail" class="w-100 h-100 border-0 rounded-3 d-flex align-items-center justify-content-center bg-light" style="height: 250px; cursor: pointer; background-color: #f8f9fa !important;">
                            <div class="text-center text-muted">
                                <i class="bi bi-image" style="font-size: 3rem;"></i>
                                <div class="mt-2">대표 이미지 선택</div>
                            </div>
                            <input type="file" name="thumbnail" id="thumbnail" class="d-none">
                        </label>
                    </div>
                    
                    <!-- 오른쪽: 입력 영역 -->
                    <div class="col-md-8">
                        <div class="mb-3">
                            <input type="text" name="title" class="form-control border-0 bg-transparent px-0" 
                                   style="font-size: 1.5rem; font-weight: 700;" placeholder="요리 제목을 입력하세요">
                        </div>
                        <div class="mb-0">
                            <textarea name="description" class="form-control border-0 bg-transparent px-0" 
                                      rows="7" placeholder="요리 소개글을 입력하세요" style="resize: none;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <button type="submit" class="btn btn-danger btn-lg px-5">등록 완료</button>
            <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg px-5 ms-2">취소</a>
        </div>
    </form>
</div>
