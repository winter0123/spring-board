<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-한글처리를 위해서다.->
<%@page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%> <%--주요 헤더파일(import, contentType 선언 등--%>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<html>
<head>
<title>재고수정</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String todayup = formatter.format(new java.util.Date());
		
		request.setCharacterEncoding("UTF-8");									//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
		String hanid0 = request.getParameter("eachid0"); 						//jeago_update.jsp에서 받아오는 부분
		String hannowproductnum0 = request.getParameter("eachnowproductnum0"); 	
																	// 그외에는 (재고 수정)
		stmt.execute("update jeago set " +										// gongji_update에서 받아온 값으로 구문 돌아감
		"nowproductnum = "+hannowproductnum0+", "+
		"firstpdate = '"+todayup+"'"+
		"where id = "+ hanid0 +";");
	
	stmt.close();
	conn.close();
%>
</head>
<body>
<script>
    alert("상품등록이 완료 되었습니다.");
    window.location.href="jeago_list.jsp";
</script>
</body>
</html>