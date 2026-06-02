<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<h2 class="mb-4">레시피 작성</h2>
<form action="${pageContext.request.contextPath}/recipe/write" method="post" enctype="multipart/form-data">
    <!-- TODO: 제목 / 카테고리 / 썸네일 / 재료(동적 추가) / 단계(동적 추가) -->
    <button type="submit" class="btn btn-danger">등록</button>
</form>
