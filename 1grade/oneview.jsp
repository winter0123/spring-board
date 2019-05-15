<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>전체보기></title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String ckey = request.getParameter( "key" );	//Alview에서 이름 출력시 준 key값을 받아와서 ckey라고 변수 설정
	
	ResultSet rset = stmt.executeQuery("select * ,(kor+eng+mat) as 총점,((kor+eng+mat)/3) as 평균,(select count(*)+1 from examtable2 " +
                                      "where (kor+eng+mat) > (b.kor + b.eng + b.mat)) as 등수 from examtable2 b where name = '"+ckey+"';");
									  //ckey값이 이름인 사람 데이 조회 (뒤에 총점, 평균, 등수 추가)
									  //등수 확인 방법 = select 구문 돌릴때 현재 테이블과 똑같은 테이블b를 만든 뒤 현재 점수보다 더 높은 점수를 가진 것의 숫자를 샌 뒤+1 
%>
<h1>[<%=ckey%>]조회</h1> <!-- 받아온 ckey값 사용해서 이름 자동으로 넣어줌 -->
<table cellspacing=1 width=600 border=1>
<%
		//표 첫줄 필드명 출력
		out.println("<tr>");
		out.println("<td align=center>"+"이름"+"</td>");
		out.println("<td align=center>"+"학번"+"</td>");
		out.println("<td align=center>"+"국어"+"</td>");
		out.println("<td align=center>"+"영어"+"</td>");
		out.println("<td align=center>"+"수학"+"</td>");
		out.println("<td align=center>"+"총점"+"</td>");
		out.println("<td align=center>"+"평균"+"</td>");
		out.println("<td align=center>"+"등수"+"</td>");
		out.println("</tr>");
	
	//표 내용 출력 (1명 이름으로 조회 후 출력이라서 while문 안써도 됨
	 rset.next();
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");					//이름
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");	//학번
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");	//국어
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");	//영어
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");	//수학
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(6))+"</p></td>");	//총점
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(7))+"</p></td>");	//평균
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(8))+"</p></td>");	//등수
		out.println("</tr>");
	
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>