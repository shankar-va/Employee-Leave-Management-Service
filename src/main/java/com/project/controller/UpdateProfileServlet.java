package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.model.User;
import com.project.service.UserService;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String contextPath = request.getContextPath();

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String phone = request.getParameter("phone");

        if (phone == null || phone.trim().isEmpty()) {
            session.setAttribute("failure", "Phone number is required.");
            response.sendRedirect(contextPath + "/profile.jsp");
            return;
        }

        phone = phone.trim();

        boolean updated = UserService.update(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getRole(),
                user.getDepartment(),
                phone);

        if (updated) {
            User refreshed = UserService.getById(user.getId());
            if (refreshed != null) {
                session.setAttribute("user", refreshed);
            } else {
                user.setPhone(phone);
                session.setAttribute("user", user);
            }
            session.setAttribute("success", "Phone number updated successfully.");
        } else {
            session.setAttribute("failure", "Unable to update phone. Please check the number and try again.");
        }

        response.sendRedirect(contextPath + "/profile.jsp");
    }
}
