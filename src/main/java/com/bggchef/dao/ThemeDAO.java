package com.bggchef.dao;
import java.sql.*;
import java.util.*;

import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
import com.bggchef.util.DBUtil;

public class ThemeDAO {
	
    public List<ThemeDTO> selectByUserId(String userId) throws SQLException {
        List<ThemeDTO> list = new ArrayList<>();
        String sql = "SELECT theme_id, title, description, thumbnail, view_count, created_at " +
                     "FROM RECOMMENDED_THEME WHERE user_id = ? AND is_visible = 1 " +
                     "ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ThemeDTO dto = new ThemeDTO();
                dto.setThemeId(rs.getInt("theme_id"));
                dto.setTitle(rs.getString("title"));
                dto.setDescription(rs.getString("description"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));
                list.add(dto);
            }
        }
        return list;
    }

    /** 테마 목록 조회 (가시성 있는 것만) */
    public List<ThemeDTO> list() throws SQLException {
    	
    	
        List<ThemeDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM RECOMMENDED_THEME WHERE is_visible = 1 ORDER BY theme_id DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ThemeDTO dto = new ThemeDTO();
                dto.setThemeId(rs.getInt("theme_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setTitle(rs.getString("title"));
                dto.setDescription(rs.getString("description"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setLinkUrl(rs.getString("link_url"));
                dto.setIsVisible(rs.getInt("is_visible"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));
                list.add(dto);
            }
        }
        return list;
    }

    /** 테마 상세 조회 */
    public ThemeDTO selectById(int themeId) throws SQLException {
        ThemeDTO dto = null;
        String sql = "SELECT * FROM RECOMMENDED_THEME WHERE theme_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new ThemeDTO();
                    dto.setThemeId(rs.getInt("theme_id"));
                    dto.setUserId(rs.getString("user_id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setDescription(rs.getString("description"));
                    dto.setThumbnail(rs.getString("thumbnail"));
                    dto.setLinkUrl(rs.getString("link_url"));
                    dto.setIsVisible(rs.getInt("is_visible"));
                    dto.setViewCount(rs.getInt("view_count"));
                    dto.setCreatedAt(rs.getDate("created_at"));
                }
            }
        }
        return dto;
    }

    /** 조회수 증가 */
    public void updateViewCount(int themeId) throws SQLException {
        String sql = "UPDATE RECOMMENDED_THEME SET view_count = view_count + 1 WHERE theme_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            pstmt.executeUpdate();
        }
    }

    /** 특정 테마에 속한 레시피 목록 조회 */
    public List<RecipeDTO> getRecipesByThemeId(int themeId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();
        String sql = "SELECT r.*, u.nickname FROM RECIPE r " +
                     "JOIN THEME_RECIPE tr ON r.recipe_id = tr.recipe_id " +
                     "JOIN USERS u ON r.user_id = u.user_id " +
                     "WHERE tr.theme_id = ? AND r.is_deleted = 0 " +
                     "ORDER BY tr.recipe_id ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, themeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RecipeDTO dto = new RecipeDTO();
                    dto.setRecipeId(rs.getLong("recipe_id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setThumbnail(rs.getString("thumbnail"));
                    dto.setDescription(rs.getString("description"));
                    dto.setAvgRating(rs.getDouble("avg_rating"));
                    dto.setViewCount(rs.getInt("view_count"));
                    dto.setNickname(rs.getString("nickname"));
                    list.add(dto);
                }
            }
        }
        return list;
    }
}
