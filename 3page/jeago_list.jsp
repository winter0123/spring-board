<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<html>
<head>
<title>식료품 재고현황-전체현황</title>
<%
   String bgn = request.getParameter("bgn");
   String cnt = request.getParameter("cnt");

   if (bgn == null) {  // 입력 값이 없으면 (기본 페이지)
      bgn="1";  // 1부터 보여주기
   }
   if (cnt == null) {  // 입력 값이 없으면 (기본 페이지)
      cnt="20"; 
   }

   int index = Integer.parseInt(bgn); // 문자열 값을 int값으로 변환, 시작번호 
   int cntperpage = Integer.parseInt(cnt);  //페이지당 출력 수 
   
   if (index <= 0) {  // 시작 번호가 음수이면
      index = 1;  // 1부터 시작
   }
   if (cntperpage <= 0) {   // 시작 번호가 음수이면
      cntperpage = 20;   // 5로 초기화 
   }
   
%>
<style type="text/css">
a.no-uline {
text-decoration:none
}

a.no-uline:hover {
text-decoration:underline;
}

a.active{
color:green;
}
</style>
</head>
<body>
<h1 align=center>식료품 재고현황-전체현황</title></h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from jeago;");	//테이블 지정
	
	Statement stmt2 = conn.createStatement();
	ResultSet rset1 = stmt2.executeQuery("select * from jeago;");
	
    Statement stmt3 = conn.createStatement();
    ResultSet rset2 = stmt3.executeQuery("select * from jeago;");
	
	
	int LineCnt = 0;  // 줄 수
    int pages = 0;  // 총 페이지 수
    int count = 0;  // 총 레코드 수(필드명을 포함한 데이터 줄)

    while (rset2.next()) {  // 읽은 줄이 null이 아니면
       count++;  // 줄 수, 페이징을 위해선 총 레코드 수가 필요하다 
    }

   if ((count) % cntperpage == 0) {  // 데이터 수(count)가 페이지당 출력 수로 나누어 떨어지면
      pages = (count) / cntperpage;  // 페이지 수는 데이터 수를 페이지당 출력 수로 나눈 값
   }
   else {  // 데이터 수가 페이지당 출력 수로 나누어 떨어지지 않으면, 나머지가 있다는 뜻이고 다음 페이지로 넘기기 위해 
      pages = ((count) / cntperpage) + 1;      // 페이지 수는 데이터 수를 페이지당 출력 수로 나눈 값 + 1
   }	
%>
<table align=center border=1 cellspacing=0>
<form method="post" action="jeago_view.jsp">
<tr>
	<td width=100 align=left>상품번호</td>
	<td width=140 align=left>상품명</td>
	<td width=120 align=left>현재 재고수</td>
	<td width=120 align=left>상품등록일</td>
	<td width=120 align=left>재고파악일</td>
</tr>
<%
	int LineCnt_break=0; 
	
    while (rset1.next()) {  // 읽은 줄이 null이 아니면
       LineCnt_break++;   // 데이터 수
    }
    int totalRecords= LineCnt_break-cntperpage;
		
	while (rset.next()) {
		
		LineCnt++;  // 줄 수 + 1
        if (LineCnt < index) continue;  // 번호가 지정한 시작 번호보다 작으면 통과
        if (LineCnt > index + cntperpage - 1) break;  // 번호가 마지막 번호보다 크면 끝내기

%>
<tr>
	<td width=100 align=left><a href='jeago_view.jsp?keyz=<%= Integer.toString(rset.getInt(1)) %>'><%= Integer.toString(rset.getInt(1)) %></a></td>
	<td width=140 align=left><a href='jeago_view.jsp?keyz=<%= Integer.toString(rset.getInt(1)) %>'><%= rset.getString(2) %></a></td>
	<!--이름 클릭시 연결 링크 생성 = url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달 [key값, key1값 설정]-->
	<td width=120 align=left><%= Integer.toString(rset.getInt(3)) %></td>
	<td width=120 align=left><%= rset.getString(4) %></td>
	<td width=120 align=left><%= rset.getString(5) %></td>
</tr>
<%
	}
	  stmt3.close();
	  rset2.close();
	  
      rset1.close();
	  stmt2.close();
	  
	  rset.close();
      stmt.close();
      conn.close();
