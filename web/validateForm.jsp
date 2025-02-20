<%-- 
    Document   : Validate
    Created on : 29-Dec-2024, 2:27:28 PM
    Author     : Suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <form action = "validateSerialNumber" method = "POST">
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Enter Complete Serial Number</label>
                    <input type="text" class="form-control" id="serialNumber" name="serialNumber" >
                </div> 
                <button type="submit" class="btn btn-primary" name="btnsubmit" value="show">VALIDATE</button>
                <% 
                    String msg = request.getParameter("msg");
                    String snNum = request.getParameter("snNum");
                    if(msg != null) {
                        if(msg.equals("NOTOK"))
                        {
                        %>
                            <div class="alert alert-danger" role="alert">
                                Serial Number not Valid
                            </div>
                        <%                        
                        }
                        if(msg.equals("OK"))
                        {
                        %>
                            <div class="alert alert-success" role="alert">
                                <%
                                    if(snNum != null)
                                        {
                                            out.println("Serial number <b>"+snNum+"</b> is Valid");
                                        }
                                %>
                            </div>
                        <%   
                        }
                        if(msg.equals("Empty"))
                        {
                        %>
                            <div class="alert alert-danger" role="alert">
                                Serial Number cannot be Empty
                            </div>
                        <%   
                        }

                    }
                %>
            </form>
        </div>
    </div>
</main>
<%@ include file = "footer.jsp" %>
