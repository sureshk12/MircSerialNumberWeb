<%-- 
    Document   : login
    Created on : 18 Jul, 2021, 8:25:43 AM
    Author     : suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@ include file = "header.jsp" %>

<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <form action = "LoginValidate" method = "POST"><!-- LoginValidate -->
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="userEmail" aria-describedby="emailHelp" name="userEmail" >
                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                </div>
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input type="password" name="userPassword" class="form-control" id="exampleInputPassword1">
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
    document.getElementById("userEmail").innerText = "enter your email";
</script>

<%@ include file = "footer.jsp" %>
