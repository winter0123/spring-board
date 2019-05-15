<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<!--현재시간 받아오기 위한 java.utill 과 text import-->
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
   <title>조아펜션 / 예약하기</title>
   
<script>
	function submitform(mode){
		myform2.action = "d_02_write.jsp";	//updateDB로 myform 데이터 전송
		myform2.submit();
		}
</script>
</head>
<body>
<center>
   <h1><p align=center>예약하기</p></h1>
<%
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());

   Calendar cal = Calendar.getInstance();
   cal.add(Calendar.MONTH, +1);
   java.util.Date currentTime=cal.getTime();
   String release_Dt_start=formatter.format(currentTime);
	
	
	String key = request.getParameter( "key" );	//앞에(d_02.jsp.jsp) key값(이름)을 받아옴
	if(key==null){key=today;}
	
	String room = request.getParameter("room");
	if(room==null){room="0";}
%>

<form method="post" name="myform2">
<table border=1 cellspacing=0>
	<tr>
		<td width=100 align=center>성명</td>
		<td><input type="text" name="name" value="" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>예약일자</td>
		<td><input type="date" name="resvdate" value="<%= key %>"  min="<%=today%>" max="<%=release_Dt_start%>"  style="width:150px"</input></td>
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
		<td><input type="text" name="addr" value="" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>전화번호</td>
		<td><input type="text" name="telnum" value="" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>입금자명</td>
		<td><input type="text" name="in_name" value="" style="width:500px"></input></td>
	</tr>
	<tr>
		<td width=100 align=center>남기실말</td>
		<td><input type="text" name="comment" value="" style="width:500px"></input></td>
	</tr>
</table>
<table border=0 cellspacing=0>
<tr>
	<td align=right width='600px'><input type="button" value="예약하기" OnClick="submitform('write')"></input></td> <!-- 투표하기 버튼 -->
</tr>
</table>
</form>
</center>
</body>
</html>