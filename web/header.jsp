<%-- 
    Document   : headerjsp
    Created on : 17 Jul, 2021, 10:21:56 PM
    Author     : suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = " java.util.* " %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->        
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="static/css/main.css">

        <%                                       
            String [] urlStr = { 
                "index.jsp?title=0",
                "generate.jsp?title=1",
                "validateForm.jsp?title=2",
                "factoryForm.jsp?title=3",
                "modelNumberForm.jsp?title=4",
                "about.jsp?title=5"
            };                                
            String [] titleStr = {
                "Home",
                "Generate",
                "Validate",
                "Factory",
                "ModelNumber",
                "About"
            };
            //Logging
            String logStatus = (String)session.getAttribute("u_name");
            String logUserLevel = (String)session.getAttribute("u_userlevel");
            if(logStatus == null) {
                logStatus = "NO";
            }
            if(!logStatus.equals("Suresh") || logUserLevel.equals("0")) {
                for (int s = 0; s < urlStr.length; s++) {
                    urlStr[s] = "";
                    titleStr[s]= "";
                }                    
            } else if(logUserLevel.equals("1")) {
                for (int s = 0; s < urlStr.length; s++) {
                    urlStr[s] = "";
                    titleStr[s]= "";
                } 
                urlStr[0] = "index.jsp?title=0";
                urlStr[1] = "generate.jsp?title=1";
                urlStr[2] = "about.jsp?title=2";
                titleStr[0] = "Home";
                titleStr[1] = "Generate";
                titleStr[2] = "About";
                
            } else if(logUserLevel.equals("2")) {
                    for (int s = 0; s < urlStr.length; s++) {
                    urlStr[s] = "";
                    titleStr[s]= "";
                } 
                urlStr[0] = "index.jsp?title=0";
                urlStr[1] = "validateForm.jsp?title=1";
                urlStr[2] = "about.jsp?title=2";
                titleStr[0] = "Home";
                titleStr[1] = "Validate";
                titleStr[2] = "About";
            }
            
            String title = request.getParameter("title");
            int titleInt = 0;
            if(title != null) {
                titleInt = Integer.parseInt(title);
            }
//            out.print("Mirc SOP - " + titleStr[titleInt]);
        %>
        <title>
            Mirc Serial Number - 
            <%out.print(" " + titleStr[titleInt]); %>
        </title>              
        <link rel="shortcut icon" href="static/image/MIRC.ico" type="image/x-icon"/>
    </head>
    <body>        
        <header class="site-header">
            <nav class="navbar navbar-expand-md navbar-dark bg-steel fixed-top">
                <div class="container">
                    <div class="nav-item nav-link">
                        <img src="static/image/MIRC_55x30.png" alt="MIRC" >
                    </div>                    
                    <a class="navbar-brand mr-4" href="index.jsp">MIRC</a>

                    <div class="collapse navbar-collapse" id="navbarToggle">
                        <%
                            if(logStatus.equals("Suresh")) {
                                %>
                                <div class="navbar-nav mr-auto">
                                    <%
                                        for(int i = 0; i < urlStr.length; i++) {
                                            %>
                                                <a class="nav-item nav-link" href=<%out.print(urlStr[i] + ">" + titleStr[i]);%></a>
                                            <%
                                        }
                                    %>
                                </div>                               
                                <%
                            }                            
                        %>
                        <!-- Navbar Right Side -->                        
                        <div class="navbar-nav">
                            <a class="nav-item nav-link" href="login.jsp">Login</a>
                            <!-- <a class="nav-item nav-link" href="/register">Register</a> -->
                        </div>
                    </div>
                </div>
            </nav>
        </header>
        <%
            if(!logStatus.equals("Suresh")) {
                %>
                <main role="main" class="container">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="alert alert-danger" role=alert">
                                <h5>You have not Logged in, Please log in to use the System</h5>
                            </div>
                        </div>
                    </div>

                </main>
                
                <% 

            }
        %>
        
        

                


