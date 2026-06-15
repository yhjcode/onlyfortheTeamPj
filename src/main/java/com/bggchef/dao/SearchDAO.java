package com.bggchef.dao;
import java.sql.*;
import java.util.*;
import com.bggchef.util.DBUtil;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
// 쉐프 검색, 재료별 검색 만들어야함!!! 아래 쿼리문 복사해서 수정만 하면 됌!!!
import com.bggchef.dto.UserDTO;


public class SearchDAO {
	
	private Connection getConnection() {
		Connection con= null;
		
		try {
			con = DBUtil.getConnection();
		} catch (Exception e) {
			System.out.println("Conection 생성 실패@@");
			e.printStackTrace();
		}
		return con;
	}
	
	public List<RecipeDTO> searchRecipe(String keyword, int currentPage, int pageSize){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		int startRow = (currentPage -1) * pageSize + 1;		// 이거 두개는 페이징의 공식
		int endRow = currentPage * pageSize;
		
		List<RecipeDTO> arr = new ArrayList<RecipeDTO>();
		try {
			
			con = getConnection(); //DB연결
			String sql ="SELECT * FROM(SELECT ROWNUM AS RNUM, A.* FROM("
					+ "SELECT R.*, U.NICKNAME FROM RECIPE R LEFT JOIN USERS U ON "
					+ "R.USER_ID = U.USER_ID WHERE UPPER(R.TITLE) LIKE UPPER(?) ORDER BY R.CREATED_AT DESC) A "
					+ "WHERE ROWNUM <=?) WHERE RNUM >=?";		//%는 바인딩할떄 추가
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+keyword.trim()+"%");
			pstmt.setInt(2,endRow);
			pstmt.setInt(3,startRow);
			
			
			rs = pstmt.executeQuery(); //쿼리문 실행 결과가 rs로 들어옴
			
			while(rs.next()) {	// 1. rs값을 dto에 넣고 2.dto 전체를 리스트에 추가  set으로 넣고 매개변수는 db컬럼이름
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
		}finally {
			if(rs !=null)try {rs.close();}catch(SQLException s) {s.printStackTrace();}
			if(pstmt !=null)try {pstmt.close();}catch(SQLException s) {s.printStackTrace();}
			if(con !=null)try {con.close();}catch(SQLException s) {s.printStackTrace();}
		}
		return arr;
	}// end searchRecipe
	
	
public List<ThemeDTO> searchTheme(String keyword, int currentPage, int pageSize){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		int startRow = (currentPage -1) * pageSize + 1;		// 이거 두개는 페이징의 공식
		int endRow = currentPage * pageSize;
		
		List<ThemeDTO> arr = new ArrayList<ThemeDTO>();
		try {
			con = getConnection(); //DB연결
			String sql ="SELECT * FROM(SELECT ROWNUM AS RNUM, A.* "
					+ "FROM(SELECT R.*, U.NICKNAME FROM RECOMMENDED_THEME R LEFT OUTER JOIN "
					+ "USERS U ON R.USER_ID = U.USER_ID WHERE UPPER(R.TITLE) LIKE UPPER(?) ORDER BY R.CREATED_AT DESC) A "
					+ "WHERE ROWNUM <=?) WHERE RNUM >=?";		//%는 바인딩할떄 추가
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+keyword.trim()+"%");
			pstmt.setInt(2,endRow);
			pstmt.setInt(3,startRow);
			
			
			rs = pstmt.executeQuery(); //쿼리문 실행 결과가 rs로 들어옴
			
			while(rs.next()) {	// 1. rs값을 dto에 넣고 2.dto 전체를 리스트에 추가  set으로 넣고 매개변수는 db컬럼이름
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
		}finally {
			if(rs !=null)try {rs.close();}catch(SQLException s) {s.printStackTrace();}
			if(pstmt !=null)try {pstmt.close();}catch(SQLException s) {s.printStackTrace();}
			if(con !=null)try {con.close();}catch(SQLException s) {s.printStackTrace();}
		}
		return arr;
	}//end serachTheme
public List<UserDTO> searchUser(String keyword, int currentPage, int pageSize){
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	
	int startRow = (currentPage -1) * pageSize + 1;		// 이거 두개는 페이징의 공식
	int endRow = currentPage * pageSize;
	
	List<UserDTO> arr = new ArrayList<UserDTO>();
	try {
		con = getConnection(); //DB연결
		String sql ="SELECT * FROM(SELECT ROWNUM AS RNUM, A.* FROM"
				+ "(SELECT U.USER_ID, U.NICKNAME, U.PROFILE_IMG, U.IS_DELETED, U.MEDAL_GRADE,"
				+ " AVG(R.AVG_RATING) AS AVGAVG_RATING"
				+ " FROM USERS U LEFT JOIN RECIPE R ON U.USER_ID = R.USER_ID  WHERE U.NICKNAME LIKE ?"
				+ " GROUP BY U.USER_ID, U.NICKNAME, U.PROFILE_IMG, U.IS_DELETED, U.MEDAL_GRADE) A"
				+ " WHERE ROWNUM <=?) WHERE RNUM >=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,"%"+keyword+"%");
		pstmt.setInt(2, endRow);
		pstmt.setInt(3, startRow);
		rs = pstmt.executeQuery(); //쿼리문 실행 결과가 rs로 들어옴
		
		while(rs.next()) {	// 1. rs값을 dto에 넣고 2.dto 전체를 리스트에 추가  set으로 넣고 매개변수는 db컬럼이름
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
	}finally {
		if(rs !=null)try {rs.close();}catch(SQLException s) {s.printStackTrace();}
		if(pstmt !=null)try {pstmt.close();}catch(SQLException s) {s.printStackTrace();}
		if(con !=null)try {con.close();}catch(SQLException s) {s.printStackTrace();}
	}
	return arr;
	}

public int getRecipeCount(String keyword) {
	int totalCount = 0;
	
	Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        con = getConnection();
        String sql = "SELECT COUNT(*) AS CNT FROM RECIPE WHERE UPPER(TITLE) LIKE UPPER(?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, "%" + keyword.trim() + "%");
        
        rs = pstmt.executeQuery();
        if(rs.next()) {
            totalCount = rs.getInt("CNT");
        }
    }catch (Exception se) {
		se.printStackTrace();
	}finally {
		if(rs !=null)try {rs.close();}catch(SQLException s) {s.printStackTrace();}
		if(pstmt !=null)try {pstmt.close();}catch(SQLException s) {s.printStackTrace();}
		if(con !=null)try {con.close();}catch(SQLException s) {s.printStackTrace();}
	}
	
	return totalCount;
}//end recipecount
public int getThemeCount(String keyword) {
	int totalCount = 0;
	
	Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        con = getConnection();
        String sql = "SELECT COUNT(*) AS CNT FROM"
        		+ "(SELECT R.*, U.NICKNAME FROM RECOMMENDED_THEME R LEFT OUTER JOIN "
        		+ "USERS U ON R.USER_ID = U.USER_ID WHERE UPPER(R.TITLE) LIKE UPPER(?) ORDER BY R.CREATED_AT DESC)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, "%" + keyword.trim() + "%");
        
        rs = pstmt.executeQuery();
        if(rs.next()) {
            totalCount = rs.getInt("CNT");
        }
    }catch (Exception se) {
		se.printStackTrace();
	}finally {
		if(rs !=null)try {rs.close();}catch(SQLException s) {s.printStackTrace();}
		if(pstmt !=null)try {pstmt.close();}catch(SQLException s) {s.printStackTrace();}
		if(con !=null)try {con.close();}catch(SQLException s) {s.printStackTrace();}
	}
	
