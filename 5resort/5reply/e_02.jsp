<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<!-- 4page(reply)에서 list만 들고옴. 모든 처리는 4reply에서 돌게됨 -->
<title>게시판 댓글</title>
<%
	//페이징 위한 부분 :시작
   String bgn = request.getParameter("bgn");
   String cnt = request.getParameter("cnt");

   if (bgn == null) {  // 입력 값이 없으면 (기본 페이지)
      bgn="1";  // 1부터 보여주기
   }
   if (cnt == null) {  // 입력 값이 없으면 (기본 페이지)
      cnt="10"; 
   }

   int index = Integer.parseInt(bgn); // 문자열 값을 int값으로 변환, 시작번호 
   int cntperpage = Integer.parseInt(cnt);  //페이지당 출력 수 
   
   if (index <= 0) {  // 시작 번호가 음수이면
      index = 1;  // 1부터 시작
   }
   if (cntperpage <= 0) {   // 시작 번호가 음수이면
      cntperpage = 10;   // 5로 초기화 
   }
   //페이징 위한 부분 :끝
%>
<style type="text/css"><!-- 페이징 위한 부분:시작 -->
a.no-uline {
text-decoration:none
}

a.no-uline:hover {
text-decoration:underline;
}

a.active{
color:green;
}
</style><!-- 페이징 위한 부분:끝 -->
<style>
@import url('https://fonts.googleapis.com/css?family=Noto+Serif+KR');
.text_box {
font-family: 'Noto Serif KR', serif;
font-size: 14px;
}
.text_box1 {
font-family: 'Noto Serif KR', serif;
font-size: 40px;
}
a.no-uline { text-decoration:none }	<!--밑줄 없애기 위해 style안에 적어줌, 밑에 class로 불러서 씀 -->
</style>
</head>

<body>
<h1 class="text_box1" align=center>Reviews</h1>
<table border=1 cellspacing=0 align=center style="margin-bottom:5px">
<tr class="text_box" style="background-color: #CCCCCC;">
	<td width=50 align=center><b>번호</b></td>
	<td width=400 align=center><b>제목</b></td>
	<td width=100 align=center><b>조회수</b></td>
	<td width=100 align=center><b>등록일</b></td>
</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = formatter.format(new java.util.Date());
	
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("SELECT id, title, date, relevel, viewcnt from 5reply order by rootid DESC, recnt ASC;"); //desc내림차순 asc오름차순
	
	
	//페이징 위한 부분 :시작
	Statement stmt2 = conn.createStatement();
	ResultSet rset1 = stmt2.executeQuery("select * from 5reply;");
	
	int LineCnt = 0;  // 줄 수
    int pages = 0;  // 총 페이지 수
    int count = 0;  // 총 레코드 수(필드명을 포함한 데이터 줄)

    while (rset1.next()) {  // 읽은 줄이 null이 아니면
       count++;  // 줄 수, 페이징을 위해선 총 레코드 수가 필요하다 
    }
   
   if ((count) % cntperpage == 0) {  // 데이터 수(count)가 페이지당 출력 수로 나누어 떨어지면
      pages = (count) / cntperpage;  // 페이지 수는 데이터 수를 페이지당 출력 수로 나눈 값
   }
   else {  // 데이터 수가 페이지당 출력 수로 나누어 떨어지지 않으면, 나머지가 있다는 뜻이고 다음 페이지로 넘기기 위해 
      pages = ((count) / cntperpage) + 1;      // 페이지 수는 데이터 수를 페이지당 출력 수로 나눈 값 + 1
   }
   
   int LineCnt_break=0; 
	
    while (rset1.next()) {  // 읽은 줄이 null이 아니면
       LineCnt_break++;   // 데이터 수
    }
    int totalRecords= LineCnt_break-cntperpage;
	//페이징 위한 부분 :끝
	
	String newid = "", newtitle="", newdate="", newhits="";
	
	while (rset.next()) {									//rset들고오기
	newid = Integer.toString(rset.getInt(1));				//번호
	newtitle = rset.getString(2);							//제목(공지사항1)
	newdate = rset.getString(3);							//date(2019-01-01)
	int newrelevel = rset.getInt(4);
	newhits = rset.getString(5);
	
	//페이징 위한 부분 :시작
	LineCnt++;  // 줄 수 + 1
        if (LineCnt < index) continue;  // 번호가 지정한 시작 번호보다 작으면 통과
        if (LineCnt > index + cntperpage - 1) break;  // 번호가 마지막 번호보다 크면 끝내기
	//페이징 위한 부분 :끝
%>
<form method="post" action="5reply_view.jsp">
<tr class="text_box" style="background-color: #ffffff;">
	<td width=50 align=center><a href='5reply_view.jsp?key=<%= newid %>'><%= newid %></td>
	<td width=400 align=left>
	<% 
		for(int j=0; j<newrelevel; j++){
			%>&nbsp;&nbsp;&nbsp;<%
		}
		if(newrelevel!=0){
			%><img src='replyimg.png' width=13 height=13><%
		}
	%> 
	<a href='5reply_view.jsp?key=<%= newid %>' class="no-uline"><%= newtitle %></a>
	<!-- 밑줄없애기위해 위에 style에서  'a.no-uline { text-decoration:none }'넣어주고 밑에서 'class="no-uline"' 추가 -->
   <%if(today.equals(newdate)){%>
   <img src='new.png' width=33 height=14/>
   <%}%>   </td>
	<!--이름 클릭시 연결 링크 생성 = url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달 [key값, key1값 설정]-->
	<td width=100 align=center><%= newhits %></td>
	<td width=100 align=center><%= newdate %></td>
</tr>
</form>
<%
	}
	rset1.close();
	 stmt2.close();
	
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<table width=650 border=0 cellspacing=0 align=center>
<form method="post" action="5reply_insert.jsp">	<!--등록된 후보 추가 = A_03_H.JSP-->
		<tr>
			<td width=560 align=right><input type="submit"  value='신규' required></input></td>
			<!-- required 입력이 있어야만 버튼클릭 가능-->
		</tr>
