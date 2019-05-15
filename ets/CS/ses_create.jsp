<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 세팅</title>
</head>
<body>
    <h1>세션 설정</h1>
    <%
    //HttpSession session = request.getSession(false);//생략되어 있음
    session.setAttribute("id", "jang");//Attribute는 모두 Object
    session.setAttribute("pwd", 1234);
    session.setAttribute("name", "yj");
    out.print("<h3>설정완료</h3>");
    %>
    <p><a href="javascript:history.go(-1)">뒤로가기</a></p>
</body>
</html>