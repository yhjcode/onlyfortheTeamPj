




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
            throws ServletException, IOException {
        
        // 1. 브라우저가 Ajax로 보낸 recipe_id 받기
        String recipeIdParam = req.getParameter("recipe_id");
        if (recipeIdParam == null || recipeIdParam.isEmpty()) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing recipe_id");
            return;
        }
        
        long recipeId = Long.parseLong(recipeIdParam);
        
        try {
            // 2. DB에서 해당 레시피의 댓글 목록 가져오기
            List<ReviewDTO> list = reviewDAO.selectByRecipeId(recipeId);
            
            // 3. 브라우저에게 JSON 형식과 인코딩(UTF-8) 선언 (매우 중요!)
            res.setContentType("application/json; charset=UTF-8");
            PrintWriter out = res.getWriter();
            
            // 4. Java 17 Text Blocks 기법을 활용한 수동 JSON 조립
            StringBuilder json = new StringBuilder();
            json.append("[");
            
            for (int i = 0; i < list.size(); i++) {
                ReviewDTO dto = list.get(i);
                
                // 특수문자나 개행문자로 인해 JSON 문법이 깨지는 것을 방지하기 위해 치환 처리
                String safeContent = dto.getContent()
                                        .replace("\\", "\\\\")
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
                
                if (i < list.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            
            // 5. 조립 완료된 JSON 텍스트 전송
            out.print(json.toString());
            out.flush();
            out.close();
            
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
            // 1. 세션에서 로그인한 유저 객체 꺼내기
            var session = req.getSession();
            Object loginUser = session.getAttribute("loginUser"); 
            
            String userId = null;
            
            // 💡 [에러 해결 포인트] loginUser가 String이 아니라 UserDTO 타입이므로 올바르게 형변환(Casting)을 진행합니다.
            if (loginUser != null) {
                com.bggchef.dto.UserDTO userDto = (com.bggchef.dto.UserDTO) loginUser;
                
                // ⚠️ 본인의 UserDTO 클래스 안에 있는 '유저아이디를 반환하는 Getter 메서드명'으로 확인해 보세요.
                // 보통 getUserId() 또는 getId() 일 확률이 높습니다. 본인 메서드명에 맞게 소문자/대문자를 맞춰주세요.
                userId = userDto.getUserId(); 
            }
            
            // 만약 로그인 세션이 풀렸거나 아이디를 못 가져온 경우 방어 코드
            if (userId == null || userId.isEmpty()) {
                res.getWriter().print("login_required");
                return;
            }

            // 2. 브라우저가 보낸 파라미터 받기
            String recipeIdParam = req.getParameter("recipe_id");
            String ratingParam = req.getParameter("rating");
            String content = req.getParameter("content");
            
            long recipeId = Long.parseLong(recipeIdParam);
            double rating = Double.parseDouble(ratingParam);
            
            // 3. DTO 데이터 세팅
            ReviewDTO dto = new ReviewDTO();
            dto.setUserId(userId);
            dto.setRecipeId(recipeId);
            dto.setRating(rating);
            dto.setContent(content);
            
            // 4. DB 저장 처리
            int result = reviewDAO.insertReview(dto);
            
            // 5. 성공 결과 전송
            if (result > 0) {
                res.getWriter().print("success");
            } else {
                res.getWriter().print("fail_db");
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
