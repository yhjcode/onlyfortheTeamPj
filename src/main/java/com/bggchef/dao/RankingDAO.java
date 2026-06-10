package com.bggchef.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bggchef.dto.ChefRankingDTO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.util.DBUtil;

/**
 * 랭킹 전용 DAO
 *  - 레시피 조회수 랭킹
 *  - 레시피 평점 랭킹
 *  - 셰프 조회수 합산 랭킹
 *  - 셰프 평점 평균 랭킹
 */
public class RankingDAO {

    /** 조회수 기준 레시피 TOP N */
    public List<RecipeDTO> selectRecipesByViewCount(int limit) throws SQLException {
        String sql = "SELECT * FROM ("
                   + "    SELECT r.recipe_id, r.user_id, r.title, r.thumbnail,"
                   + "           r.view_count, r.avg_rating, u.nickname"
                   + "    FROM RECIPE r"
                   + "    JOIN USERS u ON r.user_id = u.user_id"
                   + "    WHERE r.is_deleted = 0 AND u.is_deleted = 0"
                   + "    ORDER BY r.view_count DESC"
                   + ") WHERE ROWNUM <= ?";

        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            List<RecipeDTO> list = new ArrayList<>();
            while (rs.next()) {
                RecipeDTO dto = new RecipeDTO();
                dto.setRecipeId  (rs.getLong  ("recipe_id"));
                dto.setUserId    (rs.getString ("user_id"));
                dto.setTitle     (rs.getString ("title"));
                dto.setThumbnail (rs.getString ("thumbnail"));
                dto.setViewCount (rs.getInt    ("view_count"));
                double avgRating = rs.getDouble("avg_rating");
                dto.setAvgRating(rs.wasNull() ? null : avgRating);
                dto.setNickname  (rs.getString ("nickname"));
                list.add(dto);
            }
            return list;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /** 평점 기준 레시피 TOP N (평점 없는 레시피 제외) */
    public List<RecipeDTO> selectRecipesByRating(int limit) throws SQLException {
        String sql = "SELECT * FROM ("
                   + "    SELECT r.recipe_id, r.user_id, r.title, r.thumbnail,"
                   + "           r.view_count, r.avg_rating, u.nickname"
                   + "    FROM RECIPE r"
                   + "    JOIN USERS u ON r.user_id = u.user_id"
                   + "    WHERE r.is_deleted = 0 AND u.is_deleted = 0"
                   + "      AND r.avg_rating IS NOT NULL"
                   + "    ORDER BY r.avg_rating DESC, r.view_count DESC"
                   + ") WHERE ROWNUM <= ?";

        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            List<RecipeDTO> list = new ArrayList<>();
            while (rs.next()) {
                RecipeDTO dto = new RecipeDTO();
                dto.setRecipeId  (rs.getLong  ("recipe_id"));
                dto.setUserId    (rs.getString ("user_id"));
                dto.setTitle     (rs.getString ("title"));
                dto.setThumbnail (rs.getString ("thumbnail"));
                dto.setViewCount (rs.getInt    ("view_count"));
                dto.setAvgRating (rs.getDouble ("avg_rating"));
                dto.setNickname  (rs.getString ("nickname"));
                list.add(dto);
            }
            return list;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /** 업로드한 레시피 조회수 합산 기준 셰프 TOP N */
    public List<ChefRankingDTO> selectChefsByTotalView(int limit) throws SQLException {
        String sql = "SELECT * FROM ("
                   + "    SELECT u.user_id, u.nickname, u.profile_img,"
                   + "           SUM(r.view_count)  AS total_view_count,"
                   + "           COUNT(r.recipe_id) AS recipe_count,"
                   + "           AVG(r.avg_rating)  AS avg_rating"
                   + "    FROM USERS u"
                   + "    JOIN RECIPE r ON u.user_id = r.user_id"
                   + "    WHERE r.is_deleted = 0 AND u.is_deleted = 0"
                   + "    GROUP BY u.user_id, u.nickname, u.profile_img"
                   + "    ORDER BY SUM(r.view_count) DESC"
                   + ") WHERE ROWNUM <= ?";

        return fetchChefList(sql, limit);
    }

    /** 업로드한 레시피 평점 평균 기준 셰프 TOP N (평점 데이터 없는 셰프 제외) */
    public List<ChefRankingDTO> selectChefsByAvgRating(int limit) throws SQLException {
        String sql = "SELECT * FROM ("
                   + "    SELECT u.user_id, u.nickname, u.profile_img,"
                   + "           SUM(r.view_count)  AS total_view_count,"
                   + "           COUNT(r.recipe_id) AS recipe_count,"
                   + "           AVG(r.avg_rating)  AS avg_rating"
                   + "    FROM USERS u"
                   + "    JOIN RECIPE r ON u.user_id = r.user_id"
                   + "    WHERE r.is_deleted = 0 AND u.is_deleted = 0"
                   + "    GROUP BY u.user_id, u.nickname, u.profile_img"
                   + "    HAVING AVG(r.avg_rating) IS NOT NULL"
                   + "    ORDER BY AVG(r.avg_rating) DESC, SUM(r.view_count) DESC"
                   + ") WHERE ROWNUM <= ?";

        return fetchChefList(sql, limit);
    }

    private List<ChefRankingDTO> fetchChefList(String sql, int limit) throws SQLException {
        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            List<ChefRankingDTO> list = new ArrayList<>();
            while (rs.next()) {
                ChefRankingDTO dto = new ChefRankingDTO();
                dto.setUserId       (rs.getString("user_id"));
                dto.setNickname     (rs.getString("nickname"));
                dto.setProfileImg   (rs.getString("profile_img"));
                dto.setTotalViewCount(rs.getLong  ("total_view_count"));
                dto.setRecipeCount  (rs.getInt    ("recipe_count"));
                double avg = rs.getDouble("avg_rating");
                dto.setAvgRating(rs.wasNull() ? null : avg);
                list.add(dto);
            }
            return list;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }
}
