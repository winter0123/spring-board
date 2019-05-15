<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>글수정</title>
<script>
	function submitform(mode){
		if(mode == "write"){
			myform1.action = "jeago_write1.jsp";	//updateDB로 myform 데이터 전송
		}
	myform1.submit();
	}
	function onlyNumber(event){	//숫자만 입력받음
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
	function removeChar(event) {	//문자제거
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
</script>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());
	
	request.setCharacterEncoding("UTF-8");								//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	String hanid = request.getParameter("eachid"); 						//받아오는 변수명을 동일하게 통일시켜 insert와 update 모두 동일하게 처리
	String hanproductname = request.getParameter("eachproductname");				
	String hannowproductnum = request.getParameter("eachnowproductnum"); 								
	String hanlastpdate = request.getParameter("eachlastpdate"); 					
	String hancontent = request.getParameter("content");
	
	//이미지 링크를 불러오기 위한 rset
	ResultSet rset = stmt.executeQuery("select * from jeago where id = "+hanid+";");
	rset.next();
	String haneachphoto = rset.getString(7);	//이미지 파일은 name속성을 사용을 못해서 mysql에서 링크를 다시 불러옴

%>
<form method="post" name="myform1">
<table border=1 cellspacing=1>
<tr>
	<td width=150 align=left>상품 번호</td>
	<td width=400 align=left><input type="text" name="eachid0" value="<%= hanid %>" readonly style="border:none; width:380px"></input></td>
</tr>
<tr>
	<td width=150 align=left>상품명</td>
	<td width=400 align=left readonly><%= hanproductname %></td>
</tr>
<tr>
	<td width=150 align=left>재고현황</td>
	<td width=400 align=left><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' name="eachnowproductnum0" value="<%= hannowproductnum %>" style="width:380px"></input></td>
</tr>
<tr>
	<td width=150 align=left>상품등록일</td>
	<td width=400 align=left readonly><%= hanlastpdate %></td>
</tr>
<tr>
	<td width=150 align=left>재고등록일</td>
	<td width=400 align=left readonly><%= today %></td>
</tr>
<tr>
	<td width=150 align=left>상품설명</td>
	<td width=400 align=left readonly><%= hancontent %></td>
</tr>
<tr>
	<td width=150  height=300 align=left>상품사진</td>
	<td width=400 align=left><div><img src="<%= haneachphoto %>" width=300 height=300 ></div></td>
</tr>
</table>
<%
	rset.close();
	stmt.close();
	conn.close();
%>
<table border=0 cellspacing=0>
	<tr>
		<td width=550 align=right>
		<input type="button" value="취소" OnClick="location.href='jeago_list.jsp'" ></input>
		<input type="button" value="쓰기" OnClick="submitform('write')" ></input>
		</td>
	</tr>
</table>
</body>
</html>