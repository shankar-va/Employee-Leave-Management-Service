package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.model.User;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		String contextPath=request.getContextPath();
		if(session==null ) {
			response.sendRedirect(contextPath+"/login");
			return;
		}
		User user=(User)session.getAttribute("user");
		if(user==null) {
			response.sendRedirect(contextPath+"/login");
			return;
		}

		String role=user.getRole();
		if(role.equalsIgnoreCase("admin")) {
			response.sendRedirect(contextPath+"/admin");
			return;
		}else if(role.equalsIgnoreCase("user")) {
			response.sendRedirect(contextPath+"/user");
			return;
		}else {
			session.invalidate();
			response.sendRedirect(contextPath+"/login");
		}
	}
}
