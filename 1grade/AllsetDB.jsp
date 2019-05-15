<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" errorPage="03error.jsp" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>TBL값넣기</title>
</head>
<body>
<h1>실습데이터 입력</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();	//createDB에 만든 테이블에 맞게 mysql insert 데이터 입력문 입력
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('효민',209901,95,100,95);");
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('보람',209902,95,95,95);");
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('은정',209903,100,100,100);");
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('지연',209904,100,95,90);");
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('소연',209905,80,100,70);");
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('큐리',209906,100,100,70);");
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('화영',209907,70,70,70);");
%>
<%
	stmt.close();
	conn.close();
%>
</body>
</html>