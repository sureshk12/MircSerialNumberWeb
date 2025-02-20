/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mirc.serialNumber;

/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 12:14 PM
 */
public class Factory {
    
    private String factoryName = "";
    private String factoryCode = "";
    private String factoryEmail = "";
    
        /**
     * Default Constructor
    */
    public Factory() {
        //Default Constructor
    }
    
    /**
     * Full Constructor
     * @param name Model Name of Model.
     * @param description Description of Model.
     * @param brand Model Brand of Model belongs.
     * 
    */
    public Factory(String name, String code, String factory) {
        this.factoryName = name;
        this.factoryCode = code;
        this.factoryEmail = factory;
    }
    
    /**
     * @return the name
     */
    public String getFactoryName() {
        return factoryName;
    }

    /**
     * @return the description
     */
    public String getFactoryCode() {
        return factoryCode;
    }

    /**
     * @return the factoryEmail
     */
    public String getFactoryEmail() {
        return factoryEmail;
    }
    
}
