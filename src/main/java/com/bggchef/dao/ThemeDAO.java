package com.bggchef.dao;
import java.sql.*;
import java.util.*;
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
}