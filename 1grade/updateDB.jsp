<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>레코드 수정</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String hanname = request.getParameter("name"); 								//jsp에서 jsp로 데이터 전송 시 한글 깨짐 처리 2줄
	String hanname1 = new String(hanname.getBytes("8859_1"), "UTF-8");
	
	String sql="update examtable2 set " +										//수정버튼 클릭시 mysql update 구문 실행
		"name = '"+hanname1+"', "+												//inputForm2에서 받아온 값으로 구문 돌아감
		"kor = "+request.getParameter("userkor")+", "+
		"eng = "+request.getParameter("usereng")+", "+
		"mat = "+request.getParameter("usermat")+
		" where studentid = " + request.getParameter("studentid");				//학번으로 변경할 사람 지정
	
	stmt.execute( sql );														//sql 실행
	
	ResultSet rset = stmt.executeQuery("select * ,(kor+eng+mat) as 총점,((kor+eng+mat)/3) as 평균,(select count(*)+1 from examtable2 " +
                                      "where (kor+eng+mat) > (b.kor + b.eng + b.mat)) as 등수 from examtable2 b;");
										//rset은 총점,평균,등수까지 다시 보기 위해 출력
%>
<table cellspacing=1 width=600 border=1>	<!-- 테이블 첫번째줄 필드명 출력 -->
	<tr>
		<td width=50 align=center>이름</td>
		<td width=50 align=center>학번</td>
		<td width=50 align=center>국어</td>
		<td width=50 align=center>영어</td>
		<td width=50 align=center>수학</td>
		<td width=50 align=center>총점</td>
		<td width=50 align=center>평균</td>
		<td width=50 align=center>등수</td>
	</tr>
<%
	while (rset.next()) {
	// 수정한것 출력을 위한 부분
	if(request.getParameter("studentid").equals(Integer.toString(rset.getInt(2)))){	//수정한 학번 받아와서 그 학번과 일치한 것만
		out.println("<tr bgcolor = '#ffff00' >");									//배경 노란색으로 설정하여 출력
		out.println("<td width=50><p align=center><a href='oneview.jsp?key="+rset.getString(1)+"'> "+rset.getString(1)+"</a></p></td>");
		// url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(6))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(7))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(8))+"</p></td>");
		out.println("</tr>");
	// 전체값 출력을 위한 부분(선택 안된 학번은 배경 그냥 출력)
	}else{
		out.println("<tr>");
		out.println("<td width=50><p align=center><a href='oneview.jsp?key="+rset.getString(1)+"'> "+rset.getString(1)+"</a></p></td>");
		// url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(6))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(7))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(8))+"</p></td>");
		out.println("</tr>");
	}
}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>