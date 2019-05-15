<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" errorPage="01error.jsp"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>TBL생성</title>
</head>
<body>
<h1>테이블만들기 ok</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	stmt.execute( "create table examtable2("+				//mysql에 테이블 생성문 작성
				"name varchar(20)," +
				"studentid int not null primary key," +
				"kor int,"+
				"eng int,"+
				"mat int)"+
				"DEFAULT CHARSET=utf8;");					//한글 표시를 위해 입력
%>
<%
	stmt.close();											//stmt 닫기
	conn.close();											//conn 닫기
%>
</body>
</html>