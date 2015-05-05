package com.hxx.erp.util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.ByteBuffer;
import java.security.Principal;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.Iterator;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;

/**
 * HttpClientUtil.java
 * 
 * @author huangxingzhe, 2014/6/7
 */
public class HttpClientUtil
{

    // 获得ConnectionManager，设置相关参数
    private static MultiThreadedHttpConnectionManager manager              = new MultiThreadedHttpConnectionManager();
    private static int                                connectionTimeOut    = 60000;
    private static int                                socketTimeOut        = 20000; //20s超时
    private static int                                maxConnectionPerHost = 10;
    private static int                                maxTotalConnections  = 50;
    // 初始化ConnectionManger的方法
    static
    {
        manager.getParams().setConnectionTimeout(connectionTimeOut);
        manager.getParams().setSoTimeout(socketTimeOut);
        manager.getParams().setDefaultMaxConnectionsPerHost(maxConnectionPerHost);
        manager.getParams().setMaxTotalConnections(maxTotalConnections);
    }

    public static String get(String urlstr) throws Exception
    {
        return get(urlstr, "UTF-8");
    }

    // 通过get方法获取网页内容
    public static String get(String url, String responseCharSet) throws HttpException, IOException
    {
        // 构造HttpClient的实例
        HttpClient client = new HttpClient(manager);
        // 创建GET方法的实例
        GetMethod get = new GetMethod(url);
        get.setFollowRedirects(true);
        String result = null;
        StringBuffer resultBuffer = new StringBuffer();

        try
        {
            client.executeMethod(get);
            // 在目标页面情况未知的条件下，不推荐使用getResponseBodyAsString()方法
            BufferedReader in = new BufferedReader(new InputStreamReader(get.getResponseBodyAsStream(), get.getResponseCharSet()));
            String inputLine = null;
            boolean first = true;
            while ((inputLine = in.readLine()) != null)
            {
                if (first)
                {
                    first = false;
                }
                else
                {
                    resultBuffer.append("\n");
                }
                resultBuffer.append(inputLine);
            }

            in.close();
            result = resultBuffer.toString();
            // iso-8859-1 is the default reading encode
            result = HttpClientUtil.ConverterStringCode(resultBuffer.toString(), get.getResponseCharSet(), responseCharSet);
        }
        finally
        {
            get.releaseConnection();
        }
        return result;
    }

    /**
     * 通过post方法获取网页内容,带参数
     */
    public static String post(String url, String requestCharSet, String responseCharSet, NameValuePair[] nameValuePair) throws IOException
    {
        HttpClient client = new HttpClient(manager);
        PostMethod post = new CharSetPostMethod(url, requestCharSet);
        if (nameValuePair != null)
        {
            post.setRequestBody(nameValuePair);
        }
        post.setFollowRedirects(false);
        String result = null;
        StringBuffer resultBuffer = new StringBuffer();

        try
        {
            client.executeMethod(post);
            BufferedReader in = new BufferedReader(new InputStreamReader(post.getResponseBodyAsStream(), post.getResponseCharSet()));
            String inputLine = null;

            while ((inputLine = in.readLine()) != null)
            {
                resultBuffer.append(inputLine);
                resultBuffer.append("\n");
            }
            in.close();
            // iso-8859-1 is the default reading encode
            result = HttpClientUtil.ConverterStringCode(resultBuffer.toString(), post.getResponseCharSet(), responseCharSet);
        }
        finally
        {
            post.releaseConnection();
        }
        return result;
    }
    /**
     * 通过post方法获取网页内容,带参数
     */
    public static String post(String url, String requestCharSet, String responseCharSet,String headerValue) throws IOException
    {
        HttpClient client = new HttpClient(manager);
        PostMethod post = new CharSetPostMethod(url, requestCharSet);
        post.setFollowRedirects(false);
        String result = null;
        StringBuffer resultBuffer = new StringBuffer();

        try
        {
        	Header header=new Header("Authorization", headerValue);
        	post.addRequestHeader(header);
            client.executeMethod(post);
            BufferedReader in = new BufferedReader(new InputStreamReader(post.getResponseBodyAsStream(), post.getResponseCharSet()));
            String inputLine = null;

            while ((inputLine = in.readLine()) != null)
            {
                resultBuffer.append(inputLine);
                resultBuffer.append("\n");
            }
            in.close();
            // iso-8859-1 is the default reading encode
            result = HttpClientUtil.ConverterStringCode(resultBuffer.toString(), post.getResponseCharSet(), responseCharSet);
        }
        finally
        {
            post.releaseConnection();
        }
        return result;
    }
    /**
     * 
     * @param url
     * @param requestCharSet
     * @param responseCharSet
     * @param json 传入json格式参数
     * @return
     * @throws IOException
     */
    public static String postJSON(String url, String requestCharSet, String responseCharSet, String json) throws IOException
    {
        HttpClient client = new HttpClient(manager);
        PostMethod post = new CharSetPostMethod(url, requestCharSet);
        RequestEntity requestEntity = new StringRequestEntity(json);
        post.setRequestEntity(requestEntity);
        post.setFollowRedirects(false);
        String result = null;
        StringBuffer resultBuffer = new StringBuffer();
        try {
            client.executeMethod(post);
            BufferedReader in = new BufferedReader(new InputStreamReader(post.getResponseBodyAsStream(), post.getResponseCharSet()));
            String inputLine = null;

            while ((inputLine = in.readLine()) != null)
            {
                resultBuffer.append(inputLine);
                resultBuffer.append("\n");
            }
            in.close();
            // iso-8859-1 is the default reading encode
            result = HttpClientUtil.ConverterStringCode(resultBuffer.toString(), post.getResponseCharSet(), responseCharSet);
        }
        finally
        {
            post.releaseConnection();
        }
        return result;
    }


