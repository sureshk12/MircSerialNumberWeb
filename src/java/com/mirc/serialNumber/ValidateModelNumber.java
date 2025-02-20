/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mirc.serialNumber;

import java.io.IOException;
//import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 12:14 PM
 */
public class ValidateModelNumber extends HttpServlet {

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
            String modelNumber = request.getParameter("modelNumber");
            if(modelNumber == null || modelNumber.isEmpty() || modelNumber.trim().isEmpty() || modelNumber.length() > 15) {
                err = 1;
                msg = msg + "Not Valid Model Number;";
            }
            String factoryCode = request.getParameter("factory");
            if(factoryCode.equals("Factory")) {
                err = 1;
                msg = msg + "Not Valid Factory Code;";                
            }
            String startingSlNo = request.getParameter("startingSerialNumber");
            int startingserialNumber = 0;
            if(startingSlNo == null || startingSlNo.isEmpty() || startingSlNo.trim().isEmpty() || startingSlNo.length() > 6) {
                err = 1;
                msg = msg + "Not Valid Starting Serial Number;";
            }  else {
                try{
                    startingserialNumber = Integer.parseInt(startingSlNo);
                    if(startingserialNumber == 0 || startingserialNumber > 999999) {
                        err = 1;
                        msg = msg + "Not Valid Starting Serial Number;"; 
                    }
                }catch(Exception e){
                    err = 1;
                    msg = msg + "Not Valid Data;"; 
                }
            }
            if(err == 1) {
                ServletContext sc = this.getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/modelNumberForm.jsp?msg=" + msg + "&retErr=NOTOK");
                rd.forward(request, response);
            } else 
            {
                //process data
                //Check factory 
                DatabaseHelper db = new DatabaseHelper();
                ArrayList<Model> allMod = db.getAllModel();
                int errMod = 0;
                for(int x =0; x < allMod.size(); x++)
                {
                    if(allMod.get(x).getModelNumber().equals(modelNumber))
                    {
                        errMod = 1;
                    }
                }
                if(errMod == 1)
                {
                    ServletContext sc = this.getServletContext();
                    RequestDispatcher rd = sc.getRequestDispatcher("/modelNumberForm.jsp?msg=Model number <b>"+ modelNumber +"</b> already Exists&retErr=NOTOK");
                    rd.forward(request, response);                    
                } else {
                    Model mod = new Model(modelNumber, factoryCode, Integer.toString(startingserialNumber));
                    DatabaseHelper db1 = new DatabaseHelper();
                    String retVal = db1.updateModel(mod);
                    ServletContext sc = this.getServletContext();
                    RequestDispatcher rd = sc.getRequestDispatcher("/modelNumberForm.jsp?msg="+ retVal +"&retErr=OK");
                    rd.forward(request, response);
                }
            }
        } catch (IOException | ServletException ex) {
            
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
