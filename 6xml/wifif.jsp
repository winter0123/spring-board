<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*" %>
<html>
<head>
</head>
<body>
<h1>wifi 조회</h1>
<%
	//파싱을 위한 준비과정
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	
	//당연히 파일을 읽을때 서버내부 local path(전체경로)로 지정...dl qnswkddl xml파싱을 한다.
	Document doc = docBuilder.parse(new File("/var/lib/tomcat8/webapps/ROOT/6xml/wifi.xml"));
	
	Element root = doc.getDocumentElement();	//root태그를 가져오기도 하지만 이소스에서는 쓰이는 곳이없음
	
	NodeList tag_adr = doc.getElementsByTagName("소재지지번주소");		//xml파일의 필드명을 기준으로 불러와서 내용을 씀
																	//<가나>abc</가나>형태에서 "가나"(필드명)를 기준으로 abc를 불러옴
	NodeList tag_adr_new = doc.getElementsByTagName("소재지도로명주소");	//지번주소가 없을경우 도로명주소를 쓰기 위해 읽음
	NodeList tag_lat = doc.getElementsByTagName("위도");
	NodeList tag_lon = doc.getElementsByTagName("경도");
	
	out.println("<table cellspancing=1 width=700 border=1>");
	out.println("<tr>");
	out.println("<td width=50 align=center>순번</td>");
	out.println("<td width=550>소재지지번주소</td>");
	out.println("<td width=50>위도</td>");
	out.println("<td width=50>경도</td>");
	out.println("</tr>");
	
	for(int i=0; i<tag_adr.getLength(); i++) {
		int a=i+1;
		out.println("<tr>");
		out.println("<td width=50 align=center>"+a+"</td>");
		try{					//주소가 비어있거나 도로명이나 지번주소만 있을수도 있어서 빈경우 에러가남
			out.println("<td width=550>"+tag_adr.item(i).getFirstChild().getNodeValue()+"</td>");
		}catch(Exception e){	//try,catch를 써서 빈경우는 도로명 주소를 띄움
			out.println("<td width=550>"+tag_adr_new.item(i).getFirstChild().getNodeValue()+"</td>");
		}
		out.println("<td width=50>"+tag_lat.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=50>"+tag_lon.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("</tr>");
	}
%>
</body>
</html>
</body>
</html>