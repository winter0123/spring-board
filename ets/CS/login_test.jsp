<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="java.sql.*,javax.sql.*,java.net.*,java.io.*" %>
<html>
<head>
<%
	//세션을 체크해서 없다면 로그인창으로 보낸다. 그리고 로그인이 되면 자기자신에게 와야 하기때문에 자기자신의 url을 써준다.
	String loginOK=null;
	String jumpURL= "login.jsp?jump=login_test.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK == null){
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes"))	{
		response.sendRedirect(jumpURL);
		return;
	}
%>
</head>
<body>
<center>
<h1> 로그인 오케이 </h1>
<br><br>
<a href="logout.jsp">로그아웃</a>
</center>
</html>

