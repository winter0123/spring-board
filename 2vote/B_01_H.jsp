<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>투표</title>
</head>
<body text="#000000" link="#000000" vlink="#000000" alink="#000000">

<TABLE border=1 width=400 height=40 cellspacing=0>
<tr>
	<td align=center><a href="A_01_H.jsp" target="main"><b> 후보 등록</b></font><a></td>
	<td align=center bgcolor=yellow><a href="B_01_H.jsp" target="main"><b>투표</b></font><a></td>
	<td align=center><a href="C_01_H.jsp" target="main"><b>개표결과</b></font><a></td>
</tr>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from vote;");
	
	String newvotenum = "", newvotename="";
%>
<table cellspacing=0 width=700 border=1>
<form method="post" action="B_02_H.jsp">			<!--삭제를 위한 부분-->
<tr>
	<td>
		<select name=votenum>						<!-- 선택한 투표 번호를 넘기기 위한 변수 지정 -->
<%
	while (rset.next()) {							//후보번호+이름을 불러오기 위한 while
	newvotenum = Integer.toString(rset.getInt(2));	//후보번호
	newvotename = rset.getString(4);				//후보이름
%>
		<option value=<%= newvotenum %>><%= newvotenum %>번<%= newvotename %></option> <!-- 후보번호+이름 선택칸-->
		<!-- 첫번째 newvotenum은 테이블 vote1에 후보번호 저장을 위함 value값 : 자동으로 A_01 변화값에 따라 변하기 때문에 vote테이블에서 데이터를 받아와서 다시 vote1 테이블로 넘겨주는 형식-->
		<!-- 두번째 newvotenum은 화면 기호번호 출력-->
		<!-- 세번째 newvotname 화면 후보이름 출력-->
<%
	}
	rset.close();
	stmt.close();
	conn.close();
%>
		</select>
		
		<select name=choice>						<!--선택한 투표 나이를 넘기기 위한 변수 지정-->
			<option value=1>10대</option>			<!--연령대 선택을 위한 칸-->
			<option value=2>20대</option>			<!-- vote1테이블로 선택값을 넘기기 위해 value값 지정 -->
			<option value=3>30대</option>
			<option value=4>40대</option>
			<option value=5>50대</option>
			<option value=6>60대</option>
			<option value=7>70대</option>
			<option value=8>80대</option>
			<option value=9>90대</option>
		</select>
		<input type="submit" value="투표하기"></input> <!-- 투표하기 버튼 -->
	</td>
</tr>

</form>
</body>
</html>