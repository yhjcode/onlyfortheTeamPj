<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <div class="d-flex justify-content-end mb-3">
        <a href="${pageContext.request.contextPath}/theme/write" class="btn btn-outline-primary">おすすめテーマを作成</a>
    </div>
    <div class="section-card mb-4">
        <h2 class="section-title">
            <span class="accent">おすすめ</span>テーマリスト
        </h2>
        <p class="text-muted mt-2">プロシェフたちがおすすめする様々なテーマ別レシピをご覧ください！</p>

        <div class="row g-4 mt-2">
            <c:forEach var="theme" items="${themeList}">
                <div class="col-md-4 col-lg-3">
                    <div class="recipe-card shadow-soft" onclick="location.href='${pageContext.request.contextPath}/theme/view?themeId=${theme.themeId}'">
                        <div class="recipe-card-img-wrap">
                            <c:choose>
                            <c:when test="${not empty theme.thumbnail}">
                                <img src="${pageContext.request.contextPath}${theme.thumbnail}" class="recipe-card-img" alt="${theme.title}">
                                
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
                                <span><i class="bi bi-eye"></i> 閲覧数 ${theme.viewCount}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty themeList}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted">登録されたおすすめテーマがありません。</p>
                </div>
            </c:if>
        </div>
    </div>
</div>