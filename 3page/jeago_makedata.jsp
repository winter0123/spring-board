<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글목록</title>
</head>
<body>
<h1>Make table</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();

//	stnt.execute("create table jeago (id int not null primary key, productname  varchar(70), nowproductnum int, lastpdate date, firstpdate date, content text, image varchar(200))DEFAULT CHARSET=utf8;");
//primary key = 고유값을 가지게함 (not null은 무조건 있어야 하는 값이라는 의미, auto_increment는 자동 증가 의미)
//image파일 등록은 링크 주소만 image부분에 string으로 저장 후 view부분에서 불러옴

	String sql="";
	sql = "insert into jeago (id,productname,nowproductnum,lastpdate,firstpdate,content,image) values(111111,'바나나',10,date(now()),date(now()),'내용1','이미지경로');"; stmt.execute(sql);
	sql = "insert into jeago (id,productname,nowproductnum,lastpdate,firstpdate,content,image) values(111112,'딸기',10,date(now()),date(now()),'내용2','이미지경로');"; stmt.execute(sql);
	sql = "insert into jeago (id,productname,nowproductnum,lastpdate,firstpdate,content,image) values(111113,'사과',20,date(now()),date(now()),'내용3','이미지경로');"; stmt.execute(sql);
	sql = "insert into jeago (id,productname,nowproductnum,lastpdate,firstpdate,content,image) values(111114,'청포도',12,date(now()),date(now()),'내용4','이미지경로');"; stmt.execute(sql);
	sql = "insert into jeago (id,productname,nowproductnum,lastpdate,firstpdate,content,image) values(111115,'파인애플',13,date(now()),date(now()),'내용5','이미지경로');"; stmt.execute(sql);
	
	//이미지 파일을 업로드 먼저 한 뒤 http://192.168.23.35:8081/3page/imgs/banana.jpg '이미지경로' 부분에 링크를 넣어줌
	
	//cos넣는 위치 = / -> user -> share -> tomcat -> lib 에 cos.jar넣기
	
	
	stmt.close();
	conn.close();

%>
</body>
</html>