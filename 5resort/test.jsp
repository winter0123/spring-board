<%@ page contentType="text/html; charset=utf-8" %> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %> <%--주요 헤더파일(import, contentType 선언 등--%>
<!--현재시간 받아오기 위한 java.utill 과 text import-->
<%@ page import="java.util.*, java.text.*"  %>

<!doctype html>
<html lang="ko">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>LeeSORT / 예약시스템</title>
    <!-- meta tags 필요 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">

  </head>
  <body>
   <table class=table align=center table style = "font-size : 14px;width:800px;">
      <thead>
         <tr>
            <th>예약날짜</th>
            <th>VIP</th>
            <th>Deluxe</th>
            <th>Standard</th>
         </tr>
      </thead>
      <tbody>         
<% 
   request.setCharacterEncoding("UTF-8");
   
   String wdate = "";
   String vip = "";
   String nom = "";
   String poor = "";
   String[][] resv_arr=new String[30][5];
   
   Calendar cal = Calendar.getInstance();
   SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA);
   SimpleDateFormat df2 = new SimpleDateFormat("EEE",Locale.KOREA);
   
   Class.forName("com.mysql.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/sun","root","112233");
   Statement stmt = conn.createStatement();
   
   ResultSet rset = stmt.executeQuery("select resv_date, max(case when room=1 then name end) as vip, max(case when room=2 then name end) as nom, max(case when room=3 then name end) as poor from joaresv group by resv_date;");
   //룸이 1일 때 이름들을 갖고와서 이 중에서 맥스를 구하는 것. 맥스는 데이터 중복을 걸러서 합쳐서 보여준다.
   

   for (int i=0; i <30; i++){//배열 넣기
      resv_arr[i][0] = df.format(cal.getTime());
      resv_arr[i][1] = df2.format(cal.getTime());
      resv_arr[i][2] = "예약가능";
      resv_arr[i][3] = "예약가능";
      resv_arr[i][4] = "예약가능";
      cal.add(cal.DATE,+1);
   }   
      while(rset.next()){
         wdate = rset.getString(1);
         vip = rset.getString(2);
         nom = rset.getString(3);
         poor = rset.getString(4);
         
         if(vip==null){vip ="예약가능";}
         if(nom==null){nom ="예약가능";}
         if(poor==null){poor ="예약가능";}
         
         for(int i=0;i<resv_arr.length;i++){   //db의 이름을 배열에 넣어준다.
            if(resv_arr[i][0].equals(wdate)){
               resv_arr[i][2] = vip;
               resv_arr[i][3] = nom;
               resv_arr[i][4] = poor;
            }
         }
      }   
   stmt.close();
   conn.close();   
%>   
<%
   for (int i=0; i<resv_arr.length;i++){
         out.println("<tr><td>"+resv_arr[i][0]+" ("+resv_arr[i][1]+")</td>");
         if(resv_arr[i][2].equals("예약가능")){
         out.println("<td><a href='reservation_insert.jsp?resv_date="+resv_arr[i][0]+"&room=1'>"+resv_arr[i][2]+"</a></td>");
         }else{
         out.println("<td>"+resv_arr[i][2]+"</td>");
         }
         if(resv_arr[i][3].equals("예약가능")){
         out.println("<td><a href='reservation_insert.jsp?resv_date="+resv_arr[i][0]+"&room=2'>"+resv_arr[i][3]+"</a></td>");
         }else{
         out.println("<td>"+resv_arr[i][3]+"</td>");
         }
         if(resv_arr[i][4].equals("예약가능")){
         out.println("<td><a href='reservation_insert.jsp?resv_date="+resv_arr[i][0]+"&room=3'>"+resv_arr[i][4]+"</a></td></tr>");
         }else{
         out.println("<td>"+resv_arr[i][4]+"</td>");   
         }      
   }
%>

      </tbody>   
   </table>   
    <!-- Optional JavaScript -->
    <!-- 먼저 jQuery가 오고 그 다음 Popper.js 그 다음 Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  </body>
</html>
