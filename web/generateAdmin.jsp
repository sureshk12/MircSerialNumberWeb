<%-- 
    Document   : generateAdmin
    Created on : 27-Feb-2025, 9:28:41 PM
    Author     : Suresh
--%>

<%@page import="com.mirc.serialNumber.DatabaseHelper"%>
<%@page import="com.mirc.serialNumber.Factory"%>

<%@ include file = "header.jsp" %>

<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <form action = "generate.jsp" method = "POST">
                <table class="table">
                    <thead></thead>
                    <tbody>
                        <tr>
                            <div class="mb-3">
                                <td>
                                    <label for="exampleInputEmail1" class="form-label">Factory Name</label>
                                </td>
                                <td>
                                    <select class="form-select" id="factoryCodeAdmin" name="factoryCodeAdmin">
                                        <option selected>Factory</option>
                                    <%
                                        session = request.getSession();
                                        String email = (String)session.getAttribute("U_useremail");
                                        DatabaseHelper db = new DatabaseHelper();
                                        ArrayList<Factory> factorys = db.getAllFactory();
                                        String factoryName = "";
                                        String factoryCode = "";
                                        for(int f=0; f<factorys.size();f++){
                                            factoryName = factorys.get(f).getFactoryName();
                                            factoryCode = factorys.get(f).getFactoryCode();
                                        %>
                                            <option value="<%=factoryCode%>"><%=factoryName%></option>                                        
                                        <%
                                        }
                                    %>                                    
                                    </select>
                                </td>
                            </div>                            
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
    </div>
</main>
                                    
<%@ include file = "footer.jsp" %>
