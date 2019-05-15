<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.sql.*,javax.sql.*,java.net.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<html>
<head></head>
<body BACKGROUND>
<center>
<%
	session.invalidate();
	out.println("<h2>로그아웃 되었습니다.</h2>");
	//로그아웃 후 일반적으로는 홈으로 감(여기서는 logn_test.jsp)
	out.println("<input type=button value='메인페이지' onClick=\"location.href='login_test.jsp'\">");
%>
</center>
</body>
</html>