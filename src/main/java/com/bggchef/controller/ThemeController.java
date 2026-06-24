package com.bggchef.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.bggchef.dao.ReviewDAO;
import com.bggchef.dto.ReviewDTO;

@WebServlet({
    "/theme/list", "/theme/view", "/theme/write", "/theme/writeAction",
    "/theme/update", "/theme/updateAction", "/theme/delete", "/theme/removeRecipe",
    "/theme/myRecipeList", "/theme/addRecipeAction",
    "/theme/editRecipeInfo", "/theme/editRecipeInfoAction",
    "/theme/comment/list", "/theme/comment/add",
    "/theme/comment/update", "/theme/comment/delete"
})
public class ThemeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ThemeDAO themeDAO = new ThemeDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();

    private int getIntParam(HttpServletRequest req, String paramName) {
        String val = req.getParameter(paramName);
        if (val == null || val.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(val);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getServletPath();
        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        try {
            if ("/theme/list".equals(path)) {
                req.setAttribute("themeList", themeDAO.list());
                req.setAttribute("contentPage", "/WEB-INF/views/theme/list.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }

            else if ("/theme/view".equals(path)) {
                int themeId = getIntParam(req, "themeId");

                themeDAO.updateViewCount(themeId);

                req.setAttribute("theme", themeDAO.selectById(themeId));
                req.setAttribute("recipeList", themeDAO.getRecipesByThemeId(themeId));
                req.setAttribute("reviewList", reviewDAO.selectByThemeId(themeId));
                req.setAttribute("contentPage", "/WEB-INF/views/theme/view.jsp");

                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }

            else if ("/theme/write".equals(path)) {
                if (loginUser == null) {
                    res.sendRedirect(req.getContextPath() + "/user/login");
                    return;
                }

                req.setAttribute("contentPage", "/WEB-INF/views/theme/write.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }

            else if ("/theme/writeAction".equals(path)) {
                if (loginUser == null) {
                    res.sendRedirect(req.getContextPath() + "/user/login");
                    return;
                }

                handleUpload(req, res, false);
            }

            else if ("/theme/update".equals(path)) {
                req.setAttribute("theme", themeDAO.selectById(getIntParam(req, "themeId")));
                req.setAttribute("contentPage", "/WEB-INF/views/theme/update.jsp");
                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }

            else if ("/theme/updateAction".equals(path)) {
                if (loginUser == null) {
                    res.sendRedirect(req.getContextPath() + "/user/login");
                    return;
                }

                handleUpload(req, res, true);
            }

            else if ("/theme/myRecipeList".equals(path)) {
                if (loginUser == null) {
                    res.sendRedirect(req.getContextPath() + "/user/login");
                    return;
                }

                req.setAttribute("myRecipeList", themeDAO.getMyRecipes(loginUser.getUserId()));
                req.getRequestDispatcher("/WEB-INF/views/theme/myRecipeList.jsp").forward(req, res);
            }

            else if ("/theme/addRecipeAction".equals(path)) {
                if (loginUser == null) {
                    res.sendRedirect(req.getContextPath() + "/user/login");
                    return;
                }

                handleRecipeAdd(req, res, loginUser);
            }

            else if ("/theme/delete".equals(path)) {
                int themeId = getIntParam(req, "themeId");
                ThemeDTO theme = themeDAO.selectById(themeId);

                if (theme != null && loginUser != null && loginUser.getUserId().equals(theme.getUserId())) {
                    themeDAO.delete(themeId);
                    res.sendRedirect(req.getContextPath() + "/theme/list");
                } else {
                    res.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
            }

            else if ("/theme/removeRecipe".equals(path)) {
                int themeId = getIntParam(req, "themeId");
                int recipeId = getIntParam(req, "recipeId");

                themeDAO.removeRecipeFromTheme(themeId, recipeId);

                res.sendRedirect(req.getContextPath() + "/theme/view?themeId=" + themeId);
            }

            else if ("/theme/editRecipeInfo".equals(path)) {
                int themeId = getIntParam(req, "themeId");
                int recipeId = getIntParam(req, "recipeId");

                req.setAttribute("recipe", themeDAO.getThemeRecipeDetail(themeId, recipeId));
                req.setAttribute("themeId", themeId);
                req.setAttribute("contentPage", "/WEB-INF/views/theme/editRecipeInfo.jsp");

                req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            }

            else if ("/theme/editRecipeInfoAction".equals(path)) {
                handleRecipeUpdate(req, res);
            }

            else if ("/theme/comment/list".equals(path)) {
                int themeId = getIntParam(req, "themeId");

                List<Map<String, Object>> commentList = themeDAO.getThemeComments(themeId);

                res.setContentType("application/json; charset=UTF-8");
                PrintWriter out = res.getWriter();

                StringBuilder json = new StringBuilder();
                json.append("[");

                for (int i = 0; i < commentList.size(); i++) {
                    Map<String, Object> c = commentList.get(i);

                    if (i > 0) json.append(",");

                    Object parentReviewId = c.get("parentReviewId");

                    json.append("{");

                    json.append("\"commentId\":").append(c.get("commentId")).append(",");
                    json.append("\"userId\":\"").append(escapeJson(String.valueOf(c.get("userId")))).append("\",");
                    json.append("\"nickname\":\"").append(escapeJson(String.valueOf(c.get("nickname")))).append("\",");
                    json.append("\"content\":\"").append(escapeJson(String.valueOf(c.get("content")))).append("\",");
                    Object rating = c.get("rating");

                    json.append("\"rating\":");

                    if (rating == null) {
                        json.append("null");
                    } else {
                        json.append(rating);
                    }

                    json.append(",");
                    json.append("\"parentReviewId\":");
                    if (parentReviewId == null) {
                        json.append("null");
                    } else {
                        json.append(parentReviewId);
                    }
                    json.append(",");

                    json.append("\"createdAt\":\"").append(c.get("createdAt")).append("\"");

                    json.append("}");
                }

                json.append("]");
                out.print(json.toString());
            }

            else if ("/theme/comment/add".equals(path)) {
                if (loginUser == null) {
                    res.setContentType("text/plain; charset=UTF-8");
                    res.getWriter().print("fail");
                    return;
                }

                req.setCharacterEncoding("UTF-8");

                int themeId = getIntParam(req, "themeId");
                int parentReviewId = getIntParam(req, "parentReviewId");
                String content = req.getParameter("content");
                String ratingStr = req.getParameter("rating");
                if (content == null || content.trim().isEmpty()) {
                    res.setContentType("text/plain; charset=UTF-8");
                    res.getWriter().print("fail");
                    return;
                }

                ReviewDTO dto = new ReviewDTO();
                dto.setUserId(loginUser.getUserId());
                dto.setContent(content);

                if (parentReviewId > 0) {
                    // 대댓글
                    dto.setParentReviewId((long) parentReviewId);
                    dto.setRating(null);
                } else {
                    // 일반 댓글
                    dto.setParentReviewId(null);

                    try {
                        dto.setRating(Double.parseDouble(ratingStr));
                    } catch (Exception e) {
                        dto.setRating(5.0);
                    }
                }

                reviewDAO.insertThemeReview(dto, themeId);

                res.setContentType("text/plain; charset=UTF-8");
                res.getWriter().print("success");
            }

            else if ("/theme/comment/update".equals(path)) {
                if (loginUser == null) {
                    res.setContentType("text/plain; charset=UTF-8");
                    res.getWriter().print("fail");
                    return;
                }

                req.setCharacterEncoding("UTF-8");

                int commentId = getIntParam(req, "commentId");
                String content = req.getParameter("content");

                if (content == null || content.trim().isEmpty()) {
                    res.setContentType("text/plain; charset=UTF-8");
                    res.getWriter().print("fail");
                    return;
                }

                reviewDAO.updateThemeReview(commentId, loginUser.getUserId(), content);

                res.setContentType("text/plain; charset=UTF-8");
                res.getWriter().print("success");
            }

            else if ("/theme/comment/delete".equals(path)) {
                if (loginUser == null) {
                    res.setContentType("text/plain; charset=UTF-8");
                    res.getWriter().print("fail");
                    return;
                }

                int commentId = getIntParam(req, "commentId");

                reviewDAO.deleteThemeReview(commentId, loginUser.getUserId());
                res.setContentType("text/plain; charset=UTF-8");
                res.getWriter().print("success");
            }

        } catch (Exception e) {
            e.printStackTrace();

            if (!res.isCommitted()) {
                res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

    private void handleUpload(HttpServletRequest req, HttpServletResponse res, boolean isUpdate) throws Exception {
        String themeSaveDirectory = req.getServletContext().getRealPath("/resources/upload/theme");
        File themeDir = new File(themeSaveDirectory);
        if (!themeDir.exists()) themeDir.mkdirs();

        String recipeSaveDirectory = req.getServletContext().getRealPath("/resources/upload/recipe");
        File recipeDir = new File(recipeSaveDirectory);
        if (!recipeDir.exists()) recipeDir.mkdirs();

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");

        List<FileItem> formItems = upload.parseRequest(req);

        ThemeDTO dto = new ThemeDTO();

        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        dto.setUserId(loginUser.getUserId());

        List<String> recipeIds = new ArrayList<>();
        List<String> descriptions = new ArrayList<>();
        List<String> recipeImages = new ArrayList<>();

        for (FileItem item : formItems) {
            String name = item.getFieldName();

            if (item.isFormField()) {
                String val = item.getString("UTF-8");

                if ("title".equals(name)) {
                    dto.setTitle(val);
                } else if ("subtitle".equals(name)) {
                    dto.setSubtitle(val);
                } else if ("description".equals(name)) {
                    dto.setDescription(val);
                } else if ("themeId".equals(name) && !val.isEmpty()) {
                    dto.setThemeId(Integer.parseInt(val));
                } else if ("recipeIds".equals(name)) {
                    recipeIds.add(val);
                } else if ("descriptions".equals(name)) {
                    descriptions.add(val);
                }

            } else {
                if ("thumbnail".equals(name) && item.getSize() > 0) {
                    String originName = new File(item.getName()).getName();
                    String fileName = System.currentTimeMillis() + "_" + originName.replaceAll("\\s", "_");

                    item.write(new File(themeSaveDirectory + File.separator + fileName));
                    dto.setThumbnail("/resources/upload/theme/" + fileName);
                }

                else if ("recipeImages".equals(name)) {
                    if (item.getSize() > 0) {
                        String originName = new File(item.getName()).getName();
                        String fileName = System.currentTimeMillis() + "_" + originName.replaceAll("\\s", "_");

                        item.write(new File(recipeSaveDirectory + File.separator + fileName));
                        recipeImages.add(fileName);
                    } else {
                        recipeImages.add(null);
                    }
                }
            }
        }

        if (isUpdate) {
            themeDAO.update(dto);
        } else {
            themeDAO.insert(dto);
            dto.setThemeId(themeDAO.getLatestThemeId());
        }

        for (int i = 0; i < recipeIds.size(); i++) {
            String desc = "";

            if (i < descriptions.size()) {
                desc = descriptions.get(i);
            }

            String imageName = null;

            if (i < recipeImages.size()) {
                imageName = recipeImages.get(i);
            }

            themeDAO.insertRecipeToTheme(
                dto.getThemeId(),
                Integer.parseInt(recipeIds.get(i)),
                desc,
                loginUser.getUserId(),
                imageName
            );
        }

        res.sendRedirect(req.getContextPath() + "/theme/view?themeId=" + dto.getThemeId());
    }

    private void handleRecipeAdd(HttpServletRequest req, HttpServletResponse res, UserDTO loginUser) throws Exception {
        req.setCharacterEncoding("UTF-8");

        int themeId = Integer.parseInt(req.getParameter("themeId"));
        int recipeId = Integer.parseInt(req.getParameter("recipeId"));
        String description = req.getParameter("description");

        if (description == null) {
            description = "";
        }

        if (themeDAO.isRecipeAlreadyInTheme(themeId, recipeId)) {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = res.getWriter();
            out.println("<script>");
            out.println("alert('すでにこのテーマに追加されたレシピです。');");
            out.println("window.close();");
            out.println("</script>");
            return;
        }

        themeDAO.insertRecipeToTheme(
            themeId,
            recipeId,
            description,
            loginUser.getUserId(),
            null
        );

        res.setContentType("text/html; charset=UTF-8");

        PrintWriter out = res.getWriter();
        out.println("<script>");
        out.println("alert('レシピが追加されました。');");
        out.println("if(window.opener) window.opener.location.reload();");
        out.println("window.close();");
        out.println("</script>");
    }

    private void handleRecipeUpdate(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String saveDirectory = req.getServletContext().getRealPath("/resources/upload/recipe");
        File dir = new File(saveDirectory);
        if (!dir.exists()) dir.mkdirs();

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");

        List<FileItem> formItems = upload.parseRequest(req);

        RecipeDTO dto = new RecipeDTO();

        int themeId = 0;
        String oldThumbnail = null;

        for (FileItem item : formItems) {
            if (item.isFormField()) {
                String name = item.getFieldName();
                String val = item.getString("UTF-8");

                if ("recipeId".equals(name)) {
                    dto.setRecipeId(Long.parseLong(val));
                } else if ("title".equals(name)) {
                    dto.setTitle(val);
                } else if ("description".equals(name)) {
                    dto.setDescription(val);
                } else if ("themeId".equals(name)) {
                    themeId = Integer.parseInt(val);
                } else if ("oldThumbnail".equals(name)) {
                    oldThumbnail = val;
                }

            } else if (item.getSize() > 0) {
                String originName = new File(item.getName()).getName();
                String fileName = System.currentTimeMillis() + "_" + originName.replaceAll("\\s", "_");

                item.write(new File(saveDirectory + File.separator + fileName));
                dto.setThumbnail("/resources/upload/recipe/" + fileName);
            }
        }

        if (dto.getThumbnail() == null) {
            dto.setThumbnail(oldThumbnail);
        }

        themeDAO.updateRecipeInfo(dto);
        themeDAO.updateThemeRecipeDescription(themeId, (int) dto.getRecipeId(), dto.getDescription());

        res.sendRedirect(req.getContextPath() + "/theme/view?themeId=" + themeId);
    }

    private String escapeJson(String str) {
        if (str == null) return "";

        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\r", "")
                  .replace("\n", "\\n");
    }
}