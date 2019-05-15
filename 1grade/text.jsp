<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
if ( window.location == 'http://192.168.23.35:8081/jsp2' ) {
&nbsp; window.location.href='http://192.168.23.35:8081/jsp2/index.html';
}
</script>
</head>
<body>
<h1><center> JSP Database 실습 1(file 업로드 해서 하는 방법=)</center></h1>
<%
   String data;
   int cnt=0;
   
   FileReader f1 = new FileReader("/var/lib/tomcat8/webapps/ROOT/1grade/cnt.txt");
   StringBuffer sb = new StringBuffer();
   int ch = 0;
   while((ch = f1.read()) != -1){
   sb.append((char)ch);
   }
   data=sb.toString().trim().replace("\n","");
   f1.close();
   
   cnt=Integer.parseInt(data);
   cnt++;
   data=Integer.toString(cnt);
   out.println("<br><br><center>현재 홈페이지 방문조회수는 ["+data+"] 입니다</center></br>");
   
   FileWriter f12 = new FileWriter("/var/lib/tomcat8/webapps/ROOT/1grade/cnt.txt",false);
   f12.write(data);
   f12.close();
%>
</body>
</html>