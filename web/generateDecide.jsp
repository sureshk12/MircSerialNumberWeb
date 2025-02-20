<%-- 
    Document   : generateDecide
    Created on : 29-Dec-2024, 12:59:24 PM
    Author     : Suresh
    Checked    : 20-Feb-2025, 18:14 PM
--%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <%
           if(request.getParameter("btnsubmit").equals("Return"))
           {
                %>
                <jsp:forward page="/index.jsp"></jsp:forward>
                <%
           } else if(request.getParameter("btnsubmit").equals("Download"))
            {
                %>
                <jsp:forward page="/generateFormExcel.jsp"></jsp:forward>
                <%
            }       
    %>    
</main>
<%@ include file = "footer.jsp" %>
