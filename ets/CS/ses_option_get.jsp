<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.text.*,java.util.*"%>
<% //session option
	session.setAttribute("session_id","jang");
	SimpleDateFormat fmt = new SimpleDateFormat("yy-MM-dd [ hh:mm:ss ]");
	long createTime =(long)session.getCreationTime();//세션 생성시간
	long lastTime = (long)session.getLastAccessedTime();//마지막 처리 시간
%>
<html>
<body>
session 생성 시간 ==> <%=fmt.format(new Date(createTime))%><br>
session 마지막 처리 시간 ==> <%=fmt.format(new Date(lastTime))%><br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
session 유지 시간 변경 ==> <%session.setMaxInactiveInterval(1);%><br>
session값 표시 ==> <%=(String)session.getAttribute("session_id")%><br>
session ID ==> <%=session.getId()%> <br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
</body>
</html>