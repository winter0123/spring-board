<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-한글처리를 위해서다.->
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%> <%--주요 헤더파일(import, contentType 선언 등--%>
<html>
<head>
<script>
	function submitForm(mode){
		if(mode == "write") {
			fm.action = "5gongji_write.jsp?key=update";
		}else if(mode == "delete"){
			fm.action = "5gongji_delete.jsp";
		}
		fm.submit();
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
<% 
   request.setCharacterEncoding("UTF-8");
   Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
    Statement stmt = conn.createStatement(); 

   String newid = request.getParameter("eachnum");
   
   	//후보자의 각 연령별 합계값을 알기 위한 rest값
	ResultSet rset = stmt.executeQuery("select * from 5gongji where id = "+newid+";");
	rset.next();							//각 후보자의 연령대 별 표 수 조회(번호+나이(1~9)기준으로 조회)
	
	String newtitle = rset.getString(2);
	String newdate = rset.getString(3);
	String newcontent = rset.getString(4);
   
   rset.close();
   stmt.close();
   conn.close();
   
%>
</head>
<body>
<center>
<form method=post name='fm'>
<h1 class="text_box1" align=center style="margin-bottom:30px">공지사항 수정</h1>
<table class="text_box" border=1 cellspacing=1 style="margin-bottom:5px">
 <tr>
   <td width=50><b>번호</b></td>
   <td width=750><input type=text name=id size=90 maxlength=90 value=<%=newid%> readonly></td>
 </tr>
 <tr>
   <td width=50><b>제목</b></td>
   <td width=750><input type=text name=title size=90 maxlength=90 value=<%=newtitle%>></td>
 </tr>
 <tr>
   <td width=50><b>일자</b></td>
   <td width=750><input type=text name=today size=90 maxlength=90 value=<%=newdate%>></td>
 </tr>
 <tr>
   <td width=50><b>내용</b></td>
   <td width=750><textarea style='width:500px; height:250px;' name=content id="summernote" cols=70 row=600><%=newcontent%></textarea></td>
 </tr>
</table>
<table width=800>
 <tr>
   <td width=800></td>
   <!--취소를 누르면 리스트로 이동한다, "location.href='url'"-->
   <td><input type=button value="취소" Onclick="location.href='e_01.jsp'"></td>
   <!--등록을 누르면 submitForm에 write가 제출되며, write로 정보들과 key값이 전달된다-->
   <td><input type=button value="등록" Onclick="submitForm('write')"></td>
   <!--삭제를 누르면 submitForm에 delete가 제출되며, delete로 정보들이 전달된다-->
   <td><input type=button value="삭제" Onclick="submitForm('delete')"></td>
 </tr>
</table>
</center>
</body>
</html>     