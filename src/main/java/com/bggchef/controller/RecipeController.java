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
        "/recipe/edit"
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
            } else {
                showList(req, res);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String path = req.getServletPath();

        try {
            if ("/recipe/write".equals(path)) {
                insertRecipe(req, res);
            } else if ("/recipe/edit".equals(path)) {
                updateRecipe(req, res);
            } else {
                doGet(req, res);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void showWriteForm(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        requireLogin(req, res); // 로그인 체크
        if (res.isCommitted()) return; // 비회원일 경우 리턴처리

        req.setAttribute("categoryList", recipeDAO.selectCategoryList()); // 카테고리 리스트를 불러와서 req에 저장
        forward(req, res, "/WEB-INF/views/recipe/write.jsp");  // req에 담긴 카테고리 리스트로  write.do.jsp화면을 조립해서 사용자 브라우저에 전달
    }

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
        forward(req, res, "/WEB-INF/views/recipe/edit.do.jsp");
    }

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

        req.setAttribute("recipe", recipe);
        req.setAttribute("ingredients", recipe.getIngredients());
        req.setAttribute("steps", recipe.getSteps());
        forward(req, res, "/WEB-INF/views/recipe/view.jsp");
    }

    private void showList(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        forward(req, res, "/WEB-INF/views/recipe/list.jsp");
    }

    private void insertRecipe(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        UserDTO loginUser = requireLogin(req, res);
        if (res.isCommitted()) return;

        RecipeDTO recipe = buildRecipe(req);
        recipe.setUserId(loginUser.getUserId());
        recipe.setThumbnail(saveSingleFile(req.getPart("thumbnail_file"), RECIPE_UPLOAD_DIR));

        List<RecipeIngredientDTO> ingredients = buildIngredientList(req);
        List<RecipeStepDTO> steps = buildStepList(req, null);

        long recipeId = recipeDAO.insertRecipe(recipe, ingredients, steps);
        res.sendRedirect(req.getContextPath() + "/recipe/view?recipe_id=" + recipeId);
    }

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

    private RecipeDTO buildRecipe(HttpServletRequest req) {
        RecipeDTO recipe = new RecipeDTO();
        recipe.setCategoryId(parseInt(req.getParameter("category_id"), 0));
        recipe.setTitle(trimToEmpty(req.getParameter("title")));
        recipe.setDescription(trimToNull(req.getParameter("description")));
        recipe.setServings(parseInt(req.getParameter("servings"), 0));
        recipe.setCookTime(parseInt(req.getParameter("cook_time"), 0));
        recipe.setDifficulty(parseInt(req.getParameter("difficulty"), 0));
        return recipe;
    }

    private List<RecipeIngredientDTO> buildIngredientList(HttpServletRequest req) {
        String[] names = req.getParameterValues("ingredient_name");
        String[] amounts = req.getParameterValues("ingredient_amount");
        List<RecipeIngredientDTO> list = new ArrayList<>();

        int size = Math.max(length(names), length(amounts));
        for (int i = 0; i < size; i++) {
            String name = getAt(names, i);
            String amount = getAt(amounts, i);
            if (isBlank(name) || isBlank(amount)) {
                continue;
            }

            RecipeIngredientDTO ingredient = new RecipeIngredientDTO();
            ingredient.setName(name.trim());
            ingredient.setAmount(amount.trim());
            list.add(ingredient);
        }
        return list;
    }

    private List<RecipeStepDTO> buildStepList(HttpServletRequest req, String[] oldImageUrls)
            throws IOException, ServletException {
        String[] contents = req.getParameterValues("step_content");
        List<Part> stepFileParts = findParts(req.getParts(), "step_file");
        List<RecipeStepDTO> list = new ArrayList<>();

        for (int i = 0; i < length(contents); i++) {
            String content = getAt(contents, i);
            if (isBlank(content)) {
                continue;
            }

            RecipeStepDTO step = new RecipeStepDTO();
            step.setStepNo(list.size() + 1);
            step.setContent(content.trim());

            String uploadedImage = null;
            if (i < stepFileParts.size()) {
                uploadedImage = saveSingleFile(stepFileParts.get(i), STEP_UPLOAD_DIR);
            }
            String oldImage = getAt(oldImageUrls, i);
            step.setImageUrl(uploadedImage != null ? uploadedImage : trimToNull(oldImage));

            list.add(step);
        }
        return list;
    }

    private String saveSingleFile(Part part, String uploadDir)
            throws IOException {
        if (part == null || part.getSize() <= 0 || isBlank(part.getSubmittedFileName())) {
            return null;
        }

        String originalName = new File(part.getSubmittedFileName()).getName();
        String savedName = FileUtil.generateUniqueFileName(originalName);
        String realDir = getServletContext().getRealPath(uploadDir);
        FileUtil.ensureDir(realDir);

        part.write(realDir + File.separator + savedName);
        return uploadDir + "/" + savedName;
    }

    private List<Part> findParts(Collection<Part> parts, String name) {
        List<Part> result = new ArrayList<>();
        for (Part part : parts) {
            if (name.equals(part.getName())) {
                result.add(part);
            }
        }
        return result;
    }

    private UserDTO requireLogin(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Object loginUser = req.getSession().getAttribute("loginUser");
        if (loginUser instanceof UserDTO) {
            return (UserDTO) loginUser;
        }

        res.sendRedirect(req.getContextPath() + "/user/login");
        return null;
    }

    private void forward(HttpServletRequest req, HttpServletResponse res, String contentPage)
            throws ServletException, IOException {
        req.setAttribute("menu", "recipe");
        req.setAttribute("contentPage", contentPage);
        req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return isBlank(value) ? defaultValue : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private long parseLong(String value, long defaultValue) {
        try {
            return isBlank(value) ? defaultValue : Long.parseLong(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private int length(String[] values) {
        return values == null ? 0 : values.length;
    }

    private String getAt(String[] values, int index) {
        return values != null && index >= 0 && index < values.length ? values[index] : null;
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private String trimToNull(String value) {
        return isBlank(value) ? null : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
