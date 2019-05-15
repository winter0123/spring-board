<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션의 값을 삭제하자</title>
</head>
<body>
    <h1>세션 특정 값 삭제</h1>
    <%session.removeAttribute("pwd");%>	<!-- ""안에 넣은 값이 삭제됨 -->
    <h3>id   : <%=session.getAttribute("id")%></h3>
    <h3>pwd  : <%=session.getAttribute("pwd") %></h3>
    <h3>name : <%=session.getAttribute("name") %></h3>
    
    <h1>전체 세션 만료</h1>
    <%session.invalidate();%><!-- 강제로 세션 만료시킴. 새로고침 후 확인(전체삭제) -->

</body>
</html>