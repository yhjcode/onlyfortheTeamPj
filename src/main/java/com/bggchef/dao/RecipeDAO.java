package com.bggchef.dao;
import java.sql.*;
import java.util.*;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.util.DBUtil;

public class RecipeDAO {
    public List<RecipeDTO> selectByUserId(String userId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();
        String sql = "SELECT recipe_id, title, thumbnail, avg_rating, view_count, created_at " +
                     "FROM RECIPE WHERE user_id = ? AND is_deleted = 0 ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RecipeDTO dto = new RecipeDTO();
                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setTitle(rs.getString("title"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setAvgRating(rs.getDouble("avg_rating"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));
                list.add(dto);
            }
        }
        return list;
    }
}