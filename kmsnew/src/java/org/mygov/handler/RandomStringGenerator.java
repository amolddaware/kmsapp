/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.handler;

import java.util.Random;

/**
 *
 * @author mrsac1
 */
public class RandomStringGenerator {
  private String code="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
     public String getRandomString(int length) {
//       final String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJLMNOPQRSTUVWXYZ1234567890";
       final String numbers = "1234567890";
       StringBuilder result = new StringBuilder();
       while(length > 0) {
           Random rand = new Random();
           result.append(numbers.charAt(rand.nextInt(numbers.length())));
           length--;
       }
       return result.toString();
    }
     public String getRandomCaptchaString(int length) {
       final String numbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJLMNOPQRSTUVWXYZ1234567890";
       StringBuilder result = new StringBuilder();
       while(length > 0) {
           Random rand = new Random();
           code=result.append(numbers.charAt(rand.nextInt(numbers.length()))).toString();
           length--;
       }
       
     
       return result.toString();
    }
     public String getRandomStringGenerator(){
         code=getRandomCaptchaString(4);
//         code;
        return code;
     }
     
     final public String getGeneratedCaptcha(String captchaValue){
         setCode(captchaValue);
         return  code;
     
     }
     
     public String getRandomPassword(int length) {
       final String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJLMNOPQRSTUVWXYZ1234567890!@#$%&^*";
//       final String numbers = "1234567890";
       StringBuilder result = new StringBuilder();
       while(length > 0) {
           Random rand = new Random();
           result.append(characters.charAt(rand.nextInt(characters.length())));
           length--;
       }
       return result.toString();
    }
}
