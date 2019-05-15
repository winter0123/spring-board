<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>
<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>

<html>
<head>
<%!
DefaultHttpClient client;

public DefaultHttpClient getThreadSafeClient() {
     if(client != null)
        return client;
   
     client = new DefaultHttpClient();
     ClientConnectionManager mgr = client.getConnectionManager();
     HttpParams params = client.getParams();
     client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
     return client;
}

public String goLogin() {
   return goXML("http://192.168.23.35:8081/6xml/login.jsp", true);
}

public String goXML(String getURL) {
  return goXML(getURL, false); 
}
  
public String goXML(String getURL, Boolean loginFlag) {
   String Result = null; 
   
   //세션유지 체크 
   HttpClient client = getThreadSafeClient();
   
   HttpConnectionParams.setConnectionTimeout(client.getParams(),100000);
   HttpConnectionParams.setSoTimeout(client.getParams(),100000);
   HttpPost post = new HttpPost(getURL);
   
   List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
   
   if (loginFlag) { //post/get 파라메터를 전달하는 곳 
      nameValuePairs.add(new BasicNameValuePair("username", "kopoctc"));
      nameValuePairs.add(new BasicNameValuePair("userpasswd", "kopoctc"));
   }   
   
   try {
      post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
      HttpResponse responsePost = null;
      
      responsePost = client.execute(post);
      HttpEntity resEntity = responsePost.getEntity();
      
      if (resEntity != null) {
            Result = EntityUtils.toString(resEntity).trim();
      }
   } catch(Exception e) {
         e.printStackTrace();
   } finally {
      
   }
   return Result;
}   
%>
</head>
 <body>
<h1>성적 조회</h1>
<%
  String ret=goLogin();
  ret=goXML("http://192.168.23.35:8081/6xml/loginxml.jsp");

  //out.println(ret);
  
  try{
     //DocumentBuilderFactory 객체 생성
     DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
     //DocumentBuilder 객체 생성
     DocumentBuilder builder = factory.newDocumentBuilder();
     
     ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
     //Builder를 이용하여 xml 파싱해서 Document 객체 생성
     Document doc = builder.parse(is);
     
    //생성된 document 에서 각 요소들에 접근하여 데이터를 저장
    Element root = doc.getDocumentElement();	//root태그를 가져오기도 하지만 이소스에서는 쓰이는 곳이없음
	NodeList tag_name = doc.getElementsByTagName("name");
	NodeList tag_studentid = doc.getElementsByTagName("studentid");
	NodeList tag_kor = doc.getElementsByTagName("kor");
	NodeList tag_eng = doc.getElementsByTagName("eng");
	NodeList tag_mat = doc.getElementsByTagName("mat");
	
	out.println("<table cellspancing=1 width=500 border=1>");
	out.println("<tr>");
	out.println("<td width=100>이름</td>");
	out.println("<td width=100>학번</td>");
	out.println("<td width=100>국어</td>");
	out.println("<td width=100>영어</td>");
	out.println("<td width=100>수학</td>");
	out.println("</tr>");
  
      for(int i=0; i<tag_name.getLength(); i++) {
		out.println("<tr>");
		out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("</tr>");
	}
  } catch(Exception e) {
     e.printStackTrace();
  }
%>
</body>
</html> 