<%-- 
    Document   : index
    Created on : 17 Jul, 2021, 7:25:38 PM
    Author     : suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@ include file = "header.jsp" %>

<%    
    if (logStatus.equals("Suresh")) {
%>

<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <h1>MIRC Serial Number System</h1>
    <%
        String msg = request.getParameter("msg");
        if (msg != null) {
            if(msg.substring(0, 5).equals("ERROR")) {
    %>
                <div class="alert alert-danger" role="alert">
                    <% out.print(msg);%>
                </div>
    <%                  
            } else {
    %>
                <div class="alert alert-success" role="alert">
                    <% out.print(msg);%>
                </div>
    <%                
            }
        }
    %>
    <%
        }
    %>
        </div>
    </div>
</main>

<%@ include file = "footer.jsp" %>
