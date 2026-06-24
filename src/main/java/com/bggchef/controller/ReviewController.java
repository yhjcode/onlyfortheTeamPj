


package com.bggchef.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bggchef.dao.ReviewDAO;
import com.bggchef.dto.ReviewDTO;
import com.bggchef.dto.UserDTO;

/**
 * 리뷰/대댓글
 * URL: /review/list
 */
@WebServlet("/review/list")
public class ReviewController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String recipeIdParam = req.getParameter("recipe_id");

        if (recipeIdParam == null || recipeIdParam.trim().isEmpty()) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing recipe_id");
            return;
        }

        long recipeId = Long.parseLong(recipeIdParam);

        try {
            List<ReviewDTO> list = reviewDAO.selectByRecipeId(recipeId);

            res.setContentType("application/json; charset=UTF-8");

            PrintWriter out = res.getWriter();
            StringBuilder json = new StringBuilder();

            json.append("[");

            for (int i = 0; i < list.size(); i++) {
                ReviewDTO dto = list.get(i);

                if (i > 0) {
                    json.append(",");
                }

                String ratingJson =
                        dto.getRating() == null
                                ? "null"
                                : String.format("%.1f", dto.getRating());

                String parentReviewIdJson =
                        dto.getParentReviewId() == null
                                ? "null"
                                : String.valueOf(dto.getParentReviewId());

                json.append("{");
                json.append("\"reviewId\":").append(dto.getReviewId()).append(",");
                json.append("\"userId\":\"").append(escapeJson(dto.getUserId())).append("\",");
                json.append("\"nickname\":\"").append(escapeJson(dto.getNickname())).append("\",");
                json.append("\"rating\":").append(ratingJson).append(",");
                json.append("\"parentReviewId\":").append(parentReviewIdJson).append(",");
                json.append("\"content\":\"").append(escapeJson(dto.getContent())).append("\",");
                json.append("\"createdAt\":\"").append(dto.getCreatedAt()).append("\"");
                json.append("}");
            }

            json.append("]");

            out.print(json.toString());
            out.flush();

        } catch (SQLException e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/plain; charset=UTF-8");

        PrintWriter out = res.getWriter();

        String action = req.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = "insert";
        }

        HttpSession session = req.getSession();
        Object loginUserObj = session.getAttribute("loginUser");

        String userId = null;

        if (loginUserObj != null) {
            UserDTO loginUser = (UserDTO) loginUserObj;
            userId = loginUser.getUserId();
        }

        if (userId == null || userId.trim().isEmpty()) {
            out.print("login_required");
            return;
        }

        try {
            if ("insert".equals(action)) {
                insertReview(req, out, userId);
            } else if ("update".equals(action)) {
                updateReview(req, out);
            } else if ("delete".equals(action)) {
                deleteReview(req, out);
            } else {
                out.print("unknown_action");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("error: " + e.getMessage());
        } finally {
            out.flush();
            out.close();
        }
    }

    private void insertReview(HttpServletRequest req, PrintWriter out, String userId)
            throws Exception {

        String recipeIdParam = req.getParameter("recipe_id");
        String ratingParam = req.getParameter("rating");
        String parentReviewIdParam = req.getParameter("parentReviewId");
        String content = req.getParameter("content");

        if (recipeIdParam == null || recipeIdParam.trim().isEmpty()
                || content == null || content.trim().isEmpty()) {
            out.print("fail");
            return;
        }

        long recipeId = Long.parseLong(recipeIdParam);

        ReviewDTO dto = new ReviewDTO();
        dto.setUserId(userId);
        dto.setRecipeId(recipeId);
        dto.setContent(content);

        // 대댓글이면 별점 없음
        if (parentReviewIdParam != null && !parentReviewIdParam.trim().isEmpty()) {
            dto.setParentReviewId(Long.parseLong(parentReviewIdParam));
            dto.setRating(null);
        }
        // 일반 댓글이면 별점 있음
        else {
            dto.setParentReviewId(null);

            if (ratingParam == null || ratingParam.trim().isEmpty()) {
                dto.setRating(5.0);
            } else {
                dto.setRating(Double.parseDouble(ratingParam));
            }
        }

        int result = reviewDAO.insertReview(dto);

        if (result > 0) {
            out.print("success");
        } else {
            out.print("fail_db");
        }
    }

    private void updateReview(HttpServletRequest req, PrintWriter out)
            throws Exception {

        String reviewIdParam = req.getParameter("review_id");
        String ratingParam = req.getParameter("rating");
        String content = req.getParameter("content");

        if (reviewIdParam == null || reviewIdParam.trim().isEmpty()
                || content == null || content.trim().isEmpty()) {
            out.print("fail");
            return;
        }

        long reviewId = Long.parseLong(reviewIdParam);

        double rating = 5.0;

        if (ratingParam != null && !ratingParam.trim().isEmpty()) {
            rating = Double.parseDouble(ratingParam);
        }

        int result = reviewDAO.updateReview(reviewId, content, rating);

        if (result > 0) {
            out.print("success");
        } else {
            out.print("fail_db");
        }
    }

    private void deleteReview(HttpServletRequest req, PrintWriter out)
            throws Exception {

        String reviewIdParam = req.getParameter("review_id");

        if (reviewIdParam == null || reviewIdParam.trim().isEmpty()) {
            out.print("fail");
            return;
        }

        long reviewId = Long.parseLong(reviewIdParam);

        int result = reviewDAO.deleteReview(reviewId);

        if (result > 0) {
            out.print("success");
        } else {
            out.print("fail_db");
        }
    }

    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }

        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\r", "")
                  .replace("\n", "\\n");
    }
}
