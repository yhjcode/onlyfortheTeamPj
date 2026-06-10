package com.bggchef.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bggchef.dto.CategoryLDTO;
import com.bggchef.dto.CategoryMDTO;
import com.bggchef.util.DBUtil;

/**
 * 카테고리(CATEGORY_L/CATEGORY_M) 테이블 DAO
 *
 * TODO: 팀원이 기능 분담받은 메서드를 구현합니다.
 *       기본 패턴은 UserDAO의 selectById/insert를 참고하세요.
 */
public class CategoryDAO {

    /** 대분류 목록 조회 */
    public List<CategoryLDTO> listL() throws SQLException {
        List<CategoryLDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORY_L ORDER BY categoryl_id ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                CategoryLDTO dto = new CategoryLDTO();
                dto.setCategorylId(rs.getInt("categoryl_id"));
                dto.setName(rs.getString("name"));
                dto.setType(rs.getString("type"));
                list.add(dto);
            }
        }
        return list;
    }

    /** 특정 대분류에 속한 중분류 목록 조회 */
    public List<CategoryMDTO> listMByLId(int categoryLId) throws SQLException {
        List<CategoryMDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORY_M WHERE categoryl_id = ? ORDER BY categorym_id ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, categoryLId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CategoryMDTO dto = new CategoryMDTO();
                    dto.setCategorymId(rs.getInt("categorym_id"));
                    dto.setCategorylId(rs.getInt("categoryl_id"));
                    dto.setName(rs.getString("name"));
                    dto.setType(rs.getString("type"));
                    list.add(dto);
                }
            }
        }
        return list;
    }
}
