<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>개별예약상황</title>
<script>
	function submitform(mode){
		if(mode == "update"){
			myform1.action = "adm_update.jsp";	//updateDB로 myform 데이터 전송
		}
	myform1.submit();
	}
</script>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");	//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	String name1 = request.getParameter( "name" );	//Alview에서 이름 출력시 준 key값을 받아와서 ckey라고 변수 설정
	String resv_date1 = request.getParameter( "resv_date" );
	String room1 = request.getParameter( "room" );
	
	ResultSet rset = stmt.executeQuery("select * from castle where resv_date = '"+resv_date1+"' and room = "+room1+";");

	 rset.next();
	 
	String room = Integer.toString(rset.getInt(3));
	if(room==null){room="0";}
	 
%>
<center>
<h1><%=name1%> 조회</a></h1> <!-- 받아온 ckey값 사용해서 이름 자동으로 넣어줌 -->
<form method="post" name="myform1">
<input type = "hidden" name=rn value="<%= room %>"></input>
<table border=1 cellspacing=0>
	<tr>
		<td width=100 align=center>성명</td>
		<td><input type="text" name="name" value="<%= name1 %>" readonly style="border:none; width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>예약일자</td>
		<td><input type="date" name="resvdate" value="<%= rset.getString(2) %>" readonly style="border:none;"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>예약방</td>
		<td><input type="text" value="<%if(room.equals("1")){
											out.println("VIP Room");
										}else if(room.equals("2")){
											out.println("Suite Room");
										}else if(room.equals("3")){			
											out.println("Standard Room");  
										} else{
											out.println("방 선택");
										}%>" readonly style="border:none; width:500px"></input>
		</td>
	</tr>
	<tr>
		<td width=100 align=center>주소</td>
		<td><input type="text" name="addr" value="<%= rset.getString(4) %>" readonly style="border:none;"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>전화번호</td>
		<td><input type="text" name="telnum" value="<%= rset.getString(5) %>" readonly style="border:none;"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>입금자명</td>
		<td><input type="text" name="in_name" value="<%= rset.getString(6) %>" readonly style="border:none;"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>남기실말</td>
		<td><input type="text" name="comment" value="<%= rset.getString(7) %>" readonly style="border:none;"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>작성일</td>
		<td><input type="text" name="write_date" value="<%= rset.getString(8) %>" readonly style="border:none;"></input></td>
	</tr>
</table>
<table border=0 cellspacing=0>
	<tr>
		<td align=right width='600px'>
		<input type="button" value="수정&삭제" OnClick="submitform('update')" ></input>
		</td> <!-- 투표하기 버튼 -->
	</tr>
</table>
</form>
</center>
<%
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>