package com.bggchef.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 레시피 CRUD (REQ_REC_011)
 * URL: /recipe/list
 */
@WebServlet("/recipe/list")
public class RecipeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // TODO: 비즈니스 로직 + DAO 호출 + request 속성 set
        req.setAttribute("contentPage", "/WEB-INF/views/recipe/list.jsp");
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // 기본은 doGet으로 위임. POST 동작이 다르면 분리 구현
        doGet(req, res);
    }
}
