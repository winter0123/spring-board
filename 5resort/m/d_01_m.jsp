
<%@ page contentType="text/html; charset=utf-8" %> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %> <%--주요 헤더파일(import, contentType 선언 등--%>
<!--현재시간 받아오기 위한 java.utill 과 text import-->
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
   <title>조아펜션 / 예약시스템</title>
   
   <style type="text/css">
	@import url('https://fonts.googleapis.com/css?family=Noto+Serif+KR');
   .text_box5 {
	font-family: 'Noto Serif KR', serif;
	font-size: 14px;
	text-align: left;
	color: #ffffff;
	line-height:180%;
	padding-left:8px;
	padding-right:8px;
	}
   </style>
   
</head>
<body>
<% 

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	//룸이 1일 때 이름들을 갖고와서 이 중에서 맥스를 구하는 것. 맥스는 데이터 중복을 걸러서 합쳐서 보여준다.
	ResultSet rset = stmt.executeQuery("select resv_date, max(case when room=1 then name end) as vip, "+ 
                                     "max(case when room=2 then name end) as suite, max(case when room=3 then name end) as standard "+ 
									"from castle group by resv_date;");

	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA);
	SimpleDateFormat df2 = new SimpleDateFormat("EEE",Locale.KOREA);
   
	String newdate = "";
	String vip = "";
	String suite = "";
	String standard = "";
	String[][] resv_arr=new String[30][5];

	for (int i=0; i <30; i++){//배열 넣기
		resv_arr[i][0] = df.format(cal.getTime());
		resv_arr[i][1] = df2.format(cal.getTime());
		resv_arr[i][2] = "예약가능";
		resv_arr[i][3] = "예약가능";
		resv_arr[i][4] = "예약가능";
		cal.add(cal.DATE,+1);
	}	

	while(rset.next()){
	newdate = rset.getString(1);
	vip = rset.getString(2);
	suite = rset.getString(3);
	standard = rset.getString(4);
	
			if(vip==null){vip ="예약가능";}
			if(suite==null){suite ="예약가능";}
			if(standard==null){standard ="예약가능";}
			
			for(int i=0;i<resv_arr.length;i++){	//db의 이름을 배열에 넣어준다.
				 if(resv_arr[i][0].equals(newdate)){
					resv_arr[i][2] = vip;
					resv_arr[i][3] = suite;
					resv_arr[i][4] = standard;
				}
			}
		}	
	stmt.close();
	conn.close();	
%>
   <h1 style="color: #ffffff; padding-top:50px;"><center>예약상황</center></h1>
   <table align=center cellspacing=1 width="100%" border=1 class="text_box5">
   <tr>
      <td width="34%"><p align=center><b>예약날짜</b></p></td>
      <td width="22%"><p align=center><b>VIP Room</b></p></td>
      <td width="22%"><p align=center><b>Suite Room</b></p></td>
      <td width="22%"><p align=center><b>Standard Room</b></p></td>
   </tr> 
<%
	for (int i=0; i<resv_arr.length;i++){
			out.println("<tr align=center><td>"+resv_arr[i][0]+" ("+resv_arr[i][1]+")</td>");
			if(resv_arr[i][2].equals("예약가능")){
			out.println("<td><a href='d_02_m.jsp?key="+resv_arr[i][0]+"&room=1' style='color: #ffffff; text-decoration: none;'>"+resv_arr[i][2]+"</a></td>");
			}else{
			out.println("<td style='color: #ffff00;'>"+resv_arr[i][2]+"</td>");
			}
			if(resv_arr[i][3].equals("예약가능")){
			out.println("<td><a href='d_02_m.jsp?key="+resv_arr[i][0]+"&room=2' style='color: #ffffff; text-decoration: none;' >"+resv_arr[i][3]+"</a></td>");	
			}else{
			out.println("<td style='color: #ffff00;'>"+resv_arr[i][3]+"</td>");	
			}
			if(resv_arr[i][4].equals("예약가능")){
			out.println("<td><a href='d_02_m.jsp?key="+resv_arr[i][0]+"&room=3' style='color: #ffffff; text-decoration: none;'>"+resv_arr[i][4]+"</a></td></tr>");
			}else{
			out.println("<td style='color: #ffff00;'>"+resv_arr[i][4]+"</td>");	
			}		
	}
%>	
	</tr>
   </table>
</body>
</html>   
      