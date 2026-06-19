<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <div class="d-flex justify-content-end mb-3">
        <a href="${pageContext.request.contextPath}/theme/write" class="btn btn-outline-primary">레시피 작성</a>
    </div>
    <div class="section-card mb-4">
        <h2 class="section-title">
            <span class="accent">추천</span> 테마 리스트
        </h2>
        <p class="text-muted mt-2">전문 셰프들이 추천하는 다양한 테마별 레시피를 만나보세요!</p>

        <div class="row g-4 mt-2">
            <c:forEach var="theme" items="${themeList}">
                <div class="col-md-4 col-lg-3">
                    <div class="recipe-card shadow-soft" onclick="location.href='${pageContext.request.contextPath}/theme/view?themeId=${theme.themeId}'">
                        <div class="recipe-card-img-wrap">
                            <c:choose>
                            <c:when test="${not empty theme.thumbnail}">
                                <img src="${pageContext.request.contextPath}/resources/upload/theme/${theme.thumbnail}" class="recipe-card-img" alt="${theme.title}">
                                
                            </c:when>
                            <c:otherwise>
                                <img src="https://picsum.photos/seed/theme${theme.themeId}/400/300" class="recipe-card-img" alt="${theme.title}">
                            </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="recipe-card-body">
                            <h5 class="recipe-card-title">${theme.title}</h5>
                            <p class="recipe-meta text-truncate">${theme.description}</p>
                            <div class="recipe-meta mt-2">
                                <span><i class="bi bi-eye"></i> 조회수 ${theme.viewCount}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty themeList}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted">등록된 추천 테마가 없습니다.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>