package com.bggchef.dao;
import java.sql.*;
import java.util.*;
import com.bggchef.dto.ReviewDTO;
import com.bggchef.util.DBUtil;

public class ReviewDAO {

	
	
	//댓글 작성메서드
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//댓글 삭제메서드
	
	
	
	
	
	
	
	
	
	//댓글수정메서드
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
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
        if (clob == null) return "";
        return clob.getSubString(1, (int) clob.length());
    }
}
