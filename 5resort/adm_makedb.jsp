<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	stmt.execute(
		"create table adminfo ( "+
		"id varchar(20) primary key not null, pass varchar(20) ) " +
		"DEFAULT CHARSET=utf8;");

	String sql="";
	sql="insert into adminfo(id,pass) values ('admin','1111')";
	stmt.execute (sql);
	
	stmt.close();
	conn.close();
%>
</head>
<body>
</body>
</html>