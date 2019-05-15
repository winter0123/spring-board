<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 값 얻어오기</title>
</head>
<body><!-- session = 유지되고 있는 parameter -->
    <h1>세션 값</h1>
    <!-- 세션은 브라우저가 종료될 때까지 유지된다. -->
    <!-- 웹 서버를 껐다가 켜도 브라우저를 종료하지 않으면 유지됨. -->
    <h3>id  : <%=session.getAttribute("id")%></h3>
    <h3>pwd : <%=session.getAttribute("pwd")%></h3>
    <h3>name:<%=session.getAttribute("name") %></h3>
    <p><a href="javascript:history.go(-1)">뒤로가기</a></p>
</body>
</html>