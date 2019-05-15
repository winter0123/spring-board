<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글쓰기</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String todayup = formatter.format(new java.util.Date());

		request.setCharacterEncoding("UTF-8");						//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
		String hannum = request.getParameter("id");					//받아오는 변수명을 동일하게 통일시켜 insert와 update 모두 동일하게 처리	
		String hantitle = request.getParameter("title");
		String hantoday = request.getParameter("today"); 								
		String hancontent = request.getParameter("content");
		
		String key = request.getParameter( "key" );					//앞에(gongji_insert.jsp) function에 준 key값(이름)을 받아옴
	
	if("INSERT".equals(key)) {
		stmt.execute("insert into gongji (title,date,content) values ('"+hantitle+"','"+hantoday+"','"+hancontent+"');");
	}else{															//"INSERT"와 같은 key값일때는(신규제품 등록) // gongji_insert.jsp에서 받아온 값으로 구문 
		stmt.execute("update gongji set title = '"+hantitle+"', "+"content = '"+hancontent+"'"+"where id = "+ hannum +";");
	}																// 그외에는 (재고 수정) gongji_update에서 받아온 값으로 구문 돌아감
	
	stmt.close();
	conn.close();
%>
</head>
<body>
<script>
    alert("상품등록이 완료 되었습니다.");
    window.location.href="gongji_list.jsp";
</script>
</body>
</html>