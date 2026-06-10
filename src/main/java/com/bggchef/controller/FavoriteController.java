package com.bggchef.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.bggchef.dao.FavoriteDAO;
import com.bggchef.dto.UserDTO;

/**
 * 즐겨찾기 토글 (AJAX)
 * POST /favorite/toggle?recipeId={id}
 * 응답: {"favorited": true|false} 또는 {"error": "login_required"}
 */
@WebServlet("/favorite/toggle")
public class FavoriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("application/json; charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            res.getWriter().write("{\"error\":\"login_required\"}");
            return;
        }

        String recipeIdParam = req.getParameter("recipeId");
        if (recipeIdParam == null || recipeIdParam.isEmpty()) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"missing_recipeId\"}");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        long recipeId = Long.parseLong(recipeIdParam);

        try {
            boolean favorited;
            if (favoriteDAO.existsByUserAndRecipe(loginUser.getUserId(), recipeId)) {
                favoriteDAO.delete(loginUser.getUserId(), recipeId);
                favorited = false;
            } else {
                favoriteDAO.insert(loginUser.getUserId(), recipeId);
                favorited = true;
            }
            res.getWriter().write("{\"favorited\":" + favorited + "}");
        } catch (Exception e) {
            e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            res.getWriter().write("{\"error\":\"server_error\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}
