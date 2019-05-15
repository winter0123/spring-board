<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-한글처리를 위해서다.->
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%> <%--주요 헤더파일(import, contentType 선언 등--%>
<html>
<head>
<script>
	function submitForm(mode){
		if(mode == "write") {
			fm.action = "gongji_write.jsp?key=update";
		}else if(mode == "delete"){
			fm.action = "gongji_delete.jsp";
		}
		fm.submit();
	}

</script>
<% 
   request.setCharacterEncoding("UTF-8");
   Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.26:3306/sun","root","112233");
    Statement stmt = conn.createStatement(); 
     
   String newtitle = "";
   String newcontent = " ";
   String ckey = "";
   String newid = "";
   String newdate = "";
   
   ckey = request.getParameter("key");

   newtitle = request.getParameter("eachtitle");
   newcontent = request.getParameter("eachcontent");
   newid = request.getParameter("id");
   newdate = request.getParameter("eachdate");
   
   stmt.close();
   conn.close();
   
%>
</head>
<body>
<form method=post name='fm'>
<table width=650 border=1 cellspacing=0 cellpadding=5>
 <tr>
   <td><b>번호</b></td>
   <td><input type=text name=id size=70 maxlength=70 value=<%=newid%> readonly></td>
 </tr>
 <tr>
   <td><b>제목</b></td>
   <td><input type=text name=title size=70 maxlength=70 value=<%=newtitle%>></td>
 </tr>
 <tr>
   <td><b>일자</b></td>
   <td><input type=text name=today size=70 maxlength=70 value=<%=newdate%>></td>
 </tr>
 <tr>
    <td><b>내용</b></td>
   <td><textarea style='width:500px; height:250px;' name=content cols=70 row=600><%=newcontent%></textarea></td>
 </tr>
</table>
<table width=650>
 <tr>
   <td width=600></td>
   <!--취소를 누르면 리스트로 이동한다, "location.href='url'"-->
   <td><input type=button value="취소" Onclick="location.href='gongji_list.jsp'"></td>
   <!--등록을 누르면 submitForm에 write가 제출되며, write로 정보들과 key값이 전달된다-->
   <td><input type=button value="등록" Onclick="submitForm('write')"></td>
   <!--삭제를 누르면 submitForm에 delete가 제출되며, delete로 정보들이 전달된다-->
   <td><input type=button value="삭제" Onclick="submitForm('delete')"></td>
 </tr>
 </table>
</body>
</html>     