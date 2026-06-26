package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.model.User;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String contextPath = request.getContextPath();

        // No session → show landing page
        if (session == null || session.getAttribute("user") == null) {
            request.getRequestDispatcher("home.jsp")
                   .forward(request, response);
            return;
        }

        User user = (User) session.getAttribute("user");

        if ("admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(contextPath + "/admin");
            return;
        }

        if ("user".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(contextPath + "/user");
            return;
        }

        session.invalidate();
        response.sendRedirect(contextPath + "/login");
    }
}