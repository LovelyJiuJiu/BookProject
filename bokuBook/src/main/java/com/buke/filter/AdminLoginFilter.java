package com.buke.filter;  
  
import com.boku.pojo.Admin;
import javax.servlet.*;  
import javax.servlet.annotation.WebFilter;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;
import java.io.IOException;   
  
@WebFilter(filterName = "AdminLoginFilter")  
public class AdminLoginFilter implements Filter {  
    public void destroy() {  
    }  
  
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {  
        HttpServletRequest request = (HttpServletRequest)req;  
        HttpServletResponse response = (HttpServletResponse)resp;  
        String uri = request.getRequestURI();
        String path = uri.substring(uri.lastIndexOf("/"));
		if ("/login".equals(path) || ("/".equals(path)) || ("/login-submit".equals(path))) {
			chain.doFilter(request, response);
		} else {
			HttpSession session = request.getSession();
			Admin admin = (Admin) session.getAttribute("currentAdminUser");
			if (admin != null) {
				chain.doFilter(request, response);
			} else {
				response.sendRedirect("login");
			}
		}
    }  
  
    public void init(FilterConfig config) throws ServletException {    
    }  
  
}  