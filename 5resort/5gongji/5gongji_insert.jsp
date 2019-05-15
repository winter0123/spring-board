<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>새로운 글추가</title>
<script>
	function submitform(mode){
		myform2.action = "5gongji_write.jsp?key=INSERT";	//updateDB로 myform 데이터 전송
		myform2.submit();
		}
</script>
<!-- 오픈소스계열의 html 에디터를 위해 넣는 script : 위에 편집창 -->
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script>
$(document).ready(function() {
     $('#summernote').summernote({
             height: 300,                 // set editor height
             minHeight: 300,             // set minimum height of editor
             maxHeight: 300,             // set maximum height of editor
             focus: true                  // set focus to editable area after initializing summernote
     });
});

$(document).ready(function() {
  $('#summernote').summernote();
});
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Noto+Serif+KR');
.text_box {
font-family: 'Noto Serif KR', serif;
font-size: 14px;
}
.text_box1 {
font-family: 'Noto Serif KR', serif;
font-size: 40px;
}
</style>
</head>
<body>
<% //현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());
%>
<center>
<h1 class="text_box1" align=center style="margin-bottom:30px">공지사항 신규작성</h1>
<form method="post" name="myform2">
<table class="text_box" border=1 cellspacing=1 style="margin-bottom:5px">
<tr>
	<td width=50 align=left>번호</td>
	<td width=750 align=left>신규(insert)</td>	<!-- 번호는 auto_increment로 받아서 자동 생성됨 : 테이블 만들때 줘야함-->
</tr>
<tr>
	<td width=50 align=left>제목</td>
	<td width=750 align=left><input type="text" name="title" value="" style="width:750px"></input></td>
</tr>
<tr>
	<td width=50 align=left>일자</td>
	<td width=750 align=left><input type="text" name="today" value="<%= today %>" readonly style="border:none;"></input></td>
</tr>
<tr>
	<td width=50  height=300 align=left>내용</td>
	<td width=750 align=left><textarea name="content" id="summernote" cols="52" rows="20"></textarea></td>
</tr>
</table>
<table border=0 cellspacing=0>
	<tr>
		<td width=800 align=right>
		<input type="button" value="취소" OnClick="location.href='e_01.jsp'" ></input>
		<input type="button" value="쓰기" OnClick="submitform('write')" ></input>
		</td>
	</tr>
</table>
</center>
</body>
</html>