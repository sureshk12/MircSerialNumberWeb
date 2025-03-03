<%-- 
    Document   : login
    Created on : 18 Jul, 2021, 8:25:43 AM
    Author     : suresh
    Checked    : 20-Feb-2025, 18:12 PM
--%>



<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Year"%>
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
                String factoryName = "";
                factoryName = (String)session.getAttribute("factoryName");
                String factoryCode = "";
                factoryCode = (String)session.getAttribute("factoryCode");
                String emailNew = "";
                emailNew = (String)session.getAttribute("U_useremail");
                String factoryCodeAdmin = "";
                String hideStartingNumber = "";
                if(logUserLevel!=null && logUserLevel.equals("9")) {
                    factoryCode = (String)request.getParameter("factoryCodeAdmin");
                    session.setAttribute("factoryCode", factoryCode);
                } else {
                    hideStartingNumber = "readOnly";
                }
            %>           
            
            <form action = "generateForm.jsp" method = "POST">    
                <table class="table">
                    <thead>                        
                    </thead>
                    <tbody>
                        
                        <tr>                            
                            <div class="mb-2">
                                <td class="col-1">
                                <label for="exampleInputEmail1" class="form-label">Factory</label>
                                </td>
                                <td class="col-3">
                                <select class="form-select" id="factoryName" name="factoryName" onchange="loadModelName()">
                                    <option selected>Factory</option>
                                    <%
                                        if(logUserLevel.equals("1")) {
                                        %>
                                            <option value="<%=factoryCode%>"><%=factoryName%></option>
                                        <%
                                        } else {
                                            DatabaseHelper db = new DatabaseHelper();
                                            ArrayList<Factory> allFactory = db.getAllFactory();
                                            String factoryName1 = "";
                                            String factoryCode1 = "";
                                            for(int b=0; b<allFactory.size(); b++) {
                                                factoryName1 = allFactory.get(b).getFactoryName();
                                                factoryCode1 = allFactory.get(b).getFactoryCode();
                                                %>    
                                                <option value="<%=factoryCode1%>" ><%=factoryName1%></option>
                                                <%                                        
                                            }
                                        }
                                    %>                       
                                </select>
                                </td>
                            </div>
                        </tr>
                        
                        
                        
                        <tr>                            
                            <div class="mb-2">
                                <td class="col-1">
                                <label for="exampleInputEmail1" class="form-label">Model</label>
                                </td>
                                <td class="col-3">
                                <select class="form-select" id="modelName" name="modelName" onchange="displayStartingNumber()">
                                    <option selected>Model</option>
                                    <%
//                                        db = new DatabaseHelper();
//                                        ArrayList<Model> models = db.getAllModel();
//                                        String startingNumber = "";
//                                        String model = "";                           
//                                        db = new DatabaseHelper();
//                                        for(int b=0; b<models.size(); b++) {
//                                            if(models.get(b).getFactoryCode().equals(factoryCode)){
//                                                model = models.get(b).getModelNumber();
//                                            %>    

