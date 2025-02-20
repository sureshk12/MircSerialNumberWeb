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

import javax.crypto.Cipher;  
import javax.crypto.SecretKey;  
import javax.crypto.SecretKeyFactory;  
import javax.crypto.spec.IvParameterSpec;  
import javax.crypto.spec.PBEKeySpec;  
import javax.crypto.spec.SecretKeySpec;  
import java.nio.charset.StandardCharsets;  
import java.security.InvalidAlgorithmParameterException;  
import java.security.InvalidKeyException;  
import java.security.NoSuchAlgorithmException;  
import java.security.spec.InvalidKeySpecException;  
import java.security.spec.KeySpec;  
import java.util.Base64;  
import javax.crypto.BadPaddingException;  
import javax.crypto.IllegalBlockSizeException;  
import javax.crypto.NoSuchPaddingException;  


public class AESClass {
    
    /* Private variable declaration */  
    private static final String SECRET_KEY = "Kaval@Onida#2025";  
    private static final String SALTVALUE = "AEk0Fv84gJSJN3bz4g";  
   
    /* Encryption Method */  
    public static String encrypt(String strToEncrypt)   
    {  
        try   
        {  
            /* Declare a byte array. */  
            byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};  
            IvParameterSpec ivspec = new IvParameterSpec(iv);        
            /* Create factory for secret keys. */  
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");  
            /* PBEKeySpec class implements KeySpec interface. */  
            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALTVALUE.getBytes(), 65536, 256);  
            SecretKey tmp = factory.generateSecret(spec);  
            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");  
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");  
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivspec);  
            /* Retruns encrypted value. */  
            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8)));  
        }   
        catch (InvalidAlgorithmParameterException | InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException e)   
        {  
          System.out.println("Error occured during encryption: " + e.toString());  
        }  
        return null;  
    }
    
    /* Decryption Method */  
    public static String decrypt(String strToDecrypt)   
    {  
        try   
        {  
            /* Declare a byte array. */  
            byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};  
            IvParameterSpec ivspec = new IvParameterSpec(iv);  
            /* Create factory for secret keys. */  
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");  
            /* PBEKeySpec class implements KeySpec interface. */  
            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALTVALUE.getBytes(), 65536, 256);  
            SecretKey tmp = factory.generateSecret(spec);  
            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");  
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");  
            cipher.init(Cipher.DECRYPT_MODE, secretKey, ivspec);  
            /* Retruns decrypted value. */  
            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));  
        }   
        catch (InvalidAlgorithmParameterException | InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException e)   
        {  
          System.out.println("Error occured during decryption: " + e.toString());  
        }  
        return null;  
    }
    
    public static String preEncodeShift(String orgStr)
    {
        int lenStr = orgStr.length();
        int lastInt = Integer.parseInt(orgStr.substring(lenStr -1));
        String newStr = orgStr;
        for(int x=0; x<lastInt;x++)
        {
            String t1 = newStr.substring(lenStr-1);
            String t2 = newStr.substring(0, lenStr-1);
            newStr = t1 + t2;
        }
        return newStr;
    }
    
    public static String convertStrToValidStr(int nStr1, int nStr2)
    {
        char leftChar = (char)localConversion(nStr1);
        char rightChar = (char)localConversion(nStr2);
        return String.valueOf(leftChar)+String.valueOf(rightChar);
    }
    
    private static int localConversion(int nStr)
    {
        int retVal = 65;
        if(nStr <26){
            retVal = nStr + 65;
        }
        if(nStr > 25 && nStr <52){
            retVal = nStr + 39;
        }
        if(nStr > 51 && nStr <78){
            retVal = nStr + 13;
        }
        if(nStr > 77 && nStr <104){
            retVal = nStr - 13;
        }
        if(nStr > 103 && nStr <130){
            retVal = nStr - 39;
        }
        if(nStr > 129 && nStr <156){
            retVal = nStr - 65;
        }
        if(nStr > 155 && nStr <182){
            retVal = nStr - 91;
        }
        if(nStr > 181 && nStr <208){
            retVal = nStr - 117;
        }
        if(nStr > 207 && nStr <234){
            retVal = nStr - 143;
        }
        if(nStr > 233 && nStr <260){
            retVal = nStr - 169;
        }
        return retVal;
    }

}
