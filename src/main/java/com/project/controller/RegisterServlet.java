package com.project.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.service.UserService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname=((String)request.getParameter("username")).trim();
		String email=((String)request.getParameter("email")).trim();
		String pswd=((String)request.getParameter("pswd")).trim();
		String confirmPswd=((String)request.getParameter("confirmPswd")).trim();
		String role=((String)request.getParameter("role")).trim();
		String department=((String)request.getParameter("department")).trim();
		String phone=((String)request.getParameter("phone")).trim();
		request.setAttribute("name",uname);
		request.setAttribute("email",email);
		request.setAttribute("phone", phone);
		request.setAttribute("department",department);
		request.setAttribute("role",role);
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("register.jsp");
		
		HttpSession session=request.getSession();
		if(!pswd.equals(confirmPswd)) {
			request.setAttribute("failure", "Entered Password and confirm Password does not match ");
			requestDispatcher.forward(request, response);
			return;
		}
		if(UserService.register(uname, email, pswd, role, department, phone)) {
			
			session.setAttribute("success", "Registration Successful. Please login");
			response.sendRedirect("login.jsp");
		}
		else {
			request.setAttribute("failure", "Unable to register. Please check details.");
			requestDispatcher.forward(request, response);
		}	
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("register.jsp");
		requestDispatcher.forward(request, response);
		return;
	}
	

}
