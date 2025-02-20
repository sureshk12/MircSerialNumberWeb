<%-- 
    Document   : validateTask
    Created on : 29-Dec-2024, 2:36:48 PM
    Author     : Suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <%
                String serialNumber = request.getParameter("serialNumber");
                if(serialNumber != null || serialNumber == "" )
                {
                    %>
                        <span class="label label-warning">Serial Number cannot be Empty</span>
                    <%                
                } else 
                {

                }
            %>
        </div> 
    </div>
</main>
<%@ include file = "footer.jsp" %>