	return totalCount;
}// end themecount
public int getUserCount(String keyword) {
	int totalCount = 0;
	
	Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        con = getConnection();
        String sql = "SELECT COUNT(*) AS CNT FROM(SELECT U.USER_ID, U.NICKNAME, U.PROFILE_IMG, U.IS_DELETED,"
        		+ " U.MEDAL_GRADE, AVG(R.AVG_RATING) AS AVGAVG_RATING"
        		+ " FROM USERS U LEFT JOIN RECIPE R ON U.USER_ID = R.USER_ID  WHERE U.NICKNAME LIKE ?"
        		+ " GROUP BY U.USER_ID, U.NICKNAME, U.PROFILE_IMG, U.IS_DELETED, U.MEDAL_GRADE)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, "%" + keyword.trim() + "%");
        
        rs = pstmt.executeQuery();
        if(rs.next()) {
            totalCount = rs.getInt("CNT");
        }
    }catch (Exception se) {
		se.printStackTrace();
	}finally {
		if(rs !=null)try {rs.close();}catch(SQLException s) {s.printStackTrace();}
		if(pstmt !=null)try {pstmt.close();}catch(SQLException s) {s.printStackTrace();}
		if(con !=null)try {con.close();}catch(SQLException s) {s.printStackTrace();}
	}
	
	return totalCount;
}//end usercount
}// end SearchDAO
