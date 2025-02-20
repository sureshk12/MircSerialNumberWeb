<%-- 
    Document   : createFactory
    Created on : 30-Dec-2024, 10:05:07 AM
    Author     : Suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <form action = "validateFactoryForm" method = "POST">
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Factory Name(max 40 character)</label>
                    <input type="text" class="form-control" id="factoryName" name="factoryName" >
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Factory Code(max 2 character)</label>
                    <input type="text" class="form-control" id="factoryCode" name="factoryCode" >
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">User Name(max 40 character)</label>
                    <input type="text" class="form-control" id="userName" name="userName" >
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">User Email address</label>
                    <input type="email" class="form-control" id="userEmail" aria-describedby="emailHelp" name="userEmail" >
                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">User Password(max 15 character)</label>
                    <input type="password" name="userPassword" class="form-control" id="exampleInputPassword1">
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">User Mobile Number(10 Digits)</label>
                    <input type="text" class="form-control" id="userMobile" name="userMobile" >
                </div>
                
                <button type="submit" class="btn btn-primary" name="btnsubmit" value="show">CREATE</button>
                
                <% 
                    String msg = request.getParameter("msg");
                    String errMsg = request.getParameter("retErr");
                    if(msg != null) {
                        if(errMsg != null) {
                            if(errMsg.equals("NOTOK"))
                            {
                            %>
                                <div class="p-3 mb-2 bg-danger text-white">
                                    <% out.print(msg);%>
                                </div> 
                            <%
                            } else if(errMsg.equals("OK"))
                            {
                            %>
                                <div class="p-3 mb-2 bg-success text-white">
                                    <% out.print(msg);%>
                                </div> 
                            <%
                            }
                        }
                    }
                %>
            </form>
        </div>
    </div>
</main>