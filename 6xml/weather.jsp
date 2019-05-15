<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- 웹 xml 파일 읽어들여서 정보 다시 보내주기 위해 넣은 import : 시작 -->
<%@page import= "java.io.BufferedReader"%>
<%@page import= "java.io.InputStreamReader"%>
<%@page import= "java.io.StringReader"%>
<%@page import= "java.net.HttpURLConnection"%>
<%@page import= "java.net.URL"%>
 
<%@page import= "javax.xml.parsers.DocumentBuilder"%>
<%@page import= "javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import= "javax.xml.xpath.XPath"%>
<%@page import= "javax.xml.xpath.XPathConstants"%>
<%@page import= "javax.xml.xpath.XPathExpression"%>
<%@page import= "javax.xml.xpath.XPathFactory"%>

<%@ page import= "org.w3c.dom.Document" %>
<%@ page import= "org.w3c.dom.Element" %>
<%@ page import= "org.w3c.dom.Node" %>
<%@ page import= "org.w3c.dom.NodeList" %>
<%@ page import= "org.xml.sax.InputSource" %>
<!-- 웹 xml 파일 읽어들여서 정보 다시 보내주기 위해 넣은 import : 끝 -->


<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>


<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>

<html>
<head>
<title>web조회로 xml파싱하기</title>
<%!
	DefaultHttpClient client;	//HttpClient 재사용 관련 서버 통신시 세션을 유지하기 위함이다.
	public DefaultHttpClient getThreadSafeClient() {
		if(client != null)
			return client;

		client = new DefaultHttpClient();
		ClientConnectionManager mgr = client.getConnectionManager();
		HttpParams params = client.getParams();
		client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
		return client;
	}
  
	public String goXML(String getURL) {
		String Result = null;
		//세션유지 체크
		HttpClient client = getThreadSafeClient();
		HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
		HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
		HttpPost post = new HttpPost(getURL);
			 
		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
		if(false) { //여기가 post/get 파라미터를 전달하는 곳이다.
		nameValuePairs.add(new BasicNameValuePair("input1", "kopoctc"));
		}
     
		try {
			post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
			HttpResponse responsePost = null;
			responsePost = client.execute(post);
			HttpEntity resEntity = responsePost.getEntity();
				
			if(resEntity != null) {
				Result = EntityUtils.toString(resEntity).trim();
			}
			
		}catch(Exception e) {    
			e.printStackTrace();
		} finally {
		}
		return Result;
	}   
%>
</head>
<body>
<h1 align=center>날씨 조회</h1>

