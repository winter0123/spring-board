<%@ page contentType="text/html; charset=utf-8" %> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<HTML>
<HEAD>
<TITLE>쿠키 지우기</TITLE>
</HEAD>
<BODY> 
<%
Cookie[] cookies = request.getCookies();
for (int i = 0; i<cookies.length; i++) {
	Cookie thisCookie = cookies[i];
	if("name".equals(thisCookie.getName()))	{
		thisCookie.setMaxAge(0);		//유효기간 0으로 설정 -->지워짐
		response.addCookie(thisCookie);	//쿠키를 세팅
	}
}
%>
</BODY>
</HTML>