</table>
</form>

<!-- 페이징 위한 부분:시작 -->
<table align=center cellspacing=0 width=600 border=0 >
<%
int bgnindex = 1;  // 숫자 1
int x;  // 10페이지씩 보여주고 다음 열 페이지로 넘어가기 위해 만든 변수
if (index%cntperpage==0){
   x = (index)/cntperpage/10;   // 페이지당 5개씩 나오게 했을 때 10페이지에서 11로 넘어가기 때문에 하는 것
} else {
   x = index/cntperpage/10;  // 페이지에 나오는 첫 번호를 페이지당 개수로 나누고 10으로 나누면 (예를 들어 10개씩 했을 때 처음 번호가 21번이면
                       // 21/10 = 2.1이고 2.1/10=0.21 이라서 정수형으로 계산하면 0이 됨. 1에서 10페이지 처음 번호는 0이 되고,
                       // 11부터 20페이지부터는 100번대라서 1이 됨. 0에서 1로 넘어가는 걸로 페이지 전환)
}
   out.println("<tr>");
   out.println("<td align=center colspan=5>");  // 테이블
   
   out.println("<a href=\"e_02.jsp?bgn=1&cnt=" + cntperpage + "\" class=\"no-uline\"> << </a>");  // 첫 페이지로 가기
   out.println("<a href=\"e_02.jsp?bgn=" + (index - cntperpage) + "&cnt=" + cntperpage + "\"  class=\"no-uline\"> < </a>");   // 바로 전 페이지로 가기
   
   int currentpage;  // 현재 페이지
   double currentind = (double) index;  // 현재 페이지 시작 번호
   if (currentind / cntperpage > 0) {  // 현재 페이지 시작 번호를 페이지당 출력 수로 나누어 떨어지지 않으면
         currentpage = (int) (currentind / cntperpage) + 1;  // 현재 페이지는 시작번호를 페이지당 출력 수로 나눈 값에 1을 더함
   } else {  // 현재 페이지 시작 번호를 페이지당 출력 수로 나누어 떨어지면
         currentpage = (int) (currentind / cntperpage);  // 현재 페이지는 시작번호를 페이지당 출력 수로 나눈 값
   }

   for (int i = 1; i <= 10; i++) {
      
      if (i == currentpage) {  // 현재 페이지이면
         out.println("<a href=\"e_02.jsp?bgn=" + (cntperpage*10*x+bgnindex) + "&cnt=" + cntperpage + "\"  class=\"active\"> " + i + "</a>");
         // style에서 정의한 active 클래스로 색 표시
         
      } else {  // 다른 페이지는
         out.println("<a href=\"e_02.jsp?bgn=" + (cntperpage*10*x+bgnindex) + "&cnt=" + cntperpage + "\"  class=\"no-uline\"> " + i + " </a>");
         // 일반
      }
      // 열 번째 페이지를 누르면 다음 열 페이지로 넘어가기 (1-10페이지에서 10을 누르면 11-20페이지를 보여줌)
      // 10개씩 했을 때 1부터 10페이지까지는 시작 번호가 100 이하, 11부터 20페이지까지는 시작 번호가 100번대라서
      // 다음 페이지는 시작 번호를 페이지당 출력 수와 10으로 나눈 x에 다시 그 값을 곱해서 원래대로 시작 번호로 만들고 거기에 1을 더한 수부터 시작함
      bgnindex += cntperpage;  // 페이지당 출력 수를 더함
       if (i == pages) {
         break; 
      } 
   }

        if (currentpage == pages) {
   out.println("<a href=\"e_02.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");

   out.println("<a href=\"e_02.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
   }
   else {
   out.println("<a href=\"e_02.jsp?bgn=" + (index + cntperpage) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");

   out.println("<a href=\"e_02.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
   }
   // 마지막 페이지로 가기
   out.println("</td>");
   out.println("</tr>");
%> <!-- 페이징 위한 부분:끝 -->
</body>
</html>