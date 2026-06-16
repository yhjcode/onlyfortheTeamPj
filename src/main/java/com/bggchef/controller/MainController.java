package com.bggchef.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bggchef.dao.RankingDAO;
import com.bggchef.dao.RecipeDAO;
import com.bggchef.dao.ThemeDAO;
import com.bggchef.dto.ChefRankingDTO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;

@WebServlet("/main")
public class MainController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            RecipeDAO recipeDAO   = new RecipeDAO();
            RankingDAO rankingDAO = new RankingDAO();
            ThemeDAO themeDAO     = new ThemeDAO();

            List<RecipeDTO>      topRatedRecipes = rankingDAO.selectRecipesByRating(10);
            List<RecipeDTO>      latestRecipes   = recipeDAO.selectLatest(10);
            List<ChefRankingDTO> chefRanking     = rankingDAO.selectChefsByAvgRating(10);
            List<ThemeDTO>       themes          = themeDAO.selectTop(10);

            req.setAttribute("topRatedRecipes", topRatedRecipes);
            req.setAttribute("latestRecipes",   latestRecipes);
            req.setAttribute("chefRanking",     chefRanking);
            req.setAttribute("themes",          themes);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.setAttribute("contentPage", "/WEB-INF/views/main/index.jsp");
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
    }
}
