<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>후보등록</title>
	<script>
	function onlyKE(event){ //한글입력만
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( (keyID >= 65 && keyID <= 90) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				// 8=Backspace, 46=Delete, 37=왼쪽 화살표, 39=오른쪽 화살표
				return;
			else
				return false;
		}
		function removeChar(event) { //문자열 제거
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				event.target.value = event.target.value.replace(/[^(ㄱ-힣a-zA-Z)]/gi, "");
		}
	</script>
</head>

<body text="#000000" link="#000000" vlink="#000000" alink="#000000">
<TABLE border=1 width=400 height=40 cellspacing=0 >	<!-- 상단 테이블 -->
<tr>
	<td align=center bgcolor=yellow ><a href="A_01_H.jsp" target="main"><b> 후보 등록</b></font><a></td>
	<td align=center><a href="B_01_H.jsp" target="main"><b>투표</b></font><a></td>
	<td align=center><a href="C_01_H.jsp" target="main"><b>개표결과</b></font><a></td>
</table>
<table cellspacing=0 width=700 border=1>	<!-- 후보표시 테이블 -->
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from vote;");	//테이블 지정
	
	String newvotenum = "", newvotename="";
	
	while (rset.next()) {										//rset들고오기
	newvotenum = Integer.toString(rset.getInt(2));				//기호번호
	newvotename = rset.getString(4);							//후보이름
	
%>

<form method="post" action="A_02_H.jsp">	<!--등록된 후보 삭제 = A_02_H.JSP-->
		<tr>
			<td>기호번호 : <input type="text" name="newvotenum" value="<%= newvotenum %>" readonly  style="border:none;">
			후보명 : <input type="text" name="newvotename" value="<%= newvotename %>" readonly style="border:none;">
			<input type="submit" value="삭제"></input></td>
		</tr>

</form>
<%
	}
	rset.close();
	stmt.close();
	conn.close();
%>
<form method="post" action="A_03_H.jsp">	<!--등록된 후보 추가 = A_03_H.JSP-->
		<tr>
			<td>기호번호 : <input type="text" name="newvotenum" value='자동부여' readonly>
			후보명 : <input type="text" onkeydown='return onlyKE(event)' onkeyup='removeChar(event)' name="newvotename" value='' required> <!-- required 입력이 있어야만 버튼클릭 가능-->
			<input type="submit" value="추가"></input></td>	<!-- onkeydown='return onlyKE(event)' onkeyup='removeChar(event)' 위에 등록한 function 이용하여 숫자입력 금지-->
		</tr>
	</table>
</form>
</body>
</html>