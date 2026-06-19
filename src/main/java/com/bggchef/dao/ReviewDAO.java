package com.bggchef.dao;
import java.sql.*;
import java.util.*;
import com.bggchef.dto.ReviewDTO;
import com.bggchef.util.DBUtil;

public class ReviewDAO {

	// Ajax-
	
	
    /** 특정 레시피 번호에 달린 모든 댓글(리뷰) 목록 조회 */
    public List<ReviewDTO> selectByRecipeId(long recipeId) throws SQLException {
        List<ReviewDTO> list = new ArrayList<>();
        String sql = "SELECT r.review_id, r.user_id, r.recipe_id, r.rating, r.content, "
                   + "r.parent_review_id, r.is_deleted, r.created_at, u.nickname "
                   + "FROM REVIEW r "
                   + "JOIN USERS u ON r.user_id = u.user_id "
                   + "WHERE r.recipe_id = ? AND r.is_deleted = 0 AND r.parent_review_id IS NULL "
                   + "ORDER BY r.created_at DESC";
                   
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, recipeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();
                dto.setReviewId(rs.getLong("review_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setRating(rs.getDouble("rating"));
                dto.setContent(readClob(rs, "content"));
                dto.setParentReviewId(rs.getObject("parent_review_id") != null ? rs.getLong("parent_review_id") : null);
                dto.setIsDeleted(rs.getInt("is_deleted"));
                dto.setCreatedAt(rs.getDate("created_at"));
                dto.setNickname(rs.getString("nickname")); // 화면에 뿌릴 작성자 닉네임
                list.add(dto);
            }
        }
        return list;
    }

	
    
    
    //수정삭제{
    
    
    
    
    
    
    
    /**
     * 특정 리뷰(댓글)의 내용과 평점을 수정합니다.
     * @param reviewId 수정할 리뷰 번호
     * @param content 수정할 내용 (CLOB)
     * @param rating 수정할 평점 (NUMBER(3,1))
     */
    public int updateReview(long reviewId, String content, double rating) throws SQLException {
        String sql = "UPDATE REVIEW SET CONTENT = ?, RATING = ? WHERE REVIEW_ID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setDouble(2, rating);
            ps.setLong(3, reviewId);
            return ps.executeUpdate();
        }
    }

    /**
     * 특정 리뷰(댓글)를 삭제 처리합니다. (IS_DELETED = 1 로 업데이트)
     * @param reviewId 삭제할 리뷰 번호
     */
    public int deleteReview(long reviewId) throws SQLException {
        String sql = "UPDATE REVIEW SET IS_DELETED = 1 WHERE REVIEW_ID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, reviewId);
            return ps.executeUpdate();
        }
    }


    // }
    
    /** 새 리뷰/댓글 등록 */
    public int insertReview(ReviewDTO dto) throws SQLException {
        String sql = "INSERT INTO REVIEW (review_id, user_id, recipe_id, rating, content, parent_review_id, is_deleted, created_at) "
                   + "VALUES (SEQ_REVIEW.NEXTVAL, ?, ?, ?, ?, NULL, 0, SYSDATE)";
                  
                   
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dto.getUserId());
            ps.setLong(2, dto.getRecipeId());
            ps.setDouble(3, dto.getRating());
            ps.setString(4, dto.getContent()); // CLOB 타입이어도 setString으로 정상 저장됩니다.
            
            return ps.executeUpdate(); // 성공하면 1 반환
        }
    }

    
    
    //
    
    
    
    
    
    
    
    
	
	
	

	
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
