<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>

<body>
<body text="#000000" link="#000000" vlink="#000000" alink="#000000">
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();

	ResultSet rset = stmt.executeQuery("select votenum from vote;");
	int add = 1;		//추가값
	int newvotenum = 0; //초기값
   
	newvotenum = add;	//초기값 = 추가값
   
	while(rset.next()) {
         if(rset.getInt(1) == newvotenum) {	//받아온 첫번째 기호번호가 ==초기값이라면(처음은1)
            newvotenum = newvotenum +1;		//초기값+1
         }
         else{ break; 						//받아온 첫번째 기호번호가 ==초기값이 아니라면 break
         }
	}
   
   String newvn1 = request.getParameter("newvotename");                          //jsp에서 jsp로 데이터 전송 시 한글 깨짐 처리 2줄
   String newvn2 = new String(newvn1.getBytes("8859_1"), "UTF-8");

	stmt.execute("insert into vote (turn, votenum, name, votename) values ('"+ 	//기존 세팅된 것에 맞춰서 양식 입력
		"기호번호 : ',"+
		newvotenum+",'"+														//기호번호 자동으로 받아오기
		"후보명 : ','"+
		newvn2 +"');");															//한글 표기 처리위해 위에서 받아옴
	
	rset.close();
	stmt.close();	
	conn.close();
%>
<h1>후보등록 추가완료</h1>
<TABLE border=1 width=400 height=40 cellspacing=0>
	<tr>
		<td align=center bgcolor=yellow><a href="A_01_H.jsp" target="main"><b> 후보 등록</b></font><a></td>
		<td align=center><a href="B_01_H.jsp" target="main"><b>투표</b></font><a></td>
		<td align=center><a href="C_01_H.jsp" target="main"><b>개표결과</b></font><a></td>
	</tr>
	<tr>
		<td width=100 align=center colspan="3">후보등록 결과 : 후보추가 되었습니다</td>
	</tr>
</table>
</body>
</html>