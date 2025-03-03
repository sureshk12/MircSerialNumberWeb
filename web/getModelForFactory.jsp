<%-- 
    Document   : getModelForFactory
    Created on : 02-Mar-2025, 11:38:25 PM
    Author     : Suresh
--%>
<%@page import="com.mirc.serialNumber.Model"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mirc.serialNumber.DatabaseHelper"%>
<%
    String factoryCode = (String)request.getParameter("factoryCode");
    DatabaseHelper db = new DatabaseHelper();
    ArrayList<Model> models = db.getAllModel();
    String modelData = "";
    for(int b=0; b<models.size(); b++) {
        if(models.get(b).getFactoryCode().equals(factoryCode)){
            modelData = modelData+models.get(b).getModelNumber()+",";
        }
    }
    if(modelData.equals("")) {
        modelData = "NO DATA,";
    }
    modelData = modelData.substring(0, modelData.length()-1);
    out.println(modelData);
%>
