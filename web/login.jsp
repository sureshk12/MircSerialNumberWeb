<%-- 
    Document   : login
    Created on : 18 Jul, 2021, 8:25:43 AM
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

        <title>
            Mirc Serial Number - Home

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
    
    
                        <!-- Navbar Right Side -->                        
                        <div class="navbar-nav">
                            <a class="nav-item nav-link" href="login.jsp">Login</a>
                            <!-- <a class="nav-item nav-link" href="/register">Register</a> -->
                        </div>
                    </div>
                </div>
            </nav>
        </header>    
    
    
    
    <main role="main" class="container">
    <div class="row">
        <div class="col-md-5">
            <form action = "LoginValidate" method = "POST"><!-- LoginValidate -->
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="userEmail" name="userEmail" >
                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                </div>
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input type="password" name="userPassword" class="form-control" id="exampleInputPassword">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
                
                <% 
                    String msg = request.getParameter("msg");
                    if(msg != null) {
                        %>
                            <!-- <div class="alert alert-danger" role=alert"> -->
                            <div class="p-3 mb-2 bg-danger text-white">
                                <% out.print(msg);%>
                            </div>
                        <%
                    }
                %>
            </form>
        </div>
    </div>
</main>
            
<script>
    //document.getElementById("userEmail").value = "enter your email";
</script>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
