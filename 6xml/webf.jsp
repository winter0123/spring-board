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
<title>web조회로 xml파싱하기</title>
<%!
 DefaultHttpClient client;
  
  //HttpClient 재사용 관련 서버 통신시 세션을 유지하기 위함이다. 
  
  public DefaultHttpClient getThreadSafeClient() {
     if(client != null)
        return client;
     client = new DefaultHttpClient();
     ClientConnectionManager mgr = client.getConnectionManager();
     HttpParams params = client.getParams();
     client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
     return client;
  }
  
  public String goXML(String getURL) {
     String Result = null;
     //세션유지 체크
     HttpClient client = getThreadSafeClient();
     HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
     HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
     HttpPost post = new HttpPost(getURL);
     
     List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
     if(false) { //여기가 post/get 파라미터를 전달하는 곳이다.
        nameValuePairs.add(new BasicNameValuePair("input1", "kopoctc"));
     }
     
     try {
        post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
        HttpResponse responsePost = null;
        responsePost = client.execute(post);
        HttpEntity resEntity = responsePost.getEntity();
        
        if(resEntity != null) {
         Result = EntityUtils.toString(resEntity).trim();
      }   
   }catch(Exception e) {    
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
  String ret=goXML("http://192.168.23.26:8080/xml/xmlmake.jsp");

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
     Element root = doc.getDocumentElement();  //root태그를 가져오기도 하지만 이 소스에서는 쓰이는 곳이 없다.
      NodeList tagName = doc.getElementsByTagName("name");
      NodeList tagStudentId = doc.getElementsByTagName("studentid");
      NodeList tagKor = doc.getElementsByTagName("kor");
      NodeList tagEng = doc.getElementsByTagName("eng");
      NodeList tagMat = doc.getElementsByTagName("mat");
     
     out.println("<table cellspacing=1 width=500 border=1>");
     out.println("<tr>");
     out.println("<td width=100>이름</td>");
     out.println("<td width=100>학번</td>");
     out.println("<td width=100>국어</td>");
     out.println("<td width=100>영어</td>");
     out.println("<td width=100>수학</td>");
     out.println("</tr>");
  
      for(int i=0; i<tagName.getLength(); i++) {
        out.println("<tr>");
        out.println("<td width=100>"+tagName.item(i).getFirstChild().getNodeValue() + "</td>");
        out.println("<td width=100>"+tagStudentId.item(i).getFirstChild().getNodeValue() + "</td>");
        out.println("<td width=100>"+tagKor.item(i).getFirstChild().getNodeValue() + "</td>");
        out.println("<td width=100>"+tagEng.item(i).getFirstChild().getNodeValue() + "</td>");
        out.println("<td width=100>"+tagMat.item(i).getFirstChild().getNodeValue() + "</td>");
        out.println("</tr>");
      }
  } catch(Exception e) {
     e.printStackTrace();
  }
%>
</body>
</html>