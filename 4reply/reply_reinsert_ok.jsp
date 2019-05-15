<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<%
	request.setCharacterEncoding("euc-kr");

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");

	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = formatter.format(new java.util.Date());

	String eachnum = "";
	String eachtitle = request.getParameter("eachtitle");
	String eachcontent = request.getParameter("content");
	String originalnum = request.getParameter("originalnum");
	

		int rootid = 0;
		int relevel = 0;
		int recnt = 0;

		int vkey = Integer.parseInt(request.getParameter( "vkey" ));
		
		String sql = "SELECT rootid, relevel, recnt FROM reply WHERE id=" + vkey;
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			rootid = rs.getInt(1);
			relevel = rs.getInt(2);
			recnt = rs.getInt(3);
		}
		

		sql = "UPDATE reply SET recnt=recnt+1 where rootid="+rootid+" and recnt>"+recnt;
		stmt.executeUpdate(sql);
		
		
		Statement stmt1 = conn.createStatement();
		String sql1="";
		sql1 = "insert into reply(title, date, content, rootid, relevel, recnt, parent) values('[re]"+eachtitle+"', date(now()),'"+eachcontent+"',"+rootid+","+(relevel+1)+","+(recnt+1)+","+vkey+");";
		//조회수가 처음 클릭시 null이 떠서 처음 0값을 넣어줌, 답글 달시 제목들고오기때문에 [re]표시 넣어줌
		stmt1.execute(sql1);
		
		rs.close();
		stmt1.close();
		stmt.close();
		conn.close();
%>
  <script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="reply_list.jsp";
  </script>
</head>
<body>
</body>
</html>