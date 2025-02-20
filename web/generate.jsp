<%-- 
    Document   : login
    Created on : 18 Jul, 2021, 8:25:43 AM
    Author     : suresh
    Checked    : 20-Feb-2025, 18:12 PM
--%>


<%@page import="com.mirc.serialNumber.DatabaseHelper"%>
<%@page import="com.mirc.serialNumber.Factory"%>
<%@page import="com.mirc.serialNumber.User"%>
<%@page import="com.mirc.serialNumber.Model"%>


<%@ include file = "header.jsp" %>
<main role="main" class="container">
    <div class="row">
        <div class="col-md-8">
            <%
                session = request.getSession();
                String email = (String)session.getAttribute("U_useremail");
            %>
            
            
            <form action = "generateForm.jsp" method = "POST">    <!-- was generateDecide.jsp -->            
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Model</label>
                    <select class="form-select" id="modelName" name="modelName" onchange="displayStartingNumber()">
                        <option selected>Model</option>
                        <%
                            DatabaseHelper db = new DatabaseHelper();
                            ArrayList<Model> models = db.getAllModel();
                            if(logUserLevel!=null && logUserLevel.equals("9")){
                                for(int f=0; f<models.size();f++){
                                    String model = models.get(f).getModelNumber();
                                    %>    
                                        <option value="<%=model%>"><%=model%></option>
                                    <% 
                                }                                
                            } else {                            
                                db = new DatabaseHelper();
                                ArrayList<Factory> factories = db.getAllFactory();
                                for(int a=0; a<factories.size(); a++){
                                    if(factories.get(a).getFactoryEmail().equals(email)){
                                        for(int b=0; b<models.size(); b++) {
                                            if(models.get(b).getFactoryCode().equals(factories.get(a).getFactoryCode())){
                                                String model = models.get(b).getModelNumber();
                                            %>    
                                                <option value="<%=model%>"><%=model%></option>
                                            <%                                        
                                            }
                                        }
                                    }
                                }
                            }
                        %>                       
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Year</label>
                    <select class="form-select" id="select-model" name="year" >
                        <option selected>Year</option>
                    <%
                        ArrayList<String> yearList = new ArrayList<String>();
                        for(int x=0; x<100; x++) {
                            String temp = String.valueOf(x);
                            if(x < 10) {
                                temp = "0"+temp;
                            }
                            yearList.add(temp);

                        }                  
                        for(int x = 0; x < yearList.size(); x++) {
                            String year = yearList.get(x);
                    %>
                        <option value="<%=year%>"><%=year%></option>
                    <%
                        }
                    %>
                    </select>                   
                </div>
                     
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Month</label>
                    <select class="form-select" id="select-model" name="month" >
                    <option selected>Month</option>
                    <%
                        ArrayList<String> monthList = new ArrayList<String>();
                        ArrayList<String> monthName = new ArrayList<String>();
                        monthList.add("A");monthName.add("Jan");
                        monthList.add("B");monthName.add("Feb");
                        monthList.add("C");monthName.add("Mar");
                        monthList.add("D");monthName.add("Apr");
                        monthList.add("E");monthName.add("May");
                        monthList.add("F");monthName.add("Jun");
                        monthList.add("G");monthName.add("Jul");
                        monthList.add("H");monthName.add("Aug");
                        monthList.add("I");monthName.add("Sep");
                        monthList.add("J");monthName.add("Oct");
                        monthList.add("K");monthName.add("Nov");
                        monthList.add("L");monthName.add("Dec");
                        
                        for(int x = 0; x < monthList.size(); x++) {
                            String month = monthList.get(x);
                            String month_name = monthName.get(x);
                            %>
                            <option value="<%=month%>"><%=month_name%></option>
                            <%
                        }
                    %>
                    </select>  
                </div>

                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Starting Serial Number</label>
                    <input type="text" class="form-control" id="serialNumber" name="serialNumber" >
                </div>
                    
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Number Of Device</label>
                    <input type="text" class="form-control" id="numberOfDevice" name="numberOfDevice" >
                </div>


                <button type="submit" class="btn btn-primary" name="btnsubmit" value="show">Show</button>
                <!-- <button type="submit" class="btn btn-primary" name="btnsubmit" value="downloadExcel">downExcel</button> -->
                
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
