package com.bggchef.service;

import java.sql.SQLException;
import com.bggchef.dao.UserDAO;
import com.bggchef.dto.UserDTO;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    /** 로그인 */
    public UserDTO login(String userId, String password) throws SQLException {
        UserDTO user = userDAO.selectById(userId);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    /** 회원가입 */
    public boolean join(UserDTO user) throws SQLException {
        if (userDAO.existsId(user.getUserId())) {
            return false;
        }
        return userDAO.insert(user) > 0;
    }

    /** 회원정보 수정 */
    public boolean update(UserDTO user) throws SQLException {
        return userDAO.update(user) > 0;
    }

    /** 회원탈퇴 (논리 삭제) */
    public boolean withdraw(String userId) throws SQLException {
        return userDAO.deleteLogically(userId) > 0;
    }
}
