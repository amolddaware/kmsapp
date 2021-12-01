/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.handler;

/**
 *
 * @author Amol
 */
public class TestWord {
    public static void main(String[] args) {
        String test =  "This is a sentence";
String lastWord = test.substring(test.lastIndexOf(" ")+1);
        System.out.println("lstword:-"+lastWord);
        
    }
        
}
