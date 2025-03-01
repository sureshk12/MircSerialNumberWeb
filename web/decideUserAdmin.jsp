<%-- 
    Document   : decideUserAdmin
    Created on : 27-Feb-2025, 9:25:22 PM
    Author     : Suresh
--%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <%
        if(logUserLevel!=null && logUserLevel.equals("9"))
        {
            %>
                <jsp:forward page="/generateAdmin.jsp"></jsp:forward>
            <%
        } else 
        {
            %>
                <jsp:forward page="/generate.jsp"></jsp:forward>
            <%
        }       
    %>    
</main>
<%@ include file = "footer.jsp" %>
