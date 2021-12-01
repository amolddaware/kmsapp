/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.handler;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author Amol
 */
public class CharacterEncodingFilter implements Filter{
     @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {
    }

    @Override
//    private FilterConfig fc; 

public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException { 
HttpServletRequest request = (HttpServletRequest) req; 
HttpServletResponse response = (HttpServletResponse) res; 

request.setCharacterEncoding("UTF8"); 
response.setCharacterEncoding("UTF8"); 

chain.doFilter(request, response); 

request.setCharacterEncoding("UTF8"); 
response.setCharacterEncoding("UTF8"); 
}

    @Override
    public void destroy() {

    }
}
