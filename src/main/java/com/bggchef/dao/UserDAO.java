package com.bggchef.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bggchef.dto.UserDTO;
import com.bggchef.util.DBUtil;

/**
 * 회원(USERS) 테이블 DAO
 *
 * 구현된 메서드:
 *   - selectById  : 로그인 시 회원 단건 조회
 *   - insert      : 회원가입
 *   - existsId    : 아이디 중복 체크
 *
 * TODO 미구현:
 *   - update, deleteLogically, selectByEmail 등
 */
public class UserDAO {

    /** 회원 단건 조회 (로그인용) */
    public UserDTO selectById(String userId) throws SQLException {
        String sql = "SELECT user_id, email, password, nickname, phone, profile_img, "
                   + "       birthday, is_deleted, medal_grade "
                   + "  FROM USERS WHERE user_id = ? AND is_deleted = 0";

        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                UserDTO u = new UserDTO();
                u.setUserId    (rs.getString("user_id"));
                u.setEmail     (rs.getString("email"));
                u.setPassword  (rs.getString("password"));
                u.setNickname  (rs.getString("nickname"));
                u.setPhone     (rs.getString("phone"));
                u.setProfileImg(rs.getString("profile_img"));
                u.setBirthday  (rs.getDate  ("birthday"));
                u.setIsDeleted (rs.getInt   ("is_deleted"));
                u.setMedalGrade(rs.getString("medal_grade"));
                return u;
            }
            return null;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /** 회원가입 - INSERT */
    public int insert(UserDTO u) throws SQLException {
        String sql = "INSERT INTO USERS "
                   + "(user_id, email, password, nickname, phone, profile_img, birthday, is_deleted, medal_grade) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, 0, ?)";

        Connection conn = null; PreparedStatement pstmt = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getUserId());
            pstmt.setString(2, u.getEmail());
            pstmt.setString(3, u.getPassword());     // 호출 전 PasswordUtil.encrypt() 사용
            pstmt.setString(4, u.getNickname());
            pstmt.setString(5, u.getPhone());
            pstmt.setString(6, u.getProfileImg());
            pstmt.setDate  (7, u.getBirthday());
            pstmt.setString(8, u.getMedalGrade());   // 신규 가입은 NULL 또는 '브론즈'
            return pstmt.executeUpdate();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /** 아이디 중복 체크 */
    public boolean existsId(String userId) throws SQLException {
        String sql = "SELECT 1 FROM USERS WHERE user_id = ?";
        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            return rs.next();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /** 회원 논리 삭제 (is_deleted = 1) */
    public int deleteLogically(String userId) throws SQLException {
        String sql = "UPDATE USERS SET is_deleted = 1 WHERE user_id = ?";
        Connection conn = null; PreparedStatement pstmt = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /** 회원정보 수정 */
    public int update(UserDTO u) throws SQLException {
        String sql = "UPDATE USERS SET email=?, nickname=?, phone=?, birthday=?, profile_img=? "
                   + "WHERE user_id=?";
        Connection conn = null; PreparedStatement pstmt = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getEmail());
            pstmt.setString(2, u.getNickname());
            pstmt.setString(3, u.getPhone());
            pstmt.setDate  (4, u.getBirthday());
            pstmt.setString(5, u.getProfileImg());
            pstmt.setString(6, u.getUserId());
            return pstmt.executeUpdate();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }
}
