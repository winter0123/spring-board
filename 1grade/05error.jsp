<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<%@ page contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isErrorPage="true" %> <!-페이지 선언부에 isErrorPage="true" 추가 -> 
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>

<%
  response.setStatus(200);
%>
<html>
<head></head>
<body>
<h3>잘못된 데이터가 입력되었습니다.</h3><p>
<a href="inputForm1.html">BACK</a>
</body>
</html>