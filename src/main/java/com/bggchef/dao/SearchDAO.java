package com.bggchef.dao;

import java.sql.*;
import java.util.*;
import com.bggchef.util.DBUtil;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
import com.bggchef.dto.UserDTO;

public class SearchDAO {
	
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
	
	// 1. 레시피 리스트 조회 (삭제된 글 방지: R.IS_DELETED = 0)
	public List<RecipeDTO> searchRecipe(String keyword, int currentPage, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		List<RecipeDTO> arr = new ArrayList<RecipeDTO>();
		try {
			con = getConnection();
			String sql = "SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM ("
					+ "SELECT R.*, U.NICKNAME FROM RECIPE R LEFT JOIN USERS U ON "
					+ "R.USER_ID = U.USER_ID WHERE UPPER(R.TITLE) LIKE UPPER(?) AND R.IS_DELETED = 0 "
					+ "ORDER BY R.CREATED_AT DESC) A WHERE ROWNUM <= ?) WHERE RNUM >= ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.trim() + "%");
			pstmt.setInt(2, endRow);
			pstmt.setInt(3, startRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RecipeDTO dto = new RecipeDTO();
				dto.setAvgRating(rs.getDouble("AVG_RATING"));
				dto.setCategoryId(rs.getInt("CATEGORY_ID"));
				dto.setCookTime(rs.getInt("COOK_TIME"));
				dto.setCreatedAt(rs.getDate("CREATED_AT"));
				dto.setDifficulty(rs.getInt("DIFFICULTY"));
				dto.setIsDeleted(rs.getInt("IS_DELETED"));
				dto.setNickname(rs.getString("NICKNAME"));
				dto.setRecipeId(rs.getLong("RECIPE_ID"));
				dto.setServings(rs.getInt("SERVINGS"));
				dto.setThumbnail(rs.getString("THUMBNAIL"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setUserId(rs.getString("USER_ID"));
				dto.setViewCount(rs.getInt("VIEW_COUNT"));
				arr.add(dto);
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(con != null) try { con.close(); } catch(SQLException s) { s.printStackTrace(); }
		}
		return arr;
	}
	
	// 2. 테마 리스트 조회 (노출 설정된 테마만: R.IS_VISIBLE = 1)
	public List<ThemeDTO> searchTheme(String keyword, int currentPage, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		List<ThemeDTO> arr = new ArrayList<ThemeDTO>();
		try {
			con = getConnection();
			String sql = "SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM ("
					+ "SELECT R.*, U.NICKNAME FROM RECOMMENDED_THEME R LEFT OUTER JOIN "
					+ "USERS U ON R.USER_ID = U.USER_ID WHERE UPPER(R.TITLE) LIKE UPPER(?) AND R.IS_VISIBLE = 1 "
					+ "ORDER BY R.CREATED_AT DESC) A WHERE ROWNUM <= ?) WHERE RNUM >= ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.trim() + "%");
			pstmt.setInt(2, endRow);
			pstmt.setInt(3, startRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ThemeDTO dto = new ThemeDTO();
				dto.setCreatedAt(rs.getDate("CREATED_AT"));
				dto.setDescription(rs.getString("DESCRIPTION"));
				dto.setIsVisible(rs.getInt("IS_VISIBLE"));
				dto.setLinkUrl(rs.getString("LINK_URL"));
				dto.setThemeId(rs.getInt("THEME_ID"));
				dto.setThumbnail(rs.getString("THUMBNAIL"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setUserId(rs.getString("USER_ID"));
				dto.setViewCount(rs.getInt("VIEW_COUNT"));
				dto.setNickname(rs.getString("NICKNAME"));
				arr.add(dto);
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(con != null) try { con.close(); } catch(SQLException s) { s.printStackTrace(); }
		}
		return arr;
	}

	// 3. 셰프 리스트 조회 (탈퇴 안 한 유저만: U.IS_DELETED = 0)
	public List<UserDTO> searchUser(String keyword, int currentPage, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		List<UserDTO> arr = new ArrayList<UserDTO>();
		try {
			con = getConnection();
			String sql = "SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM ("
					+ "SELECT U.USER_ID, U.NICKNAME, U.PROFILE_IMG, U.IS_DELETED, U.MEDAL_GRADE, "
					+ "AVG(R.AVG_RATING) AS AVGAVG_RATING "
					+ "FROM USERS U LEFT JOIN RECIPE R ON U.USER_ID = R.USER_ID WHERE U.NICKNAME LIKE ? AND U.IS_DELETED = 0 "
					+ "GROUP BY U.USER_ID, U.NICKNAME, U.PROFILE_IMG, U.IS_DELETED, U.MEDAL_GRADE) A "
					+ "WHERE ROWNUM <= ?) WHERE RNUM >= ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.trim() + "%");
			pstmt.setInt(2, endRow);
			pstmt.setInt(3, startRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				dto.setUserId(rs.getString("USER_ID"));
				dto.setNickname(rs.getString("NICKNAME"));
				dto.setMedalGrade(rs.getString("MEDAL_GRADE"));
				dto.setProfileImg(rs.getString("PROFILE_IMG"));
				dto.setIsDeleted(rs.getInt("IS_DELETED"));
				dto.setAvgRating(rs.getDouble("AVGAVG_RATING"));
				arr.add(dto);
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(con != null) try { con.close(); } catch(SQLException s) { s.printStackTrace(); }
		}
		return arr;
	}

	// 4. 레시피 총 개수 (삭제된 글 방지: IS_DELETED = 0)
	public int getRecipeCount(String keyword) {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "SELECT COUNT(*) AS CNT FROM RECIPE WHERE UPPER(TITLE) LIKE UPPER(?) AND IS_DELETED = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.trim() + "%");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("CNT");
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(con != null) try { con.close(); } catch(SQLException s) { s.printStackTrace(); }
		}
		return totalCount;
	}

	// 5. 테마 총 개수 (노출 설정된 테마만: R.IS_VISIBLE = 1)
	public int getThemeCount(String keyword) {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "SELECT COUNT(*) AS CNT FROM ("
					+ "SELECT R.* FROM RECOMMENDED_THEME R WHERE UPPER(R.TITLE) LIKE UPPER(?) AND R.IS_VISIBLE = 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.trim() + "%");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("CNT");
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(con != null) try { con.close(); } catch(SQLException s) { s.printStackTrace(); }
		}
		return totalCount;
	}

	// 6. 셰프 총 개수 (탈퇴 안 한 유저만: U.IS_DELETED = 0)
	public int getUserCount(String keyword) {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "SELECT COUNT(*) AS CNT FROM (SELECT U.USER_ID FROM USERS U "
					+ "LEFT JOIN RECIPE R ON U.USER_ID = R.USER_ID WHERE U.NICKNAME LIKE ? AND U.IS_DELETED = 0 "
					+ "GROUP BY U.USER_ID)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.trim() + "%");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("CNT");
			}
		} catch (Exception se) {
			se.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException s) { s.printStackTrace(); }
			if(con != null) try { con.close(); } catch(SQLException s) { s.printStackTrace(); }
		}
		return totalCount;
	}
}