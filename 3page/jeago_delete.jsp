<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글삭제</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");							//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	String number2 = request.getParameter("eachid");				//번호를 받아옴
	String name2 = request.getParameter("eachproductname");			//이름을 받아옴
	
	
	String sql="delete from jeago where id = " + number2;			//받아온 번호로 mysql에 delete 삭제문 돌림
		
	stmt.executeUpdate( sql );										//삭제문 실행
	
	ResultSet rset = stmt.executeQuery("select*from jeago;");		//삭제후 업데이된 데이터 출력을 위해 다시 examtable2 선택
	
%>
</head>
<body>
<form method="post" action="jeago_list.jsp">

	<TABLE border=0 width=400 height=400 cellspacing=0>
		<tr>
			<td align="center">
				[<%= name2 %>]상품이 삭제되었습니다.<br><br>
				<div align="center">
					<input type="submit" value="재고현황"></input>	<!-- 뒤로가기 버튼 생성, 뒤로가기 클릭시 inputForm1로 -->
				</div>
			</td>
		</tr>
	</TABLE>
<script>
    alert("["<%= name2 %>"] 상품이 삭제되었습니다.");
    window.location.href="jeago_list.jsp";
</script>
</body>
</html>