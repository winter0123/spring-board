<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>투표결과</title>
</head>
<body text="#000000" link="#000000" vlink="#000000" alink="#000000">

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from castle;");	//투표된 데이터 누적을 위해서 castle을 먼저 만든 후 castle선택

	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String today = formatter.format(new java.util.Date());	//예약일자
	
	request.setCharacterEncoding("UTF-8");					//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	
	//앞에서(d_02) 작성한 데이터를 받아옴
	String name = request.getParameter("name");				//이름
	String resvdate = request.getParameter("resvdate");	//예약일자
	String room = request.getParameter("room"); 			//예약방
	String addr = request.getParameter("addr"); 			//주소
	String telnum = request.getParameter("telnum"); 		//전화번호
	String in_name = request.getParameter("in_name"); 		//입금자명
	String comment = request.getParameter("comment"); 		//남기실말
	String processing = "1";								//현재진행(1=예약완료)
	
	stmt.execute("insert into castle (name,resv_date,room,addr,telnum,in_name,comment,write_date,processing) values ('" +
	name+"','"+resvdate+"',"+room+",'"+addr+"','"+telnum+"','"+
	in_name+"','"+comment+"','"+today+"',"+processing+");");
	
	out.println("예약되었습니다.");
	
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>