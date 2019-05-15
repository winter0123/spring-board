<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글목록</title>
</head>
<body>
<table border=1 cellspacing=1>
<tr>
	<td width=50 align=center>번호</td>
	<td width=400 align=center>제목</td>
	<td width=100 align=center>등록일</td>
</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from gongji;");	//테이블 지정

	String newid = "", newtitle="", newdate="";
	
	while (rset.next()) {							//rset들고오기
	newid = Integer.toString(rset.getInt(1));		//번호
	newtitle = rset.getString(2);					//제목(공지사항1)
	newdate = rset.getString(3);					//date(2019-01-01)

%>
<form method="post" action="gongji_view.jsp">		<!-- 입력값 gongji_view로 전송 -->
<tr>
	<td width=50 align=center><%= newid %></td>		<!-- 번호 -->
	<td width=400 align=left><a href='gongji_view.jsp?key=<%= newid %>'><%= newtitle %></a></td>
	<!--이름 클릭시 연결 링크 생성 = url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달 [key값, key1값 설정]-->
	<td width=100 align=center><%= newdate %></td>	<!--오늘 날짜-->
</tr>
</form>
<%
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<table border=0 cellspacing=0>
<form method="post" action="gongji_insert.jsp">	<!--등록된 후보 추가 = A_03_H.JSP-->
		<tr>
			<td width=560 align=right><input type="submit"  value='신규' required></input></td>
			<!-- required 입력이 있어야만 버튼클릭 가능-->
		</tr>
</form>
</table>
</body>
</html>