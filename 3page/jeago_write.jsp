<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-한글처리를 위해서다.->
<%@page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%> <%--주요 헤더파일(import, contentType 선언 등--%>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<html>
<head>
<title>신규등록</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hd","root","1234");
	Statement stmt = conn.createStatement();
	
	//현재 시간 입력을 위한 2줄(위에 노란것 3번째줄도 추가해야함)
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String todayup = formatter.format(new java.util.Date());
	
	//이미지 파일 저장을 위한 부분
	String savePath = request.getServletContext().getRealPath("3page/imgs");	//이미지 저장될 부분 경로 지정
	int maxSize = 10*1024*1024;													//이미지 크기 최대값 설정
    String format = "UTF-8";													//한글처리
    String uploadFile="";
	
	MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, format, new DefaultFileRenamePolicy());	
    uploadFile = multi.getFilesystemName("filename");
	//MultipartRequest는 cosj를 들고있는 라이브러리
	//new DefaultFileRenamePolicy() = 파일업로드할때 rename을 위해서 만드는것
	//첫줄은 선언임
	//두번째 줄 = multi를 사용해서 파일이름을 가져와서 uploadFile에 저장

	String hanid = multi.getParameter("eachid"); 						//jeago_insert.jsp에서 받아오는 부분
	String hanproductname = multi.getParameter("eachproductname");		//insert에서는 multi로 받아와야해서 update와 별도로 받아와야함
	String hannowproductnum = multi.getParameter("eachnowproductnum"); 								
	String hancontent = multi.getParameter("content");
	
	String key = request.getParameter( "key" );							//앞에(gongji_insert.jsp) function에 준 key값(이름)을 받아옴
																		//(현 페이지는 필요없지만 key값 받아오는 방법 보기위해 남겨둠)
																		
	if("INSERT".equals(key)) {											//"INSERT"와 같은 key값일때는(신규제품 등록), gongji_insert.jsp에서 받아온 값으로 구문 돌아감
		stmt.execute("insert into jeago (id, productname, nowproductnum, lastpdate, firstpdate, content, image) values ("+ 
		hanid+",'"+hanproductname+"',"+hannowproductnum+", '"+todayup+"', '"+todayup+"', '"+hancontent+"', '/3page/imgs/"+uploadFile+"');");
	}
	stmt.close();
	conn.close();
%>
</head>
<body>
<script>
    alert("상품등록이 완료 되었습니다.");
    window.location.href="jeago_list.jsp";
</script>
</body>
</html>