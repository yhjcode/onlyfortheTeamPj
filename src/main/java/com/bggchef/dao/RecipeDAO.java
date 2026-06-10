package com.bggchef.dao;
import java.sql.*;
import java.util.*;

import com.bggchef.dto.CategoryMDTO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.RecipeIngredientDTO;
import com.bggchef.dto.RecipeStepDTO;
import com.bggchef.util.DBUtil;

public class RecipeDAO {

    public long insertRecipe(RecipeDTO recipe, List<RecipeIngredientDTO> ingrList, List<RecipeStepDTO> stepList)
            throws SQLException {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            long recipeId = nextLong(conn, "SELECT SEQ_RECIPE.NEXTVAL FROM DUAL");
            recipe.setRecipeId(recipeId);

            insertRecipeOnly(conn, recipe);
            insertIngredients(conn, recipeId, ingrList);
            insertSteps(conn, recipeId, stepList);

            conn.commit();
            return recipeId;
        } catch (SQLException e) {
            rollback(conn);
            throw e;
        } finally {
            closeConnection(conn);
        }
    }

    public void updateRecipe(RecipeDTO recipe, List<RecipeIngredientDTO> ingrList, List<RecipeStepDTO> stepList)
            throws SQLException {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            String sql = "UPDATE RECIPE "
                       + "   SET category_id = ?, title = ?, thumbnail = ?, description = ?, "
                       + "       servings = ?, cook_time = ?, difficulty = ? "
                       + " WHERE recipe_id = ? AND user_id = ? AND is_deleted = 0";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, recipe.getCategoryId());
                pstmt.setString(2, recipe.getTitle());
                pstmt.setString(3, recipe.getThumbnail());
                pstmt.setString(4, recipe.getDescription());
                pstmt.setInt(5, recipe.getServings());
                pstmt.setInt(6, recipe.getCookTime());
                pstmt.setInt(7, recipe.getDifficulty());
                pstmt.setLong(8, recipe.getRecipeId());
                pstmt.setString(9, recipe.getUserId());
                pstmt.executeUpdate();
            }

            deleteChildren(conn, recipe.getRecipeId());
            insertIngredients(conn, recipe.getRecipeId(), ingrList);
            insertSteps(conn, recipe.getRecipeId(), stepList);

            conn.commit();
        } catch (SQLException e) {
            rollback(conn);
            throw e;
        } finally {
            closeConnection(conn);
        }
    }

    public RecipeDTO selectRecipeById(long recipeId) throws SQLException {
        String sql = "SELECT r.recipe_id, r.user_id, r.category_id, r.title, r.thumbnail, r.description, "
                   + "       r.servings, r.cook_time, r.difficulty, r.view_count, r.avg_rating, "
                   + "       r.is_deleted, r.created_at, u.nickname, cm.name AS category_name "
                   + "  FROM RECIPE r "
                   + "  JOIN USERS u ON r.user_id = u.user_id "
                   + "  JOIN CATEGORY_M cm ON r.category_id = cm.categorym_id "
                   + " WHERE r.recipe_id = ? AND r.is_deleted = 0";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, recipeId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                RecipeDTO recipe = mapRecipe(rs);
                recipe.setIngredients(selectIngredientsByRecipeId(conn, recipeId));
                recipe.setSteps(selectStepsByRecipeId(conn, recipeId));
                return recipe;
            }
            return null;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    public List<RecipeIngredientDTO> selectIngredientsByRecipeId(long recipeId) throws SQLException {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            return selectIngredientsByRecipeId(conn, recipeId);
        } finally {
            closeConnection(conn);
        }
    }

    public List<RecipeStepDTO> selectStepsByRecipeId(long recipeId) throws SQLException {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            return selectStepsByRecipeId(conn, recipeId);
        } finally {
            closeConnection(conn);
        }
    }

    public List<CategoryMDTO> selectCategoryList() throws SQLException {
        String sql = "SELECT categorym_id, categoryl_id, name, type "
                   + "  FROM CATEGORY_M "
                   + " ORDER BY categorym_id";
        List<CategoryMDTO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CategoryMDTO category = new CategoryMDTO();
                category.setCategorymId(rs.getInt("categorym_id"));
                category.setCategorylId(rs.getInt("categoryl_id"));
                category.setName(rs.getString("name"));
                category.setType(rs.getString("type"));
                list.add(category);
            }
            return list;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    public void increaseViewCount(long recipeId) throws SQLException {
        String sql = "UPDATE RECIPE SET view_count = view_count + 1 WHERE recipe_id = ? AND is_deleted = 0";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, recipeId);
            pstmt.executeUpdate();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    private void insertRecipeOnly(Connection conn, RecipeDTO recipe) throws SQLException {
        String sql = "INSERT INTO RECIPE "
                   + "(recipe_id, user_id, category_id, title, thumbnail, description, "
                   + " servings, cook_time, difficulty, view_count, is_deleted, created_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0, SYSDATE)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, recipe.getRecipeId());
            pstmt.setString(2, recipe.getUserId());
            pstmt.setInt(3, recipe.getCategoryId());
            pstmt.setString(4, recipe.getTitle());
            pstmt.setString(5, recipe.getThumbnail());
            pstmt.setString(6, recipe.getDescription());
            pstmt.setInt(7, recipe.getServings());
            pstmt.setInt(8, recipe.getCookTime());
            pstmt.setInt(9, recipe.getDifficulty());
            pstmt.executeUpdate();
        }
    }

    private void insertIngredients(Connection conn, long recipeId, List<RecipeIngredientDTO> ingrList)
            throws SQLException {
        if (ingrList == null) return;

        String sql = "INSERT INTO RECIPE_INGREDIENTS "
                   + "(recipe_ingr_id, ingredient_id, recipe_id, amount) "
                   + "VALUES (SEQ_RECIPE_INGR.NEXTVAL, ?, ?, ?)";

        for (RecipeIngredientDTO ingredient : ingrList) {
            if (isBlank(ingredient.getName()) || isBlank(ingredient.getAmount())) {
                continue;
            }
            int ingredientId = findOrCreateIngredient(conn, ingredient.getName());
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, ingredientId);
                pstmt.setLong(2, recipeId);
                pstmt.setString(3, ingredient.getAmount());
                pstmt.executeUpdate();
            }
        }
    }

    private void insertSteps(Connection conn, long recipeId, List<RecipeStepDTO> stepList)
            throws SQLException {
        if (stepList == null) return;

        String sql = "INSERT INTO RECIPE_STEP "
                   + "(step_id, recipe_id, step_no, image_url, content) "
                   + "VALUES (SEQ_RECIPE_STEP.NEXTVAL, ?, ?, ?, ?)";

        int stepNo = 1;
        for (RecipeStepDTO step : stepList) {
            if (isBlank(step.getContent())) {
                continue;
            }
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setLong(1, recipeId);
                pstmt.setInt(2, stepNo++);
                pstmt.setString(3, step.getImageUrl());
                pstmt.setString(4, step.getContent());
                pstmt.executeUpdate();
            }
        }
    }

    private int findOrCreateIngredient(Connection conn, String name) throws SQLException {
        String selectSql = "SELECT ingredient_id FROM INGREDIENT WHERE name = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
            pstmt.setString(1, name);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("ingredient_id");
                }
            }
        }

        int ingredientId = (int) nextLong(conn, "SELECT SEQ_INGREDIENT.NEXTVAL FROM DUAL");
        String insertSql = "INSERT INTO INGREDIENT (ingredient_id, name, unit) VALUES (?, ?, NULL)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
            pstmt.setInt(1, ingredientId);
            pstmt.setString(2, name);
            pstmt.executeUpdate();
        }
        return ingredientId;
    }

    private List<RecipeIngredientDTO> selectIngredientsByRecipeId(Connection conn, long recipeId)
            throws SQLException {
        String sql = "SELECT ri.recipe_ingr_id, ri.ingredient_id, ri.recipe_id, ri.amount, "
                   + "       i.name, i.unit "
                   + "  FROM RECIPE_INGREDIENTS ri "
                   + "  JOIN INGREDIENT i ON ri.ingredient_id = i.ingredient_id "
                   + " WHERE ri.recipe_id = ? "
                   + " ORDER BY ri.recipe_ingr_id";
        List<RecipeIngredientDTO> list = new ArrayList<>();

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, recipeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RecipeIngredientDTO ingredient = new RecipeIngredientDTO();
                    ingredient.setRecipeIngrId(rs.getLong("recipe_ingr_id"));
                    ingredient.setIngredientId(rs.getInt("ingredient_id"));
                    ingredient.setRecipeId(rs.getLong("recipe_id"));
                    ingredient.setAmount(rs.getString("amount"));
                    ingredient.setName(rs.getString("name"));
                    ingredient.setUnit(rs.getString("unit"));
                    list.add(ingredient);
                }
            }
        }
        return list;
    }

    private List<RecipeStepDTO> selectStepsByRecipeId(Connection conn, long recipeId)
            throws SQLException {
        String sql = "SELECT step_id, recipe_id, step_no, image_url, content "
                   + "  FROM RECIPE_STEP "
                   + " WHERE recipe_id = ? "
                   + " ORDER BY step_no";
        List<RecipeStepDTO> list = new ArrayList<>();

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, recipeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RecipeStepDTO step = new RecipeStepDTO();
                    step.setStepId(rs.getLong("step_id"));
                    step.setRecipeId(rs.getLong("recipe_id"));
                    step.setStepNo(rs.getInt("step_no"));
                    step.setImageUrl(rs.getString("image_url"));
                    step.setContent(rs.getString("content"));
                    list.add(step);
                }
            }
        }
        return list;
    }

    private void deleteChildren(Connection conn, long recipeId) throws SQLException {
        try (PreparedStatement pstmt = conn.prepareStatement("DELETE FROM RECIPE_INGREDIENTS WHERE recipe_id = ?")) {
            pstmt.setLong(1, recipeId);
            pstmt.executeUpdate();
        }
        try (PreparedStatement pstmt = conn.prepareStatement("DELETE FROM RECIPE_STEP WHERE recipe_id = ?")) {
            pstmt.setLong(1, recipeId);
            pstmt.executeUpdate();
        }
    }

    private RecipeDTO mapRecipe(ResultSet rs) throws SQLException {
        RecipeDTO recipe = new RecipeDTO();
        recipe.setRecipeId(rs.getLong("recipe_id"));
        recipe.setUserId(rs.getString("user_id"));
        recipe.setCategoryId(rs.getInt("category_id"));
        recipe.setTitle(rs.getString("title"));
        recipe.setThumbnail(rs.getString("thumbnail"));
        recipe.setDescription(rs.getString("description"));
        recipe.setServings(rs.getInt("servings"));
        recipe.setCookTime(rs.getInt("cook_time"));
        recipe.setDifficulty(rs.getInt("difficulty"));
        recipe.setViewCount(rs.getInt("view_count"));
        recipe.setAvgRating(rs.getObject("avg_rating") == null ? null : rs.getDouble("avg_rating"));
        recipe.setIsDeleted(rs.getInt("is_deleted"));
        recipe.setCreatedAt(rs.getDate("created_at"));
        recipe.setNickname(rs.getString("nickname"));
        recipe.setCategoryName(rs.getString("category_name"));
        return recipe;
    }

    private long nextLong(Connection conn, String sql) throws SQLException {
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getLong(1);
            }
            throw new SQLException("시퀀스 값을 가져오지 못했습니다.");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void rollback(Connection conn) {
        try {
            if (conn != null) conn.rollback();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void closeConnection(Connection conn) {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<RecipeDTO> selectByUserId(String userId) throws SQLException {
        List<RecipeDTO> list = new ArrayList<>();
        String sql = "SELECT recipe_id, title, thumbnail, avg_rating, view_count, created_at " +
                     "FROM RECIPE WHERE user_id = ? AND is_deleted = 0 ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RecipeDTO dto = new RecipeDTO();
                dto.setRecipeId(rs.getLong("recipe_id"));
                dto.setTitle(rs.getString("title"));
                dto.setThumbnail(rs.getString("thumbnail"));
                dto.setAvgRating(rs.getDouble("avg_rating"));
                dto.setViewCount(rs.getInt("view_count"));
                dto.setCreatedAt(rs.getDate("created_at"));
                list.add(dto);
            }
        }
        return list;
    }
    
    
}
