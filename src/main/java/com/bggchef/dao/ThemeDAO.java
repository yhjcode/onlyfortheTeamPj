package com.bggchef.dao;

import java.sql.*;
import java.util.*;
import java.sql.Clob;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
import com.bggchef.util.DBUtil;

public class ThemeDAO {

    public List<ThemeDTO> selectTop(int limit) throws SQLException {
        String sql = "SELECT * FROM (SELECT theme_id, title, thumbnail, description, view_count FROM RECOMMENDED_THEME WHERE is_visible = 1 ORDER BY theme_id DESC) WHERE ROWNUM <= ?";
        List<ThemeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ThemeDTO dto = new ThemeDTO();
                dto.setThemeId(rs.getInt("theme_id"));
                dto.setTitle(rs.getString("title"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setDescription(rs.getString("description"));
                dto.setViewCount(rs.getInt("view_count"));
                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return list;
    }

    public void insert(ThemeDTO dto) throws SQLException {
        String sql = "INSERT INTO RECOMMENDED_THEME "
                   + "(theme_id, user_id, title, subtitle, description, thumbnail, content, is_visible, view_count, created_at) "
                   + "VALUES (RECOMMENDED_THEME_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, 1, 0, SYSDATE)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dto.getUserId());
            pstmt.setString(2, dto.getTitle());
            pstmt.setString(3, dto.getSubtitle());
            pstmt.setString(4, dto.getDescription());
            pstmt.setString(5, dto.getThumbnail());
            pstmt.setString(6, dto.getContent());

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public List<ThemeDTO> selectByUserId(String userId) throws SQLException {
        List<ThemeDTO> list = new ArrayList<>();
        String sql = "SELECT theme_id, title, subtitle, description, thumbnail, view_count, created_at "
                   + "FROM RECOMMENDED_THEME "
                   + "WHERE user_id = ? AND is_visible = 1 "
                   + "ORDER BY created_at DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                ThemeDTO dto = new ThemeDTO();
                dto.setThemeId(rs.getInt("theme_id"));
                dto.setTitle(rs.getString("title"));
                dto.setSubtitle(rs.getString("subtitle"));
                dto.setDescription(rs.getString("description"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));
                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }

        return list;
    }

    public int getLatestThemeId() throws SQLException {
        String sql = "SELECT MAX(theme_id) FROM RECOMMENDED_THEME";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return 0;
    }

    public void insertRecipeToTheme(int themeId, int recipeId, String description, String userId) throws SQLException {
        insertRecipeToTheme(themeId, recipeId, description, userId, null);
    }

    public void insertRecipeToTheme(int themeId, int recipeId, String description, String userId, String fileName) throws SQLException {
        String sql = "INSERT INTO THEME_RECIPE "
                   + "(theme_recipe_id, theme_id, recipe_id, user_id, description, recipe_image) "
                   + "VALUES (SEQ_THEME_RECIPE.NEXTVAL, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);
            pstmt.setString(3, userId);
            pstmt.setString(4, description);
            pstmt.setString(5, fileName);

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public void addRecipesToTheme(int themeId, String[] recipeIds, String userId) throws SQLException {
        String sql = "INSERT INTO THEME_RECIPE "
                   + "(theme_recipe_id, theme_id, recipe_id, user_id) "
                   + "VALUES (SEQ_THEME_RECIPE.NEXTVAL, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            for (String rId : recipeIds) {
                pstmt.setInt(1, themeId);
                pstmt.setLong(2, Long.parseLong(rId));
                pstmt.setString(3, userId);
                pstmt.addBatch();
            }

            pstmt.executeBatch();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public List<RecipeDTO> getMyRecipes(String userId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();
        String sql = "SELECT recipe_id, title FROM RECIPE WHERE user_id = ? AND is_deleted = 0 ORDER BY recipe_id DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RecipeDTO r = new RecipeDTO();
                r.setRecipeId(rs.getLong("recipe_id"));
                r.setTitle(rs.getString("title"));
                list.add(r);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return list;
    }

    public List<RecipeDTO> getRecipesByThemeId(int themeId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();

        String sql = "SELECT r.*, tr.description AS theme_desc, tr.recipe_image AS theme_image "
                   + "FROM RECIPE r "
                   + "JOIN THEME_RECIPE tr ON r.recipe_id = tr.recipe_id "
                   + "WHERE tr.theme_id = ? AND r.is_deleted = 0";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, themeId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RecipeDTO dto = new RecipeDTO();

                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setTitle(rs.getString("title"));
                dto.setUserId(rs.getString("user_id"));

                try {
                    dto.setRecipeLink(rs.getString("link"));
                } catch (SQLException e) {
                    dto.setRecipeLink(null);
                }

                dto.setThumbnail(rs.getString("thumbnail"));

                String themeDesc = rs.getString("theme_desc");

                if (themeDesc != null && !themeDesc.isEmpty()) {
                    dto.setDescription(themeDesc);
                } else {
                    dto.setDescription(rs.getString("description"));
                }

                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return list;
    }

    public List<ThemeDTO> list() throws SQLException {
        String sql = "SELECT * FROM RECOMMENDED_THEME WHERE is_visible = 1 ORDER BY theme_id DESC";
        List<ThemeDTO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ThemeDTO dto = new ThemeDTO();

                dto.setThemeId(rs.getInt("theme_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setTitle(rs.getString("title"));
                dto.setSubtitle(rs.getString("subtitle"));
                dto.setDescription(rs.getString("description"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));

                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return list;
    }

    public void removeRecipeFromTheme(int themeId, int recipeId) throws SQLException {
        String sql = "DELETE FROM THEME_RECIPE WHERE theme_id = ? AND recipe_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public ThemeDTO selectById(int themeId) throws SQLException {
        ThemeDTO dto = null;
        String sql = "SELECT * FROM RECOMMENDED_THEME WHERE theme_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, themeId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new ThemeDTO();

                dto.setThemeId(rs.getInt("theme_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setTitle(rs.getString("title"));
                dto.setSubtitle(rs.getString("subtitle"));
                dto.setDescription(rs.getString("description"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return dto;
    }

    public RecipeDTO getThemeRecipeDetail(int themeId, int recipeId) throws SQLException {
        String sql = "SELECT r.*, tr.description AS theme_desc, tr.recipe_image AS theme_image "
                   + "FROM RECIPE r "
                   + "JOIN THEME_RECIPE tr ON r.recipe_id = tr.recipe_id "
                   + "WHERE tr.theme_id = ? AND tr.recipe_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                RecipeDTO dto = new RecipeDTO();

                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setTitle(rs.getString("title"));
                dto.setRecipeLink(rs.getString("link"));
                dto.setDescription(rs.getString("theme_desc"));

                dto.setThumbnail(rs.getString("thumbnail"));

                return dto;
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return null;
    }

    public void updateRecipeInfo(RecipeDTO dto) throws SQLException {
        String sql = "UPDATE RECIPE SET title = ?, description = ?, thumbnail = ?, link = ? WHERE recipe_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getDescription());
            pstmt.setString(3, dto.getThumbnail());
            pstmt.setString(4, dto.getRecipeLink());
            pstmt.setLong(5, dto.getRecipeId());

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public void updateThemeRecipeDescription(int themeId, int recipeId, String description) throws SQLException {
        String sql = "UPDATE THEME_RECIPE SET description = ? WHERE theme_id = ? AND recipe_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, description);
            pstmt.setInt(2, themeId);
            pstmt.setInt(3, recipeId);

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public void updateViewCount(int themeId) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET view_count = view_count + 1 WHERE theme_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, themeId);

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public void update(ThemeDTO dto) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET title = ?, subtitle = ?, description = ?, thumbnail = ? WHERE theme_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getSubtitle());
            pstmt.setString(3, dto.getDescription());
            pstmt.setString(4, dto.getThumbnail());
            pstmt.setInt(5, dto.getThemeId());

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public void delete(int themeId) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET is_visible = 0 WHERE theme_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, themeId);

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public boolean isRecipeAlreadyInTheme(int themeId, int recipeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM THEME_RECIPE WHERE theme_id = ? AND recipe_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }

        return false;
    }
    public void insertThemeComment(
            int themeId,
            String userId,
            String content,
            Long parentReviewId) throws SQLException {

        String sql =
            "INSERT INTO REVIEW " +
            "(review_id, user_id, recipe_id, rating, content, parent_review_id, is_deleted, created_at, theme_id) " +
            "VALUES (SEQ_REVIEW.NEXTVAL, ?, NULL, NULL, ?, ?, 0, SYSDATE, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            pstmt.setString(2, content);

            if (parentReviewId == null) {
                pstmt.setNull(3, Types.NUMERIC);
            } else {
                pstmt.setLong(3, parentReviewId);
            }

            pstmt.setInt(4, themeId);

            pstmt.executeUpdate();
        }
    }
    public List<Map<String, Object>> getThemeComments(int themeId) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql =
            "SELECT r.review_id AS comment_id, " +
            "       r.user_id, " +
            "       u.nickname, " +
            "       r.content, " +
            "       r.parent_review_id, " +
            "       r.created_at " +
            "FROM REVIEW r " +
            "JOIN USERS u ON r.user_id = u.user_id " +
            "WHERE r.theme_id = ? " +
            "AND r.is_deleted = 0 " +
            "ORDER BY " +
            "    NVL(r.parent_review_id, r.review_id), " +
            "    CASE WHEN r.parent_review_id IS NULL THEN 0 ELSE 1 END, " +
            "    r.created_at ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, themeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();

                    map.put("commentId", rs.getInt("comment_id"));
                    map.put("userId", rs.getString("user_id"));
                    map.put("nickname", rs.getString("nickname"));
                    map.put("content", readClob(rs, "content"));
                    map.put("createdAt", rs.getDate("created_at"));

                    Long parentReviewId = null;
                    long parentId = rs.getLong("parent_review_id");
                    if (!rs.wasNull()) {
                        parentReviewId = parentId;
                    }
                    map.put("parentReviewId", parentReviewId);

                    list.add(map);
                }
            }
        }

        return list;
    }
    public void updateThemeComment(int commentId, String userId, String content) throws SQLException {
        String sql = "UPDATE REVIEW "
                   + "SET content = ? "
                   + "WHERE review_id = ? AND user_id = ? AND theme_id IS NOT NULL";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, content);
            pstmt.setInt(2, commentId);
            pstmt.setString(3, userId);

            pstmt.executeUpdate();
        }
    }

    public void deleteThemeComment(int commentId, String userId) throws SQLException {
        String sql = "UPDATE REVIEW "
                   + "SET is_deleted = 1 "
                   + "WHERE review_id = ? AND user_id = ? AND theme_id IS NOT NULL";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commentId);
            pstmt.setString(2, userId);

            pstmt.executeUpdate();
        }
    }
    private String readClob(ResultSet rs, String columnName) throws SQLException {
        Clob clob = rs.getClob(columnName);

        if (clob == null) {
            return "";
        }

        return clob.getSubString(1, (int) clob.length());
    }
}