<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>정정/삭제</title>
</head>
<body>
<h1>레코드 삭제</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String student = request.getParameter("studentid");					//학번을 받아옴
	
	String sql="delete from examtable2 where studentid = " + student;	//받아온 학번으로 mysql에 delete 삭제문 돌림
		
	stmt.executeUpdate( sql );											//삭제문 실행
	
	ResultSet rset = stmt.executeQuery("select*from examtable2;");		//삭제후 업데이된 데이터 출력을 위해 다시 examtable2 선택
	
%>
<!-- 삭제 후 보여줄 필드명 출력 -->
<table cellspacing=1 width=600 border=1>
	<tr>
		<td width=50 align=center>이름</td>
		<td width=50 align=center>학번</td>
		<td width=50 align=center>국어</td>
		<td width=50 align=center>영어</td>
		<td width=50 align=center>수학</td>
	</tr>
<%
	while (rset.next()) {	//삭제 후 업데이트 된 내용 출력

		out.println("<tr>");
		out.println("<td width=50><p align=center><a href='oneview.jsp?key="+rset.getString(1)+"'> "+rset.getString(1)+"</a></p></td>");//이름
		// url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");	//학번
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");	//국어
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");	//영어
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");	//수학
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>