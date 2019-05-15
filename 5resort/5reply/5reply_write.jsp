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
	Statement stmt1 = conn.createStatement();
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String todayup = formatter.format(new java.util.Date());

		request.setCharacterEncoding("UTF-8");						//jsp에서 jsp로 받아오는 모든 한글을 표시하게 처리
		String hannum = request.getParameter("id");					//받아오는 변수명을 동일하게 통일시켜 insert와 update 모두 동일하게 처리	
		String hantitle = request.getParameter("title");
		String hantoday = request.getParameter("today"); 								
		String hancontent = request.getParameter("content");
		
		String key = request.getParameter( "key" );					//앞에(gongji_insert.jsp) function에 준 key값(이름)을 받아옴
		out.println(hancontent);
		
		//원글 넣기 위한 부분 (insert 부분에도 rootid넣어줌)
		int max = 0;
		String sql = "SELECT MAX(id) FROM 5reply";					//기존 번호 부여가 최대값에 자동으로 +1되어 번호가 부여되기 때문에
		ResultSet rs = stmt.executeQuery(sql);						//최대값을 찾고, insert 쿼리에서 max+1을 해줘서 원글 번호 부여될 값을 알아내서 rootid에 넣음
		
		if(rs.next()){
			max=rs.getInt(1);
		}

	
	if("INSERT".equals(key)) {
		stmt1.execute("insert into 5reply (title,date,content,rootid) values ('"
		+hantitle+"','"+hantoday+"','"+hancontent+"', "+(max+1)+");");

	}else{															//"INSERT"와 같은 key값일때는(신규제품 등록), reply_insert.jsp에서 받아온 값으로 구문 
		stmt1.execute("update 5reply set title = '"+hantitle+"', "+"content = '"+hancontent+"'"+"where id = "+ hannum +";");
	}																// 그외에는 (재고 수정) gongji_update에서 받아온 값으로 구문 돌아감
	
	rs.close();
	stmt1.close();
	stmt.close();
	conn.close();
%>
</head>
<body>
<script>
    alert("게시글 등록이 완료 되었습니다.");
    window.location.href="e_02.jsp";
</script>
</body>
</html>