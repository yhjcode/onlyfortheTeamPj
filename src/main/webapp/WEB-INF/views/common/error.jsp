<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<jsp:include page="header.jsp"/>
<div class="text-center py-5">
    <h1 class="display-4 text-danger">앗! 문제가 발생했어요</h1>
    <p class="lead text-muted">잠시 후 다시 시도해주세요.</p>
    <a href="${pageContext.request.contextPath}/main" class="btn btn-danger">메인으로</a>
</div>
<jsp:include page="footer.jsp"/>
