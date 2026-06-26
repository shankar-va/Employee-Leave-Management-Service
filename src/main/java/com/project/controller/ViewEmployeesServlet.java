package com.project.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

import com.project.model.User;
import com.project.service.UserService;

/**
 * Servlet implementation class viewAllEmployees
 */@WebServlet("/employees")
 public class ViewEmployeesServlet extends HttpServlet {

	    protected void doGet(HttpServletRequest request,
	                         HttpServletResponse response)
	            throws ServletException, IOException {

	        List<User> users = UserService.getAll();

	        if (users == null) {
	            users = Collections.emptyList();
	        }

	        request.setAttribute("employees", users);

	        RequestDispatcher rd =
	                request.getRequestDispatcher("employees.jsp");
	        rd.forward(request, response);
	    }
	}