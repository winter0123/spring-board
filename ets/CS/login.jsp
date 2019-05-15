<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.sql.*,javax.sql.*,java.net.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<html>
<head></head>
<body>
<% String jump = request.getParameter("jump");
%>
<center>
<h2>관리자 로그인</h2>
<form method="post" action="loginck.jsp">
<table border=1>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td colspan=2 align=center><input type="submit" value="전송"></td>
	</tr>
</table>
<input type="hidden" name="jump" value='<%=jump%>'>
</form>
</center>
</center>
</body>
</html>