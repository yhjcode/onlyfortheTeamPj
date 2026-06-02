package com.bggchef.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 메인페이지 컨트롤러 (REQ_REC_001)
 * - 별점순 / 최신순 / 셰프랭킹 3개 섹션 데이터 준비
 * URL: /main
 */
@WebServlet("/main")
public class MainController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // TODO: RecipeDAO에서 별점순 TOP10, 최신순 TOP10, 셰프랭킹 TOP10 조회
        // req.setAttribute("topRatedRecipes", recipeDAO.selectTopRated(10));
        // req.setAttribute("latestRecipes",   recipeDAO.selectLatest(10));
        // req.setAttribute("chefRanking",     userDAO.selectChefRanking(10));

        req.setAttribute("contentPage", "/WEB-INF/views/main/index.jsp");
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
    }
}
