<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글목록</title>
<!-- 원래 jeago_list.jsp 파일 -->
</head>
<body>
<h1>Make table</h1>
<table border=1 cellspacing=0>
<tr>
	<td width=100 align=left>상품번호</td>
	<td width=140 align=left>상품명</td>
	<td width=120 align=left>현재 재고수</td>
	<td width=120 align=left>재고파악일</td>
	<td width=120 align=left>상품등록일</td>
</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from jeago;");	//테이블 지정

	String id="", productname="", nowproductnum="", lastpdate="", firstpdate="";
	
	while (rset.next()) {										//rset들고오기
	id = Integer.toString(rset.getInt(1));						//제품번호(111111)
	productname = rset.getString(2);							//상품명(바나나)
	nowproductnum = Integer.toString(rset.getInt(3));			//현재 재고수(10)
	lastpdate = rset.getString(4);								//재고파악일(2019-01-01)
	firstpdate = rset.getString(5);								//상품등록일(2019-01-01)
	

%>
<form method="post" action="jeago_view.jsp">
<tr>
	<td width=100 align=left><a href='jeago_view.jsp?keyz=<%= id %>'><%= id %></a></td>
	<td width=140 align=left><a href='jeago_view.jsp?keyz=<%= id %>'><%= productname %></a></td>
	<!--이름 클릭시 연결 링크 생성 = url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달 [key값, key1값 설정]-->
	<td width=120 align=left><%= nowproductnum %></td>
	<td width=120 align=left><%= lastpdate %></td>
	<td width=120 align=left><%= firstpdate %></td>
</tr>
</form>
<%
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<table border=0 cellspacing=0>
<form method="post" action="jeago_insert.jsp">	<!--등록된 후보 추가 = A_03_H.JSP-->
		<tr>
			<td width=560 align=right><input type="submit"  value='신규등록' required></input></td> <!-- required 입력이 있어야만 버튼클릭 가능-->
		</tr>
</form>
</table>
</body>
</html>