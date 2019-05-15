<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>개표결과</title>
</head>
<body text="#000000" link="#000000" vlink="#000000" alink="#000000">

<TABLE border=1 width=400 height=40 cellspacing=0>
<tr>
	<td align=center><a href="A_01_H.jsp" target="main"><b> 후보 등록</b></font><a></td>
	<td align=center><a href="B_01_H.jsp" target="main"><b>투표</b></font><a></td>
	<td align=center bgcolor=yellow><a href="C_01_H.jsp" target="main"><b>개표결과</b></font><a></td>
</tr>
</table>
후보 별 득표율

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from vote;");

%>
<table cellspacing=0 width=600 border=1>

<%
	//번호,이름 뽑기 위한 rset
	while (rset.next()) {
		String a = Integer.toString(rset.getInt(2));
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+a);	//기호번호 출력
		out.println("<a href='C_02_H.jsp?key="+rset.getString(4)+"&key1="+rset.getInt(2)+"'> "+rset.getString(4)+"</a></p></td>");	//이름 출력
		// 이름 클릭시 연결 링크 생성 = url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달 [key값, key1값 설정]
	
			// 각 투표수 들고오기 위한 rset1
			Statement stmt1 = conn.createStatement();
			ResultSet rset1 = stmt1.executeQuery("select count(*) from vote1 where votenum ="+a+";");
		
			rset1.next();
			int b = 0;
			b = rset1.getInt(1);		//각 기호번호별 투표수 합계
			
				// %값 구하기 위한 rset2
				Statement stmt2 = conn.createStatement();
				ResultSet rset2 = stmt2.executeQuery("select count(*) from vote1 where votenum;");
				
				rset2.next();
				int c = 0;
				c = rset2.getInt(1);	//전체 후보의 투표수 합계
				
				//토탈값 double화 해서 소수점자리 끌어올리기 
				double d = 0;
				d = (double)b/(double)c *100 *100 ;		//전체 투표중 차지하는 투표수 %값 구하는것 = 부분값*100/전체값
				
				//int화 시켜 3333 으로 소수점 뒤에 버리기 
				int d1 = 0;
				d1 = (int)d ;
				
				//double로 소수점 두번째까지 표현하기 
				double d2 = (double) d1 / 100;
				
				rset2.close();	
				stmt2.close();
				
			out.println("<td width=75><p align=left><img src='bar.jpg' width="+b*6+" height=20>"+b+"("+d2+"%)</p></td>");
			//막대그래프+득표수+득표% 출력
			//사진은 동일 파일안에 등록 후 '이름.속성'으로 불러와서 등록
			//b에 * 6해준건 막대 높이를 위해서, Math.round(a) = 반올림
			out.println("</tr>");

			rset1.close();	
			stmt1.close();
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>