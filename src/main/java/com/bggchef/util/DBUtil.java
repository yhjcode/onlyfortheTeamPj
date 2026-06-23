package com.bggchef.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Oracle DB 커넥션 관리 유틸
 *
 * <p>사용 전 필요:</p>
 * <ul>
 *   <li>WEB-INF/lib/ojdbc8.jar 배치</li>
 *   <li>아래 URL/USER/PWD 본인 환경에 맞게 수정</li>
 * </ul>
 */
public class DBUtil {

    // Oracle 11g XE 기본
    private static final String URL  = "jdbc:oracle:thin:@localhost:1521:xe";
    // Oracle 19c는 보통: "jdbc:oracle:thin:@localhost:1521:orcl"
    private static final String USER = "bggchef";
    private static final String PWD  = "bggchef1234";

    static {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Oracle JDBC Driver 로드 실패", e);
        }
    }

    /** 커넥션 획득 */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PWD);
    }

    /** 자원 해제 (rs, pstmt, conn 순서) */
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try { if (rs    != null) rs.close();    } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn  != null) conn.close();  } catch (SQLException e) { e.printStackTrace(); }
    }

    public static void close(Connection conn, PreparedStatement pstmt) {
        close(conn, pstmt, null);
    }
}