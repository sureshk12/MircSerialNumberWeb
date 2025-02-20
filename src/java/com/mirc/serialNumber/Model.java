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
public class Model {
    private String modelNumber = "";
    private String factoryCode = "";
    private String startingSerialNumber = "";
    
    /**
     * Default Constructor
    */
    public Model() {
        //Default Constructor
    }
    
    /**
     * Full Constructor
     * @param model modelNumber of Model.
     * @param code factoryCode of Factory
     * @param startingSlNumber lastSerialNumber number of model
     * 
    */
    public Model(String model, String code, String startingSlNumber)
    {
        this.modelNumber = model;
        this.factoryCode = code;
        this.startingSerialNumber = startingSlNumber;
    }

    /**
     * @return the modelNumber
     */
    public String getModelNumber() {
        return modelNumber;
    }

    /**
     * @return the factoryCode
     */
    public String getFactoryCode() {
        return factoryCode;
    }

    /**
     * @return the lastSerialNumber
     */
    public String getStartingSerialNumber() {
        return startingSerialNumber;
    }
}
