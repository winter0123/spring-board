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
	
	String sql = "select title from reply where id = "+eachnum+";";
	ResultSet rs = stmt.executeQuery(sql);
	
	if(rs.next()){
			title = rs.getString(1);
 	}
	
	ResultSet rset = stmt.executeQuery("select * from reply where id = "+eachnum+";");
	rset.next();
	
	int eachrelevel = rset.getInt(6)+1;		//조회시 초기값이 null값이라 볼때 null로 조회되어 +1을 하여 표기해줌(실제처리는 reply_insert_ok.jsp에서 처리)
	
%>
<script>
	function submitform(mode){
		replyform.action = "reply_reinsert_ok.jsp?vkey=<%= eachnum %>";	//updateDB로 myform 데이터 전송
		replyform.submit();
		}
</script>
	<!-- 오픈소스계열의 html 에디터를 위해 넣는 script : 위에 편집창 -->
    <meta charset="utf-8">
    <title>CKEditor 5 – Classic editor</title>
    <script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
</head>
<body>
<form name=replyform method=post>
<table align=center border=1 cellspacing=0 style="margin-bottom:5px">
	<tr>
		<td width=100 align=left>번호</td>
		<td width=600 align=left>댓글<input type="text" name="eachnum" value="INSERT" ></td>
	</tr>
	<tr>
		<td width=100 align=left>제목</td>
		<td width=600 align=left><input type="text" name="eachtitle" value="<%= eachtitle %>" ></td>
	</tr>
	<tr>
		<td width=100 align=left>일자</td>
		<td width=600 align=left><input type="text" name="eachdate" value="<%= today %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=100 align=left>내용</td>
		<td width=600 align=left><textarea name="content" id="editor"></textarea>
    <script>	<!-- 오픈소스계열의 html 에디터를 위해 넣는 script : 위에 편집창 -->
        ClassicEditor
            .create( document.querySelector( '#editor' ) )
            .catch( error => {
                console.error( error );
            } );
    </script></td>
	</tr>
	<tr>
		<td width=100 align=left>원글</td>
		<td width=600 align=left><input type="text" name="originalnum" value="<%= eachnum %>" ></td>
	</tr>
	<tr>
		<td width=100 align=left>댓글수준</td>
		<td width=600 align=left><input type="text" name="eachrelevel" value="<%= eachrelevel %>" ></td>
	</tr>
</table>
<table align=center border=0 cellspacing=0>
	<tr>
		<td width=700 align=right>
		<input type="button" value="취소" OnClick="location.href='reply_list.jsp'" ></input>
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