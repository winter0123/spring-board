<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>식료품 재고현황-한개보기</title>
<script>
	function submitform(mode){
		if(mode == "delete"){
			myform.action = "jeago_delete.jsp";	//updateDB로 myform 데이터 전송
			myform.submit();
		}else if(mode == "update"){
			myform.action = "jeago_update.jsp";	//deleteDB로 myform 데이터 전송
			myform.submit();
		}
	}
</script>

</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String xkey = request.getParameter( "keyz" );	//앞에(jeago_list) keyz값(이름)을 받아옴

	//후보자의 각 연령별 합계값을 알기 위한 rest값
	ResultSet rset = stmt.executeQuery("select * from jeago where id = "+xkey+";");
	rset.next();									// 재고 번호기준으로 조회
	
	String eachproductname = rset.getString(2);		// 상품명
	int eachnowproductnum = rset.getInt(3);			// 현재재고수
	String eachlastpdate = rset.getString(4);		// 상품등록일
	String eachfirstpdate = rset.getString(5);		// 재고등록일
	String eachexplain = rset.getString(6);			// 상품설명
	String eachphoto = rset.getString(7);			// 상품사진
%>
<form method="post" name="myform">	
<table border=1 cellspacing=0>
	<tr>
		<td width=150 align=left>상품번호</td>
		<td width=400 align=left><input type="text" name="eachid" value="<%= xkey %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>상품명</td>
		<td width=400 align=left><input type="text" name="eachproductname" value="<%= eachproductname %>" readonly style="border:none;"></td>
	</tr>
		<tr>
		<td width=150 align=left>현재 재고수</td>
		<td width=400 align=left><input type="text" name="eachnowproductnum" value="<%= eachnowproductnum %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>상품등록일</td>
		<td width=400 align=left><input type="text" name="eachlastpdate" value="<%= eachlastpdate %>" readonly style="border:none;"></td>
	</tr>
		<tr>
		<td width=150 align=left>재고등록일</td>
		<td width=400 align=left><input type="text" name="eachfirstpdate" value="<%= eachfirstpdate %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>상품설명</td>
		<td width=400 align=left><input type="eachexplain" name="content" value="<%= eachexplain %>" readonly style="border:none;"></input></td>
	</tr>
		<tr>
		<td width=150 align=left>상품사진</td>
		<td width=400 align=left><div><img src="<%= eachphoto %>" width="300" height="300"></img></div></td>
	</tr>
</table>
<table border=0 cellspacing=0>
	<tr>
		<td width=550 align=right>
		<input type="button" value="상품삭제" OnClick="submitform('delete')" ></input>
		<input type="button" value="재고수정" OnClick="submitform('update')" ></input>
		</td>
	</tr>
</table>
<%
	rset.close();
	stmt.close();
	conn.close();
%>
</form>
</body>
</html>