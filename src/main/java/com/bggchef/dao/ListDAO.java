package com.bggchef.dao;
import com.bggchef.util.PagingUtil;
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

	public List<ListDTO> CategoryButton() throws SQLException{
		
		
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
				dto.setCategoryId(rs.getInt("CATEGORYL_ID"));
				
				arr.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}// Categorybutton end
	
public List<ListDTO> CategorySort(String sort, String categoryId, String ratingFilter,  int currentPage, int totalCount) throws SQLException{	// 카테고리 버튼 + 정렬 메소드 + 페이징
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ListDTO> arr = new ArrayList<ListDTO>();
		
		
		try {
			con = getConnection();
			int paramIndex = 1;
			String basesql = "SELECT R.RECIPE_ID, R.TITLE, R.DESCRIPTION, R.THUMBNAIL, "
							+ " R.VIEW_COUNT, R.AVG_RATING, R.CREATED_AT, R.IS_DELETED, R.CATEGORY_ID, "
							+ " R.USER_ID, U.NICKNAME, U.PROFILE_IMG "
							+ "FROM RECIPE R, USERS U WHERE R.USER_ID = U.USER_ID";			// 일단 조건문없이 불러옴 !! 주소창의 카테고리 번호를 가져오기때문에 카테고리 테이블 필요없음!!
			
			if(categoryId != null && !categoryId.equals("0")) {		// if문의 조건에 맞을 시 sql의 조건문 추가, WHERE 앞에 띄어쓰기 필수
				basesql += " AND R.CATEGORY_ID = ?";
			}
			
			double minRating = 0.0;											//평점버튼 시작
			double maxRating = 0.0;
			if (ratingFilter != null && !ratingFilter.equals("0")) {
			    int filterNum = Integer.parseInt(ratingFilter);
			    if (filterNum == 10) {
			        minRating = -0.1; 				// 0점대 레시피 포함
			        maxRating = 0.5;
			    } else {
			        maxRating = 5.5 - (0.5 * filterNum);
			        minRating = maxRating - 0.5;
			    }
			    basesql += " AND R.AVG_RATING > ? AND R.AVG_RATING <= ?";
			}																		//평점버튼 끝
			
			
			if("desc".equals(sort)) {
				basesql += " ORDER BY R.CREATED_AT DESC";
			}else if("view".equals(sort)) {
				basesql += " ORDER BY R.VIEW_COUNT DESC";
			}else if("avg".equals(sort)) {
				basesql += " ORDER BY R.AVG_RATING DESC";
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
			
			// 평점 필터 물음표 바인딩
			if (ratingFilter != null && !ratingFilter.equals("0")) {
			    pstmt.setDouble(paramIndex++, minRating);
			    pstmt.setDouble(paramIndex++, maxRating);
			}
			
			pstmt.setInt(paramIndex++,paging.getEndRow());
			pstmt.setInt(paramIndex,paging.getStartRow());
		
			rs = pstmt.executeQuery();
			
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
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}
		return arr;
	}// 카테고리 버튼+정렬 메소드 끝
	
	public int getTotalCount(String categoryId, String ratingFilter) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;
	    
	    try {
	        con = getConnection();
	        // 바인딩 인덱스용 변수
	        int paramIndex = 1; 
	        
	        String sql = "SELECT COUNT(*) FROM RECIPE WHERE IS_DELETED = 0";
	        
	        // 카테고리
	        if(categoryId != null && !categoryId.equals("0")) {
	            sql += " AND CATEGORY_ID = ?";
	        }
	
	        // 평점버튼
	        double minRating = 0.0;
	        double maxRating = 0.0;
	        if (ratingFilter != null && !ratingFilter.equals("0")) {
	            int filterNum = Integer.parseInt(ratingFilter);
	            if (filterNum == 10) {
	                minRating = -0.1;
	                maxRating = 0.5;
	            } else {
	                maxRating = 5.5 - (0.5 * filterNum);
	                minRating = maxRating - 0.5;
	            }
	            sql += " AND AVG_RATING > ? AND AVG_RATING <= ?";
	        }
	        
	        pstmt = con.prepareStatement(sql);
	        
	        if(categoryId != null && !categoryId.equals("0")) {
	            pstmt.setInt(paramIndex++, Integer.parseInt(categoryId));
	        }
	        if (ratingFilter != null && !ratingFilter.equals("0")) {
	            pstmt.setDouble(paramIndex++, minRating);
	            pstmt.setDouble(paramIndex++, maxRating);
	        }
	        
	        // 실행 및 결과 받기
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
	
	
}//listDAO end
