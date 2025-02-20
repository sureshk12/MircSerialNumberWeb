<%-- 
    Document   : generateForm
    Created on : 28-Dec-2024, 1:34:29 PM
    Author     : Suresh
    Checked    : 20-Feb-2025, 18:19 PM
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import= "java.util.Date" %>

<%@page import="com.mirc.serialNumber.AESClass"%>
<%@page import="com.mirc.serialNumber.DatabaseHelper"%>

<%@ include file = "header.jsp" %>

<main role="main" class="container">
    <form action = "generateDecide.jsp">
        <% String formError = "OK"; %>
        <table cellpadding="3" cellspacing="3" border="1">            
            <%            
                String fileExcelName="SerialNumber";
                //response.setContentType("application/vnd.ms-excel");
                DateFormat dfFile = new SimpleDateFormat("yyyyMMdd");
                String today = dfFile.format(Calendar.getInstance().getTime());
              //response.setHeader("Content-Disposition", "inline; filename=" + fileExcelName+"_"+today+".xls");

                int err = 0;
                String modelName = null;
                String year = null;
                String month = null;
                String factory = null;
                String startingSerialNumberStr = null;
                int startingSerialNumber = 0;
                String numberOfDevice = null;                
                
                try 
                {
                    modelName = request.getParameter("modelName");
                    session.setAttribute("modelName", modelName);
                    year = request.getParameter("year");
                    session.setAttribute("year", year);
                    month = request.getParameter("month");
                    session.setAttribute("month", month);
//                    factory = request.getParameter("factory");
                    startingSerialNumberStr = request.getParameter("serialNumber");
                    session.setAttribute("serialNumber", startingSerialNumberStr);
                    startingSerialNumber = Integer.parseInt(startingSerialNumberStr);
                    numberOfDevice = request.getParameter("numberOfDevice");
                    session.setAttribute("numberOfDevice", numberOfDevice);
                    DatabaseHelper db = new DatabaseHelper();
                    factory = db.getFactoryCodeForModelNumber(modelName);
                    
                    if(modelName == null || modelName == "" || year.equals("Year") || month.equals("Month") || startingSerialNumberStr == null ||factory.equals("") || startingSerialNumberStr == "" || numberOfDevice == null || numberOfDevice == "")
                    {
                        err = 1;
                    }
                    
                } catch(Exception e) {
                    err = 1;
                }
                String yearMonthFactory = year+month+factory;
                String pNum = modelName+"#"+yearMonthFactory;

                if( err == 0)
                {
                    out.println("<TR>");
                    out.println("<TH>Serial Number</TH>");
                    out.println("<TH>Encoded Serial Number</TH>");
                    out.println("</TR>");

                    for (int x = 0; x<Integer.parseInt(numberOfDevice); x++)
                    {
                        //String eNum = String.format("%03d", 7);
                        String eNumbeforePadding = String.valueOf(startingSerialNumber+x);
                        int leneNumbeforePadding = eNumbeforePadding.length();
                        String eNum = "";
                        switch(leneNumbeforePadding)
                        {
                            case 1:
                                eNum = "00000"+eNumbeforePadding;
                                break;
                            case 2:
                                eNum = "0000"+eNumbeforePadding;
                                break;
                            case 3:
                                eNum = "000"+eNumbeforePadding;
                                break;
                            case 4:
                                eNum = "00"+eNumbeforePadding;
                                break;
                            case 5:
                                eNum = "0"+eNumbeforePadding;
                                break;
                            case 6:
                                eNum = eNumbeforePadding;
                                break;
                            default:
                                break;                
                        }
                        String orgStr = pNum+"#"+eNum;
                        String codedSerialNumber = "";
                        
                        /********************************
                         * REMOVED ERROR CHECKING FOR REPEATED SERIAL NUMBER

                        //Check if Serial number exists 
                        DatabaseHelper db = new DatabaseHelper();
                        String errorString = db.checkForSerialNumber(modelName, eNum); 
                        */
                        String errorString = "OK"; //Inserted non error checking
                        
                        if (errorString.equals("OK")) {
                            //db.createSerialNumber(modelName, yearMonthFactory, eNum);
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
                            //String codedSerialNumber = orgStr + codedString;
                            codedSerialNumber = pNum+codedString+"#"+eNum;
                        } else {
                            codedSerialNumber = "Sl num exists: "+ errorString ;
                            formError = "NOT OK";
                        }                 

                        //out.println("<h5>N1: " + n1+ "/N2: "+ n2 + "/nStr1: " + nStr1 +"/nStr2:" +nStr2+"/Coded2Char: "+codedString+"</h5>");
                        //out.println("<h5>Serial Number: " + orgStr + " / Coded Serial Number: " + codedSerialNumber + "</h5>");
                        //out.println("Serial Number: " + orgStr + " / Coded Serial Number: " + codedSerialNumber );
                        out.println("<TR>");
                        out.println("<TD><center>" + orgStr +"</center></TD>");
                        out.println("<TD><center>" + codedSerialNumber +"</center></TD>");
                        out.println("</TR>");
                    }
                } else 
                {
                    //Error
                    ServletContext sc = this.getServletContext();
                    RequestDispatcher rd = sc.getRequestDispatcher("/generate.jsp?msg=Invalid Data Entry, Try Once again");
                    rd.forward(request, response);
                }

            %>        
            <input type="submit" class="btn btn-primary mr-4" name="btnsubmit" value="Return">
            
            <%
                if(formError.equals("OK")) {
                %>
                <input type="submit" class="btn btn-primary" name="btnsubmit" value="Download">
                <%
                }
            %>
            <br>
            <a>Data Generated</a>

        </form>
    </table>
</main>



<%@ include file = "footer.jsp" %>