    /**
     * 通过post方法获取网页内容，不带参数
     * 
     * @param url
     * @param requestCharSet
     * @param responseCharSet
     * @return
     * @throws IOException
     */
    public static String post(String url, String requestCharSet, String responseCharSet) throws IOException
    {

        return post(url, requestCharSet, responseCharSet);
    }

    /**
     * 通过post方式提交请求获得文本结果
     * 
     * @param urlstr
     * @param contentCharset
     * @return
     * @throws Exception
     */
    public static String post(String url, Map<String, String> paramMap, String contentCharset) throws Exception
    {

        NameValuePair[] nameValuePair = null;
        if (paramMap != null)
        {
            nameValuePair = new NameValuePair[paramMap.size()];
            int i = 0;
            Iterator<Map.Entry<String, String>> iter = paramMap.entrySet().iterator();
            while (iter.hasNext())
            {
                Map.Entry<String, String> entry = iter.next();
                nameValuePair[i++] = (new NameValuePair(entry.getKey(), entry.getValue()));
            }
        }

        return post(url, contentCharset, contentCharset, nameValuePair);
    }
    
    public static String postJSON(String urlstr, String json) throws Exception
    {
        return postJSON(urlstr,"UTF-8","UTF-8",json);
    }

    public static String post(String urlstr, Map<String, String> paramMap) throws Exception
    {
        return post(urlstr, paramMap, "UTF-8");
    }

    public static int getHttpStatusCode(String url) throws HttpException, IOException
    {
        HttpClient client = new HttpClient(manager);

        GetMethod method = new GetMethod(url);
        method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler(3, false));

