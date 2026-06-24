package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname=(String)request.getParameter("username");
		String email=(String)request.getParameter("email");
		String pswd=(String)request.getParameter("pswd");
		String confirmPswd=(String)request.getParameter("confirmPswd");
		boolean validate=
						(!(uname.equals(null)||uname.equals(""))&&
						!(email.equals(null)||email.equals(""))&&
						!(pswd.equals(null)||pswd.equals("")))&&
						pswd.equals(confirmPswd);
		request.getRequestDispatcher("/");
		
	}

}
