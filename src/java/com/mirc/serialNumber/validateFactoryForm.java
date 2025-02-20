/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mirc.serialNumber;

import java.io.IOException;
//import java.io.PrintWriter;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.util.ArrayList;

/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 12:14 PM
 */
public class validateFactoryForm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request HttpServlet request
     * @param response HttpServlet response
     * @throws ServletException if a HttpServlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int err = 0;
        String msg = "";
        try {
            /* TODO output your page here. You may use following sample code. */
            String factoryName = request.getParameter("factoryName");
            if(factoryName == null || factoryName.isEmpty() || factoryName.trim().isEmpty() || factoryName.length() > 40) {
                err = 1;
                msg = msg + "Not Valid Factory Name;";
            }
            String factoryCode = request.getParameter("factoryCode");
            if(factoryCode == null || factoryCode.isEmpty() || factoryCode.trim().isEmpty() || factoryCode.length() > 2) {
                err = 1;
                msg = msg + "Not Valid Factory Code;";
            }
            String userName = request.getParameter("userName");
            if(userName == null || userName.isEmpty() || userName.trim().isEmpty() || userName.length() > 40) {
                err = 1;
                msg = msg + "Not Valid User Name;";
            }
            String userEmail = request.getParameter("userEmail");
            if(userEmail == null || userEmail.isEmpty() || userEmail.trim().isEmpty()) {
                err = 1;
                msg = msg + "Not Valid User Email;";
            } else {                
                Pattern pattern = Pattern.compile("^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
                Matcher matcher = pattern.matcher(userEmail);
                if(!matcher.find())
                {
                    err = 1;
                    msg = msg + "Not Valid User Email;";
                }
            }
            String userPwd = request.getParameter("userPassword");
            if(userPwd == null || userPwd.isEmpty() || userPwd.trim().isEmpty() || userPwd.length() > 15) {
                err = 1;
                msg = msg + "Not Valid User Password;";
            }

            String userMobile = request.getParameter("userMobile");
            if(userMobile == null || userMobile.isEmpty() || userMobile.trim().isEmpty() || userMobile.length() != 10 || userMobile.length() > 10) {
                err = 1;
                msg = msg + "Not Valid User Mobile Number;";
            }
        
            if(err == 1) {
                ServletContext sc = this.getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/factoryForm.jsp?msg=" + msg + "&retErr=NOTOK");
                rd.forward(request, response);
            } else 
            {
                //process data
                //Check factory 
                DatabaseHelper db = new DatabaseHelper();
                ArrayList<Factory> allFac = db.getAllFactory();
                int errFac = 0;
                for(int x =0; x < allFac.size(); x++)
                {
                    if(allFac.get(x).getFactoryCode().equals(factoryCode))
                    {
                        errFac = 1;
                        msg = msg + "Factory Code Already exists;";
                    }
                }
                if(errFac == 1)
                {
                    ServletContext sc = this.getServletContext();
                    RequestDispatcher rd = sc.getRequestDispatcher("/factoryForm.jsp?msg=" + msg +"&retErr=NOTOK");
                    rd.forward(request, response);                    
                } else {
                    Factory fact = new Factory(factoryName, factoryCode, userEmail);
                    DatabaseHelper db1 = new DatabaseHelper();
                    db1.updateFactory(fact);
                    String message = "New Factory added";
                    
                    db = new DatabaseHelper();
                    ArrayList<User> allUser = db.getAllUser();
                    int errUsr = 0;
                    for(int x = 0; x<allUser.size(); x++) {
                        if(allUser.get(x).getUser_email().equals(userEmail)){
                            errUsr =1;
                        }
                    }
                    if(errUsr == 1)
                    {
                        message = message + " User already existing";
                    } else {
                        User user = new User(userEmail, userPwd, factoryCode, userName, userMobile, "1");
                        DatabaseHelper db2 = new DatabaseHelper();
                        db2.updateUser(user);
                        message = message + " also Added User";
                    }                   
                    ServletContext sc = this.getServletContext();
                    String returnStatement = "/factoryForm.jsp?msg="+ message+"&retErr=OK";
                    RequestDispatcher rd = sc.getRequestDispatcher(returnStatement);
                    rd.forward(request, response); 
                }
            }
        } catch (IOException | ServletException e) {
            ServletContext sc = this.getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/factoryForm.jsp?msg=Incorrect Data Entered, pls correct");
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request HttpServlet request
     * @param response HttpServlet response
     * @throws ServletException if a HttpServlet-specific error occurs
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