<%-- 
    Document   : generateForm
    Created on : 28-Dec-2024, 1:34:29 PM
    Author     : Suresh
    Checked    : 20-Feb-2025, 18:26 PM
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import= "java.util.Date" %>

<%@page import="com.mirc.serialNumber.AESClass"%>
<%@page import="com.mirc.serialNumber.DatabaseHelper"%>



<main role="main" class="container">
    <form action = "index.jsp">
        <% String formError = "OK"; %>
        <table cellpadding="3" cellspacing="3" border="1">            
            <%            
                String fileExcelName="SerialNumber";
                response.setContentType("application/vnd.ms-excel");
                DateFormat dfFile = new SimpleDateFormat("yyyyMMdd");
                String today = dfFile.format(Calendar.getInstance().getTime());
                response.setHeader("Content-Disposition", "inline; filename=" + fileExcelName+"_"+today+".xls");

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
                    modelName = (String)session.getAttribute("modelName");
                    year = (String)session.getAttribute("year");
                    month = (String)session.getAttribute("month");
                    //factory = request.getParameter("factory");
                    startingSerialNumberStr = (String)session.getAttribute("serialNumber");
                    startingSerialNumber = Integer.parseInt(startingSerialNumberStr);
                    numberOfDevice = (String)session.getAttribute("numberOfDevice");
                    //Update the starting serial number
                    int newStartingNumber = startingSerialNumber+Integer.parseInt(numberOfDevice);
                    String newStartingNumberStr = Integer.toString(newStartingNumber);                    
                    DatabaseHelper db = new DatabaseHelper();
                    factory = db.getFactoryCodeForModelNumber(modelName);
                    
                    db = new DatabaseHelper();
                    db.updateStartingNumberOfModelFactorycode(modelName, factory , newStartingNumberStr);
                    
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
                        DatabaseHelper db = new DatabaseHelper();
                        String errorStr = db.createSerialNumber(modelName, eNum, yearMonthFactory, codedString);

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
            <!-- <input type="submit" class="btn btn-primary mr-4" name="btnreturn" value="Return"> -->
            
            <%
                //if(formError.equals("OK")) {
                %>
                <!-- <input type="submit" class="btn btn-primary" name="btncreate" value="Create"> -->
                <%
                //}
                Date date = new Date();
            %>
            <!-- <br> -->
            <a>Generated on <%= date %>.</a>

        </form>
    </table>
</main>



<%@ include file = "footer.jsp" %>



