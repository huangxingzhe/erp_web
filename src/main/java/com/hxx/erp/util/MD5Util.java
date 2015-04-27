package com.hxx.erp.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {

	public static byte[] MD5Encode(byte[] origin) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			return md.digest(origin);
		} catch (Exception ex) {

		}
		return null;
	}
	
	public static byte[] doubleMD5Encode(byte[] origin) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			return md.digest(md.digest(origin));
		} catch (Exception ex) {

		}
		return null;
	}
	
	public static String getHexMD5Str(String strIn)
    {
        return getHexMD5Str((strIn).getBytes());
    }

    public static String getHexMD5Str(byte[] arrIn) 
    {
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("cant surport md5 : NoSuchAlgorithmException");
        }
        byte[] arrB = md.digest(arrIn);
        StringBuilder sb = new StringBuilder(32);
        for (int i = 0; i < arrB.length; i++)
        {
            int intTmp = arrB[i];
            while (intTmp < 0)
            {
                intTmp = intTmp + 256;
            }
            if (intTmp < 16)
            {
                sb.append('0');
            }
            sb.append(Integer.toString(intTmp, 16));
        }
        return sb.toString().toUpperCase();
    }
    
    public static void main(String args[]){
    	String pass = "123456";
    	String ret = MD5Util.getHexMD5Str(pass);
    	System.out.println(ret);
    }
}
