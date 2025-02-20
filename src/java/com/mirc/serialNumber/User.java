package com.mirc.serialNumber;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Suresh
 * Checked    : 20-Feb-2025, 12:14 PM
 */
public class User {
    private String user_email = "";
    private String user_pwd ="";
    private String user_factory_code = "";
    private String user_name = "";
    private String user_mobile = "";
    private String user_level = "";
    
    /**
     * Default Constructor
    */
    public User() {
        //Default Constructor
    }
    
    /**
     * Full Constructor
     * @param name Model Name of Model.
     * @param description Description of Model.
     * @param brand Model Brand of Model belongs.
     * 
    */
    public User(String email, String pwd, String code, String name, String mobile, String level) {
        this.user_email = email;
        this.user_pwd = pwd;
        this.user_factory_code = code;
        this.user_name = name;
        this.user_mobile = mobile;
        this.user_level = level;
    }

    /**
     * @return the user_email
     */
    public String getUser_email() {
        return user_email;
    }

    /**
     * @return the user_pwd
     */
    public String getUser_pwd() {
        return user_pwd;
    }

    /**
     * @return the user_factory_code
     */
    public String getUser_factory_code() {
        return user_factory_code;
    }

    /**
     * @return the user_name
     */
    public String getUser_name() {
        return user_name;
    }

    /**
     * @return the user_mobile
     */
    public String getUser_mobile() {
        return user_mobile;
    }

    /**
     * @return the user_level
     */
    public String getUser_level() {
        return user_level;
    }

    
    
}
