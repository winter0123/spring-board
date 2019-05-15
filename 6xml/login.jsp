<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.sql.*,javax.sql.*,java.net.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<html>
<head>
<title>로그인(Authority)가 있는 데이터 xml조회를 만들기(1)</title>
<% 
	String username = request.getParameter("username");
	String userpasswd = request.getParameter("userpasswd");
	String rtn_url = request.getParameter("rtn_url");
	String logincnt = request.getParameter("logincnt");
	if(logincnt == null) logincnt="0";
	if(username == null) username="";
	if(userpasswd ==null) userpasswd="";
	if(rtn_url == null) rtn_url="";
	
	if(username.equals("kopoctc") && userpasswd.equals("kopoctc")) { //login OK
		session.setAttribute("loginOK","YES");
		response.sendRedirect(rtn_url);	//다시돌아감
	}else{	//login Err
		logincnt=Integer.toString(Integer.parseInt(logincnt)+1);
	}	
%>
</head>
<body>
<form method="post" action="login.jsp">
	이름 : <input type="text" name="username">
	비밀번호 : <input type="password" name="userpasswd">
	<input type="hidden" name="logincnt" value=<%=logincnt%>><br>
	<input type="hidden" name="rtn_url" value=<%=rtn_url%>><br>
	<input type="submit" value="전송">
</form>
로그인 시도 횟수 <%= logincnt %>회입니다.<br>
rtn_url <%= rtn_url %> 입니다.<br>
</body>
</html>