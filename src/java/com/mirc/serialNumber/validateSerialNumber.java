package com.mirc.serialNumber;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
//import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;

/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 12:14 PM
 */
public class validateSerialNumber extends HttpServlet {

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
        try {
            /* TODO output your page here. You may use following sample code. */
            String serialNumber = request.getParameter("serialNumber");
            int err = 0;
            if (serialNumber == null || serialNumber.equals("")) {
                err = 1;
            }
            if (err == 0) {
                //Strip the serail number
                String pNum = serialNumber.substring(0, (serialNumber.length()-9));
                String aNum = serialNumber.substring(serialNumber.length()-7);
                String orgStr = pNum+aNum;
                String shiftStr = AESClass.preEncodeShift(orgStr);
                String sNum = AESClass.encrypt(shiftStr);
                int n1 = 0;
                int n2 = 0; 
                for(int y = 0; y < sNum.length(); y++)
                {
                    n1 = n1 + sNum.charAt(y);
                    y++;
                    n2 = n2 + sNum.charAt(y);
                }
                int nStr1 = Integer.parseInt(String.valueOf(n1).substring(2));
                int nStr2 = Integer.parseInt(String.valueOf(n2).substring(2));

                String codedString = AESClass.convertStrToValidStr(nStr1, nStr2);
                String toCompareStr = serialNumber.substring((serialNumber.length() - 9),(serialNumber.length() - 7));
                if(codedString.equals(toCompareStr))
                {
                    err = 2;
                }
            }
            if(err == 2)
            {
                ServletContext sc = this.getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/validateForm.jsp?msg=OK&snNum="+serialNumber);
                rd.forward(request, response);                
            }
            if(err == 1)
            {
                ServletContext sc = this.getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/validateForm.jsp?msg=Empty");
                rd.forward(request, response);
            }
            if(err == 0)
            {
                ServletContext sc = this.getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/validateForm.jsp?msg=NOTOK");
                rd.forward(request, response);
            }
        } catch (IOException | NumberFormatException | ServletException ex) {
            
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