%>
</form>
</table>
<table align=center cellspacing=0 width=600 border=0 >
<%
int bgnindex = 1;  // 숫자 1
int x;  // 10페이지씩 보여주고 다음 열 페이지로 넘어가기 위해 만든 변수
if (index%cntperpage==0){
   x = (index)/cntperpage/20;   // 페이지당 5개씩 나오게 했을 때 10페이지에서 11로 넘어가기 때문에 하는 것
} else {
   x = index/cntperpage/20;  // 페이지에 나오는 첫 번호를 페이지당 개수로 나누고 10으로 나누면 (예를 들어 10개씩 했을 때 처음 번호가 21번이면
                       // 21/10 = 2.1이고 2.1/10=0.21 이라서 정수형으로 계산하면 0이 됨. 1에서 10페이지 처음 번호는 0이 되고,
                       // 11부터 20페이지부터는 100번대라서 1이 됨. 0에서 1로 넘어가는 걸로 페이지 전환)
}
   out.println("<tr>");
   out.println("<td align=center colspan=5>");  // 테이블
   
   out.println("<a href=\"jeago_list.jsp?bgn=1&cnt=" + cntperpage + "\" class=\"no-uline\"> << </a>");  // 첫 페이지로 가기
   out.println("<a href=\"jeago_list.jsp?bgn=" + (index - cntperpage) + "&cnt=" + cntperpage + "\"  class=\"no-uline\"> < </a>");   // 바로 전 페이지로 가기
   
   int currentpage;  // 현재 페이지
   double currentind = (double) index;  // 현재 페이지 시작 번호
   if (currentind / cntperpage > 0) {  // 현재 페이지 시작 번호를 페이지당 출력 수로 나누어 떨어지지 않으면
         currentpage = (int) (currentind / cntperpage) + 1;  // 현재 페이지는 시작번호를 페이지당 출력 수로 나눈 값에 1을 더함
   } else {  // 현재 페이지 시작 번호를 페이지당 출력 수로 나누어 떨어지면
         currentpage = (int) (currentind / cntperpage);  // 현재 페이지는 시작번호를 페이지당 출력 수로 나눈 값
   }

   for (int i = 1; i <= 20; i++) {
      
      if (i == currentpage) {  // 현재 페이지이면
         out.println("<a href=\"jeago_list.jsp?bgn=" + (cntperpage*10*x+bgnindex) + "&cnt=" + cntperpage + "\"  class=\"active\"> " + i + "</a>");
         // style에서 정의한 active 클래스로 색 표시
         
      } else {  // 다른 페이지는
         out.println("<a href=\"jeago_list.jsp?bgn=" + (cntperpage*10*x+bgnindex) + "&cnt=" + cntperpage + "\"  class=\"no-uline\"> " + i + " </a>");
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
   out.println("<a href=\"jeago_list.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");

   out.println("<a href=\"jeago_list.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
   }
   else {
   out.println("<a href=\"jeago_list.jsp?bgn=" + (index + cntperpage) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");

   out.println("<a href=\"jeago_list.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
   }
   
   out.println("</td>");
   out.println("</tr>");
%> 
</table>
<table width=600 align=center border=0 cellspacing=0>
<form method="post" action="jeago_insert.jsp">	<!--등록된 후보 추가 = A_03_H.JSP-->
		<tr>
			<td width=560 align=right><input type="submit"  value='신규등록' required></input></td> <!-- required 입력이 있어야만 버튼클릭 가능-->
		</tr>
</form>
</table>
</body>
</html>