package com.buke.filter;  
  
import com.boku.pojo.User;
import javax.servlet.*;  
import javax.servlet.annotation.WebFilter;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;
import java.io.IOException;   
  
@WebFilter(filterName = "LoginFilter")  
public class LoginFilter implements Filter {  
    public void destroy() {  
    }  
  
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {  
        HttpServletRequest request = (HttpServletRequest)req;  
        HttpServletResponse response = (HttpServletResponse)resp;  
        String uri = request.getRequestURI();
        String path = uri.substring(uri.lastIndexOf("/"));

		if ("/login".equals(path) || ("/bookNumber".equals(path)) || ("/login-submit".equals(path)) || ("/register".equals(path)) || ("/register-submit".equals(path)) || ("/bookMain".equals(path))) {
			chain.doFilter(request, response);
		} else {
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");
			if (user != null) {
				chain.doFilter(request, response);
			} else {
				response.sendRedirect("login");
			}
		}
    }  
  
    public void init(FilterConfig config) throws ServletException {    
    }  
  
}  