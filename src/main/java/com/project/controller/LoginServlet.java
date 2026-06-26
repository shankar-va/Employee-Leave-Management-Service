package com.project.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.project.model.User;
import com.project.service.UserService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=((String)request.getParameter("email")).trim();
		String pswd=((String)request.getParameter("pswd")).trim();
		User user=UserService.login(email, pswd);
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("login.jsp");
		if(user==null) {
			request.setAttribute("failure", "Invalid email or password");
			request.setAttribute("email", email);
			requestDispatcher.forward(request, response);
			return;
		}
		HttpSession session=request.getSession();
		if(user.getRole().equalsIgnoreCase("admin")) {
			session.setAttribute("user", user);
			response.sendRedirect("admin.jsp");
		}
		else if(user.getRole().equalsIgnoreCase("user")){
			session.setAttribute("user", user);
			response.sendRedirect("user.jsp");
		}
		else {
			request.setAttribute("failure",
			        "Invalid user role.");
			requestDispatcher.forward(request, response);
			return;
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("login.jsp");
		requestDispatcher.forward(request, response);
		return;
	}
	

}
