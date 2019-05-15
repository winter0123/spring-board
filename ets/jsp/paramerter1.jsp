<%@ page contentType="text/html; charset=utf-8" %>
<%
  request.setCharacterEncoding("utf-8"); //post방식(html에서)으로 부터 데이터 받아와서 한글표기위해서 추가
	String name = request.getParameter("username");
	String password = request.getParameter("userpasswd");
%>
<html>
<head>
	<title>로그인</title>
</head>
<body>
	이름 : <%= name %><br>
	비밀번호 : <%= password %><br>
</body>
</html>