//                                            <%                                        
//                                            }
//                                        }
                                    %>                       
                                </select>
                                </td>
                            </div>
                        </tr>
                        <tr>
                            <div class="mb-3">
                                <td class="col-1">
                                <label for="exampleInputEmail1" class="form-label">Year</label>
                                </td>
                                <td class="col-3">
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
                                    LocalDate today = LocalDate.now();
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MMM dd yyyy");
                                    String todayStr = today.format(dtf);
                                    String currentYearStr = todayStr.substring(todayStr.length()-2, todayStr.length());
                                    String currentMonthStr = todayStr.substring(0, 3);
                                    String selectedValueStr = "";
                                    for(int x = 0; x < yearList.size(); x++) {
                                    String year = yearList.get(x);
                                    if(currentYearStr.equals(year)) {
                                        selectedValueStr = "selected";
                                    } else {
                                        selectedValueStr="";
                                    }
                                        
                                %>
                                    <option value="<%=year%>" <%=selectedValueStr%>><%=year%></option>
                                <%
                                    }
                                %>
                                </select>
                                </td>
                            </div>
                        </tr>
                        <tr>
                            <div class="mb-3">
                                <td class="col-1">
                                <label for="exampleInputEmail1" class="form-label">Month</label>
                                </td>
                                <td class="col-3">
                                <select class="form-select" id="select-model" name="month" >
                                <option selected>Month</option>
                                <%
                                    ArrayList<String> monthList = new ArrayList<>();
                                    ArrayList<String> monthName = new ArrayList<>();
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
                                        if(month_name.equals(currentMonthStr)) {
                                            selectedValueStr = "selected";
                                        } else {
                                            selectedValueStr = "";
                                        }
                                        %>
                                        <option value="<%=month%>" <%=selectedValueStr%>><%=month_name%></option>
                                        <%
                                    }
                                %>
                                </select>
                                </td>
                            </div>
                        </tr>
                        <tr>
                            <div class="mb-3">
                                <td class="col-1">
                                    <label for="exampleInputEmail1" class="form-label">Starting Serial Number</label>
                                </td>
                                <td class="col-3">
                                    <input type="text" class="form-control" id="serialNumber" name="serialNumber" <%=hideStartingNumber%>>
                                </td>
                            </div>
                        </tr>
                        <tr>
                            <div class="mb-3">
                                <td class="col-1">
                                    <label for="exampleInputEmail1" class="form-label">Number Of Device</label>
                                </td> 
                                <td class="col-3">
                                    <input type="text" class="form-control" id="numberOfDevice" name="numberOfDevice" >
                                </td>
                            </div>
                        </tr>
                        <tr>
                            <div class="mb-3">
                                <td class="col-1">
                                    <button type="submit" class="btn btn-primary" name="btnsubmit" value="show">Show</button>
                                </td>
                                <td>
                                    <!-- <button type="submit" class="btn btn-primary" name="btnsubmit" value="downloadExcel">downExcel</button> -->
                                </td>
                            </div>
                        </tr>
                </tbody>
                </table>
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
    //document.getElementById("userEmail").innerText = "enter your email";
    function displayStartingNumber(){
        let modelName = document.querySelector('#modelName').value;
        let userType = "<%=logUserLevel%>";
        //console.log(userType);
        let factoryUserCode = document.querySelector('#factoryName').value;
        let http = new XMLHttpRequest();
        http.open("POST", "http://localhost:8080/MircSerialNumberWeb/getStartingSerialNumber.jsp", true);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        let params = "modelName=" + modelName +"&factoryUserCode="+factoryUserCode;
        http.send(params);
        http.onload = function() {
            document.getElementById("serialNumber").value = http.responseText;
        };
//        if(userType === "1") {
//            document.getElementById("serialNumber").readOnly = true;
//        }
    }
    
    function loadModelName(){
        //$("#modelName").empty();
        //let modelDropdown = document.getElementById("modelName");        
        
        let factoryCode = document.querySelector('#factoryName').value;
        let userType = "<%=logUserLevel%>";
        console.log("User Type:"+userType);
        console.log("Factory Code:"+factoryCode);        
               
        let http = new XMLHttpRequest();
        http.open("POST", "http://localhost:8080/MircSerialNumberWeb/getModelForFactory.jsp", true);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");        
        let params = "factoryCode=" + factoryCode;
        http.send(params);
        let dataReceived = "";
        http.onload = function() {
//            let option1 = document.createElement("option");
//            option1.text = "Model";
//            modelDropdown.add(option1, modelDropdown[0]);
            dataReceived = http.responseText;
            let model = dataReceived.split(",");
            model.push("Model");
            $("#modelName").empty();
            let modelDropdown = document.getElementById("modelName");
//            let option = document.createElement("option");
//            option.text = "Model";
//            modelDropdown.add(option, modelDropdown[0]);
            if(dataReceived === "NO DATA,") {
                
            } else {                
                console.log(model);
                for (let x = 0; x < model.length; x++) {
                    let option = document.createElement("option");
                    option.text = model[x];
                    modelDropdown.add(option, modelDropdown[0]);
                }
            }
            $("#modelName").prop("selectedIndex", 0).val(); 
        };

        

    }
</script>

<%@ include file = "footer.jsp" %>
