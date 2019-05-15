<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글삭제</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String number1 = request.getParameter("id");
	
	String sql="delete from 5gongji where id = " + number1;
		
	stmt.executeUpdate( sql );										//삭제문 실행
	
	ResultSet rset = stmt.executeQuery("select*from 5gongji;");		//삭제후 업데이된 데이터 출력을 위해 다시 5gongji 선택
	
%>
</head>
<body>
<script>
    alert("게시글이 삭제 되었습니다.");
    window.location.href="e_01.jsp";
</script>
</body>
</html>