<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>


<%
   String bgn = request.getParameter("bgn");  // 시작 번호
   if (bgn == null) {  // 입력 값이 없으면 (기본 페이지)
      bgn="1";  // 1부터 보여주기
   }
   int index = Integer.parseInt(bgn);  // 시작 번호
   if (index <= 0) {  // 시작 번호가 음수이면
      index = 1;  // 1부터 시작
   }
   
   
   String cnt = request.getParameter("cnt");  
   if (cnt == null) {  
      cnt="10";  
   }
   int cntperpage = Integer.parseInt(cnt);
   if (cntperpage <= 0) {  
      cntperpage = 10;  
   }
   
%>
<html>
<head>
   <title> 무료 와이파이 정보 보기 </title>
   
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
File f = new File("/var/lib/tomcat8/webapps/ROOT/jsp/wifi.txt");  // 파일 불러오기
BufferedReader br = new BufferedReader(new FileReader(f));  // 파일 읽기

int LineCnt = 0;  // 줄 수
int pages = 0;  // 총 페이지 수
int end = 0;  // 마지막 페이지


double lat = 37.3860521;
double lng = 127.1214038;

String readtxt;  // 읽은 줄

int count = 0;  // 총 줄 수(필드명을 포함한 데이터 줄)

while ((readtxt=br.readLine())!=null) {  // 읽은 줄이 null이 아니면
   count++;  // 줄 수
}
br.close();  // 읽기 닫기


if ((count - 1) % cntperpage == 0) {  // 데이터 수가 페이지당 출력 수로 나누어 떨어지면
   pages = (count - 1) / cntperpage;  // 페이지 수는 데이터 수를 페이지당 출력 수로 나눈 값
}
else {  // 데이터 수가 페이지당 출력 수로 나누어 떨어지지 않으면
   pages = (count - 1) / cntperpage + 1;  // 페이지 수는 데이터 수를 페이지당 출력 수로 나눈 값 + 1
}


%>
<h3 align="center">무료 와이파이 </h3>
<table border = 1 cellspacing=0 align=center width=900 style="table-layout:fixed"> 
   <tr>
      <td width=50 align="center"> 번호 </td>
      <td width=450 align="center"> 주소 </td>
      <td width=100 align="center"> 위도 </td>
      <td width=100 align="center"> 경도 </td>
      <td width=200 align="center"> 현재 위치로부터의 거리 </td>
   </tr>

<%
BufferedReader br2 = new BufferedReader(new FileReader(f));  // 파일 읽기

if ((readtxt=br2.readLine())==null) {  // 읽은 줄이 null이면
   out.println("빈 파일입니다.");
   return;
}

BufferedReader br_break = new BufferedReader(new FileReader(f));  // 파일 읽기
String readtxt_break;  // 뒤에 마지막 페이지 설정을 위해 만든 변수
int LineCnt_break=0; 
while((readtxt_break = br_break.readLine()) != null) {
   LineCnt_break++;  // 데이터 수
}
int totalRecords= LineCnt_break-cntperpage;  // 데이터 수에서 페이지당 출력 수를 뺀 값
// 마지막 페이지의 시작 번호, 마지막 페이지로 가기 위해 만든 변수
br_break.close();  // 읽기 닫기

String [] field_name = readtxt.split("\t");  // 첫 줄은 필드명
while ((readtxt=br2.readLine())!=null) {  // 읽은 줄이 null이 아니면
   
   
   String [] field = readtxt.split("\t");  // 탭을 구분자로 쪼개기, 필드
   
   LineCnt++;  // 줄 수 + 1
   if (LineCnt < index) continue;  // 번호가 지정한 시작 번호보다 작으면 통과
   if (LineCnt > index + cntperpage - 1) break;  // 번호가 마지막 번호보다 크면 끝내기
   
   double dist = Math.sqrt(Math.pow(Double.parseDouble(field[12]) - lat, 2)
            + Math.pow(Double.parseDouble(field[13]) - lng, 2));
   
   out.println("<tr>");
   out.println("<td>" + LineCnt + "</td>");
   out.println("<td>" + field[9] + "</td>");
   out.println("<td>" + field[12] + "</td>");
   out.println("<td>" + field[13] + "</td>");
   out.println("<td>" + dist + "</td>");
   out.println("</tr>");
   
}
%>
</table> 
<%

int currentpage;
if (index % cntperpage == 0) {
   currentpage = index / cntperpage;
}
else {
   currentpage = index / cntperpage + 1;
}

%>


<table align=center> 
<tr>
<td>


<%
int first = 1;

if ((index / cntperpage) >= first + 9) {
   first = (index / cntperpage) / 10 * 10 + 1;
}


out.println("<a href=\"wifi.jsp?bgn=1&cnt=" + cntperpage + "\" class=\"no-uline\"> << </a>"); 


out.println("<a href=\"wifi.jsp?bgn=" + (index - cntperpage) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> < </a>");

for (int i = first; i < first + 10; i++) {
   if (i == currentpage) {
         out.println("<a href=\"wifi.jsp?bgn=" + ((i - 1) * cntperpage + 1) + "&cnt=" + cntperpage + "\" class=\"active\"> " + i + "</a>");
   }
   else {
      out.println("<a href=\"wifi.jsp?bgn=" + ((i - 1) * cntperpage + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> " + i + "</a>");
   }
   
   
   if (i == pages) {
      break;
   }
   
}

if (currentpage == pages) {
   out.println("<a href=\"wifi.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");
   
   out.println("<a href=\"wifi.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
}
else {
   out.println("<a href=\"wifi.jsp?bgn=" + (index + cntperpage) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> > </a>");
   
   out.println("<a href=\"wifi.jsp?bgn=" + (cntperpage * (pages - 1) + 1) + "&cnt=" + cntperpage + "\" class=\"no-uline\"> >> </a>");
}

%>


</tr>
</td>
</table>

</body>
</html>