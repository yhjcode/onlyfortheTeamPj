package com.bggchef.dao;
import java.sql.*;
import java.util.*;
import com.bggchef.util.DBUtil;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
// 쉐프 검색, 재료별 검색 만들어야함!!! 아래 쿼리문 복사해서 수정만 하면 됌!!!


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
	//일단 데이터 검색기능부터 만들것
	
	public List<RecipeDTO> searchRecipe(String keyword){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		List<RecipeDTO> arr = new ArrayList<RecipeDTO>();
		try {
			con = getConnection(); //DB연결
			String sql ="SELECT r.*, u.nickname FROM RECIPE r "
			           + "INNER JOIN USERS u ON r.user_id = u.user_id "
			           + "WHERE r.TITLE LIKE ? "
			           + "ORDER BY r.created_at";		//%는 바인딩할떄 추가
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+keyword+"%");
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
	
	
public List<ThemeDTO> searchTheme(String keyword){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		List<ThemeDTO> arr = new ArrayList<ThemeDTO>();
		try {
			con = getConnection(); //DB연결
			String sql ="SELECT R.* ,U.NICKNAME FROM"
					+ " RECOMMENDED_THEME R, USERS U WHERE"
					+ " R.USER_ID=U.USER_ID AND R.TITLE LIKE ? ORDER BY CREATED_AT";		//%는 바인딩할떄 추가
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+keyword+"%");
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
	
	
	
}// end SearchDAO
