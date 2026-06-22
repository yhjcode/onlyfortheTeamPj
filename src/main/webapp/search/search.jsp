<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="com.bggchef.dao.SearchDAO" %>
<%@ page import="com.bggchef.dto.RecipeDTO" %>
<%@ page import="com.bggchef.dto.ThemeDTO" %>
<%@ page import="com.bggchef.dto.UserDTO" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="container py-4"> <%
    String serchType = request.getParameter("searchType");
    String keyword = request.getParameter("keyword");
    String chefColor;
    
    //페이징
    String strPage = request.getParameter("page");
    
    int currentPage = 1;
    if(strPage != null && !strPage.trim().equals("")){
    	currentPage = Integer.parseInt(strPage);	// 문자열이기 때문에 숫자로 형변환
    }
    int pageSize = 12;		//화면에 출력할 갯수
    
    List<RecipeDTO> arrRecipe = new ArrayList<RecipeDTO>();
    List<ThemeDTO> arrTheme = new ArrayList<ThemeDTO>();
    List<UserDTO> arrUser = new ArrayList<UserDTO>();
    
    if (keyword == null){
    	keyword = "";
%>
 <%--    <script type="text/javascript">
    alert("검색어를 입력해 주세요!");
    history.go(-1);
    </script>--%>
<%
    } else {
        SearchDAO dao = new SearchDAO();

        // 1. 레시피 검색 구역
        if(serchType.equals("recipe")){									
            int totalCount = dao.getRecipeCount(keyword);
            arrRecipe = dao.searchRecipe(keyword, currentPage, pageSize);
            int pageCount = (int) Math.ceil((double) totalCount / pageSize);
%>		
    <section class="section-card position-relative">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="section-title">
                <i class="bi bi-search text-danger me-2"></i>
                <%if(keyword != ""){ %> 
                '<span class="accent"><%= keyword %></span>' 검색 결과
                <%}else if(keyword == ""){%>
                <span claass="accent">레시피 전체</span> 검색 결과
                <%} %>
            </h3>
            <span class="text-muted">총 <%=totalCount%>개의 레시피</span>
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
        
        <%-- 페이징 번호 --%>
        </div> <% if (totalCount > 0) { // 검색 결과가 있을 때만 버튼그리기 %>
            <div class="pagination-container" style="text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 5px; align-items: center;">
                    <%
                        for (int i = 1; i <= pageCount; i++) {
                            if (i == currentPage) {
                    %>
                                <input type="button" value="<%= i %>" class="active" style="font-weight: bold;" disabled>
                    <%
                            } else {
                    %>
                                <input type="button" value="<%= i %>" onclick="location.href='?searchType=<%= serchType %>&keyword=<%= keyword %>&page=<%= i %>'">
                    <%
                            }
                        }
                    %>
                </div>
        <% } %>
    </section>

<% 
        // 2. 테마 검색 구역
        } else if(serchType.equals("theme")){
            int totalCount = dao.getThemeCount(keyword);
            arrTheme = dao.searchTheme(keyword, currentPage, pageSize);
            int pageCount = (int) Math.ceil((double) totalCount / pageSize);
%>			
	    <section class="section-card position-relative">
	        <div class="d-flex justify-content-between align-items-center mb-4">
	            <h3 class="section-title">
	                <i class="bi bi-search text-danger me-2"></i> 
	                <%if(keyword != ""){ %> 
	                '<span class="accent"><%= keyword %></span>' 검색 결과
	                <%}else if(keyword == ""){%>
	                 <span class="accent">테마 전체</span> 검색 결과
	                 <%} %>
	            </h3>
	            <span class="text-muted">총 <%=totalCount %>개의 테마글</span>
	        </div>

	        <div class="row g-3">
	            <% 
	                if (arrTheme == null || arrTheme.isEmpty()) { 
	            %>
	                <div class="col-12 text-center py-5">
	                    <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
	                    <p class="mt-3 text-muted">검색어와 일치하는 테마가 없습니다.<br>다른 검색어를 입력해 보세요.</p>
	                </div>
	            <% 
	                } else { 
	                    for (ThemeDTO theme : arrTheme) {
	                        String imgUrl = "https://picsum.photos/seed/recipe/400/400";		
	                        if (theme.getThumbnail() != null && !theme.getThumbnail().trim().isEmpty()) {
	                            imgUrl = theme.getThumbnail();	
                        	}
	                        
	                        String viewStr = "0";	
	                        if (theme.getViewCount() > 0) {
	                            viewStr = String.valueOf(theme.getViewCount());	
	                        }
	            %>
	                <div class="col-md-3 col-6">
	                    <a href="${pageContext.request.contextPath}/recipe/view?id=<%= theme.getThemeId() %>">
	                        <div class="recipe-card">
	                            <div class="recipe-card-img-wrap">
	                                <img class="recipe-card-img" src="<%= imgUrl %>" alt="<%= theme.getTitle() %>">
	                            </div>
	                            <div class="recipe-card-body">
	                                <h6 class="recipe-card-title"><%= theme.getTitle() %></h6>
	                                <div class="recipe-meta">
	                                    <span class="rating">
	                                        <i class="bi bi-star-fill"></i> 
	                                        <%= viewStr %>
	                                    </span> 
	                                    <span><i class="bi bi-eye"></i> <%= theme.getViewCount() %></span> 
	                                    <span><i class="bi bi-person-fill"></i> <%= (theme.getNickname() != null) ? theme.getNickname() : "무명셰프" %></span>
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
	        <% if (totalCount > 0) { // 검색 결과가 있을 때만 버튼그리기 %>
           <div class="pagination-container" style="text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 5px; align-items: center;">
                    <%
                        for (int i = 1; i <= pageCount; i++) {
                            if (i == currentPage) {
                    %>
                                <input type="button" value="<%= i %>" class="active" style="font-weight: bold;" disabled>
                    <%
                            } else {
                    %>
                                <input type="button" value="<%= i %>" onclick="location.href='?searchType=<%= serchType %>&keyword=<%= keyword %>&page=<%= i %>'">
                    <%
                            }
                        }
                    %>
                </div>
        <% } %>
	        
	    </section>

<% 
        // 3. 셰프(유저) 검색 구역
        } else if(serchType.equals("user")){							
            int totalCount = dao.getUserCount(keyword);
            arrUser = dao.searchUser(keyword, currentPage, pageSize);
            int pageCount = (int) Math.ceil((double) totalCount / pageSize);
            
%>		
        <section class="section-card position-relative">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="section-title">
                    <i class="bi bi-search text-danger me-2"></i> 
                    <%if(keyword != ""){ %> 
	                '<span class="accent"><%= keyword %></span>' 검색 결과
	                <%}else if(keyword == ""){%>
	                 <span class="accent">셰프 전체</span> 검색 결과
	                 <%} %>
                </h3>
                <span class="text-muted">총 <%=totalCount %>명의 셰프</span>
            </div>

            <div class="row g-3">
                <% 
                    if (arrUser == null || arrUser.isEmpty()) { 
                %>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3 text-muted">검색어와 일치하는 셰프가 없습니다.<br>다른 검색어를 입력해 보세요.</p>
                    </div>
                <% 
                    } else { 
                        for (UserDTO user : arrUser) {
                            String imgUrl = "https://picsum.photos/seed/recipe/400/400";		
                            if (user.getProfileImg() != null && !user.getProfileImg().trim().isEmpty()) {
                                imgUrl = user.getProfileImg();	
                        	}
                            
                            String ratingStr = "0.0";														
                            if (user.getAvgRating() != null && user.getAvgRating() > 0) {
                                ratingStr = String.valueOf(user.getAvgRating());	
                            }
                            
                            chefColor = "#6c757d";
                            if (user.getMedalGrade() != null) {
                                if (user.getMedalGrade().equals("골드")) {
                                   chefColor = "#DAA520";
                                } else if (user.getMedalGrade().equals("실버")) {
                                   chefColor = "#A9A9A9";
                                } else if (user.getMedalGrade().equals("브론즈")) {
                                   chefColor = "#CD7F32";
                                }
                            }
                %>
                    <div class="col-md-3 col-6">
                        <a href="${pageContext.request.contextPath}/recipe/view?id=<%= user.getUserId() %>">
                            <div class="recipe-card">
                                <div class="recipe-card-img-wrap">
                                    <img class="recipe-card-img" src="<%= imgUrl %>" alt="<%= user.getNickname() %>">
                                </div>
                                <div class="recipe-card-body">
                                    <div align="center"><h6 class="recipe-card-title"><%= user.getNickname() %></h6></div>
                                    <div class="recipe-meta">
                                        <span class="rating" align="center">
                                            <i class="bi bi-star-fill"></i> 
                                            <%= ratingStr %>
                                        </span> 
                                        <span><i class="bi bi-award-fill" style="color: <%=chefColor%>"></i> <%= user.getMedalGrade() %></span> 
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                <% 
                        } // for 끝
                    } // inner-else 끝
                %>
            </div>
             <% if (totalCount > 0) { // 검색 결과가 있을 때만 버튼그리기 %>
           <div class="pagination-container" style="text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 5px; align-items: center;">
                    <%
                        for (int i = 1; i <= pageCount; i++) {
                            if (i == currentPage) {
                    %>
                                <input type="button" value="<%= i %>" class="active" style="font-weight: bold;" disabled>
                    <%
                            } else {
                    %>
                                <input type="button" value="<%= i %>" onclick="location.href='?searchType=<%= serchType %>&keyword=<%= keyword %>&page=<%= i %>'">
                    <%
                            }
                        }
                    %>
                </div>
        <% } %> </section> <%
        } // user 검색 종료
    } // user키워드검색 종료
%>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>