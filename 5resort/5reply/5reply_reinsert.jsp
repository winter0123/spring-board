<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %> <!-- 현재시간 받아오기 위해 입력 -->
<html>
<head>
<% //현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String today = formatter.format(new java.util.Date());
   
   	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String eachtitle="", eachnum = "", title = "";
	
	request.setCharacterEncoding("UTF-8");						//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
	eachnum = request.getParameter("eachnum");
	eachtitle = request.getParameter("eachtitle");
	
	String sql = "select title from 5reply where id = "+eachnum+";";
	ResultSet rs = stmt.executeQuery(sql);
	
	if(rs.next()){
			title = rs.getString(1);
 	}
	
	ResultSet rset = stmt.executeQuery("select * from 5reply where id = "+eachnum+";");
	rset.next();
	
	int eachrelevel = rset.getInt(6)+1;		//조회시 초기값이 null값이라 볼때 null로 조회되어 +1을 하여 표기해줌(실제처리는 reply_insert_ok.jsp에서 처리)
	
%>
<script>
	function submitform(mode){
		replyform.action = "5reply_reinsert_ok.jsp?vkey=<%= eachnum %>";	//updateDB로 myform 데이터 전송
		replyform.submit();
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
<h1 class="text_box1" align=center style="margin-bottom:30px">답글 등록</h1>
<form name=replyform method=post>
<table class="text_box" align=center border=1 cellspacing=1 style="margin-bottom:5px">
	<tr>
		<td width=30 align=left>번호</td>
		<td width=720 align=left>댓글<input type="text" name="eachnum" value="INSERT" ></td>
	</tr>
	<tr>
		<td width=30 align=left>제목</td>
		<td width=720 align=left><input type="text" name="eachtitle" value="<%= eachtitle %>" style="width:750px"></td>
	</tr>
	<tr>
		<td width=30 align=left>일자</td>
		<td width=720 align=left><input type="text" name="eachdate" value="<%= today %>" readonly style="border:none; "></td>
	</tr>
	<tr>
		<td width=70 align=left>내용</td>
		<td width=720 align=left><textarea name="content" id="summernote" ></textarea></td>
	</tr>
	<tr>
		<td width=70 align=left>원글</td>
		<td width=720 align=left><input type="text" name="originalnum" value="<%= eachnum %>" style="width:750px"></td>
	</tr>
	<tr>
		<td width=70 align=left>댓글수준</td>
		<td width=720 align=left><input type="text" name="eachrelevel" value="<%= eachrelevel %>" style="width:750px"></td>
	</tr>
</table>
<table align=center border=0 cellspacing=0>
	<tr>
		<td width=750 align=right>
		<input type="button" value="취소" OnClick="location.href='e_02.jsp'" ></input>
		<input type="button" value="쓰기" OnClick="submitform('reinsert_ok')" ></input>
		</td>
	</tr>
</table>
<%	
	rset.close();
	rs.close();
	stmt.close();
	conn.close();
 
%>
</body>
</html>