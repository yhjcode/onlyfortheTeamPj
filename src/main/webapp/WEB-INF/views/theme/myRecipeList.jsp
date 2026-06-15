<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 레시피 선택</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; border: 1px solid #ddd; text-align: center; }
        /* 링크 스타일 유지 */
        .recipe-link { color: #333; text-decoration: none; font-weight: bold; }
        .recipe-link:hover { text-decoration: underline; color: #007bff; }
    </style>
</head>
<body>
    <h3>내 레시피 선택</h3>
    <table>
        <thead>
            <tr>
                <th>요리 제목</th>
                <th>테마 소개글</th>
                <th>선택</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty myRecipeList}">
                    <c:forEach var="recipe" items="${myRecipeList}">
                        <tr>
                            <td>
                                <%-- [수정] 상세 페이지 링크 추가 --%>
                                <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}" 
                                   target="_blank" class="recipe-link">
                                    ${recipe.title}
                                </a>
                            </td>
                            <td>
                                <input type="text" id="desc_${recipe.recipeId}" placeholder="이 테마에서의 소개글">
                            </td>
                            <td>
                                <button type="button" onclick="selectRecipe('${recipe.recipeId}', '${recipe.title}')">
                                    선택
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="3">등록된 레시피가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    <br>
    <button type="button" onclick="window.close()">닫기</button>

    <script>
        function selectRecipe(recipeId, title) {
            let description = document.getElementById('desc_' + recipeId).value;
            
            if (window.opener && !window.opener.closed) {
                // 부모 창의 addRecipeWithDesc 함수 호출
                window.opener.addRecipeWithDesc(recipeId, title, description);
                window.close();
            } else {
                alert("부모 페이지가 연결되어 있지 않습니다.");
            }
        }
    </script>
</body>
</html>