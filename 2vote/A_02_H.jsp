<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>후보등록 삭제</title>
</head>

<body text="#000000" link="#000000" vlink="#000000" alink="#000000">
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select*from vote;");
	
	String voten = request.getParameter("newvotenum");			// A_01_H.jsp에서 newvotenum(후보번호)을 받아옴
	
	String sql="delete from vote where votenum = " + voten;		// 삭제버튼 클릭시 후보번호와 일치하는것 지움(vote 테이블)
	stmt.executeUpdate( sql );									// sql 실행
	
	
	Statement stmt1 = conn.createStatement();
	ResultSet rset1 = stmt1.executeQuery("select*from vote;");
	
	String sql1="delete from vote1 where votenum = " + voten;	// 삭제버튼 클릭시 후보번호와 일치하는것 지움(vote1 테이블 투표된것 투표 누적수)
	stmt.executeUpdate( sql1 );									// sql 실행
	
	
	rset.close();
	stmt.close();
	rset1.close();
	stmt1.close();
	conn.close();
	
%>
<h1>레코드 삭제</h1>
<TABLE border=1 width=400 height=40 cellspacing=0>
	<tr>
		<td align=center bgcolor=yellow><a href="A_01_H.jsp" target="main"><b> 후보 등록</b></font><a></td>
		<td align=center><a href="B_01_H.jsp" target="main"><b>투표</b></font><a></td>
		<td align=center><a href="C_01_H.jsp" target="main"><b>개표결과</b></font><a></td>
	</tr>
	<tr>
		<td width=100 align=center colspan="3">후보등록 결과 : 후보삭제 되었습니다</td>
	</tr>
</table>
</body>
</html>