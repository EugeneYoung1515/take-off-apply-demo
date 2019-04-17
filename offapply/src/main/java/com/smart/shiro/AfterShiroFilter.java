package com.smart.shiro;

import com.smart.domain.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.UUID;

public class AfterShiroFilter implements Filter{
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        User userSession = (User) ((HttpServletRequest)servletRequest).getSession().getAttribute("userSession");
        if(userSession==null) {
        Subject subject = SecurityUtils.getSubject();
            if (subject.isAuthenticated() || subject.isRemembered()) {
                Object principal = subject.getPrincipal();
                if (null != principal) {
                    User user = (User) principal;
                    //System.out.println(user.getUserId());

                    //String uuid = UUID.randomUUID().toString();
                    //System.out.println(uuid);
                    //user.setPersonalWebsite(uuid);
                    Session session = subject.getSession();
                    session.setAttribute("user", user);
                    //String url = ((HttpServletRequest)servletRequest).getRequestURI();
                    //System.out.println(url);//被认证过 这个会话里所有的链接都能 拿到
                }
            }
        }
        filterChain.doFilter(servletRequest,servletResponse);
    }

    @Override
    public void destroy() {

    }
}
