package com.bggchef.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bggchef.dao.CategoryDAO;
import com.bggchef.dto.CategoryLDTO;
import com.bggchef.dto.CategoryMDTO;

/**
 * 카테고리 필터/정렬 (REQ_REC_009)
 * URL: /category/list
 */
@WebServlet("/category/list")
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        req.setAttribute("menu", "category");
        
        try {
            // 모든 대분류 조회
            List<CategoryLDTO> listL = categoryDAO.listL();
            req.setAttribute("listL", listL);
            
            // 대분류별 중분류 맵 구성
            Map<Integer, List<CategoryMDTO>> mapM = new HashMap<>();
            for (CategoryLDTO l : listL) {
                mapM.put(l.getCategorylId(), categoryDAO.listMByLId(l.getCategorylId()));
            }
            req.setAttribute("mapM", mapM);
            
            req.setAttribute("contentPage", "/WEB-INF/views/category/list.jsp");
            req.getRequestDispatcher("/WEB-INF/views/common/layout.jsp").forward(req, res);
            
        } catch (SQLException e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}
