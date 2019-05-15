<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.* ,java.text.* , java.util.*"%>
<html>
<head>
<title>입력중</title>
<%
	request.setCharacterEncoding("UTF-8");
	
	String name = request.getParameter("name");//고객이름
	String resv_date = request.getParameter("resv_date");//예약 날짜
	String room = request.getParameter("room");//예약 방 번호
	String telnum = request.getParameter("telnum");//연락처
	String in_name = request.getParameter("in_name");//입금자명
	String comment = request.getParameter("comment");//추가사항
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	df.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
	String today = df.format(new java.util.Date());//현재 날짜
try{	
	// DB
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/dbtest","root","pjh8134");
	Statement stmt = conn.createStatement();

	stmt.execute("insert into resortbook(name, resv_date, room, telnum, in_name, comment,write_date, processing) values('"+name+"','"+resv_date+"',"+room+",'"+telnum+"','"+in_name+"','"+comment+"','"+today+"',0);");
	stmt.close();
	conn.close();
	
}catch(SQLException e){//중복된 값이 입력될 경우 튕겨낸다.
out.println("<script>alert('날짜와 방 종류를 확인해 주세요');</script>");

}	
	
	//response.sendRedirect("d_01.jsp");
	
	
%>
</head>
<body>
<script language="javascript">
	location.href="d_01.jsp";
</script>
</body>
</html>