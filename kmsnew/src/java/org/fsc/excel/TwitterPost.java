/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.excel;

/**
 *
 * @author Fluidscapes
 */
public class TwitterPost {
    public String srno;
    public String source;
     public String topic;
     public String url;
     public String post;
     public String count;
    public String sentiment;

    public TwitterPost() {
    }

    public TwitterPost(String source, String topic, String url, String post, String count, String sentiment) {
        this.source = source;
        this.topic = topic;
        this.url = url;
        this.post = post;
        this.count = count;
        this.sentiment = sentiment;
    }
    
    
}
