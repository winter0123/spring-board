<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8" %> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %> <%--주요 헤더파일(import, contentType 선언 등--%>
<%	//로그인(Authority)가 있는 데이터 xml조회를 만들기(2)

	//로그인 체크
	String thispage = "loginxml.jsp";
	String login_url="login.jsp?rtn_url="+thispage;
	
	String loginVal= (String) session.getAttribute("loginOK");
	if( loginVal == null || !loginVal.equals("YES") )
		response.sendRedirect(login_url);	//로그인 필요
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery("select * from examtable;");
	out.println("<datas>");
	
	while (rset.next()) {
		out.println("<data>");
		out.println("<name>"+rset.getString(1)+"</name>");
		out.println("<studentid>"+Integer.toString(rset.getInt(2))+"</studentid>");
		out.println("<kor>"+rset.getString(3)+"</kor>");
		out.println("<eng>"+rset.getString(3)+"</eng>");
		out.println("<mat>"+rset.getString(3)+"</mat>");
		out.println("</data>");
	}
	out.println("</datas>");
	stmt.close();
	conn.close();
%>
