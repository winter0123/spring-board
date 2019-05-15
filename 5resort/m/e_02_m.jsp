<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글보기(한개항목)</title>
<script>
	function submitform(mode){
		if(mode == "list"){
			myform.action = "e_01_m.jsp";	//updateDB로 myform 데이터 전송
			myform.submit();
		}
	}
</script>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String ckey = request.getParameter( "key" );	//앞에(C_01) key값(이름)을 받아옴

	//후보자의 각 연령별 합계값을 알기 위한 rest값
	ResultSet rset = stmt.executeQuery("select * from 5gongji where id = "+ckey+";");
	rset.next();							//각 후보자의 연령대 별 표 수 조회(번호+나이(1~9)기준으로 조회)
	
	int eachnum = rset.getInt(1);
	String eachtitle = rset.getString(2);
	String eachdate = rset.getString(3);
	String eachcontent = rset.getString(4);

%>
<form method="post" name="myform">	
<table border=1 cellspacing=0 width="100%" style="background-color: #ffffff;">
	<tr>
		<td width="20%" align=left>번호</td>
		<td width="80%" align=left><input type="text" name="id" value="<%= eachnum %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width="20%" align=left>제목</td>
		<td width="80%" align=left><input type="text" name="eachtitle" value="<%= eachtitle %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width="20%" align=left>일자</td>
		<td width="80%" align=left><input type="text" name="eachdate" value="<%= eachdate %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width="20%" align=left>내용</td>
		<td width="80%" align=left><textarea name="eachcontent" readonly style="border:none;"><%= eachcontent %></textarea></td>
	</tr>
</table>
<table border=0 cellspacing=0 width="100%">
	<tr>
		<td width="95%" align=right>
		<input type="button" value="목록" OnClick="submitform('list')" ></input>
		</td>
	</tr>
</table>
<%
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>