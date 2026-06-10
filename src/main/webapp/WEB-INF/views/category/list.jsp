<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <div class="section-card mb-4">
        <h2 class="section-title">
            레시피 <span class="accent">분류</span>
        </h2>
        <p class="text-muted mt-2">다양한 카테고리별로 원하는 레시피를 찾아보세요.</p>
    </div>

    <div class="row g-4">
        <c:forEach var="l" items="${listL}">
            <div class="col-12">
                <div class="section-card">
                    <h4 class="mb-4 pb-2 border-bottom">
                        <i class="bi bi-tag-fill text-danger me-2"></i>${l.name}
                    </h4>
                    <div class="d-flex flex-wrap gap-2">
                        <c:forEach var="m" items="${mapM[l.categorylId]}">
                            <a href="${pageContext.request.contextPath}/recipe/list?categorymId=${m.categorymId}" 
                               class="category-chip">
                                ${m.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>