<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.bggchef.util.DBUtil" %>
<html><body>
<h1>DB 연결 테스트</h1>
<%
    try (Connection conn = DBUtil.getConnection()) {
        out.println("<h2 style='color:green'>✅ 연결 성공!</h2>");
        out.println("<p><b>DB:</b> " + conn.getMetaData().getDatabaseProductVersion() + "</p>");
        out.println("<p><b>URL:</b> " + conn.getMetaData().getURL() + "</p>");
        out.println("<p><b>User:</b> " + conn.getMetaData().getUserName() + "</p>");
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM USERS")) {
            if (rs.next()) {
                out.println("<p><b>USERS 테이블 행 수:</b> " + rs.getInt(1) + "</p>");
            }
        }
    } catch (Exception e) {
        out.println("<h2 style='color:red'>❌ 실패</h2>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    }
%>
</body></html>