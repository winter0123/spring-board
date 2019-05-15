<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" errorPage="02error.jsp" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>TBL삭제</title>
</head>
<body>
<h1>테이블지우기 ok</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
%>
<%
		stmt.execute("drop table examtable2;");	//삭제를 위한 mysql drop 실행문 작성
		stmt.close();
		conn.close();
%>
</body>
</html>