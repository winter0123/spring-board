<!-%@ page errorPage="error.jsp" %-->
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<%
String arr[]= new String[]{"111","222","333"};
try{
	out.println(arr[4]+"<br>");
	
}catch(Exception e){
	out.println("error==>"+e+"<=======<br>");
}
%>
Good...
</body>     
</html>