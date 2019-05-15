
<%@ page contentType="text/html; charset=utf-8" %> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%
	String myName = "jang.YJ1";
	Cookie cookieName = new Cookie("name", myName );
	cookieName.setMaxAge(-1);		//브라우저 켜있을때 까지
	response.addCookie(cookieName);	//response객체에 보내야 사용가능
%>
<HTML>
<HEAD>
<TITLE>쿠키 저장</TITLE>
</HEAD>
<BODY> JSP 쿠키사용 </BODY>
</HTML>