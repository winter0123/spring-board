<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" errorPage="04error.jsp" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title> 전체조회 </title>
<%
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
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * ,(kor+eng+mat) as 총점,((kor+eng+mat)/3) as 평균,(select count(*)+1 from examtable2 " +
                                      "where (kor+eng+mat) > (b.kor + b.eng + b.mat)) as 등수 from examtable2 b;");
									  //(필드명+필드명) as 가가 = 좌측과 같은 방법으로 새로운 필드(가가) 추가 가능. as 뒤에는 새로운 필드명 입력
									  //(kor+eng+mat) as 총점
									  //((kor+eng+mat)/3) as 평균
									  //등수 확인 방법 = select 구문 돌릴때 현재 테이블과 똑같은 테이블b를 만든 뒤 현재 점수보다 더 높은 점수를 가진 것의 숫자를 샌 뒤+1 
									  
	Statement stmt2 = conn.createStatement();
	ResultSet rset1 = stmt2.executeQuery("select * from examtable2;");
	
    Statement stmt3 = conn.createStatement();
    ResultSet rset2 = stmt3.executeQuery("select * from examtable2;");
	
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
<table align=left cellspacing=1 width=600 border=1>
<%
		//첫줄 필드명 출력
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
		
	int LineCnt_break=0; 
	
    while (rset1.next()) {  // 읽은 줄이 null이 아니면
       LineCnt_break++;   // 데이터 수
    }
    int totalRecords= LineCnt_break-cntperpage;
		
	while (rset.next()) {
		
		LineCnt++;  // 줄 수 + 1
        if (LineCnt < index) continue;  // 번호가 지정한 시작 번호보다 작으면 통과
        if (LineCnt > index + cntperpage - 1) break;  // 번호가 마지막 번호보다 크면 끝내기
		
		//데이터 내용 출력
		out.println("<tr>");
		out.println("<td width=50><p align=center><a href='oneview.jsp?key="+rset.getString(1)+"'> "+rset.getString(1)+"</a></p></td>");//이름
		// url(웹주소) 뒤에 “?”를 표기하고 “이름=값” 형식으로 전달
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");	//학번
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");	//국어
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");	//영어
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");	//수학
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(6))+"</p></td>");	//총점
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(7))+"</p></td>");	//평균
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(8))+"</p></td>");	//등수
		out.println("</tr>");
	}
	  stmt3.close();
	  rset2.close();
	  
      rset1.close();
	  stmt2.close();
	  
	  rset.close();
      stmt.close();
      conn.close();
%>
</table>
<table align=left cellspacing=0 width=600 border=0 >
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
   
   out.println("<a href=\"AllviewDB.jsp?bgn=1&cnt=" + cntperpage + "\" class=\"no-uline\"> << </a>");  // 첫 페이지로 가기
   out.println("<a href=\"AllviewDB.jsp?bgn=" + (index - cntperpage) + "&cnt=" + cntperpage + "\"  class=\"no-uline\"> < </a>");   // 바로 전 페이지로 가기
   
   int currentpage;  // 현재 페이지
   double currentind = (double) index;  // 현재 페이지 시작 번호
   if (currentind / cntperpage > 0) {  // 현재 페이지 시작 번호를 페이지당 출력 수로 나누어 떨어지지 않으면
         currentpage = (int) (currentind / cntperpage) + 1;  // 현재 페이지는 시작번호를 페이지당 출력 수로 나눈 값에 1을 더함
   } else {  // 현재 페이지 시작 번호를 페이지당 출력 수로 나누어 떨어지면
         currentpage = (int) (currentind / cntperpage);  // 현재 페이지는 시작번호를 페이지당 출력 수로 나눈 값
   }

   for (int i = 1; i <= 10; i++) {
      
      if (i == currentpage) {  // 현재 페이지이면
         out.println("<a href=\"AllviewDB.jsp?bgn=" + (cntperpage*10*x+bgnindex) + "&cnt=" + cntperpage + "\"  class=\"active\"> " + i + "</a>");
         // style에서 정의한 active 클래스로 색 표시
         
      } else {  // 다른 페이지는
         out.println("<a href=\"AllviewDB.jsp?bgn=" + (cntperpage*10*x+bgnindex) + "&cnt=" + cntperpage + "\"  class=\"no-uline\"> " + i + " </a>");
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
   out.println("<a href=\"AllviewDB.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");

   out.println("<a href=\"AllviewDB.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
   }
   else {
   out.println("<a href=\"AllviewDB.jsp?bgn=" + (index + cntperpage) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");

   out.println("<a href=\"AllviewDB.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
   }
   // 마지막 페이지로 가기
   out.println("</td>");
   out.println("</tr>");
%> 
</table>
</body>
</html>