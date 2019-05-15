<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>레코드 수정</title>
<script>
	function submitform(mode){
		if(mode == "update_write"){
			myform2.action = "adm_update_write.jsp";	//updateDB로 myform 데이터 전송
		}else if(mode == "delete"){
			myform2.action = "adm_delete.jsp";	//deleteDB로 myform 데이터 전송
		}
	myform2.submit();
	}
</script>
</head>
<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");	//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	String resvdate1 = request.getParameter("resvdate");
	String room1 = request.getParameter("rn");
	
	ResultSet rset = stmt.executeQuery("select * from castle where resv_date = '"+resvdate1+"' and room = "+room1+";");

	rset.next();	
	String room = Integer.toString(rset.getInt(3));
	if(room==null){room="0";}
	
%>
<h1>[<%=rset.getString(1)%>]수정</h1> <!-- 받아온 ckey값 사용해서 이름 자동으로 넣어줌 -->
<form method="post" name="myform2">

<input type = "hidden" name=d value="<%= resvdate1 %>"></input>
<input type = "hidden" name=r value="<%= room1 %>"></input>

<table border=1 cellspacing=0>
	<tr>
		<td width=100 align=center>성명</td>
		<td><input type="text" name="name" value="<%= rset.getString(1) %>" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>예약일자</td>
		<td><input type="date" name="resvdate" value="<%= rset.getString(2) %>"  style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>예약방</td>
		<td>
				<select name=room>						<!--선택한 방을 넘기기 위한 변수 지정-->
				<%if(room.equals("1")){
						out.println("<option value=1 selected>VIP Room</option>");
						out.println("<option value=2>Suite Room</option>");
						out.println("<option value=3>Standard Room</option>");
				 }else if(room.equals("2")){
						out.println("<option value=1>VIP Room</option>");
						out.println("<option value=2 selected>Suite Room</option>");
						out.println("<option value=3>Standard Room</option>");  
				 }else if(room.equals("3")){			
						out.println("<option value=1>VIP Room</option>");
						out.println("<option value=2>Suite Room</option>");
						out.println("<option value=3 selected>Standard Room</option>");  
				 } else{
						out.println("<option disabled hidden selected>방 선택</option>");
						out.println("<option value=1>VIP Room</option>");
						out.println("<option value=2>Suite Room</option>");
						out.println("<option value=3>Standard Room</option>");
				 }%>
			</select>
		</td>
	</tr>
	<tr>
		<td width=100 align=center>주소</td>
		<td><input type="text" name="addr" value="<%= rset.getString(4) %>" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>전화번호</td>
		<td><input type="text" name="telnum" value="<%= rset.getString(5) %>" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>입금자명</td>
		<td><input type="text" name="in_name" value="<%= rset.getString(6) %>" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>남기실말</td>
		<td><input type="text" name="comment" value="<%= rset.getString(7) %>" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>작성일</td>
		<td><input type="text" name="write_date" value="<%= rset.getString(8) %>" style="width:500px"></input></td>
	</tr>
</table>
<table border=0 cellspacing=0>
	<tr>
		<td align=right width='600px'>
		<input type="button" value="취소" OnClick="location.href='adm_allview.jsp'" ></input>
		<input type="button" value="수정" OnClick="submitform('update_write')" ></input>
		<input type="button" value="삭제" OnClick="submitform('delete')" ></input>
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
</table>
</body>
</html>