<%@page import="com.mirc.serialNumber.DatabaseHelper"%>
<%
    String modelName = (String)request.getParameter("modelName");
    String factoryCode = (String)request.getParameter("factoryUserCode");
    //DatabaseHelper db = new DatabaseHelper();
    //String factoryCode = db.getFactoryCodeForfactoryEmail(factoryUserEmail);
    
    DatabaseHelper db = new DatabaseHelper();
    String startingSerialNumber = db.getStartingSerialNumber(modelName, factoryCode);
    
    out.println(startingSerialNumber);

%>
