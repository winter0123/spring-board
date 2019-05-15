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
	
	String number1 = request.getParameter("id");					//학번을 받아옴
	
	String sql="delete from gongji where id = " + number1;	//받아온 학번으로 mysql에 delete 삭제문 돌림
		
	stmt.executeUpdate( sql );											//삭제문 실행
	
	ResultSet rset = stmt.executeQuery("select*from gongji;");		//삭제후 업데이된 데이터 출력을 위해 다시 examtable2 선택
	
%>
</head>
<body>
<script>
    alert("게시글이 삭제 되었습니다.");
    window.location.href="gongji_list.jsp";
</script>
</body>
</html>