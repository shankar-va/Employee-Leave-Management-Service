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

@WebServlet("/changePassword")
public class ChangePasswordServlet
        extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        User user =
                (User) session.getAttribute("user");

        String oldPassword =
                request.getParameter("oldPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter(
                        "confirmPassword");

        if (!newPassword.equals(
                confirmPassword)) {

            session.setAttribute(
                    "failure",
                    "Passwords do not match.");

            response.sendRedirect(
                    "changePassword.jsp");
            return;
        }

        boolean result =
                UserService.changePassword(
                        user.getEmail(),
                        oldPassword,
                        newPassword);

        if (result) {
            session.setAttribute(
                    "success",
                    "Password changed successfully.");
        }
        else {
            session.setAttribute(
                    "failure",
                    "Unable to change password.");
        }

        response.sendRedirect(
                "changePassword.jsp");
    }
}
