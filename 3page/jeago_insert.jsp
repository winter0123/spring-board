<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>새로운 글추가</title>
<script>
	function submitform(){
		myform2.action = "jeago_write.jsp?key=INSERT";	//updateDB로 myform 데이터 전송
		myform2.submit();
		}
		
	function onlyNumber(event){	//숫자만 입력받음
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
	function removeChar(event) {//문자제거
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
<% //현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());
%>
<form method="post" name="myform2" enctype="Multipart/form-data">
<table border=1 cellspacing=1>
<tr>
	<td width=150 align=left>상품 번호</td>
	<td width=400 align=left><input type="text" name="eachid" value="" style="width:380px"></input></td>
</tr>
<tr>
	<td width=150 align=left>상품명</td>
	<td width=400 align=left><input type="text" name="eachproductname" value="" style="width:380px"></input></td>
</tr>
<tr>
	<td width=150 align=left>재고현황</td>
	<td width=400 align=left><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' name="eachnowproductnum" value="" style="width:380px"></input></td>
</tr>
<tr>
	<td width=150 align=left>상품등록일</td>
	<td width=400 align=left><input type="text" name="eachlastpdate" value="<%= today %>" readonly style="border:none;"></input></td>
</tr>
<tr>
	<td width=150 align=left>재고등록일</td>
	<td width=400 align=left><input type="text" name="eachfirstpdate" value="<%= today %>" readonly style="border:none;"></input></td>
	<!-- 신규등록이기 때문에 오늘날짜기준으로 등록 -->
</tr>
<tr>
	<td width=150 align=left>상품설명</td>
	<td width=400 align=left><input type="text" name="content" value="" style="width:380px"></input>
</tr>
<tr>
	<td width=150 align=left>상품사진</td>
	<td width=400 align=left><input type="file" name="filename"></input></tr>
	<!-- input type을 file로 할 경우 파일 선택창이 뜸 -->
	
</table>
<table border=0 cellspacing=0>
	<tr>
		<td width=450 align=right>
		<input type="button" value="완료" OnClick="submitform()" ></input>
		<!-- 위의 jeago_write로 key값 전달하는 버튼 -->
		</td>
	</tr>
</table>
</body>
</html>