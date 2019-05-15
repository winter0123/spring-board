<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>데이터 만들기</title>
</head>
<body>
<h1>Make table</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();

	stmt.execute(
	"create table castle ( "+
	"name varchar(20), "+   		// 성명	
	"resv_date date not null, "+ 	// 예약일
	"room int not null, "+ 			// 예약방 1:VIP룸 2:일반룸 3:합리적인룸
	"addr varchar(100), "+  		// 주소
	"telnum varchar(20), "+ 		// 연락처
	"in_name varchar(20), "+		// 입금자명
	"comment text, "+ 				// 남기실말
	"write_date date, "+			// 예약한(이 글을 쓴) 날짜
	"processing int, "+				// 현재 진행 1:예약완료 2: 입금완료(예약확정) 3: 환불요청 4:...
	"primary key (resv_date,room) )"+ //예약일과 룸을 합쳐서 DB의 키로 사용
	"DEFAULT CHARSET=utf8"); 

	stmt.close();
	conn.close();

%>
</body>
</html>