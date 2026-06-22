<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<jsp:include page="header.jsp"/>
<div class="text-center py-5">
    <h1 class="display-4 text-danger">エラーが発生しました</h1>
    <p class="lead text-muted">しばらくしてからもう一度お試しください。</p>
    <a href="${pageContext.request.contextPath}/main" class="btn btn-danger">トップへ戻る</a>
</div>
<jsp:include page="footer.jsp"/>
