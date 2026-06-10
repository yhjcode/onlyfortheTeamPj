<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="com.bggchef.dao.SearchDAO" %>
<%@ page import="com.bggchef.dto.RecipeDTO" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<%
    String serchType = request.getParameter("searchType");
    String keyword = request.getParameter("keyword");
	
    List<RecipeDTO> arrRecipe = new ArrayList<RecipeDTO>();
    
    if (keyword == null || keyword.trim().equals("")) { 
%>
    <script type="text/javascript">
	alert("검색어를 입력해 주세요!");
	history.go(-1);
	</script>
<%
    } else {
        SearchDAO dao = new SearchDAO();

        if(serchType.equals("recipe")){									
            arrRecipe = dao.searchRecipe(keyword);
%>	
    <section class="section-card position-relative">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="section-title">
                <i class="bi bi-search text-danger me-2"></i> 
                '<span class="accent"><%= keyword %></span>' 검색 결과
            </h3>
            <span class="text-muted">총 <%= (arrRecipe != null) ? arrRecipe.size() : 0 %>개의 레시피</span>
        </div>

        <div class="row g-3">
            <% 
                if (arrRecipe == null || arrRecipe.isEmpty()) { 
            %>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3 text-muted">검색어와 일치하는 레시피가 없습니다.<br>다른 검색어를 입력해 보세요.</p>
                </div>
            <% 
                } else { 
                    for (RecipeDTO recipe : arrRecipe) {
                        
                        String imgUrl = "https://picsum.photos/seed/recipe/400/400";		
                        if (recipe.getThumbnail() != null && !recipe.getThumbnail().trim().isEmpty()) {
                            imgUrl = recipe.getThumbnail();	
                        }
                        
                        String ratingStr = "0.0";	
                        if (recipe.getAvgRating() != null && recipe.getAvgRating() > 0) {
                            ratingStr = String.valueOf(recipe.getAvgRating());	
                        }
            %>
                <div class="col-md-3 col-6">
                    <a href="${pageContext.request.contextPath}/recipe/view?id=<%= recipe.getRecipeId() %>">
                        <div class="recipe-card">
                            <div class="recipe-card-img-wrap">
                                <img class="recipe-card-img" src="<%= imgUrl %>" alt="<%= recipe.getTitle() %>">
                            </div>
                            <div class="recipe-card-body">
                                <h6 class="recipe-card-title"><%= recipe.getTitle() %></h6>
                                <div class="recipe-meta">
                                    <span class="rating">
                                        <i class="bi bi-star-fill"></i> 
                                        <%= ratingStr %>
                                    </span> 
                                    <span><i class="bi bi-eye"></i> <%= recipe.getViewCount() %></span> 
                                    <span><i class="bi bi-person-fill"></i> <%= (recipe.getNickname() != null) ? recipe.getNickname() : "무명셰프" %></span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            <% 
                    }
                } 
            %>
        </div>
    </section>
<%}} 
     %>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>