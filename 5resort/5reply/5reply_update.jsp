<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head>
<title>글수정</title>
<script>
	function submitform(mode){
		if(mode == "write"){
			myform1.action = "5reply_write.jsp";	//updateDB로 myform 데이터 전송
		}else if(mode == "delete"){
			myform1.action = "5reply_delete.jsp";	//deleteDB로 myform 데이터 전송
		}
	myform1.submit();
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
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	
	request.setCharacterEncoding("UTF-8");	//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	String eachnum1 = request.getParameter("eachnum"); //view에서 번호값만 받아와서 각글을 번호로 조회함
	
	ResultSet rset = stmt.executeQuery("select * from 5reply where id = "+eachnum1+";"); //번호로 조회해서 데이터 뽑기
	rset.next();
	int eachnum = rset.getInt(1);
	String eachtitle = rset.getString(2);
	String eachdate = rset.getString(3);
	String eachcontent = rset.getString(4);

%>
<form method="post" name="myform1">
<h1 class="text_box1" align=center style="margin-bottom:30px">리뷰 수정</h1>
<table align=center border=1 cellspacing=1>
<tr>
	<td width=50 align=left>번호</td>
	<td width=750 align=left><input type="text" name="id" value="<%= eachnum %>" style="width:750px"></td>
</tr>
<tr>
	<td width=50 align=left>제목</td>
	<td width=750 align=left><input type="text" name="title" value="<%= eachtitle %>" style="width:750px"></input></td>
</tr>
<tr>
	<td width=50 align=left>일자</td>
	<td width=750 align=left><input type="text" name="today" value="<%= eachdate %>" style="width:750px"></input></td>
</tr>
<tr>
	<td width=50  height=300 align=left>내용</td>
	<td width=750 align=left><textarea name="content" id="summernote"><%= eachcontent %></textarea></td>	<!-- 텍스트박스 형식으로 쓸때는 content로 씀 -->
</tr>
</table>
<%
	rset.close();
	stmt.close();
	conn.close();
%>
<table align=center border=0 cellspacing=0>
	<tr>
		<td width=800 align=right>
		<input type="button" value="취소" OnClick="location.href='e_02.jsp'" ></input>
		<input type="button" value="쓰기" OnClick="submitform('write')" ></input>
		<input type="button" value="삭제" OnClick="submitform('delete')" ></input>
		</td>
	</tr>
</table>
</body>
</html>