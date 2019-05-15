<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title> 조회한 학번으로 수정 or 삭제 버튼 클릭 페이지 </title>
<script>
	function submitform(mode){
		if(mode == "update"){
			myform.action = "updateDB.jsp";	//updateDB로 myform 데이터 전송
			myform.submit();
		}else if(mode == "delete"){
			myform.action = "deleteDB.jsp";	//deleteDB로 myform 데이터 전송
			myform.submit();
		}
	}
			function onlyNumber(event){	//숫자만 입력받음
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				return false;
		}
		function removeChar(event) {	//문자제거
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
</script>
</head>
<body>

<h1>성적 조회후 정정 / 삭제</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String name = "", studentid="", kor="", eng="", mat="";
	
	String student = request.getParameter( "searchid" );	// inputFrom2에서 조회할 학번의 name값으로 학번 받아옴
	if(student.length()==0) student="0";					// 아무것도 입력 안되었을때 student=0으로 설정
	ResultSet rset = stmt.executeQuery("select * from examtable2 where studentid = " +student+ ";");	//입력된 학번으로 학번 조회
	
	name="해당학번없음";	//학번이 없는 학번일때 "해당학번 없음" 출력을 위해 name값 지정
	
	while(rset.next()) {									// 조회한 학번으로 데이터 받아와서 변수에 저장
		name = rset.getString(1);							// 이름	
		studentid = Integer.toString(rset.getInt(2));		// 학번										
		kor = Integer.toString(rset.getInt(3));				// 국어점수
		eng = Integer.toString(rset.getInt(4));				// 영어점수
		mat = Integer.toString(rset.getInt(5));				// 수학점수
	}
	stmt.close();
	conn.close();
%>
<form method="post" action="showREC.jsp">										<!-- 조회버튼 클릭스 현재패이지 showREC 계속 작동 -->
	<TABLE border=0 width=400 cellspacing=0>
		<tr>
			<td>조회할 학번</td>
			<td align=center><input type= "text" name="searchid" value=""></td>	<!-- 조회하고 싶은 학번 입력 창 -->
			<td align="right"><input type="submit" value="조회"></input></td>		<!-- 조회버튼 생성 -->
		</tr>
	</TABLE>
</form>
<form method="post" name="myform">												<!-- 위에 function에 있는 myform으로 전송 -->
	<table border=1 width=400 cellspacing=1>
	<tr>
		<td width=100 align=center>이름</td>
		<td width=300 align=center><input type= "text" name="name" value="<%= name %>"></input></td>
	</tr>															<!-- 위에 받아온 데이터 이름 출력 -->
	<tr>
		<td width=100 align=center>학번</td>
		<td width=300 align=center><input type="text" name="studentid" value="<%= studentid %>"></input></td>
	</tr>															<!-- 위에 받아온 데이터 학번 출력 -->
	<tr>
		<td width=100 align=center>국어</td>
		<td width=300 align=center><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' name="userkor" value="<%= kor %>"></input></td>
	</tr>															<!-- 위에 받아온 데이터 국어점수 출력 -->
	<tr>
		<td width=100 align=center>영어</td>
		<td width=300 align=center><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' name="usereng" value="<%= eng %>"></input></td>
	</tr>															<!-- 위에 받아온 데이터 영어점수 출력 -->
	<tr>
		<td width=100 align=center>수학</td>
		<td width=300 align=center><input type="number" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' name="usermat" value="<%= mat %>"></input></td>
		<span id="keyinfo"></span>									<!-- 위에 받아온 데이터 수학점수 출력 -->
	</tr>
</table>
<%
   if(studentid.length()!=0) {
        out.println("<table cellspacing=1 width=400 border=0>"); // 수정 삭제 버튼 테이블
        out.println("<tr>");
        out.println("<td width=200></td>");  
        out.println("<td width=100><p align = center><input type=button value=\"수정\" OnClick=\"submitform('update')\"</p></td>");
																		//수정 버튼 클릭시 function submitform(mood)에서 update 부분 작동
        out.println("<td width=100><p align = center><input type=button value=\"삭제\" OnClick=\"submitform('delete')\"</p></td>");
																		//삭제 버튼 클릭시 function submitform(mood)에서 delete 부분 작동    
        out.println("</tr>");
      out.println("</table>");
   }
%>
</form>
</body>
</html>