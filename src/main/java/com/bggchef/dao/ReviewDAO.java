package com.bggchef.dao;

import java.sql.*;
import java.util.*;
import com.bggchef.dto.ReviewDTO;
import com.bggchef.util.DBUtil;

public class ReviewDAO {

    /** 테마 댓글/대댓글 등록 */
    public int insertThemeReview(ReviewDTO dto, long themeId) throws SQLException {
        String sql = "INSERT INTO REVIEW "
                   + "(REVIEW_ID, USER_ID, RECIPE_ID, RATING, CONTENT, PARENT_REVIEW_ID, IS_DELETED, CREATED_AT, THEME_ID) "
                   + "VALUES "
                   + "(REVIEW_SEQ.NEXTVAL, ?, NULL, NULL, ?, ?, 0, SYSDATE, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, dto.getUserId());
            ps.setString(2, dto.getContent());

            if (dto.getParentReviewId() == null || dto.getParentReviewId() == 0) {
                ps.setNull(3, java.sql.Types.NUMERIC);
            } else {
                ps.setLong(3, dto.getParentReviewId());
            }

            ps.setLong(4, themeId);

            return ps.executeUpdate();
        }
    }

    /** 테마 댓글/대댓글 목록 */
    public List<ReviewDTO> selectByThemeId(long themeId) throws SQLException {
        List<ReviewDTO> list = new ArrayList<>();

        String sql = "SELECT r.review_id, r.user_id, r.content, r.parent_review_id, "
                   + "r.created_at, r.is_deleted, u.nickname "
                   + "FROM REVIEW r "
                   + "JOIN USERS u ON r.user_id = u.user_id "
                   + "WHERE r.theme_id = ? AND r.is_deleted = 0 "
                   + "ORDER BY "
                   + "NVL(r.parent_review_id, r.review_id), "
                   + "CASE WHEN r.parent_review_id IS NULL THEN 0 ELSE 1 END, "
                   + "r.created_at";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, themeId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();

                dto.setReviewId(rs.getLong("review_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setContent(readClob(rs, "content"));

                long parentId = rs.getLong("parent_review_id");
                if (rs.wasNull()) {
                    dto.setParentReviewId(null);
                } else {
                    dto.setParentReviewId(parentId);
                }

                dto.setCreatedAt(rs.getDate("created_at"));
                dto.setIsDeleted(rs.getInt("is_deleted"));
                dto.setNickname(rs.getString("nickname"));

                list.add(dto);
            }
        }

        return list;
    }

    /** 테마 댓글 수정 */
    public int updateThemeReview(long reviewId, String userId, String content) throws SQLException {
        String sql = "UPDATE REVIEW "
                   + "SET CONTENT = ? "
                   + "WHERE REVIEW_ID = ? "
                   + "AND USER_ID = ? "
                   + "AND IS_DELETED = 0";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, content);
            ps.setLong(2, reviewId);
            ps.setString(3, userId);

            return ps.executeUpdate();
        }
    }

    /** 테마 댓글 삭제 */
    public int deleteThemeReview(long reviewId, String userId) throws SQLException {
        String sql = "UPDATE REVIEW "
                   + "SET IS_DELETED = 1 "
                   + "WHERE REVIEW_ID = ? "
                   + "AND USER_ID = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, reviewId);
            ps.setString(2, userId);

            return ps.executeUpdate();
        }
    }

    /** 내가 작성한 댓글 목록 */
    public List<ReviewDTO> selectByUserId(String userId) throws SQLException {
        List<ReviewDTO> list = new ArrayList<>();

        String sql = "SELECT r.review_id, r.content, r.rating, r.created_at, "
                   + "rc.title AS recipe_title, rc.recipe_id "
                   + "FROM REVIEW r "
                   + "JOIN RECIPE rc ON r.recipe_id = rc.recipe_id "
                   + "WHERE r.user_id = ? AND r.is_deleted = 0 "
                   + "ORDER BY r.created_at DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();

                dto.setReviewId(rs.getLong("review_id"));
                dto.setContent(readClob(rs, "content"));
                dto.setRating(rs.getDouble("rating"));
                dto.setCreatedAt(rs.getDate("created_at"));
                dto.setRecipeTitle(rs.getString("recipe_title"));
                dto.setRecipeId(rs.getLong("recipe_id"));

                list.add(dto);
            }
        }

        return list;
    }

    /** 내 레시피에 달린 댓글 목록 */
    public List<ReviewDTO> selectRepliesToMe(String userId) throws SQLException {
        List<ReviewDTO> list = new ArrayList<>();

        String sql = "SELECT r.review_id, r.content, r.rating, r.created_at, "
                   + "rc.title AS recipe_title, rc.recipe_id, u.nickname "
                   + "FROM REVIEW r "
                   + "JOIN RECIPE rc ON r.recipe_id = rc.recipe_id "
                   + "JOIN USERS u ON r.user_id = u.user_id "
                   + "WHERE rc.user_id = ? AND r.user_id != ? "
                   + "AND r.is_deleted = 0 AND r.parent_review_id IS NULL "
                   + "ORDER BY r.created_at DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();

                dto.setReviewId(rs.getLong("review_id"));
                dto.setContent(readClob(rs, "content"));
                dto.setRating(rs.getDouble("rating"));
                dto.setCreatedAt(rs.getDate("created_at"));
                dto.setRecipeTitle(rs.getString("recipe_title"));
                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setNickname(rs.getString("nickname"));

                list.add(dto);
            }
        }

        return list;
    }

    /** CLOB 컬럼을 String으로 읽는 헬퍼 */
    private String readClob(ResultSet rs, String col) throws SQLException {
        Clob clob = rs.getClob(col);

        if (clob == null) {
            return "";
        }

        return clob.getSubString(1, (int) clob.length());
    }
}