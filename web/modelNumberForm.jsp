<%-- 
    Document   : modelNumberForm
    Created on : 31-Dec-2024, 9:18:12 AM
    Author     : Suresh
    Checked    : 20-Feb-2025, 12:14 PM
--%>

<%@page import="com.mirc.serialNumber.DatabaseHelper"%>
<%@page import="com.mirc.serialNumber.Factory"%>

<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <form action = "ValidateModelNumber" method = "POST">
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Model Number(max 15 character)</label>
                    <input type="text" class="form-control" id="modelNumber" name="modelNumber" >
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Factory Code</label>
                    <select class="form-select" id="selectFactory" name="factory" >
                        <option selected>Factory</option>
                    <%
                        DatabaseHelper db1 = new DatabaseHelper();
                        ArrayList<Factory> allFactory = db1.getAllFactory();                        
                        ArrayList<String> factoryNameList = new ArrayList<String>();
                        ArrayList<String> factoryCodeList = new ArrayList<String>();
                        for(int x = 0; x < allFactory.size(); x++)
                        {
                            factoryNameList.add(allFactory.get(x).getFactoryName());
                            factoryCodeList.add(allFactory.get(x).getFactoryCode());
                        }
                        
                        for(int x = 0; x < factoryNameList.size(); x++) {
                            String factoryname = factoryNameList.get(x);
                            String factorycode = factoryCodeList.get(x);
                            %>
                            <option value="<%=factorycode%>"><%=factoryname%></option>
                            <%
                        }
                    %>
                    </select>                        
                </div>
                    
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Starting serial Number(6 digits)</label>
                    <input type="text" class="form-control" id="startingSerialNumber" name="startingSerialNumber" >
                </div>
                
                <button type="submit" class="btn btn-primary" name="btnsubmit" value="show">CREATE</button>
                
                <% 
                    String msg = request.getParameter("msg");
                    String errMsg = request.getParameter("retErr");
                    if(msg != null) {
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
                %>
            </form>
        </div>
    </div>
</main>