/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mirc.serialNumber;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;

/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 12:14 PM
 */
public class LoginValidate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);

        String usrEmail = request.getParameter("userEmail");
        String usrPwd = request.getParameter("userPassword");
        int err = 0;
        
        if (usrEmail == null || usrEmail.isEmpty()|| usrEmail.trim().isEmpty()) {
            err = 1;
        }
        if (usrPwd == null || usrPwd.isEmpty()|| usrPwd.trim().isEmpty()) {
            err = 1;
        }
        if (err == 0) {
            DatabaseHelper db = new DatabaseHelper();
            err = db.validateUser(usrEmail, usrPwd);
        }
        
        String userLevel = "";
        if(err == 0) {
            DatabaseHelper db = new DatabaseHelper();
            ArrayList<User> users = db.getAllUser();
            for(int x=0; x<users.size(); x++)
            {
                if(users.get(x).getUser_email().equals(usrEmail))
                {
                    userLevel = users.get(x).getUser_level();
                }
            }
        }
        
        String factoryName = "";
        String factoryCode = "";
        if(err == 0) {
            DatabaseHelper db = new DatabaseHelper();
            ArrayList<Factory> factories = db.getAllFactory();
            for(int f = 0; f<factories.size(); f++) {
                if(factories.get(f).getFactoryEmail().equals(usrEmail))
                {
                    factoryName = factories.get(f).getFactoryName();
                    factoryCode = factories.get(f).getFactoryCode();
                }
            }
        }

        if (err == 0) {
            String idData = "Suresh";
            session.setAttribute("u_name", idData);
            session.setAttribute("u_userlevel", userLevel);
            session.setAttribute("U_useremail", usrEmail);
            session.setAttribute("factoryName", factoryName);
            session.setAttribute("factoryCode", factoryCode);
            session.setMaxInactiveInterval(300);

            ServletContext sc = this.getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/index.jsp?msg=You are now Logged In");
            rd.forward(request, response);
        } else {
            String idData = "kumar";
            session.setAttribute("u_name", idData);

            ServletContext sc = this.getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/login.jsp?msg=Invalid Credentials, Try Once again");
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

