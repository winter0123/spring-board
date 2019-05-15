<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>게시판 댓글</title>
<style>
@import url('https://fonts.googleapis.com/css?family=Hi+Melody');
.text_box {
font-family: 'Hi Melody', cursive;
font-size: 16px;
}
.text_box1 {
font-family: 'Hi Melody', cursive;
font-size: 40px;
}
a.no-uline { text-decoration:none }	<!--밑줄 없애기 위해 style안에 적어줌, 밑에 class로 불러서 씀 -->
</style>
</head>

<body>
<h1 class="text_box1" align=center>게시판 댓글</h1>
<table border=1 cellspacing=0 align=center style="margin-bottom:5px">
<tr class="text_box" style="background-color: #FEE8E2;">
	<td width=50 align=center>번호</td>
	<td width=400 align=center>제목</td>
	<td width=100 align=center>조회수</td>
	<td width=100 align=center>등록일</td>
</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = formatter.format(new java.util.Date());
	
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("SELECT id, title, date, relevel, viewcnt from reply order by rootid DESC, recnt ASC;"); //desc내림차순 asc오름차순

	String newid = "", newtitle="", newdate="", newhits="";
	
	while (rset.next()) {									//rset들고오기
	newid = Integer.toString(rset.getInt(1));				//번호
	newtitle = rset.getString(2);							//제목(공지사항1)
	newdate = rset.getString(3);							//date(2019-01-01)
	int newrelevel = rset.getInt(4);
	newhits = rset.getString(5);

%>
<form method="post" action="reply_view.jsp">
<tr class="text_box" style="background-color: #F8F2EF;">
	<td width=50 align=center><a href='reply_view.jsp?key=<%= newid %>'><%= newid %></td>
	<td width=400 align=left>
	<% 
		for(int j=0; j<newrelevel; j++){
			%>&nbsp;&nbsp;&nbsp;<%
		}
		if(newrelevel!=0){
			%><img src='image/replyimg.png' width=13 height=13><%
		}
	%> 
	<a href='reply_view.jsp?key=<%= newid %>' class="no-uline"><%= newtitle %></a>
	<!-- 밑줄없애기위해 위에 style에서  'a.no-uline { text-decoration:none }'넣어주고 밑에서 'class="no-uline"' 추가 -->
   <%if(today.equals(newdate)){%>
   <img src='image/new.png' width=33 height=14/>
   <%}%>   </td>
	<!--이름 클릭시 연결 링크 생성 = url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달 [key값, key1값 설정]-->
	<td width=100 align=center><%= newhits %></td>
	<td width=100 align=center><%= newdate %></td>
</tr>
</form>
<%
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<table width=650 border=0 cellspacing=0 align=center>
<form method="post" action="reply_insert.jsp">	<!--등록된 후보 추가 = A_03_H.JSP-->
		<tr>
			<td width=560 align=right><input type="submit"  value='신규' required></input></td>
			<!-- required 입력이 있어야만 버튼클릭 가능-->
		</tr>
</table>
</form>
</body>
</html>




