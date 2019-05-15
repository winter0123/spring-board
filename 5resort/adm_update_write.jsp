<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>레코드 수정 완료</title>
</head>
<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");	//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	String d1 = request.getParameter("d");
	String r1 = request.getParameter("r");
	String hanname = request.getParameter("name");
	String hanresvdate = request.getParameter("resvdate");
	String hanroom = request.getParameter("room");
	String hanaddr = request.getParameter("addr");
	String hantelnum = request.getParameter("telnum");
	String haninname = request.getParameter("in_name");
	String hancomment = request.getParameter("comment");
	String hanwritedate = request.getParameter("write_date");
	
	String sql = "update castle set name = '"+hanname+"', resv_date = '"+hanresvdate+"', room = "+hanroom+", addr = '"+hanaddr+"', telnum = '"+hantelnum+"', in_name = '"+haninname+"', comment = '"+hancomment+"', write_date = '"+hanwritedate+"' where resv_date = '"+d1+"' and room = "+r1+";";
	
	stmt.executeUpdate( sql );
	
	Statement stmt1 = conn.createStatement();
	ResultSet rset1 = stmt1.executeQuery("select * from castle where resv_date = '"+hanresvdate+"' and room = "+hanroom+";");
	
	rset1.next();
	 
	String room = Integer.toString(rset1.getInt(3));
	if(room==null){room="0";}
	
	
										//rset은 총점,평균,등수까지 다시 보기 위해 출력
%>
<h1><%=hanname%>수정완료</h1> <!-- 받아온 ckey값 사용해서 이름 자동으로 넣어줌 -->
<table border=1 cellspacing=0>
	<tr>
		<td width=100 align=center>성명</td>
		<td><input type="text" name="name" value="<%= hanname %>" style="border:none; width:500px" readonly></input></td>
	</tr>
	<tr>
		<td width=100 align=center>예약일자</td>
		<td><input type="date" name="resvdate" value="<%= rset1.getString(2) %>" style="border:none; width:500px" readonly></input></td>
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
		<td><input type="text" name="addr" value="<%= rset1.getString(4) %>" style="border:none; width:500px" readonly></input></td>
	</tr>
	<tr>
		<td width=100 align=center>전화번호</td>
		<td><input type="text" name="telnum" value="<%= rset1.getString(5) %>" style="border:none; width:500px" readonly></input></td>
	</tr>
	<tr>
		<td width=100 align=center>입금자명</td>
		<td><input type="text" name="in_name" value="<%= rset1.getString(6) %>" style="border:none; width:500px" readonly></input></td>
	</tr>
	<tr>
		<td width=100 align=center>남기실말</td>
		<td><input type="text" name="comment" value="<%= rset1.getString(7) %>" style="border:none; width:500px" readonly></input></td>
	</tr>
	<tr>
		<td width=100 align=center>작성일</td>
		<td><input type="text" name="write_date" value="<%= rset1.getString(8) %>" style="border:none; width:500px" readonly></input></td>
	</tr>
</table>
<table border=0 cellspacing=0>
<tr>
	<td align=right width='600px'><input type="button" value="리스트 돌아가기" OnClick="location.href='adm_allview.jsp'" ></input></td> <!-- 투표하기 버튼 -->
</tr>
</table>
</center>
<%
	rset1.close();
	stmt1.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>