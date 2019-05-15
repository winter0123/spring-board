<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글목록</title>
</head>
<body>
<h1>Make table</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();

//	stnt.execute("create table 5gongji(id int not null primary key auto_increment, title varchar (70), date date, content text) DEFAULT CHARSET=utf8;");

	String sql="";
	sql = "insert into 5gongji(title,date,content) values('공지사항1',date(now()),'공지사항내용1');"; stmt.execute(sql);
	sql = "insert into 5gongji(title,date,content) values('공지사항2',date(now()),'공지사항내용2');"; stmt.execute(sql);
	sql = "insert into 5gongji(title,date,content) values('공지사항3',date(now()),'공지사항내용3');"; stmt.execute(sql);
	sql = "insert into 5gongji(title,date,content) values('공지사항4',date(now()),'공지사항내용4');"; stmt.execute(sql);
	sql = "insert into 5gongji(title,date,content) values('공지사항5',date(now()),'공지사항내용5');"; stmt.execute(sql);
	
	stmt.close();
	conn.close();

%>
</body>
</html>