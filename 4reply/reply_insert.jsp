<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<title>새로운 글추가</title>
<script>
	function submitform(mode){
		myform2.action = "reply_write.jsp?key=INSERT";	//updateDB로 myform 데이터 전송
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
@import url('https://fonts.googleapis.com/css?family=Hi+Melody');
.text_box {
font-family: 'Hi Melody', cursive;
font-size: 16px;
}
.text_box1 {
font-family: 'Hi Melody', cursive;
font-size: 40px;
text-align: center;
}
a.no-uline { text-decoration:none }	<!--밑줄 없애기 위해 style안에 적어줌, 밑에 class로 불러서 씀 -->
</style>
</head>
<body>
<h1 class="text_box1" align=center style="margin-bottom:30px">신규 게시글 등록</h1>
<% //현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());
%>
<form method="post" name="myform2">
<table class="text_box" align=center border=1 cellspacing=1 style="margin-bottom:5px">
<tr>
	<td width=50 align=left>번호</td>
	<td width=750 align=left>신규(insert)</td>
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
	<td width=50 align=left>내용</td>
	<td width=750 align=left><textarea name="content" id="summernote"></textarea>
	<!-- 오픈소스계열의 html 에디터를 위해 넣는 script : 위에 편집창 -->

	</td>
	
</tr>
</table>
<table align=center border=0 cellspacing=0>
	<tr>
		<td width=800 align=right>
		<input type="button" value="취소" OnClick="location.href='reply_list.jsp'" ></input>
		<input type="button" value="쓰기" OnClick="submitform('write')" ></input>
		</td>
	</tr>
</table>
</body>
</html>