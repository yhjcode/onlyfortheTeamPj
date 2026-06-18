




package com.bggchef.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bggchef.dao.ReviewDAO;
import com.bggchef.dto.ReviewDTO;

/**
 * 리뷰/대댓글 (REQ_REC_012)
 * URL: /review/list
 */
@WebServlet("/review/list")
public class ReviewController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {                                                 // 레시피 상세페이지에서 댓글목록 조회요청을 받았을 때
        
       
        String recipeIdParam = req.getParameter("recipe_id");                                  // 레시피id 저장
        if (recipeIdParam == null || recipeIdParam.isEmpty()) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing recipe_id");    // 레시피id가 null이거나 비어있으면 오류메시지 전송과 함께 종료
            return;
        }
        
        long recipeId = Long.parseLong(recipeIdParam);                                        // 레시피id를 long타입으로 형변환하여 저장
        
        try {
          
            List<ReviewDTO> list = reviewDAO.selectByRecipeId(recipeId);                  //레시피id에 해당하는 모든 댓글dto(행)로 이루어진dto리스트를 리턴하여 저장
            
            
            res.setContentType("application/json; charset=UTF-8");                            //브라우저에게 응답할 데이터의 타입이(댓글dto list)json형식이라고 명시
            
            PrintWriter out = res.getWriter();                                                       //브라우저로 json형식의 데이터를 보낼 단방향 스트림 생성
            
            // 4. Java 17 Text Blocks 기법을 활용한 수동 JSON 조립
            StringBuilder json = new StringBuilder();                                             //StringBuilder 클래스로 하나의 문자열객체 안에 댓글DTO 리스트의 데이터들을 전부 저장하도록 세팅
            json.append("[");                                                                           // [ 로 js가 인식할 json배열의 시작점 미리 세팅
            
            for (int i = 0; i < list.size(); i++) {
                ReviewDTO dto = list.get(i);
                
                
                //////
                /// gson.jar추가시
                /// 
                /// String jsonStr = new Gson().toJson(list); 
                /// 스트링빌더클래스도 생략가능

               
                String safeContent = dto.getContent()
                                        .replace("\\", "\\\\")                                      //json 줄바꿈 오류 방지작업
                                        .replace("\"", "\\\"")
                                        .replace("\n", "\\n")
                                        .replace("\r", "");
                
                String jsonItem = """
                {
                    "reviewId": %d,
                    "userId": "%s",
                    "nickname": "%s",
                    "rating": %.1f,
                    "content": "%s",
                    "createdAt": "%s"                                                                   
                }""".formatted(            
                    dto.getReviewId(),
                    dto.getUserId(),
                    dto.getNickname(),
                    dto.getRating(),
                    safeContent,
                    dto.getCreatedAt().toString()
                );
                
                json.append(jsonItem);                                                               
                
                if (i < list.size() - 1) {                                                                    //마지막 댓글이 아니면 , 를 찍어라
                    json.append(",");
                }
            }
            json.append("]");
            
            // 5. 조립 완료된 JSON 텍스트 전송
            out.print(json.toString());
            out.flush();
            out.close();                                                                                    // 스트림 반납
            
        } catch (SQLException e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
    
    
    
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // 인코딩 설정 (한글 깨짐 방지)
        req.setCharacterEncoding("UTF-8");
        
        try {
            
            var session = req.getSession();                                                          //  세션에서 로그인한 유저 객체 꺼내기(쿠키)
            Object loginUser = session.getAttribute("loginUser");                              //loginUser(키)의 값인 UserDTO 객체를   Object loginUser에 저장
            
            String userId = null;                                                                     
            
            
            if (loginUser != null) {
                com.bggchef.dto.UserDTO userDto = (com.bggchef.dto.UserDTO) loginUser;// 이 프로젝트의 userDTO로 형변환하여 DTO타입 참조변수에 저장
                
                
                userId = userDto.getUserId(); 
            }
            
           
            if (userId == null || userId.isEmpty()) {
                res.getWriter().print("login_required");
                return;
            }

         
            String recipeIdParam = req.getParameter("recipe_id");                                //  브라우저가 보낸 파라미터 받기
            String ratingParam = req.getParameter("rating");
            String content = req.getParameter("content");
            
            long recipeId = Long.parseLong(recipeIdParam);
            double rating = Double.parseDouble(ratingParam);                                   // 댓글DTO필드타입에 맞도록 형변환
            
           
            ReviewDTO dto = new ReviewDTO();                                                     // DTO 데이터 세팅
            dto.setUserId(userId);
            dto.setRecipeId(recipeId);
            dto.setRating(rating);
            dto.setContent(content);
            
            
            int result = reviewDAO.insertReview(dto);                                               // DB 저장 처리
            
         
            if (result > 0) {
                res.getWriter().print("success");
            } else {
                res.getWriter().print("fail_db");
                 System.out.println("댓글,댓글정보를 db에 저장 실패");
            }
            
        } catch (Exception e) {
            System.out.println("💥 [댓글 등록 서블릿 에러 발생] 원인 설명: ");
            e.printStackTrace(); 
            res.getWriter().print("error: " + e.getMessage());
        }
    }

    
    
    
    
    
    
    
//    protected void doPost(HttpServletRequest req, HttpServletResponse res)
//            throws ServletException, IOException {
//        doGet(req, res);
//    }
}










//package com.bggchef.controller;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
///**
// * 리뷰/대댓글 (REQ_REC_012)
// * URL: /review/list
// */
//@WebServlet("/review/list")
//public class ReviewController extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse res)
//            throws ServletException, IOException {
//        // TODO: 비즈니스 로직 + DAO 호출 + request 속성 set
//        req.setAttribute("contentPage", "/WEB-INF/views/recipe/view.jsp");
//        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
//        
//        
//        //
//        
//        
//        
//        
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse res)
//            throws ServletException, IOException {
//        // 기본은 doGet으로 위임. POST 동작이 다르면 분리 구현
//        doGet(req, res);
//        
//        
//        
//        
//    }
//}
