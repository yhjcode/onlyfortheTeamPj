package com.bggchef.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bggchef.dao.SearchDAO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
import com.bggchef.dto.UserDTO;

@WebServlet("/search")
public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final SearchDAO searchDAO = new SearchDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String searchType = req.getParameter("searchType");
        String keyword    = req.getParameter("keyword");

        if (searchType == null || searchType.trim().isEmpty()) searchType = "recipe";
        if (keyword    == null) keyword = "";

        String strPage = req.getParameter("page");
        int currentPage = 1;
        if (strPage != null && !strPage.trim().isEmpty()) {
            try { currentPage = Integer.parseInt(strPage); } catch (NumberFormatException ignored) {}
        }
        final int pageSize = 12;

        int totalCount = 0;
        int pageCount  = 0;

        if (!keyword.trim().isEmpty()) {
            if ("recipe".equals(searchType)) {
                totalCount = searchDAO.getRecipeCount(keyword);
                pageCount  = (int) Math.ceil((double) totalCount / pageSize);
                List<RecipeDTO> recipes = searchDAO.searchRecipe(keyword, currentPage, pageSize);
                req.setAttribute("recipes", recipes);

            } else if ("theme".equals(searchType)) {
                totalCount = searchDAO.getThemeCount(keyword);
                pageCount  = (int) Math.ceil((double) totalCount / pageSize);
                List<ThemeDTO> themes = searchDAO.searchTheme(keyword, currentPage, pageSize);
                req.setAttribute("themes", themes);

            } else if ("user".equals(searchType)) {
                totalCount = searchDAO.getUserCount(keyword);
                pageCount  = (int) Math.ceil((double) totalCount / pageSize);
                List<UserDTO> users = searchDAO.searchUser(keyword, currentPage, pageSize);
                req.setAttribute("users", users);
            }
        }

        req.setAttribute("searchType",  searchType);
        req.setAttribute("keyword",     keyword);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("pageCount",   pageCount);
        req.setAttribute("totalCount",  totalCount);

        req.getRequestDispatcher("/WEB-INF/views/search/search.jsp").forward(req, res);
    }
}
