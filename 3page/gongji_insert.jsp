<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>새로운 글추가</title>
<script>
	function submitform(mode){
		myform2.action = "gongji_write.jsp?key=INSERT";	//updateDB로 myform 데이터 전송
		myform2.submit();
		}
</script>
</head>
<body>
<% //현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());
%>
<form method="post" name="myform2">
<table border=1 cellspacing=1>
<tr>
	<td width=50 align=left>번호</td>
	<td width=400 align=left>신규(insert)</td>	<!-- 번호는 auto_increment로 받아서 자동 생성됨 : 테이블 만들때 줘야함-->
</tr>
<tr>
	<td width=50 align=left>제목</td>
	<td width=400 align=left><input type="text" name="title" value="" style="width:380px"></input></td>
</tr>
<tr>
	<td width=50 align=left>일자</td>
	<td width=400 align=left><input type="text" name="today" value="<%= today %>" readonly style="border:none;"></input></td>
</tr>
<tr>
	<td width=50  height=300 align=left>내용</td>
	<td width=400 align=left><textarea name="content" cols="52" rows="20"></textarea></td>
</tr>
</table>
<table border=0 cellspacing=0>
	<tr>
		<td width=450 align=right>
		<input type="button" value="취소" OnClick="location.href='gongji_list.jsp'" ></input>
		<input type="button" value="쓰기" OnClick="submitform('write')" ></input>
		</td>
	</tr>
</table>
</body>
</html>