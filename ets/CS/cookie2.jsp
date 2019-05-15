<%@ page contentType="text/html; charset=utf-8" %> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<HTML>
<HEAD>
<TITLE>쿠키 값 검사</TITLE>
</HEAD>
<BODY> 
<%
Cookie[] cookies = request.getCookies();
for (int i = 0; i<cookies.length; i++) {
	Cookie thisCookie = cookies[i];
	if("name".equals(thisCookie.getName()))	{
		out.println("이름:"+thisCookie.getValue()+"<br>");
	}
}
%>
</BODY>
</HTML>