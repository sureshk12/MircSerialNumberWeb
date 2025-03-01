<%-- 
    Document   : preGenerate
    Created on : 27-Feb-2025, 6:37:44 PM
    Author     : Suresh
--%>

<%@page import="com.mirc.serialNumber.DatabaseHelper"%>
<%@page import="com.mirc.serialNumber.Factory"%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
        <%
            session = request.getSession();
            String email = (String)session.getAttribute("U_useremail");
        %>

        <form action = "generate1.jsp" method = "POST">
            <table class="table">
                <thead></thead>
                <tbody>
                    <tr>
                    <%
                        DatabaseHelper db = new DatabaseHelper();
                        ArrayList<Factory> factorys = db.getAllFactory();
                        String factoryName = "";                        
                        if(logUserLevel!=null && logUserLevel.equals("9")){
                    %>
                        <div class="mb-3">
                        <td>
                            <label for="exampleInputEmail1" class="form-label">Factory Name</label>
                        </td>
                        <td>
                            <select class="form-select" id="factoryName" name="factoryName">
                            <option selected>Factory</option>                            
                            <%
                            for(int f=0; f<factorys.size();f++){
                                factoryName = factorys.get(f).getFactoryName();
                                %>    
                                    <option value="<%=factoryName%>"><%=factoryName%></option>
                                <% 
                            }
                        } else {
                            db = new DatabaseHelper();
                            factoryName = db.getFactoryCodeForfactoryEmail(email);
                            session.setAttribute("factoryName", factoryName);
                        }
                    %>
                        </td>
                    </tr>
                    <tr>
                        <div class="mb-3">
                            <td>
                                <button type="submit" class="btn btn-primary" name="btnsubmit" value="show">NEXT</button>
                            </td>
                        </div>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</main>