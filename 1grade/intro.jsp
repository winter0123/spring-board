<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>

<HTML>
<HEAD>
<title>첫페이지 방문자 수 표시</title>
</HEAD>
<BODY>
<h1><center>JSP Database 실습 1</center></h1>
   <%int status=1;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hd","root","1234");   
		PreparedStatement ps =con.prepareStatement("SELECT counter FROM hitscounter;");
		ResultSet rs =ps.executeQuery();	//쿼리문 돌려서 hitscounter테이블의 counter 선택
      
		while(rs.next()){
		status =rs.getInt(1);				//status값 저장

      }
      
	}catch(Exception e){					//에러있을시 에러문 출력
		System.out.println(e);
	}
    Integer Hits =(Integer)application.getAttribute("hitCounter");	//속성값을 받아와서 Hits에 저장
    
    Hits=status;
    status =Hits++;

    application.setAttribute("hitCounter", status);

   
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hd","root","1234");   
		PreparedStatement ps = con.prepareStatement("UPDATE hitscounter SET counter ="+Hits+";");
		status = ps.executeUpdate();
      
		if(status!=0){
		out.println("<div class='pageHits'>현재 홈페이지 방문조회수:"+ Hits +"</div>");	//방문자수 출력
		}
		con.close();
	%>
</BODY>
</HTML>   