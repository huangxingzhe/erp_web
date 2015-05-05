package com.hxx.erp.util;

import org.apache.commons.httpclient.methods.PostMethod;

/**
 * CharSetPostMethod.java
 * 
 * @author huangxingzhe
 */
public class CharSetPostMethod extends PostMethod
{

    private String charSet = "utf-8";

    public CharSetPostMethod()
    {
    }

    public CharSetPostMethod(String uri, String charSet)
    {
        super(uri);
        this.charSet = charSet;
    }

    public String getRequestCharSet()
    {
        return charSet;
    }
}
