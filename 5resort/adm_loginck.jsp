<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.sql.*,javax.sql.*,java.net.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<html>
<head></head>
<body>
<center>
<%
	String jump = request.getParameter("jump");
	String id = request.getParameter("id");
	String pass = request.getParameter("passwd");
	
	boolean bPassChk=false;
	
	//아이디, 패스워드 체크(id,pw가 현재는 admin,admin으로만 로그인되게 되어있음)
	if( id.replaceAll(" ","").equals("admin")&& pass.replaceAll(" ","").equals("admin"))
	{
		bPassChk=true;
	}else{
		bPassChk=false;
	}
	
	//패스워드 체크가 끝나면, 세션을 기록하고 점프한다.
	if(bPassChk){
		session.setAttribute("login_ok","yes");
		session.setAttribute("login_id",id);
		response.sendRedirect(jump);			//로그인 체크 이후 돌아갈 곳
	}else{
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		out.println("<input type=button value='로그인' onClick=\"location.href='adm_login.jsp?jump="+jump+"'\">");
	}
%>
</center>
</body>
</html>