        int statusCode = 0;
        try
        {
            statusCode = client.executeMethod(method);
        }
        finally
        {
            method.releaseConnection();
        }
        return statusCode;
    }

    private static String ConverterStringCode(String source, String srcEncode, String destEncode) throws UnsupportedEncodingException
    {
        if (source != null)
        {
            return new String(source.getBytes(srcEncode), destEncode);
        }
        else
        {
            return "";
        }
    }
    
    public static String verifyToken(String url,String body,String mode) {
    	try {
			//http://192.168.3.251:8080/login/check/lenovo.do
			URL u = new URL(url);
			StringBuffer bufer = new StringBuffer();
//			bufer.append("token=").append(token).append("&appId=").append(appId);
			HttpURLConnection urlConnection = (HttpURLConnection) u.openConnection();
			//			int mTimeOut = back.timeOut(mWhat, mToken);
			final int timeOut = 10*1000;
			urlConnection.setConnectTimeout(timeOut);
			urlConnection.setReadTimeout(timeOut);
			//			HashMap<String, String> mProperty = back.param(mWhat, mToken);
			urlConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			urlConnection.setDoOutput(true);  
			urlConnection.setDoInput(true);  
			urlConnection.setRequestMethod(mode);
			byte[] message = body.getBytes();
			int length = message.length;
			urlConnection.setRequestProperty("Content-Length",length+"");
			urlConnection.setUseCaches(false);
			urlConnection.setInstanceFollowRedirects(true);
			urlConnection.connect();
			OutputStream os = urlConnection.getOutputStream();
			bufer= null;
			os.write(message);
			os.flush();
			os.close();
			os = null;
			String encoding = urlConnection.getContentEncoding();
			if (null == encoding || encoding.length() <1)
				encoding = "utf-8";
			InputStream is = urlConnection.getInputStream();
			int totalLen = urlConnection.getContentLength();
			byte[] tmp = new byte[7 * 1024];
			byte[] resultData = null;
			if(totalLen > 0)
			{
				ByteBuffer byBuf = ByteBuffer.allocate(totalLen);
				int len = 0;
				while ((len = is.read(tmp)) != -1)
					byBuf.put(tmp, 0, len);
				resultData = byBuf.array();
			}else{
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				int len = 0;
				while ((len = is.read(tmp)) != -1)
					bos.write(tmp, 0, len);
				resultData = bos.toByteArray();
				bos.reset();
				bos.close();
			}
			is.close();
			byte[] data = resultData;
			int size = data.length;
			byte[] data2 = null;
			if(size % 16 !=0 ){
				int multiple = ((size /16)+1)*16;
				data2 = new byte[multiple];
				System.arraycopy(data, 0, data2, 0, size);
				data = data2;
			}else{
				data = data2;
			}
			return new String(data);
		} catch (Exception e) {
//			Log.e("MainActivity", "获取用户id异常", e);
		}
		return "";
	}
    
    public static String getHttps(String url1){
 	   String result = null;
 		try{
 			URL url = new URL(url1);
 			SSLContext sslctxt = SSLContext.getInstance("TLS");
 			sslctxt.init(null, new TrustManager[]{new MyX509TrustManager()}, new java.security.SecureRandom());
 			HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
 			conn.setSSLSocketFactory(sslctxt.getSocketFactory());
 			conn.setHostnameVerifier(new MyHostnameVerifier());
 			conn.connect();
 			int respCode = conn.getResponseCode();
 			InputStream input = conn.getInputStream();
 			result = toString(input);
 			input.close();
 			conn.disconnect();
 			}catch(Exception e){
 				e.printStackTrace();
 			}
 		return result;
    } 
    
    private static String toString(InputStream input){
 		String content = null;
 		try{
 		InputStreamReader ir = new InputStreamReader(input);
 		BufferedReader br = new BufferedReader(ir);
 		StringBuilder sbuff = new StringBuilder();
 		while(null != br){
 			String temp = br.readLine();
 			if(null == temp)break;
 			sbuff.append(temp).append(System.getProperty("line.separator"));
 		}
 		content = sbuff.toString();
 		}catch(Exception e){
 			e.printStackTrace();
 		}
 		return content;
 	}
    static class MyX509TrustManager implements X509TrustManager{
 		@Override
 		public void checkClientTrusted(X509Certificate[] chain, String authType)
 				throws CertificateException {
 			if(null != chain){
 				for(int k=0; k < chain.length; k++){
 					X509Certificate cer = chain[k];
 					print(cer);
 				}
 			}
 		}
 		@Override
 		public void checkServerTrusted(X509Certificate[] chain, String authType)
 				throws CertificateException {
 			if(null != chain){
 				for(int k=0; k < chain.length; k++){
 					X509Certificate cer = chain[k];
 					print(cer);
 				}
 			}
 		}
 		@Override
 		public X509Certificate[] getAcceptedIssuers() {
 			return null;
 		}
 		private void print(X509Certificate cer){
 			int version = cer.getVersion();
 			String sinname = cer.getSigAlgName();
 			String type = cer.getType();
 			String algorname = cer.getPublicKey().getAlgorithm();
 			BigInteger serialnum = cer.getSerialNumber();
 			Principal principal = cer.getIssuerDN();
 			String principalname = principal.getName();
 		}
 	}
 	static class MyHostnameVerifier implements HostnameVerifier{
 		@Override
 		public boolean verify(String hostname, SSLSession session) {
 			return true;
 		}
 	}  
    
 	
 	
 	 public static String sendPost(String url,String param) {
         PrintWriter out = null;
         BufferedReader in = null;
         String result = "";
         try {
             URL realUrl = new URL(url);
             // 打开和URL之间的连接
             URLConnection conn = realUrl.openConnection();
             // 设置通用的请求属性
             conn.setRequestProperty("accept", "*/*");
             conn.setRequestProperty("connection", "Keep-Alive");
             conn.setRequestProperty("user-agent",
                     "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
             // 发送POST请求必须设置如下两行
             conn.setDoOutput(true);
             conn.setDoInput(true);
             // 获取URLConnection对象对应的输出流
             out = new PrintWriter(conn.getOutputStream());
             // 发送请求参数
             out.print(param);
             // flush输出流的缓冲
             out.flush();
             // 定义BufferedReader输入流来读取URL的响应
             in = new BufferedReader(
                     new InputStreamReader(conn.getInputStream(),"utf-8"));      
             String line;
             while ((line = in.readLine()) != null) {
                 result += line;
             }
         } catch (Exception e) {
             System.out.println("发送 POST 请求出现异常！"+e);
             e.printStackTrace();
         }
         //使用finally块来关闭输出流、输入流
         finally{
             try{
                 if(out!=null){
                     out.close();
                 }
                 if(in!=null){
                     in.close();
                 }
             }
             catch(IOException ex){
                 ex.printStackTrace();
             }
         }
         return result;
     }   
}
