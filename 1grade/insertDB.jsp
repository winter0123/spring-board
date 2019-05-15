<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="05error.jsp" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>추가 -> 추가완료</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	//학번 부과 과정
	int userstudentid = 0;																	// 학번 부과할 int값 초기화
	
	if(true) {	//빠져 있는 것 중에 있는 학번 찾기
      ResultSet rset = stmt.executeQuery("select min(studentid+1) FROM examtable2 WHERE (studentid+1) NOT IN (SELECT studentid FROM examtable2);"); 
      while (rset.next()) {																	// 최소값+1을 찾을때 없으면
         userstudentid=rset.getInt(1);														// 그것(최솟값+1)을 학번으로 부여
      }   
   }else {
      ResultSet rset = stmt.executeQuery("select max(studentid) FROM examtable2 ;"); 		// 중간에 빈 값이 없다면 최댓값을 찾아서
      while (rset.next()) { 																// while 구문을 돌려서 max학번에서 +1해줌
         userstudentid=rset.getInt(1)+1; 
      }
   }
	
	String hanname = request.getParameter("username"); 										//jsp에서 jsp로 데이터 전송 시 한글 깨짐 처리 2줄
	String hanname1 = new String(hanname.getBytes("8859_1"), "UTF-8");
	
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('"+ 	//기존 세팅된 것에 맞춰서 양식 입력
		hanname1 +"',"+
		Integer.toString(userstudentid)+","+												//int값으로 받아온 학번을 string값으로 변환 = Integer.toString()
		request.getParameter("userkor")+","+
		request.getParameter("usereng")+","+
		request.getParameter("usermat")+");");
	
	stmt.close();
	conn.close();
%>
</head>

<body>
<form method="post" action="inputForm1.html">	<!-- action inputForm1로 이동 -->
<h1>성적입력 추가완료</h1>
	<TABLE border=0 width=400 cellspacing=0>
		<tr>
			<td>
				<div align="right">
					<input type="submit" value="뒤로가기"></input>	<!-- 뒤로가기 버튼 생성, 뒤로가기 클릭시 inputForm1로 -->
				</div>
			</td>
		</tr>
	</TABLE>
	<table border=1 width=400 cellspacing=1>	<!-- 입력 후 조회를 위한 표 -->
		<tr>
			<td width=100 align=center>이름</td>
			<td width=300 align=center><input type= "text" name="name" value='<%= hanname1 %>'></td> 
		</tr>															<!-- 위쪽 이릅 변수 받아와서 표시 -->
		<tr>
			<td width=100 align=center>학번</td>
			<td width=300 align=center><input type="text" name="studentid" value='<%= Integer.toString(userstudentid)%>'></td>
		</tr>																<!-- 위쪽 학번 변수 받아와서 표시 -->	
		<tr>
			<td width=100 align=center>국어</td>
			<td width=300 align=center><input type="text" name="userkor" value='<%= request.getParameter("userkor") %>'></td>
		</tr>																<!-- 위쪽 국어점수 변수 받아와서 표시 -->
		<tr>
			<td width=100 align=center>영어</td>
			<td width=300 align=center><input type="text" name="usereng" value='<%= request.getParameter("usereng") %>'></td>
		</tr>																<!-- 위쪽 영어점수 변수 받아와서 표시 -->
		<tr>
			<td width=100 align=center>수학</td>
			<td width=300 align=center><input type="number" name="usermat" value='<%= request.getParameter("usermat") %>'></td>
		</tr>																<!-- 위쪽 수학점수 변수 받아와서 표시 -->
	</table>
</form>
</body>
</html>