<%
 try{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
	   
		String urlstr = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123";
	   
		URL url = new URL(urlstr);
		HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();


		BufferedReader br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));

		String result = "";
		String line;
		while ((line = br.readLine()) != null) {
					result = result + line.trim();// result = URL로 XML을 읽은 값
		}
		
		InputSource is = new InputSource(new StringReader(result));
		Document doc = builder.parse(is);
	 
		//생성된 document 에서 각 요소들에 접근하여 데이터를 저장
		Element root = doc.getDocumentElement();  //root태그를 가져오기도 하지만 이 소스에서는 쓰이는 곳이 없다.
		NodeList tag_001 = doc.getElementsByTagName("data");   //xml data tag

		String seq="";      //48시간중 몇번째인지 가르킴
		String hour="";   //동네예보 3시간 단위
		String day="";      //1번째날 (0오늘/1내일/2모레)
		String temp="";   //현재 신간온도
		String tmx="";      //최고 온도
		String tmn="";      //최저 온도
		String sky="";      //하늘 상태 코드(1맑음/2구름조금/3구름많음/4흐림)
		String pty="";      //강수 상태 코드(0없음/1비/2비,눈/3눈,비/4눈)
		String wfKor="";   //날씨 한국어
		String wfEn="";   //날씨 영어
		String pop="";      //강수 확률%
		String r12="";      //12시간 예상 강수량
		String s12="";      //12시간 예상 적설량
		String ws="";      //풍속(m/s)
		String wd="";      //풍향(0~7:북,북동,동,남동,남,남서,서,북서)
		String wdKor="";   //풍향 한국어
		String wdEn="";   //풍향 영어
		String reh="";      //습도 %
		String r06="";      //6시간 예상 강수량
		String s06="";      //6시간 예상 적설량

		out.println("<table  cellspacing='0' width='80%' border='1' align='center'>");
		out.println("<tr>");
		out.println("<td width=50>seq</td>");
		out.println("<td width=50>hour</td>");
		out.println("<td width=50>day</td>");
		out.println("<td width=50>temp</td>");
		out.println("<td width=50>tmx</td>");
		out.println("<td width=50>tmn</td>");
		out.println("<td width=50>sky</td>");
		out.println("<td width=50>pty</td>");
		out.println("<td width=80>wfKor</td>");
		out.println("<td width=100>wfEn</td>");
		out.println("<td width=50>r12</td>");
		out.println("<td width=50>s12</td>");
		out.println("<td width=50>ws</td>");
		out.println("<td width=50>wd</td>");
		out.println("<td width=50>wdKor</td>");
		out.println("<td width=50>wdEn</td>");
		out.println("<td width=50>reh</td>");
		out.println("<td width=50>r06</td>");
		out.println("<td width=50>s06</td>");
		out.println("</tr>");
		
		for(int i=0; i<tag_001.getLength(); i++) {
			Element elmt=(Element)tag_001.item(i);
			seq=tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
			hour=elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day=elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
			temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
			tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
			tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
			sky=elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
			pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
			wfKor=elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();
			wfEn=elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
			pop=elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
			r12=elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
			s12=elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
			ws=elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
			wd=elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			wdKor=elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
			wdEn=elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
			reh=elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
			r06=elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
			s06=elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();

			out.println("<tr>");
			out.println("<td width=50>"+seq+ "</td>");
			out.println("<td width=50>"+hour+ "</td>");
			out.println("<td width=50>"+day + "</td>");
			out.println("<td width=50>"+temp + "</td>");
			out.println("<td width=50>"+tmx+ "</td>");
			out.println("<td width=50>"+tmn+ "</td>");
			if(sky.equals("1")){
				out.println("<td width=50><img src='1.png' width='30' height='30'></td>");
			}else if(sky.equals("2")){
				out.println("<td width=50><img src='2.png' width='30' height='30'></td>");
			}else if(sky.equals("3")){
				out.println("<td width=50><img src='3.png' width='30' height='30'></td>");
			}else if(sky.equals("4")){
				out.println("<td width=50><img src='4.png' width='30' height='30'></td>");
			}
		
			if(pty.equals("0")){
				out.println("<td width=50>0</td>");
			}else if(pty.equals("1")){
				out.println("<td width=50><img src='rs.png' width='30' height='30'></td>");
			}else if(pty.equals("2")){
				out.println("<td width=50><img src='rs.png' width='30' height='30'></td>");
			}else if(pty.equals("3")){
				out.println("<td width=50><img src='sr.png' width='30' height='30'></td>");
			}else if(pty.equals("4")){
				out.println("<td width=50><img src='snow.png' width='30' height='30'></td>");
			}
			out.println("<td width=80>"+wfKor+ "</td>");
			out.println("<td width=100>"+wfEn + "</td>");
			out.println("<td width=50>"+r12 + "</td>");
			out.println("<td width=50>"+s12+ "</td>");
			out.println("<td width=100>"+ws+ "</td>");
			out.println("<td width=50>"+wd+ "</td>");
			out.println("<td width=50>"+wdKor + "</td>");
			out.println("<td width=50>"+wdEn+ "</td>");
			out.println("<td width=50>"+reh+ "</td>");
			out.println("<td width=50>"+r06+ "</td>");
			out.println("<td width=50>"+s06+ "</td>");
			out.println("</tr>");
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>