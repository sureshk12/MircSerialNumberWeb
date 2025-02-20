/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mirc.serialNumber;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 18:05 PM
 */
public class DatabaseHelper {

    Connection conn = null;
    Statement stmt = null;

    public DatabaseHelper() {
        //Constructor        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/serial_number?autoReconnect=true&useSSL=false", "root", "Vidya@100");
            stmt = conn.createStatement();
        } catch (SQLException ex) {
            System.out.println(" ERROR System Error");
        } catch (ClassNotFoundException e) {
            System.out.println(e);
            System.out.println(" ERROR System error");
        }
    }

    
    public int validateUser(String userEmail, String userPwd) {
        int retValue = 1;//0=Found,1=NotFound 
        try {
            ResultSet resultset;
            String queryString = "SELECT * FROM user WHERE user_email='" + userEmail + "' AND user_pwd='" + userPwd + "'";
            resultset = stmt.executeQuery(queryString);

            while (resultset.next()) {
                retValue = 0;
            }
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Error System Error");
        }
        return retValue;
    }

    
    public ArrayList<User> getAllUser() {
        ArrayList<User> users = new ArrayList<>();
        try {
            ResultSet resultset;
            String queryString = "select *from user";
            resultset = stmt.executeQuery(queryString);

            while (resultset.next()) {
                users.add(new User(resultset.getString(1), resultset.getString(2), resultset.getString(3), resultset.getString(4), resultset.getString(5), resultset.getString(6)));
            }
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("ERROR System Error");
        }
        return users;        
        
    }
    
    public ArrayList<Factory> getAllFactory() {
        ArrayList<Factory> factorys = new ArrayList<>();
        try {
            ResultSet resultset;
            String queryString = "select *from factory";
            resultset = stmt.executeQuery(queryString);

            while (resultset.next()) {
                factorys.add(new Factory(resultset.getString(1), resultset.getString(2), resultset.getString(3)));
            }
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("ERROR System Error");
        }
        return factorys;
    }
    
    public ArrayList<Model> getAllModel() {
        ArrayList<Model> models = new ArrayList<>();
        try {
            ResultSet resultset;
            String queryString = "select *from model";
            resultset = stmt.executeQuery(queryString);

            while (resultset.next()) {
                models.add(new Model(resultset.getString(1), resultset.getString(2), resultset.getString(3)));
            }
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("ERROR System Error");
        }
        return models;
    }
    
    public String updateUser(User u) {
        //Company Creation
        String retValue = "Created User with Email: " + u.getUser_email() + " & Code: " + u.getUser_factory_code();
        try {
            //Store Company in Database
            PreparedStatement st;
            st = conn.prepareStatement("INSERT into user (user_email, user_pwd, user_factory_code, user_name, user_mobile, user_level) VALUES (?,?,?,?,?,?)");
            st.setString(1, u.getUser_email());//User name
            st.setString(2, u.getUser_pwd());//User password
            st.setString(3, u.getUser_factory_code());//User password
            st.setString(4, u.getUser_name());//User password
            st.setString(5, u.getUser_mobile());//User password
            st.setString(6, u.getUser_level()); //User level
            retValue = "Created User with code <b>" + u.getUser_email() + "</b> Sucessfully";
            st.executeUpdate();
            st.close();

            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            if (ex.getMessage() != null) {
                System.out.println("SQL Error" + ex.getMessage());
                retValue = "ERROR could not create User with Email " + u.getUser_email();
            }
        }
        return retValue;
    }
    
    public String updateFactory(Factory f) {
        //Company Creation
        String retValue = "Created Factory with Name: " + f.getFactoryCode() + "  Code: " + f.getFactoryCode();
        try {
            //Store Company in Database
            PreparedStatement st;
            st = conn.prepareStatement("INSERT into factory (factory_name, factory_code, factory_email) VALUES (?,?,?)");
            st.setString(1, f.getFactoryName());//Factory name
            st.setString(2, f.getFactoryCode());//Factory Code
            st.setString(3, f.getFactoryEmail());//Factory Code
            retValue = "Created factory with code <b>" + f.getFactoryCode() + "</b> Sucessfully";
            st.executeUpdate();
            st.close();

            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            if (ex.getMessage() != null) {
                System.out.println("SQL Error" + ex.getMessage());
                retValue = "ERROR could not create factory with Code " + f.getFactoryCode();
            }
        }
        return retValue;
    }
    
    public String updateModel(Model m) {
        //Company Creation
        String retValue = "Created Model with Number: " + m.getModelNumber()+ " & Code: " + m.getFactoryCode() + " & Starting serial Number: " + m.getStartingSerialNumber();
        try {
            //Store Company in Database
            PreparedStatement st;
            st = conn.prepareStatement("INSERT into model (modelnumber, factorycode, startingSerialNumber) VALUES (?,?,?)");
            st.setString(1, m.getModelNumber());//Model Number
            st.setString(2, m.getFactoryCode());//Factory Code
            st.setString(3, m.getStartingSerialNumber());//Factory Code
            retValue = "Created model <B>" + m.getModelNumber() + "</b> Code: <b>" + m.getFactoryCode() +"</b> Starting Serail Number: <b>" + m.getStartingSerialNumber() + "</b>Sucessfully";
            st.executeUpdate();
            st.close();

            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            if (ex.getMessage() != null) {
                System.out.println("SQL Error" + ex.getMessage());
                retValue = "ERROR could not create Model,factory, starting serial number with code " + m.getFactoryCode();
            }
        }
        return retValue;
    }
    
    public String getFactoryCodeForModelNumber(String modelNumber){
        String retValue = ""; 
        try {
            ResultSet resultset;
            String queryString = "SELECT * FROM model WHERE modelNumber='" + modelNumber + "'";
            resultset = stmt.executeQuery(queryString);

            while (resultset.next()) {
                retValue = resultset.getString(2);
            }
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Error System Error");
        }
        return retValue;        
    }
    
    public String checkForSerialNumber(String modelName, String eNum) {
        String retValue = "OK";
        try {
            ResultSet resultset;
            String queryString = "SELECT * FROM serial_number WHERE modelNumber='" + modelName + "' AND serialNumber='" + eNum + "'";  
            resultset = stmt.executeQuery(queryString);
            
            while(resultset.next()) {
                retValue = resultset.getString(2)+"#"+resultset.getString(4)+"#"+resultset.getString(3);
            }
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Error System Error");
        }
        
        return retValue;                
    }
    
    public String createSerialNumber(String modelName, String eNum, String yearMonthFactory, String codedString) {        
        String retValue = "OK";
        try {
            //Store Company in Database
            PreparedStatement st;
            st = conn.prepareStatement("INSERT into serial_number (modelNumber, serialNumber, dateYearfactory, alphaNumeric) VALUES (?,?,?,?)"); 
            st.setString(1, modelName);//Model Number
            st.setString(2, eNum);//Serial Number
            st.setString(3, yearMonthFactory);//YearMonthFactory
            st.setString(4, codedString);// AlphaNumberic
            //retValue = "Created model <B>" + m.getModelNumber() + "</b> Code: <b>" + m.getFactoryCode() +"</b> Sucessfully";
            st.executeUpdate();
            st.close();

            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            if (ex.getMessage() != null) {
                System.out.println("SQL Error" + ex.getMessage());
                retValue = "ERROR";
            }
        }        
        return retValue; 
    }
    
    public String updateStartingNumberOfModelFactorycode(String model, String code, String starting) {
        String retValue = "OK";
        try {
            PreparedStatement st;            
            st = conn.prepareStatement("UPDATE model SET startingSerialNumber=? WHERE modelNumber=? AND factorycode=?");
            st.setString(1, starting);
            st.setString(2, model);
            st.setString(3, code);

            st.executeUpdate();
            st.close();

            stmt.close();
            conn.close();            
        } catch (SQLException ex) {
            if (ex.getMessage() != null) {
                System.out.println("SQL Error" + ex.getMessage());
                retValue = "ERROR";
            }
        } 
        return retValue;
        
    }
}

