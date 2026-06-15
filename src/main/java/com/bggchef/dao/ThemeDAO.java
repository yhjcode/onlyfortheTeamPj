package com.bggchef.dao;

import java.sql.*;
import java.util.*;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
import com.bggchef.util.DBUtil;

public class ThemeDAO {
	
    public List<ThemeDTO> selectTop(int limit) throws SQLException {
        String sql = "SELECT * FROM ("
                   + "    SELECT theme_id, title, thumbnail, description, view_count"
                   + "    FROM RECOMMENDED_THEME"
                   + "    WHERE is_visible = 1"
                   + "    ORDER BY theme_id DESC"
                   + ") WHERE ROWNUM <= ?";
        List<ThemeDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ThemeDTO dto = new ThemeDTO();
                    dto.setThemeId(rs.getInt("theme_id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setThumbnail(rs.getString("thumbnail"));
                    dto.setDescription(rs.getString("description"));
                    dto.setViewCount(rs.getInt("view_count"));
                    list.add(dto);
                }
            }
        }
        return list;
    }

    /** 1. 테마 등록 */
    public void insert(ThemeDTO dto) throws SQLException {
        String sql = "INSERT INTO RECOMMENDED_THEME (theme_id, user_id, title, subtitle, description, thumbnail, is_visible, view_count, created_at) " +
                     "VALUES (RECOMMENDED_THEME_SEQ.NEXTVAL, ?, ?, ?, ?, ?, 1, 0, SYSDATE)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getUserId());
            pstmt.setString(2, dto.getTitle());
            pstmt.setString(3, dto.getSubtitle());
            pstmt.setString(4, dto.getDescription());
            pstmt.setString(5, dto.getThumbnail());
            pstmt.executeUpdate();
        }
    }

    /** 2. 사용자별 테마 목록 조회 */
    public List<ThemeDTO> selectByUserId(String userId) throws SQLException {
        List<ThemeDTO> list = new ArrayList<>();
        String sql = "SELECT theme_id, title, subtitle, description, thumbnail, view_count, created_at " +
                     "FROM RECOMMENDED_THEME WHERE user_id = ? AND is_visible = 1 ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        }
        return list;
    }

    /** 3. 가장 최근 생성된 테마 ID 조회 */
    public int getLatestThemeId() throws SQLException {
        String sql = "SELECT MAX(theme_id) FROM RECOMMENDED_THEME";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    /** 4. 개별 요리 추가 (소개글 포함) */
    public void insertRecipeToTheme(int themeId, int recipeId, String description, String userId) throws SQLException {
        String sql = "INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id, description) " +
                     "VALUES (SEQ_THEME_RECIPE.NEXTVAL, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);
            pstmt.setString(3, userId);
            pstmt.setString(4, description);
            pstmt.executeUpdate();
        }
    }

    /** 5. 테마-레시피 일괄 등록 */
    public void addRecipesToTheme(int themeId, String[] recipeIds, String userId) throws SQLException {
        String sql = "INSERT INTO THEME_RECIPE (theme_recipe_id, theme_id, recipe_id, user_id) VALUES (SEQ_THEME_RECIPE.NEXTVAL, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (String rId : recipeIds) {
                pstmt.setInt(1, themeId);
                pstmt.setLong(2, Long.parseLong(rId));
                pstmt.setString(3, userId);
                pstmt.addBatch();
            }
            pstmt.executeBatch();
        }
    }

    /** 6. 내 레시피 목록 조회 (팝업용) */
    public List<RecipeDTO> getMyRecipes(String userId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();
        String sql = "SELECT recipe_id, title FROM RECIPE WHERE user_id = ? AND is_deleted = 0 ORDER BY recipe_id DESC";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RecipeDTO r = new RecipeDTO();
                    r.setRecipeId(rs.getLong("recipe_id"));
                    r.setTitle(rs.getString("title"));
                    list.add(r);
                }
            }
        }
        return list;
    }

    /** 7. 테마 내 레시피 목록 조회 */
    public List<RecipeDTO> getRecipesByThemeId(int themeId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();
        String sql = "SELECT r.*, tr.description AS theme_desc FROM RECIPE r " +
                     "JOIN THEME_RECIPE tr ON r.recipe_id = tr.recipe_id WHERE tr.theme_id = ? AND r.is_deleted = 0";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RecipeDTO dto = new RecipeDTO();
                    dto.setRecipeId(rs.getLong("recipe_id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setThumbnail(rs.getString("thumbnail"));
                    dto.setUserId(rs.getString("user_id"));
                    dto.setRecipeLink(rs.getString("link")); 
                    String themeDesc = rs.getString("theme_desc");
                    dto.setDescription((themeDesc != null && !themeDesc.isEmpty()) ? themeDesc : rs.getString("description"));
                    list.add(dto);
                }
            }
        }
        return list;
    }

    /** 8. 테마 목록 조회 */
    public List<ThemeDTO> list() throws SQLException {
        String sql = "SELECT * FROM RECOMMENDED_THEME WHERE is_visible = 1 ORDER BY theme_id DESC";
        List<ThemeDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql); 
             ResultSet rs = pstmt.executeQuery()) {
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
        }
        return list;
    }

    /** 9. 레시피 삭제 */
    public void removeRecipeFromTheme(int themeId, int recipeId) throws SQLException {
        String sql = "DELETE FROM THEME_RECIPE WHERE theme_id = ? AND recipe_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);
            pstmt.executeUpdate();
        }
    }

    /** 10. 테마 상세 조회 */
    public ThemeDTO selectById(int themeId) throws SQLException {
        ThemeDTO dto = null;
        String sql = "SELECT * FROM RECOMMENDED_THEME WHERE theme_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new ThemeDTO();
                    dto.setThemeId(rs.getInt("theme_id"));
                    dto.setUserId(rs.getString("user_id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setSubtitle(rs.getString("subtitle"));
                    dto.setDescription(rs.getString("description"));
                    dto.setViewCount(rs.getInt("view_count"));
                }
            }
        }
        return dto;
    }
    
    public RecipeDTO getThemeRecipeDetail(int themeId, int recipeId) throws SQLException {
        String sql = "SELECT r.*, tr.description AS theme_desc FROM RECIPE r " +
                     "JOIN THEME_RECIPE tr ON r.recipe_id = tr.recipe_id WHERE tr.theme_id = ? AND tr.recipe_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            pstmt.setInt(2, recipeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    RecipeDTO dto = new RecipeDTO();
                    dto.setRecipeId(rs.getLong("recipe_id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setThumbnail(rs.getString("thumbnail"));
                    dto.setRecipeLink(rs.getString("link")); 
                    dto.setDescription(rs.getString("theme_desc"));
                    return dto;
                }
            }
        }
        return null;
    }

    public void updateRecipeInfo(RecipeDTO dto) throws SQLException {
        String sql = "UPDATE RECIPE SET title = ?, description = ?, thumbnail = ?, link = ? WHERE recipe_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getDescription());
            pstmt.setString(3, dto.getThumbnail());
            pstmt.setString(4, dto.getRecipeLink());
            pstmt.setLong(5, dto.getRecipeId());
            pstmt.executeUpdate();
        }
    }

    public void updateThemeRecipeDescription(int themeId, int recipeId, String description) throws SQLException {
        String sql = "UPDATE THEME_RECIPE SET description = ? WHERE theme_id = ? AND recipe_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, description);
            pstmt.setInt(2, themeId);
            pstmt.setInt(3, recipeId);
            pstmt.executeUpdate();
        }
    }

    public void updateViewCount(int themeId) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET view_count = view_count + 1 WHERE theme_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            pstmt.executeUpdate();
        }
    }

    public void update(ThemeDTO dto) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET title = ?, subtitle = ?, description = ?, thumbnail = ? WHERE theme_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getSubtitle());
            pstmt.setString(3, dto.getDescription());
            pstmt.setString(4, dto.getThumbnail());
            pstmt.setInt(5, dto.getThemeId());
            pstmt.executeUpdate();
        }
    }

    public void delete(int themeId) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET is_visible = 0 WHERE theme_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            pstmt.executeUpdate();
        }
    }
}