package com.bggchef.controller;
import com.bggchef.util.PagingUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bggchef.dao.CategoryDAO;
import com.bggchef.dao.ListDAO;
import com.bggchef.dto.CategoryLDTO;
import com.bggchef.dto.CategoryMDTO;
import com.bggchef.dto.ListDTO;

/**
 * 카테고리 필터/정렬 (REQ_REC_009)
 * URL: /category/list
 */
@WebServlet("/category/list")
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO = new CategoryDAO();
    
   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        req.setAttribute("menu", "category");
        
        try {
            // 모든 대분류 조회
            List<CategoryLDTO> listL = categoryDAO.listL();
            req.setAttribute("listL", listL);
            
            // 대분류별 중분류 맵 구성
            Map<Integer, List<CategoryMDTO>> mapM = new HashMap<>();
            for (CategoryLDTO l : listL) {
                mapM.put(l.getCategorylId(), categoryDAO.listMByLId(l.getCategorylId()));
            }
            req.setAttribute("mapM", mapM);
            //sort로 버튼기능 구현
            
            String sort = req.getParameter("sort");					// /list 일때 버튼누르면 팅기는거 방지하려고 가져옴
            String categoryId = req.getParameter("categoryId");
            String ratingFilter = req.getParameter("ratingFilter");
            
            if(sort == null || sort.trim().isEmpty()) {
            	sort="desc";
            }
            if (categoryId == null || categoryId.trim().isEmpty()) {
                categoryId = "0";
            }
            
            if (ratingFilter == null || ratingFilter.trim().isEmpty()) {
                ratingFilter = "0";
            }
            
            ListDAO dao = new ListDAO();
            
            String strPage = req.getParameter("page");
            int currentPage = (strPage != null && !strPage.equals("")) ? Integer.parseInt(strPage) : 1;
            int totalCount = dao.getTotalCount(categoryId, ratingFilter);
            
           // List<ListDTO> Recipestack = null;
            List<ListDTO> Recipestack = dao.CategorySort(sort, categoryId,ratingFilter ,currentPage, totalCount);
            
            /*
            if("desc".equals(sort)) {
            	Recipestack = dao.descRecipe();
            }else if("view".equals(sort)) {
            	Recipestack = dao.viewcountRecipe();
            }else if("avg".equals(sort)) {
            	Recipestack = dao.avgratingRecipe();
            }else {
            	Recipestack = dao.descRecipe();
            }
            
            
            
            
			List<ListDTO> descRe = dao.descRecipe();
			List<ListDTO> viewcountRe = dao.viewcountRecipe();
			List<ListDTO> avgratingRe = dao.avgratingRecipe();
			
			req.setAttribute("descRe", descRe);
			req.setAttribute("viewcountRe", viewcountRe);
			req.setAttribute("avgratingRe", avgratingRe);
            */
            
            List<ListDTO> button = dao.CategoryButton();
            
            req.setAttribute("button", button);
            
            
            req.setAttribute("paging", new PagingUtil(currentPage, totalCount));
            req.setAttribute("descRe", Recipestack);
            
            
            req.setAttribute("currentsort",sort);
            req.setAttribute("currentcategory",categoryId);
            req.setAttribute("currentRatingFilter", ratingFilter);
            
            
            
            
            req.setAttribute("contentPage", "/WEB-INF/views/category/list.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            
        } catch (SQLException e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}
