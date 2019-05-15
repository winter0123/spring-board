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
	Statement stmt = conn.createStatement();\
	
//	stmt.execute("create table 5reply(id int not null primary key auto_increment, title varchar (70), date date, content text) DEFAULT CHARSET=utf8;");

	String sql="";
//	sql = "insert into 5reply(title,date,content) values('공지사항1',date(now()),'공지사항내용1');"; stmt.execute(sql);
//	sql = "insert into 5reply(title,date,content) values('공지사항2',date(now()),'공지사항내용2');"; stmt.execute(sql);
//	sql = "insert into 5reply(title,date,content) values('공지사항3',date(now()),'공지사항내용3');"; stmt.execute(sql);
//	sql = "insert into 5reply(title,date,content) values('공지사항4',date(now()),'공지사항내용4');"; stmt.execute(sql);
//	sql = "insert into 5reply(title,date,content) values('공지사항5',date(now()),'공지사항내용5');"; stmt.execute(sql);
	
	//필드 추가
	stmt.execute("alter table 5reply add rootid int;");	// 원 글 번호
	stmt.execute("alter table 5reply add relevel int Default '0' not null;");	// 댓글 레벨(본 글이면0, 댓글1,댓글의 댓글2,...)
	stmt.execute("alter table 5reply add recnt int Default '0' not null;");		// 댓글내 글 표시 순서
	stmt.execute("alter table 5reply add viewcnt int Default '0' not null;");	// 조회수
	stmt.execute("alter table 5reply add parent int;");;						// 댓글의 댓글을 위한 부분
	
	stmt.close();
	conn.close();

%>
</body>
</html>