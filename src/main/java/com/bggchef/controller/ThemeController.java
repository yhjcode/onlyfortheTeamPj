package com.bggchef.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bggchef.dao.ThemeDAO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;

/**
 * 추천테마 (REQ_REC_013)
 * URL: /theme/list, /theme/view
 */
@WebServlet({"/theme/list", "/theme/view"})
public class ThemeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ThemeDAO themeDAO = new ThemeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        String path = req.getServletPath();
        req.setAttribute("menu", "theme");
        
        try {
            if ("/theme/list".equals(path)) {
                List<ThemeDTO> themeList = themeDAO.list();
                req.setAttribute("themeList", themeList);
                req.setAttribute("contentPage", "/WEB-INF/views/theme/list.jsp");
            } else if ("/theme/view".equals(path)) {
                int themeId = Integer.parseInt(req.getParameter("themeId"));
                
                // 조회수 증가
                themeDAO.updateViewCount(themeId);
                
                ThemeDTO theme = themeDAO.selectById(themeId);
                List<RecipeDTO> recipeList = themeDAO.getRecipesByThemeId(themeId);
                
                req.setAttribute("theme", theme);
                req.setAttribute("recipeList", recipeList);
                req.setAttribute("contentPage", "/WEB-INF/views/theme/view.jsp");
            }
            
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            
        } catch (SQLException | NumberFormatException e) {
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
