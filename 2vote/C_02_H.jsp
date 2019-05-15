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
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String ckey = request.getParameter( "key" );	//앞에(C_01) key값(이름)을 받아옴
	String ckey1 = request.getParameter( "key1" );	//앞에(C_01) key1값(번호)을 받아옴

%>
<h1>[<%=ckey%>]후보 득표성향 분석</h1>
<table cellspacing=1 width=600 border=1>
<%	
	//득표자 나이를 10단위로 10~90살 까지 뽑기 때문에 for문을 1~9까지 돌림
	for(int a=1; a<10; a++){
		//후보자의 각 연령별 합계값을 알기 위한 rest값
		ResultSet rset = stmt.executeQuery("select count(*) from vote1 where votenum = '"+ckey1+"' and age="+a+";");
		rset.next();							//각 후보자의 연령대 별 표 수 조회(번호+나이(1~9)기준으로 조회)
		int f = rset.getInt(1);				//위 rset에서 후보의 나이별 득표수를 변수f에 저장
		
			//후보자 전체 득표수를 뽑기 위한 rset1
			Statement stmt1 = conn.createStatement();
			ResultSet rset1 = stmt.executeQuery("select count(*) from vote1 where votenum = '"+ckey1+"';");
			rset1.next();						//각 후보자가 받은 표의 합계 조회(번호기준으로 조회)
			
			int h = rset1.getInt(1);			//위의 rset1에서 전체 득표수를 가져오기 위한 변수
			double g = (double)f/(double)h*100*100;					//%값 구하는것 = 부분값*100/전체값
			
			//int화 시켜 3333 으로 소수점 뒤에 버리기 
			int g1 = 0;
			g1 = (int)g ;
				
			//double로 소수점 두번째까지 표현하기 
			double g2 = (double) g1 / 100;

			rset1.close();
			stmt1.close();
		
		out.println("<tr>");
		out.println("<td width=75><p align=center>"+a+"0대</p></td>");	//나이 출력
		out.println("<td width=500><p align=left><img src='bar.jpg' width="+f*6+" height=20> "+f+"("+g2+"%)</p></td>");
		//막대그래프+득표수+득표% 출력
		//사진은 동일 파일안에 등록 후 '이름.속성'으로 불러와서 등록
		//b에 * 6해준건 막대 높이를 위해서, Math.round(a) = 반올림
		out.println("</tr>");
	}
	stmt.close();
	conn.close();
%>
</body>
</html>