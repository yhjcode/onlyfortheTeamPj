package com.bggchef.dao;
import java.sql.*;
import java.util.*;
import com.bggchef.dto.FavoriteDTO;
import com.bggchef.util.DBUtil;

public class FavoriteDAO {
    public List<FavoriteDTO> selectByUserId(String userId) throws SQLException {
        List<FavoriteDTO> list = new ArrayList<>();
        String sql = "SELECT f.favorite_id, f.recipe_id, f.created_at, " +
                     "r.title AS recipe_title, r.thumbnail " +
                     "FROM FAVORITE f JOIN RECIPE r ON f.recipe_id = r.recipe_id " +
                     "WHERE f.user_id = ? AND r.is_deleted = 0 ORDER BY f.created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FavoriteDTO dto = new FavoriteDTO();
                dto.setFavoriteId(rs.getLong("favorite_id"));
                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setCreatedAt(rs.getDate("created_at"));
                dto.setRecipeTitle(rs.getString("recipe_title"));
                dto.setThumbnail(rs.getString("thumbnail"));
                list.add(dto);
            }
        }
        return list;
    }

    /** 즐겨찾기 여부 확인 */
    public boolean existsByUserAndRecipe(String userId, long recipeId) throws SQLException {
        String sql = "SELECT 1 FROM FAVORITE WHERE user_id = ? AND recipe_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setLong(2, recipeId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    /** 즐겨찾기 추가 */
    public int insert(String userId, long recipeId) throws SQLException {
        String sql = "INSERT INTO FAVORITE (user_id, recipe_id) VALUES (?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setLong(2, recipeId);
            return ps.executeUpdate();
        }
    }

    /** 즐겨찾기 삭제 */
    public int delete(String userId, long recipeId) throws SQLException {
        String sql = "DELETE FROM FAVORITE WHERE user_id = ? AND recipe_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setLong(2, recipeId);
            return ps.executeUpdate();
        }
    }
}