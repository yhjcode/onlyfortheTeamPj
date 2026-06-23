package com.bggchef.controller;

import com.bggchef.dao.RecipeDAO;
import com.bggchef.dao.ReviewDAO;
import com.bggchef.dao.FavoriteDAO;
import com.bggchef.dao.ThemeDAO;
import com.bggchef.util.FileUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.bggchef.dto.UserDTO;
import com.bggchef.service.UserService;
import javax.servlet.annotation.MultipartConfig;

@WebServlet("/user/*")
@MultipartConfig
public class UserController extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getPathInfo();

        if ("/login".equals(action)) {
            req.setAttribute("contentPage", "/WEB-INF/views/user/login.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);

        } else if ("/join".equals(action)) {
            req.setAttribute("contentPage", "/WEB-INF/views/user/join.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);

        } else if ("/mypage".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("loginUser") == null) {
                resp.sendRedirect(req.getContextPath() + "/user/login");
                return;
            }
            UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
            try {
                RecipeDAO recipeDAO     = new RecipeDAO();
                ReviewDAO reviewDAO     = new ReviewDAO();
                FavoriteDAO favoriteDAO = new FavoriteDAO();
                ThemeDAO themeDAO       = new ThemeDAO();
                req.setAttribute("myRecipes",   recipeDAO.selectByUserId(loginUser.getUserId()));
                req.setAttribute("myReviews",   reviewDAO.selectByUserId(loginUser.getUserId()));
                req.setAttribute("repliesToMe", reviewDAO.selectRepliesToMe(loginUser.getUserId()));
                req.setAttribute("myFavorites", favoriteDAO.selectByUserId(loginUser.getUserId()));
                req.setAttribute("myThemes",    themeDAO.selectByUserId(loginUser.getUserId()));
                req.setAttribute("chefIntro",   userService.getIntro(loginUser.getUserId()));
            } catch (Exception e) {
                e.printStackTrace();
            }
            req.setAttribute("contentPage", "/WEB-INF/views/user/mypage.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);

        } else if ("/logout".equals(action)) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/main");

        } else if ("/edit".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("loginUser") == null) {
                resp.sendRedirect(req.getContextPath() + "/user/login");
                return;
            }
            req.setAttribute("contentPage", "/WEB-INF/views/user/userEdit.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);

        } else if ("/withdraw".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("loginUser") == null) {
                resp.sendRedirect(req.getContextPath() + "/user/login");
                return;
            }
            req.setAttribute("contentPage", "/WEB-INF/views/user/withdraw.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);

        } else if ("/checkId".equals(action)) {
            resp.setContentType("application/json; charset=UTF-8");
            String userId = req.getParameter("userId");
            try {
                boolean available = userId != null && !userId.isEmpty()
                        && !new com.bggchef.dao.UserDAO().existsId(userId);
                resp.getWriter().write("{\"available\":" + available + "}");
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("{\"available\":false}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getPathInfo();

        if ("/login".equals(action)) {
            doLogin(req, resp);
        } else if ("/join".equals(action)) {
            doJoin(req, resp);
        } else if ("/edit".equals(action)) {
            doEdit(req, resp);
        } else if ("/withdraw".equals(action)) {
            doWithdraw(req, resp);
        } else if ("/intro".equals(action)) {
            doSaveIntro(req, resp);
        }
    }

    /** 로그인 처리 */
    private void doLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String userId   = req.getParameter("userId");
        String password = req.getParameter("password");
        try {
            UserDTO user = userService.login(userId, password);
            if (user != null) {
                req.getSession().setAttribute("loginUser", user);
                resp.sendRedirect(req.getContextPath() + "/main");
            } else {
                req.setAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
                req.setAttribute("contentPage", "/WEB-INF/views/user/login.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** 회원가입 처리 */
    private void doJoin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UserDTO user = new UserDTO();
        user.setUserId  (req.getParameter("userId"));
        user.setEmail   (req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        user.setNickname(req.getParameter("nickname"));
        String phone = req.getParameter("phone");
        if (phone != null && !phone.isEmpty() && !phone.matches("\\d{3}-\\d{4}-\\d{4}")) {
            req.setAttribute("errorMsg", "電話番号の形式が正しくありません。(例: 010-0000-0000)");
            req.setAttribute("contentPage", "/WEB-INF/views/user/join.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);
            return;
        }
        user.setPhone(phone);

        String birthday = req.getParameter("birthday");
        if (birthday != null && !birthday.isEmpty()) {
            user.setBirthday(java.sql.Date.valueOf(birthday));
        }

        String uploadDir = req.getServletContext().getRealPath("/resources/upload/profile");
        FileUtil.ensureDir(uploadDir);
        Part filePart = req.getPart("profileImg");
        String originalName = filePart != null ? filePart.getSubmittedFileName() : null;
        if (originalName != null && !originalName.isEmpty()) {
            String savedName = FileUtil.generateUniqueFileName(originalName);
            filePart.write(uploadDir + "/" + savedName);
            user.setProfileImg("/resources/upload/profile/" + savedName);
        }

        try {
            boolean success = userService.join(user);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/user/login");
            } else {
                req.setAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
                req.setAttribute("contentPage", "/WEB-INF/views/user/join.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** 회원정보 수정 처리 */
    private void doEdit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        loginUser.setEmail   (req.getParameter("email"));
        loginUser.setNickname(req.getParameter("nickname"));
        String editPhone = req.getParameter("phone");
        if (editPhone != null && !editPhone.isEmpty() && !editPhone.matches("\\d{3}-\\d{4}-\\d{4}")) {
            req.setAttribute("errorMsg", "電話番号の形式が正しくありません。(例: 010-0000-0000)");
            req.setAttribute("contentPage", "/WEB-INF/views/user/userEdit.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);
            return;
        }
        loginUser.setPhone(editPhone);

        String birthday = req.getParameter("birthday");
        if (birthday != null && !birthday.isEmpty()) {
            loginUser.setBirthday(java.sql.Date.valueOf(birthday));
        }

        Part filePart = req.getPart("profileImg");
        String originalName = filePart != null ? filePart.getSubmittedFileName() : null;
        if (originalName != null && !originalName.isEmpty()) {
            String uploadDir = req.getServletContext().getRealPath("/resources/upload/profile");
            FileUtil.ensureDir(uploadDir);
            String savedName = FileUtil.generateUniqueFileName(originalName);
            filePart.write(uploadDir + "/" + savedName);
            loginUser.setProfileImg("/resources/upload/profile/" + savedName);
        }

        try {
            userService.update(loginUser);
            session.setAttribute("loginUser", loginUser);
            resp.sendRedirect(req.getContextPath() + "/user/mypage");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** 셰프 소개글 저장 (AJAX POST, JSON 응답) */
    private void doSaveIntro(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json; charset=UTF-8");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.getWriter().write("{\"ok\":false,\"msg\":\"로그인이 필요합니다.\"}");
            return;
        }
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        String intro = req.getParameter("intro");
        if (intro == null) intro = "";
        if (intro.length() > 1000) intro = intro.substring(0, 1000);
        try {
            userService.saveIntro(loginUser.getUserId(), intro);
            resp.getWriter().write("{\"ok\":true}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"ok\":false,\"msg\":\"저장에 실패했습니다.\"}");
        }
    }

    /** 회원탈퇴 처리 */
    private void doWithdraw(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login");
            return;
        }
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        String password = req.getParameter("password");

        try {
            UserDTO verified = userService.login(loginUser.getUserId(), password);
            if (verified == null) {
                req.setAttribute("errorMsg", "비밀번호가 올바르지 않습니다.");
                req.setAttribute("contentPage", "/WEB-INF/views/user/withdraw.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, resp);
                return;
            }
            userService.withdraw(loginUser.getUserId());
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/main");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
