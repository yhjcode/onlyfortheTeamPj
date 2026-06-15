package com.bggchef.dao;
import java.util.*;

import com.bggchef.dto.ListDTO;
import com.bggchef.util.DBUtil;
import java.sql.*;

public class ListDAO {
	
	
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
	
	
public List<ListDTO> descRecipe()throws SQLException{	// ----------------------------- 모든레시피 desc 정렬
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		List<ListDTO> arr = new ArrayList<ListDTO>();
		try {
			
			con = getConnection(); //DB연결
			String sql ="SELECT R.*, U.NICKNAME, U.PROFILE_IMG, U.MEDAL_GRADE FROM RECIPE R"
					+ " LEFT JOIN USERS U ON R.USER_ID=U.USER_ID ORDER BY CREATED_AT DESC";
			pstmt = con.prepareStatement(sql);
	
			rs = pstmt.executeQuery(); //쿼리문 실행 결과가 rs로 들어옴
			
			while(rs.next()) {	// 1. rs값을 dto에 넣고 2.dto 전체를 리스트에 추가  set으로 넣고 매개변수는 db컬럼이름
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
			System.out.println("==========> DB에서 가져온 레시피 개수: " + arr.size() + "개");
			
		} catch (Exception se) {
			se.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}//descList end	

public List<ListDTO> viewcountRecipe()throws SQLException{	// ----------------------------- 모든레시피 viewcount 정렬
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	
	List<ListDTO> arr = new ArrayList<ListDTO>();
	try {
		
		con = getConnection(); //DB연결
		String sql ="SELECT R.*, U.NICKNAME, U.PROFILE_IMG, U.MEDAL_GRADE FROM RECIPE R"
				+ " LEFT JOIN USERS U ON R.USER_ID=U.USER_ID ORDER BY VIEW_COUNT DESC";
		pstmt = con.prepareStatement(sql);

		rs = pstmt.executeQuery(); //쿼리문 실행 결과가 rs로 들어옴
		
		while(rs.next()) {	// 1. rs값을 dto에 넣고 2.dto 전체를 리스트에 추가  set으로 넣고 매개변수는 db컬럼이름
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
	}finally {
		DBUtil.close(con, pstmt, rs);
	}
	return arr;
}//viewcountRecipe end

public List<ListDTO> avgratingRecipe()throws SQLException{	// ----------------------------- 모든레시피 avgrating 정렬
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	
	List<ListDTO> arr = new ArrayList<ListDTO>();
	try {
		
		con = getConnection(); //DB연결
		String sql ="SELECT R.*, U.NICKNAME, U.PROFILE_IMG, U.MEDAL_GRADE FROM RECIPE R"
				+ " LEFT JOIN USERS U ON R.USER_ID=U.USER_ID ORDER BY AVG_RATING DESC";
		pstmt = con.prepareStatement(sql);

		rs = pstmt.executeQuery(); //쿼리문 실행 결과가 rs로 들어옴
		
		while(rs.next()) {	// 1. rs값을 dto에 넣고 2.dto 전체를 리스트에 추가  set으로 넣고 매개변수는 db컬럼이름
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
	}finally {
		DBUtil.close(con, pstmt, rs);
	}
	return arr;
}

	
	
	
	
}//listDAO end
