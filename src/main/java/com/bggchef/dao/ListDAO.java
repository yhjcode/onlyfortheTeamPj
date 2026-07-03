package com.bggchef.dao;

import com.bggchef.util.PagingUtil;
import java.util.*;
import com.bggchef.dto.ListDTO;
import com.bggchef.util.DBUtil;
import java.sql.*;

public class ListDAO {

	private Connection getConnection() {
		Connection con = null;
		try {
			con = DBUtil.getConnection();
		} catch (Exception e) {
			System.out.println("Connection 생성 실패@@");
			e.printStackTrace();
		}
		return con;
	}
	
	// 1. 모든 레시피 최신순 정렬
	public List<ListDTO> descRecipe() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ListDTO> arr = new ArrayList<ListDTO>();
		try {
			con = getConnection();
			String sql = "SELECT R.RECIPE_ID, R.USER_ID, R.CATEGORY_ID, R.TITLE, R.THUMBNAIL, R.DESCRIPTION, "
					+ "R.VIEW_COUNT, R.CREATED_AT, R.IS_DELETED, U.NICKNAME, U.PROFILE_IMG, U.MEDAL_GRADE, "
					+ "NVL(ar.AVG_RATING, 0) AS AVG_RATING "
					+ "FROM RECIPE R LEFT JOIN USERS U ON R.USER_ID = U.USER_ID "
					+ "LEFT JOIN (SELECT RECIPE_ID, AVG(RATING) AS AVG_RATING FROM REVIEW "
					+ "           WHERE IS_DELETED = 0 AND RATING IS NOT NULL GROUP BY RECIPE_ID) ar "
					+ "ON R.RECIPE_ID = ar.RECIPE_ID WHERE R.IS_DELETED = 0 ORDER BY R.CREATED_AT DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setAvgRating(rs.getDouble("AVG_RATING"));
				dto.setCategoryId(rs.getInt("CATEGORY_ID"));
				dto.setCreatedAt(rs.getDate("CREATED_AT"));
				dto.setIsDeleted(rs.getInt("IS_DELETED"));
				dto.setNickname(rs.getString("NICKNAME"));
				dto.setRecipeId(rs.getLong("RECIPE_ID"));
				dto.setThumbnail(rs.getString("THUMBNAIL"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setUserId(rs.getString("USER_ID"));
				dto.setViewCount(rs.getInt("VIEW_COUNT"));
				dto.setProfileImg(rs.getString("PROFILE_IMG"));
				dto.setDescription(rs.getString("DESCRIPTION"));
				arr.add(dto);
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}

	// 2. 모든 레시피 조회수순 정렬
	public List<ListDTO> viewcountRecipe() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ListDTO> arr = new ArrayList<ListDTO>();
		try {
			con = getConnection();
			String sql = "SELECT R.RECIPE_ID, R.USER_ID, R.CATEGORY_ID, R.TITLE, R.THUMBNAIL, R.DESCRIPTION, "
					+ "R.VIEW_COUNT, R.CREATED_AT, R.IS_DELETED, U.NICKNAME, U.PROFILE_IMG, U.MEDAL_GRADE, "
					+ "NVL(ar.AVG_RATING, 0) AS AVG_RATING "
					+ "FROM RECIPE R LEFT JOIN USERS U ON R.USER_ID = U.USER_ID "
					+ "LEFT JOIN (SELECT RECIPE_ID, AVG(RATING) AS AVG_RATING FROM REVIEW "
					+ "           WHERE IS_DELETED = 0 AND RATING IS NOT NULL GROUP BY RECIPE_ID) ar "
					+ "ON R.RECIPE_ID = ar.RECIPE_ID WHERE R.IS_DELETED = 0 ORDER BY NVL(R.VIEW_COUNT, 0) DESC, R.CREATED_AT DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setAvgRating(rs.getDouble("AVG_RATING"));
				dto.setCategoryId(rs.getInt("CATEGORY_ID"));
				dto.setCreatedAt(rs.getDate("CREATED_AT"));
				dto.setIsDeleted(rs.getInt("IS_DELETED"));
				dto.setNickname(rs.getString("NICKNAME"));
				dto.setRecipeId(rs.getLong("RECIPE_ID"));
				dto.setThumbnail(rs.getString("THUMBNAIL"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setUserId(rs.getString("USER_ID"));
				dto.setViewCount(rs.getInt("VIEW_COUNT"));
				dto.setProfileImg(rs.getString("PROFILE_IMG"));
				dto.setDescription(rs.getString("DESCRIPTION"));
				arr.add(dto);
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}

	// 3. 모든 레시피 평점순 정렬
	public List<ListDTO> avgratingRecipe() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ListDTO> arr = new ArrayList<ListDTO>();
		try {
			con = getConnection();
			String sql = "SELECT R.RECIPE_ID, R.USER_ID, R.CATEGORY_ID, R.TITLE, R.THUMBNAIL, R.DESCRIPTION, "
					+ "R.VIEW_COUNT, R.CREATED_AT, R.IS_DELETED, U.NICKNAME, U.PROFILE_IMG, U.MEDAL_GRADE, "
					+ "NVL(ar.AVG_RATING, 0) AS AVG_RATING "
					+ "FROM RECIPE R LEFT JOIN USERS U ON R.USER_ID = U.USER_ID "
					+ "LEFT JOIN (SELECT RECIPE_ID, AVG(RATING) AS AVG_RATING FROM REVIEW "
					+ "           WHERE IS_DELETED = 0 AND RATING IS NOT NULL GROUP BY RECIPE_ID) ar "
					+ "ON R.RECIPE_ID = ar.RECIPE_ID WHERE R.IS_DELETED = 0 ORDER BY NVL(ar.AVG_RATING, 0) DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setAvgRating(rs.getDouble("AVG_RATING"));
				dto.setCategoryId(rs.getInt("CATEGORY_ID"));
				dto.setCreatedAt(rs.getDate("CREATED_AT"));
				dto.setIsDeleted(rs.getInt("IS_DELETED"));
				dto.setNickname(rs.getString("NICKNAME"));
				dto.setRecipeId(rs.getLong("RECIPE_ID"));
				dto.setThumbnail(rs.getString("THUMBNAIL"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setUserId(rs.getString("USER_ID"));
				dto.setViewCount(rs.getInt("VIEW_COUNT"));
				dto.setProfileImg(rs.getString("PROFILE_IMG"));
				dto.setDescription(rs.getString("DESCRIPTION"));
				arr.add(dto);
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}

	// 4. 카테고리 대분류 목록 출력용
	public List<ListDTO> CategoryButton() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ListDTO> arr = new ArrayList<ListDTO>();
		try {
			con = getConnection();
			String sql = "SELECT * FROM CATEGORY_L";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {	
				ListDTO dto = new ListDTO();
				dto.setCategoryL(rs.getString("NAME")); 
				dto.setCategoryId(rs.getInt("CATEGORYL_ID")); //확인 
				arr.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}
	
	// 5. 카테고리 정렬 + 평점 필터 + 페이징 통합 s
	public List<ListDTO> CategorySort(String sort, String categoryId, String ratingFilter, int currentPage, int totalCount) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ListDTO> arr = new ArrayList<ListDTO>();
		
		try {
			con = getConnection();
			int paramIndex = 1;
			
			String basesql = "SELECT R.RECIPE_ID, R.TITLE, R.DESCRIPTION, R.THUMBNAIL, "
							+ "R.VIEW_COUNT, R.CREATED_AT, R.IS_DELETED, R.CATEGORY_ID, "
							+ "R.USER_ID, U.NICKNAME, U.PROFILE_IMG, "
							+ "NVL(ar.AVG_RATING, 0) AS AVG_RATING "
							+ "FROM RECIPE R "
							+ "INNER JOIN USERS U ON R.USER_ID = U.USER_ID "
							+ "LEFT JOIN (SELECT RECIPE_ID, AVG(RATING) AS AVG_RATING FROM REVIEW "
							+ "           WHERE IS_DELETED = 0 AND RATING IS NOT NULL GROUP BY RECIPE_ID) ar "
							+ "ON R.RECIPE_ID = ar.RECIPE_ID "
							+ "WHERE R.IS_DELETED = 0";
			
			if(categoryId != null && !categoryId.equals("0")) {
				basesql += " AND R.CATEGORY_ID = ?";
			}
			
			double minRating = 0.0;	
			double maxRating = 0.0;
			if (ratingFilter != null && !ratingFilter.equals("0")) {
			    int filterNum = Integer.parseInt(ratingFilter);
			    
			    if (filterNum == 1) { minRating = 4.5; maxRating = 5.0; }
			    else if (filterNum == 2) { minRating = 4.0; maxRating = 4.4; }
			    else if (filterNum == 3) { minRating = 3.5; maxRating = 3.9; }
			    else if (filterNum == 4) { minRating = 3.0; maxRating = 3.4; }
			    else if (filterNum == 5) { minRating = 2.5; maxRating = 2.9; }
			    else if (filterNum == 6) { minRating = 2.0; maxRating = 2.4; }
			    else if (filterNum == 7) { minRating = 1.5; maxRating = 1.9; }
			    else if (filterNum == 8) { minRating = 1.0; maxRating = 1.4; }
			    else if (filterNum == 9) { minRating = 0.5; maxRating = 0.9; }
			    else if (filterNum == 10) { minRating = 0.0; maxRating = 0.4; }
			    
			    basesql += " AND NVL(ar.AVG_RATING, 0) >= ? AND NVL(ar.AVG_RATING, 0) <= ?";
			}
			
			if("desc".equals(sort)) {
				basesql += " ORDER BY R.CREATED_AT DESC";
			} else if("view".equals(sort)) {
				basesql += " ORDER BY NVL(R.VIEW_COUNT, 0) DESC, R.CREATED_AT DESC";
			} else if("avg".equals(sort)) {
				basesql += " ORDER BY NVL(ar.AVG_RATING, 0) DESC";
			}
			
			String sql = "SELECT * FROM ( "
			           + "    SELECT A.*, ROWNUM RN FROM ( "
			           + "        " + basesql
			           + "    ) A WHERE ROWNUM <= ?" 
			           + ") WHERE RN >= ?";
			
			pstmt = con.prepareStatement(sql);
			PagingUtil paging = new PagingUtil(currentPage, totalCount);
			
			if(categoryId != null && !categoryId.equals("0")) {	
				pstmt.setInt(paramIndex++, Integer.parseInt(categoryId));
			}
			
			if (ratingFilter != null && !ratingFilter.equals("0")) {
			    pstmt.setDouble(paramIndex++, minRating);
			    pstmt.setDouble(paramIndex++, maxRating);
			}
			
			pstmt.setInt(paramIndex++, paging.getEndRow());
			pstmt.setInt(paramIndex, paging.getStartRow());
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setAvgRating(rs.getDouble("AVG_RATING"));
				dto.setCategoryId(rs.getInt("CATEGORY_ID"));
				dto.setCreatedAt(rs.getDate("CREATED_AT"));
				dto.setIsDeleted(rs.getInt("IS_DELETED"));
				dto.setNickname(rs.getString("NICKNAME"));
				dto.setRecipeId(rs.getLong("RECIPE_ID"));
				dto.setThumbnail(rs.getString("THUMBNAIL"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setUserId(rs.getString("USER_ID"));
				dto.setViewCount(rs.getInt("VIEW_COUNT"));
				dto.setProfileImg(rs.getString("PROFILE_IMG"));
				dto.setDescription(rs.getString("DESCRIPTION"));
				arr.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}
	
	//  전체글 개수
	public int getTotalCount(String categoryId, String ratingFilter) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;
	    
	    try {
	        con = getConnection();
	        int paramIndex = 1; 
	        
	        String sql = "SELECT COUNT(*) FROM RECIPE R INNER JOIN USERS U ON R.USER_ID = U.USER_ID "
	        		   + "LEFT JOIN (SELECT RECIPE_ID, AVG(RATING) AS AVG_RATING FROM REVIEW "
	        		   + "           WHERE IS_DELETED = 0 AND RATING IS NOT NULL GROUP BY RECIPE_ID) ar "
	        		   + "ON R.RECIPE_ID = ar.RECIPE_ID WHERE R.IS_DELETED = 0";
	        
	        if(categoryId != null && !categoryId.equals("0")) {
	            sql += " AND R.CATEGORY_ID = ?";
	        }
	
	        double minRating = 0.0;
	        double maxRating = 0.0;

	        if (ratingFilter != null && !ratingFilter.equals("0")) {
	            int filterNum = Integer.parseInt(ratingFilter);
	            
	            if (filterNum == 1) { minRating = 4.5; maxRating = 5.1; } 
	            else if (filterNum == 2) { minRating = 4.0; maxRating = 4.5; } 
	            else if (filterNum == 3) { minRating = 3.5; maxRating = 4.0; } 
	            else if (filterNum == 4) { minRating = 3.0; maxRating = 3.5; } 
	            else if (filterNum == 5) { minRating = 2.5; maxRating = 3.0; } 
	            else if (filterNum == 6) { minRating = 2.0; maxRating = 2.5; } 
	            else if (filterNum == 7) { minRating = 1.5; maxRating = 2.0; } 
	            else if (filterNum == 8) { minRating = 1.0; maxRating = 2.5; } 
	            else if (filterNum == 9) { minRating = 0.5; maxRating = 1.0; } 
	            else if (filterNum == 10) { minRating = 0.0; maxRating = 0.5; }
	            
	            sql += " AND NVL(ar.AVG_RATING, 0) >= ? AND NVL(ar.AVG_RATING, 0) < ?";
	        }
	        pstmt = con.prepareStatement(sql);
	        
	        if(categoryId != null && !categoryId.equals("0")) {
	            pstmt.setInt(paramIndex++, Integer.parseInt(categoryId));
	        }
	        if (ratingFilter != null && !ratingFilter.equals("0")) {
	            pstmt.setDouble(paramIndex++, minRating);
	            pstmt.setDouble(paramIndex++, maxRating);
	        }
	        
	        rs = pstmt.executeQuery();
	        if(rs.next()) { 
	            totalCount = rs.getInt(1); 
	        }
	    } catch(Exception e) { 
	        e.printStackTrace(); 
	    } finally {
	        DBUtil.close(con, pstmt, rs); 
	    }
	    return totalCount;   
	}
}