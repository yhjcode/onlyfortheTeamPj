package com.bggchef.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bggchef.dao.RecipeDAO;
import com.bggchef.dao.ThemeDAO;
import com.bggchef.dao.UserDAO;
import com.bggchef.dto.UserDTO;
import com.bggchef.service.UserService;

@WebServlet("/chef/profile")
public class ChefController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String targetUserId = req.getParameter("userId");
        if (targetUserId == null || targetUserId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/main");
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            UserDTO chefUser = userDAO.selectById(targetUserId);
            if (chefUser == null) {
                resp.sendRedirect(req.getContextPath() + "/main");
                return;
            }

            RecipeDAO recipeDAO = new RecipeDAO();
            ThemeDAO  themeDAO  = new ThemeDAO();

            req.setAttribute("chefUser",    chefUser);
            req.setAttribute("chefIntro",   userService.getIntro(targetUserId));
            req.setAttribute("chefRecipes", recipeDAO.selectByUserId(targetUserId));
            req.setAttribute("chefThemes",  themeDAO.selectByUserId(targetUserId));

            // 로그인한 사용자가 본인 프로필을 보는지 여부
            HttpSession session = req.getSession(false);
            UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;
            boolean isOwner = loginUser != null && loginUser.getUserId().equals(targetUserId);
            req.setAttribute("isOwner", isOwner);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("contentPage", "/WEB-INF/views/chef/profile.jsp");
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);
    }
}
