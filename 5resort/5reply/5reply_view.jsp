<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글보기(한개항목)</title>
<script>
	function submitform(mode){
		if(mode == "list"){
			myform.action = "e_02.jsp";	//updateDB로 myform 데이터 전송
			myform.submit();
		}else if(mode == "update"){
			myform.action = "5reply_update.jsp";	//deleteDB로 myform 데이터 전송
			myform.submit();
		}else if(mode == "delete"){
			myform.action = "5reply_delete.jsp";	//deleteDB로 myform 데이터 전송
			myform.submit();
		}else if(mode == "reinsert"){
			myform.action = "5reply_reinsert.jsp";	//deleteDB로 myform 데이터 전송
			myform.submit();
		}
	}
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
a.no-uline { text-decoration:none }	<!--밑줄 없애기 위해 style안에 적어줌, 밑에 class로 불러서 씀 -->
</style>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	String ckey = request.getParameter( "key" );	//앞에(C_01) key값(이름)을 받아옴


	//조회수 누적을 위한 부분
	int status=1;
	try{   
		PreparedStatement ps =conn.prepareStatement("select * from 5reply where id = "+ckey+";");
		ResultSet rs =ps.executeQuery();	//쿼리문 돌려서 reply테이블의 viewcnt 선택
      
		while(rs.next()){
		status =rs.getInt(8);				//status값 저장
      }
      
	}catch(Exception e){					//에러있을시 에러문 출력
		System.out.println(e);
	}
    Integer Hits =(Integer)application.getAttribute("hitCounter");	//속성값을 받아와서 Hits에 저장
    
    Hits=status;
    status =Hits++;

    application.setAttribute("hitCounter", status);
  
	PreparedStatement ps1 = conn.prepareStatement("update 5reply set viewcnt = '"+Hits+"' where id = "+ckey+";");
	status = ps1.executeUpdate();


	//후보자의 각 연령별 합계값을 알기 위한 rest값
	ResultSet rset = stmt.executeQuery("select * from 5reply where id = "+ckey+";");
	rset.next();							//각 후보자의 연령대 별 표 수 조회(번호+나이(1~9)기준으로 조회)
	
	int eachnum = rset.getInt(1);
	String eachtitle = rset.getString(2);
	String eachdate = rset.getString(3);
	String eachcontent = rset.getString(4);
	String eachhits = rset.getString(8);
%>
<center>
<form method="post" name="myform">
<h1 class="text_box1">리뷰</h1>
<table border=1 cellspacing=0 style="margin-bottom:5px" class="text_box">
	<tr>
		<td width=150 align=left>번호</td>
		<td width=400 align=left><input type="text" name="eachnum" value="<%= eachnum %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>제목</td>
		<td width=400 align=left><input type="text" name="eachtitle" value="<%= eachtitle %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>일자</td>
		<td width=400 align=left><input type="text" name="eachdate" value="<%= eachdate %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>조회수</td>
		<td width=400 align=left><input type="text" name="eachHitss" value="<%= eachhits %>" readonly style="border:none;"></td>
	</tr>
	<tr>
		<td width=150 align=left>내용</td>
		<td width=400 align=left>
		<!-- 오픈소스계열의 html 에디터(글쓰기 편집창)를 위해 div를 씀, textarea를 쓸경우 html코드가 view창에 다 보임 -->
		<div id="eachcontent" readonly style="border:none;"><%= eachcontent %></div></td>
	</tr>
</table>
<table border=0 cellspacing=0>
	<tr>
		<td width=550 align=right>
		<input type="button" value="목록" OnClick="submitform('list')" ></input>
		<input type="button" value="댓글" OnClick="submitform('reinsert')" ></input>
		<%
   String loginOK=null;
   
   loginOK = (String)session.getAttribute("login_ok");
   if(loginOK == null) {

   } else { // 로그인을 한 경우 %>
		<input type="button" value="수정" OnClick="submitform('update')" ></input>
		<input type="button" value="삭제" OnClick="submitform('delete')" ></input>
	<%} %>
		</td>
	</tr>
</table>
</center>
<%
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>