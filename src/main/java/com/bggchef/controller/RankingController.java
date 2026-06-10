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
import com.bggchef.dto.ChefRankingDTO;
import com.bggchef.dto.RecipeDTO;

/**
 * 랭킹 페이지 컨트롤러
 * URL: /ranking/* — 레시피 랭킹 + 셰프 랭킹을 한 페이지에 표시
 */
@WebServlet("/ranking/*")
public class RankingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int TOP_N = 100;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            RankingDAO dao = new RankingDAO();

            List<RecipeDTO>     recipesByView   = dao.selectRecipesByViewCount(TOP_N);
            List<RecipeDTO>     recipesByRating = dao.selectRecipesByRating(TOP_N);
            List<ChefRankingDTO> chefsByView    = dao.selectChefsByTotalView(TOP_N);
            List<ChefRankingDTO> chefsByRating  = dao.selectChefsByAvgRating(TOP_N);

            req.setAttribute("recipesByView",   recipesByView);
            req.setAttribute("recipesByRating", recipesByRating);
            req.setAttribute("chefsByView",     chefsByView);
            req.setAttribute("chefsByRating",   chefsByRating);

        } catch (SQLException e) {
            throw new ServletException("랭킹 데이터 조회 실패", e);
        }

        req.setAttribute("menu", "ranking");
        req.setAttribute("contentPage", "/WEB-INF/views/ranking/daily.jsp");
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}
