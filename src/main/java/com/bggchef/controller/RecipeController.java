package com.bggchef.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bggchef.dao.RecipeDAO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.RecipeIngredientDTO;
import com.bggchef.dto.RecipeStepDTO;
import com.bggchef.dto.UserDTO;
import com.bggchef.util.FileUtil;

@WebServlet(urlPatterns = {
        "/recipe/list",
        "/recipe/write",
        "/recipe/view",
        "/recipe/edit",
        "/recipe/delete"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 80
)
public class RecipeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String RECIPE_UPLOAD_DIR = "/resources/upload/recipe";
    private static final String STEP_UPLOAD_DIR = "/resources/upload/step";

    private final RecipeDAO recipeDAO = new RecipeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String path = req.getServletPath(); // 매핑정보를 Path에 저장

        try {
            if ("/recipe/write".equals(path)) { 
                showWriteForm(req, res);
            } else if ("/recipe/view".equals(path)) {
                showView(req, res);
            } else if ("/recipe/edit".equals(path)) {
                showEditForm(req, res);
            } else if ("/recipe/delete".equals(path)) {
                res.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            } else {
                showList(req, res);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
    
    
    
    //////////////////
    /// 
    /// 
    /// 



    //////////////////
    /// 
    /// 
    /// 

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String path = req.getServletPath();

        try {
            if ("/recipe/write".equals(path)) {
                insertRecipe(req, res);
            } else if ("/recipe/edit".equals(path)) {
                updateRecipe(req, res);
            } else if ("/recipe/delete".equals(path)) {
                deleteRecipe(req, res);
            } else {
                doGet(req, res);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }




    
    
    
    
//1
    private void showWriteForm(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        requireLogin(req, res); // 로그인 체크
        if (res.isCommitted()) return; // 비회원일 경우 리턴처리

        req.setAttribute("categoryList", recipeDAO.selectCategoryList()); // 카테고리 리스트를 불러와서 req에 저장
        forward(req, res, "/WEB-INF/views/recipe/write.jsp");  // req에 담긴 카테고리 리스트로  write.do.jsp화면을 조립해서 사용자 브라우저에 전달
    }
    
    
 //2


 //2

    private void showEditForm(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        requireLogin(req, res);
        if (res.isCommitted()) return;

        long recipeId = parseLong(req.getParameter("recipe_id"), parseLong(req.getParameter("id"), 0L));
        RecipeDTO recipe = recipeDAO.selectRecipeById(recipeId);
        if (recipe == null) {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.setAttribute("recipe", recipe);
        req.setAttribute("ingredients", recipe.getIngredients());
        req.setAttribute("steps", recipe.getSteps());
        req.setAttribute("categoryList", recipeDAO.selectCategoryList());
        forward(req, res, "/WEB-INF/views/recipe/edit.jsp");
    }
    
    
    
    
    
   //3





   //3

    private void showView(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        long recipeId = parseLong(req.getParameter("recipe_id"), parseLong(req.getParameter("id"), 0L));
        if (recipeId <= 0) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        recipeDAO.increaseViewCount(recipeId);
        RecipeDTO recipe = recipeDAO.selectRecipeById(recipeId);
        if (recipe == null) {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ================= [최종 검증 완료된 권한 체크 구역] =================
        javax.servlet.http.HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        
        boolean isAuthor = false;
        
        // 비회원(null) 방어 및 작성자 아이디(recipe.getUserId()) 일치 판별 완료
        if (loginUser != null && loginUser.getUserId() != null && loginUser.getUserId().equals(recipe.getUserId())) {
            isAuthor = true;
        }
        
        req.setAttribute("isAuthor", isAuthor);
        // ===================================================================

        req.setAttribute("recipe", recipe);
        req.setAttribute("ingredients", recipe.getIngredients());
        req.setAttribute("steps", recipe.getSteps());
        forward(req, res, "/WEB-INF/views/recipe/view.jsp");
    }

//    private void showView(HttpServletRequest req, HttpServletResponse res)
//            throws SQLException, ServletException, IOException {
//        long recipeId = parseLong(req.getParameter("recipe_id"), parseLong(req.getParameter("id"), 0L));
//        if (recipeId <= 0) {
//            res.sendError(HttpServletResponse.SC_BAD_REQUEST);
//            return;
//        }
//
//        recipeDAO.increaseViewCount(recipeId);
//        RecipeDTO recipe = recipeDAO.selectRecipeById(recipeId);
//        if (recipe == null) {
//            res.sendError(HttpServletResponse.SC_NOT_FOUND);
//            return;
//        }
//
//        req.setAttribute("recipe", recipe);
//        req.setAttribute("ingredients", recipe.getIngredients());
//        req.setAttribute("steps", recipe.getSteps());
//        forward(req, res, "/WEB-INF/views/recipe/view.jsp");
//    }










    //4
    private void showList(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        forward(req, res, "/WEB-INF/views/recipe/list.jsp");
    }



    //5
    private void insertRecipe(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        UserDTO loginUser = requireLogin(req, res);// 로그인 세션 
        if (res.isCommitted()) return; //이미 응답확정 처리 됏으묜 리턴

        RecipeDTO recipe = buildRecipe(req);// write페이지에서 입력받은데이터로 채워진레시피DTO객체 recipe변수에 참조
        recipe.setUserId(loginUser.getUserId());//세션에서 추출한 id정보를 레시피DTO에 저장
        recipe.setThumbnail(saveSingleFile(req.getPart("thumbnail_file"), RECIPE_UPLOAD_DIR));// 썸네일url정보 레시피DTO썸네일 필드에 저장

        List<RecipeIngredientDTO> ingredients = buildIngredientList(req);// 재료묶음정보를  레시피재료DTO에 채우고 레시피DTO리스트를 만들어서 ingredients에 참조
        List<RecipeStepDTO> steps = buildStepList(req, null); // 스텝별로(스텝설명,사진) 리세피스텝 DTO에 저장후 스탭DTO리스트에 저장 


        // 이 시점에서 레시피 정보(레시피DTO객체), 재료정보(리스트),스텝정보(리스트) 완성

        long recipeId = recipeDAO.insertRecipe(recipe, ingredients, steps);//  (레시피DTO객체), 재료정보(리스트),스텝정보(리스트)들을 각 db테이블에 insert into 하고 한번에 커밋+ 레시피id를 시퀀스로
        //발급받고 리턴
        res.sendRedirect(req.getContextPath() + "/recipe/view?recipe_id=" + recipeId); //레시피id에 해당하는 레시피상세페이지를 조립해서 브라우저에 응답
    }
    
    
    
    
    
    
    
    
//6








//6

    private void updateRecipe(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        UserDTO loginUser = requireLogin(req, res);
        if (res.isCommitted()) return;

        RecipeDTO recipe = buildRecipe(req);
        recipe.setRecipeId(parseLong(req.getParameter("recipe_id"), 0L));
        recipe.setUserId(loginUser.getUserId());

        String oldThumbnail = trimToNull(req.getParameter("thumbnail"));
        String newThumbnail = saveSingleFile(req.getPart("thumbnail_file"), RECIPE_UPLOAD_DIR);
        recipe.setThumbnail(newThumbnail != null ? newThumbnail : oldThumbnail);

        List<RecipeIngredientDTO> ingredients = buildIngredientList(req);
        List<RecipeStepDTO> steps = buildStepList(req, req.getParameterValues("step_image_url"));

        recipeDAO.updateRecipe(recipe, ingredients, steps);
        res.sendRedirect(req.getContextPath() + "/recipe/view?recipe_id=" + recipe.getRecipeId());
    }





//7
    private void deleteRecipe(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        UserDTO loginUser = requireLogin(req, res);
        if (res.isCommitted()) return; 

        long recipeId = parseLong(req.getParameter("recipe_id"), parseLong(req.getParameter("id"), 0L));
        if (recipeId <= 0) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        recipeDAO.deleteRecipe(recipeId, loginUser.getUserId());
        res.sendRedirect(req.getContextPath() + "/recipe/list");
    }






  //8
    private RecipeDTO buildRecipe(HttpServletRequest req) { // 입력받은 데이터 레시피DTO에 저장
        RecipeDTO recipe = new RecipeDTO();
        recipe.setCategoryId(parseInt(req.getParameter("categoryLId"), 0));
        recipe.setTitle(trimToEmpty(req.getParameter("title")));
        recipe.setDescription(trimToNull(req.getParameter("description")));
        recipe.setServings(parseInt(req.getParameter("servings"), 0));
        recipe.setCookTime(parseInt(req.getParameter("cook_time"), 0));
        recipe.setDifficulty(parseInt(req.getParameter("difficulty"), 0));
        return recipe; 
    }
    
    
    
    
   //9
    private List<RecipeIngredientDTO> buildIngredientList(HttpServletRequest req) {
        String[] names = req.getParameterValues("ingredient_name"); //재료이름을 names에 저장 // 배열값을 가져오는 메서드 참고
        String[] amounts = req.getParameterValues("ingredient_amount");//재료수량정보를 amounts에 저장
        List<RecipeIngredientDTO> list = new ArrayList<>(); // 레시피재료DTO 리스트 생성

        int size = Math.max(length(names), length(amounts)); // 재료명배열, 수량배열중 더 큰 배열의 size를 int size에 저장
        for (int i = 0; i < size; i++) {
            String name = getAt(names, i);// 재료명 배열,i에 해당하는 인덱스번호의 값을 추출하여 String name에 저장
            String amount = getAt(amounts, i);// 수량 배열, i에 해당하는 인덱스번호의 값을 추출하여 String amount에 저장
            if (isBlank(name) || isBlank(amount)) {
                continue;// 두 배열의 값중 하나라도 값이 없으면 i번인덱스에 해당하는 실행문은 생략
            }

            RecipeIngredientDTO ingredient = new RecipeIngredientDTO();
            ingredient.setName(name.trim());
            ingredient.setAmount(amount.trim());
            ingredient.setUnit(amount.trim());
            list.add(ingredient);// 각 배열에서 추출한 재료명,수량정보를 레시피재료 DTO 객체 필드에 저장후 그 DTO를 DTO리스트에 저장
        }
        return list;//  가장큰 사이즈의 배열size만큼 반복하며 DTO리스트를 만들고 리스트를 리턴
    }
    
    
    
    
//10
    private List<RecipeStepDTO> buildStepList(HttpServletRequest req, String[] oldImageUrls) //req로 스텝,파일의 정보들을 가져옴
            throws IOException, ServletException {
        String[] contents = req.getParameterValues("step_content");// 스텝 설명 문자열 배열값을 그대로 contents에 저장
        List<Part> stepFileParts = findParts(req.getParts(), "step_file");// req로 받아온 사진파일들을 Part리스트에 저장
        List<RecipeStepDTO> list = new ArrayList<>();

        for (int i = 0; i < length(contents); i++) {
            String content = getAt(contents, i); // i번째 인덱스에 해당하는 스텝정보값을 contents에 저장
            if (isBlank(content)) {// contents가 비어있으면(step설명이 없는 상태로 전달되었을 경우) i번째 인덱스 실행문 생략
                continue;
            }

            RecipeStepDTO step = new RecipeStepDTO(); // 스텝정보, 스텝별 사진을 저장할 스텝DTO를 생성
            step.setStepNo(list.size() + 1); // 스텝번호를 현재 리스트사이즈 기준으로 설정하여 위 조건문에서 continue처리된 카운트를 무시
            step.setContent(content.trim()); //공백없이 스텝정보를 DTO필드에 저장

            String uploadedImage = null;//기존 사진파일 정보 미리 지우기
            if (i < stepFileParts.size()) {
                uploadedImage = saveSingleFile(stepFileParts.get(i), STEP_UPLOAD_DIR); // IndexOutOfBoundsException 방지
            }
            String oldImage = getAt(oldImageUrls, i);
            step.setImageUrl(uploadedImage != null ? uploadedImage : trimToNull(oldImage)); // uploadedImage가 null이 아니라면 그 값을 DTO step필드에 저장/null이라면 공백없이 null그대로or 기존사진재활용

            list.add(step); // 레시피스탭 DTO를 리스트에 저장
        }
        return list;
    }





 //11
    private String saveSingleFile(Part part, String uploadDir) //썸네일 세팅 메서드---썸네일파일,파일정뵤 + 웹용가상경로를 매개변수로 받는다
            throws IOException {
        if (part == null || part.getSize() <= 0 || isBlank(part.getSubmittedFileName())) {
            return null;    //업로드한 파일이 비어있거나 null이거나 용량이0일 경우 null리턴
        }

        String originalName = new File(part.getSubmittedFileName()).getName(); //썸네일 파일명 추출
        String savedName = FileUtil.generateUniqueFileName(originalName);// 랜덤문자열+확장자명 설정
        String realDir = getServletContext().getRealPath(uploadDir);//업로드된 파일의 디렉터리데이터 저장
        FileUtil.ensureDir(realDir);//상위폴더 없으면 자동생성

        part.write(realDir + File.separator + savedName);
        return uploadDir + "/" + savedName; // 웹용 디렉터리+랜덤문자열+확장자명의 url주소 생성
    }
    
    
    
    //12
    private List<Part> findParts(Collection<Part> parts, String name) {
        List<Part> result = new ArrayList<>();
        for (Part part : parts) {
            if (name.equals(part.getName())) {
                result.add(part);
            }
        }
        return result;
    }
    
    
    
    
  //13
    private UserDTO requireLogin(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Object loginUser = req.getSession().getAttribute("loginUser"); //키 이름이 loginUser인 로그인세션 가져오기
        if (loginUser instanceof UserDTO) { // 가져온 세션에 UserDTO가 있는지 확인
            return (UserDTO) loginUser; 
        }

        res.sendRedirect(req.getContextPath() + "/user/login"); //없으면 로그인페이지로 응답 확정
        return null;
    }
    
    
    
  //14
    private void forward(HttpServletRequest req, HttpServletResponse res, String contentPage)
            throws ServletException, IOException {
        req.setAttribute("menu", "recipe");
        req.setAttribute("contentPage", contentPage);
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
    }
    
    
    
   //15
    private int parseInt(String value, int defaultValue) {
        try {
            return isBlank(value) ? defaultValue : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
    
    
    
//16
    private long parseLong(String value, long defaultValue) {
        try {
            return isBlank(value) ? defaultValue : Long.parseLong(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    
    
    
    //17
    private int length(String[] values) {
        return values == null ? 0 : values.length;
    }

    
    //18
    private String getAt(String[] values, int index) {
        return values != null && index >= 0 && index < values.length ? values[index] : null;
    }

    
    //19
    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    
    //20
    private String trimToNull(String value) {
        return isBlank(value) ? null : value.trim();
    }

    
    //21
    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}