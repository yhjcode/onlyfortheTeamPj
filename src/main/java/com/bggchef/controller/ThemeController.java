package com.bggchef.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.bggchef.dao.ThemeDAO;
import com.bggchef.dto.RecipeDTO;
import com.bggchef.dto.ThemeDTO;
import com.bggchef.dto.UserDTO;

@WebServlet({"/theme/list", "/theme/view", "/theme/write", "/theme/writeAction", 
             "/theme/update", "/theme/updateAction", "/theme/delete", "/theme/removeRecipe", 
             "/theme/myRecipeList", "/theme/addRecipeAction", 
             "/theme/editRecipeInfo", "/theme/editRecipeInfoAction"})
public class ThemeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ThemeDAO themeDAO = new ThemeDAO();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getServletPath();
        req.setAttribute("menu", "theme");
        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        try {
            if ("/theme/list".equals(path)) {
                req.setAttribute("themeList", themeDAO.list());
                req.setAttribute("contentPage", "/WEB-INF/views/theme/list.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            } 
            else if ("/theme/view".equals(path)) {
                int themeId = Integer.parseInt(req.getParameter("themeId"));
                themeDAO.updateViewCount(themeId);
                req.setAttribute("theme", themeDAO.selectById(themeId));
                req.setAttribute("recipeList", themeDAO.getRecipesByThemeId(themeId));
                req.setAttribute("contentPage", "/WEB-INF/views/theme/view.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            } 
            else if ("/theme/editRecipeInfo".equals(path)) {
                int themeId = Integer.parseInt(req.getParameter("themeId"));
                int recipeId = Integer.parseInt(req.getParameter("recipeId"));
                req.setAttribute("recipe", themeDAO.getThemeRecipeDetail(themeId, recipeId));
                req.setAttribute("themeId", themeId);
                req.setAttribute("contentPage", "/WEB-INF/views/theme/editRecipeInfo.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }
            else if ("/theme/editRecipeInfoAction".equals(path)) {
                if (!"POST".equals(req.getMethod())) {
                    res.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
                    return;
                }
                handleRecipeUpdate(req, res);
            }
            else if ("/theme/myRecipeList".equals(path)) {
                if (loginUser == null) { res.sendRedirect(req.getContextPath() + "/user/login"); return; }
                req.setAttribute("myRecipeList", themeDAO.getMyRecipes(loginUser.getUserId()));
                req.getRequestDispatcher("/WEB-INF/views/theme/myRecipeList.jsp").forward(req, res);
            }
            else if ("/theme/addRecipeAction".equals(path)) {
                if (loginUser == null) { res.sendRedirect(req.getContextPath() + "/user/login"); return; }
                int themeId = Integer.parseInt(req.getParameter("themeId"));
                int recipeId = Integer.parseInt(req.getParameter("recipeId"));
                String description = req.getParameter("description");
                themeDAO.insertRecipeToTheme(themeId, recipeId, description, loginUser.getUserId());
                res.sendRedirect(req.getContextPath() + "/theme/view?themeId=" + themeId);
            }
            else if ("/theme/delete".equals(path)) {
                int themeId = Integer.parseInt(req.getParameter("themeId"));
                ThemeDTO theme = themeDAO.selectById(themeId);
                if (loginUser != null && loginUser.getUserId().equals(theme.getUserId())) {
                    themeDAO.delete(themeId);
                    res.sendRedirect(req.getContextPath() + "/theme/list");
                } else {
                    res.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
            }
            else if ("/theme/removeRecipe".equals(path)) {
                int themeId = Integer.parseInt(req.getParameter("themeId"));
                int recipeId = Integer.parseInt(req.getParameter("recipeId"));
                themeDAO.removeRecipeFromTheme(themeId, recipeId);
                res.sendRedirect(req.getContextPath() + "/theme/view?themeId=" + themeId);
            }
            else if ("/theme/write".equals(path)) {
                if (loginUser == null) { res.sendRedirect(req.getContextPath() + "/user/login"); return; }
                req.setAttribute("contentPage", "/WEB-INF/views/theme/write.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            } 
            else if ("/theme/writeAction".equals(path)) {
                handleUpload(req, res, false); 
            }
            else if ("/theme/update".equals(path)) {
                req.setAttribute("theme", themeDAO.selectById(Integer.parseInt(req.getParameter("themeId"))));
                req.setAttribute("contentPage", "/WEB-INF/views/theme/update.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }
            else if ("/theme/updateAction".equals(path)) {
                handleUpload(req, res, true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void handleRecipeUpdate(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String saveDirectory = req.getServletContext().getRealPath("/resources/upload/recipe");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> formItems = upload.parseRequest(req);

        RecipeDTO dto = new RecipeDTO();
        String oldThumbnail = null;
        String themeIdStr = "0"; 

        for (FileItem item : formItems) {
            if (item.isFormField()) {
                String name = item.getFieldName();
                String val = item.getString("UTF-8");
                if ("recipeId".equals(name) && val != null && !val.isEmpty()) dto.setRecipeId(Long.parseLong(val));
                else if ("title".equals(name)) dto.setTitle(val);
                else if ("description".equals(name)) dto.setDescription(val);
                else if ("recipeLink".equals(name)) dto.setRecipeLink(val);
                else if ("themeId".equals(name)) themeIdStr = val;
                else if ("oldThumbnail".equals(name)) oldThumbnail = val;
            } else if (item.getName() != null && !item.getName().isEmpty()) {
                String savedFileName = System.currentTimeMillis() + "_" + new File(item.getName()).getName();
                item.write(new File(saveDirectory + File.separator + savedFileName));
                dto.setThumbnail(savedFileName);
            }
        }
        
        if (dto.getThumbnail() == null) dto.setThumbnail(oldThumbnail);
        int themeId = Integer.parseInt(themeIdStr);
        
        themeDAO.updateRecipeInfo(dto);
        themeDAO.updateThemeRecipeDescription(themeId, (int)dto.getRecipeId(), dto.getDescription());
        
        res.sendRedirect(req.getContextPath() + "/theme/view?themeId=" + themeId);
    }

    private void handleUpload(HttpServletRequest req, HttpServletResponse res, boolean isUpdate) throws Exception {
        // 기존 업로드 로직 유지
    }
}