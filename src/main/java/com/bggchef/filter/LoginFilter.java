package com.bggchef.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 로그인 검증 필터
 * - 보호된 URL 접근 시 세션에 loginUser 없으면 /user/login.do로 리다이렉트
 */
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        Object loginUser = (session != null) ? session.getAttribute("loginUser") : null;
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {}
}
