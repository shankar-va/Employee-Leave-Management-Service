package com.project.filter;

import java.io.IOException;

import com.project.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = "/*")
public class AuthFilter implements Filter{
	private static final String AUTH_MSG =
	        "You are not authorized to access this page.";
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpServletRequest=(HttpServletRequest)request;
		HttpServletResponse httpServletResponse=(HttpServletResponse)response;
		String uri=httpServletRequest.getRequestURI();
		String contextPath=httpServletRequest.getContextPath();
		String actualURI=uri.substring(contextPath.length());
		if(actualURI.equals("")
			||
			actualURI.equals("/")
			||
			actualURI.equals("/home")
			||
			actualURI.equals("/home.jsp")
			||
			actualURI.equals("/login")
			||
			actualURI.equals("/register")
		    ||
		    actualURI.equals("/login.jsp")
		    ||
		    actualURI.equals("/register.jsp")
		    ||
		    actualURI.startsWith("/css/")
		    ||
		    actualURI.startsWith("/js/")
		    ||
		    actualURI.startsWith("/images/")){
			     chain.doFilter(request,response);
			     return;
			}
		HttpSession session= httpServletRequest.getSession(false);
		if(session==null || session.getAttribute("user")==null) {
			HttpSession newSession= httpServletRequest.getSession();
			newSession.setAttribute("failure", "Please login first");
			httpServletResponse.sendRedirect(contextPath+"/login");
			return;	
		}
		User user=(User)session.getAttribute("user");
		if(!user.getRole().equalsIgnoreCase("user")&&
				((actualURI.startsWith("/user"))||actualURI.equalsIgnoreCase("/user.jsp")) ){
			session.setAttribute("failure", AUTH_MSG);
			httpServletResponse.sendRedirect(contextPath+"/home");
			return;
		}
		if(!user.getRole().equalsIgnoreCase("admin")&&
				((actualURI.startsWith("/admin")||actualURI.equalsIgnoreCase("/admin.jsp"))) ){
			session.setAttribute("failure", AUTH_MSG);
			httpServletResponse.sendRedirect(contextPath+"/home");
			return;
		}
		chain.doFilter(request, response);
	}
	
}
