<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>투표결과</title>
</head>
<body text="#000000" link="#000000" vlink="#000000" alink="#000000">

<TABLE border=1 width=400 height=40 cellspacing=0>
<tr>
	<td align=center><a href="A_01_H.jsp" target="main"><b> 후보 등록</b></font><a></td>
	<td align=center bgcolor=yellow><a href="B_01_H.jsp" target="main"><b>투표</b></font><a></td>
	<td align=center><a href="C_01_H.jsp" target="main"><b>개표결과</b></font><a></td>
</tr>
</table>



<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from vote1;");		//투표된 데이터 누적을 위해서 vote1을 먼저 만듬, vote1선택

	String id1 = request.getParameter("votenum");					//앞에서(B_01) 투표한 기호번호를 받아옴
		String choice1 = request.getParameter("choice"); 			//앞에서(B_01) 투표한 연령대를 받아옴
	
	if(id1 == null){												//만약 기호번호가 없을때는 아래의 ""구문 출력
		out.println("투표할 후보자가 없습니다");
	}else {
	
	stmt.execute("insert into vote1 (votenum,age) values ("+ 		//기호번호가 선택 되었을때는 기존 세팅된 것에 맞춰서 양식 입력하여 vote1에 데이터 누적 후 ""구문 출력
	id1 +","+
	choice1+");");
	out.println("투표 결과 : 투표하였습니다.");
	}
	
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>