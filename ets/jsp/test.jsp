<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>

<html>
<head>
<%
		File f = new File("/var/lib/tomcat8/webapps/ROOT/jsp/wifi.txt");
		BufferedReader br = new BufferedReader (new FileReader(f));
		BufferedReader br2 = new BufferedReader (new FileReader(f));
		String readtxt;
		
		if((readtxt = br.readLine())==null) {		//첫번째 줄을 읽어 파일이 null값이면
			System.out.println("빈 파일입니다");			//"빈 파일입니다"출력
			return;
		}
		String[] field_name = readtxt.split("\t");	//목차를 한줄을 읽어 ,를 기준으로 문자열을 나눠 배열을 만듬
		
		double lat = 37.3860521;					//현재 위치 위도 설정
		double lng = 127.1214038;					//현재 위치 경도 설정
		
		int LineCnt = 1;	//출력 항목 순서
		int allcount = 0;	//누적번호
		int pagenum = 10;	//페이지 번호 (1페이지~10페이지)
		int count = 10;		//한페이지에 보여줄 번호 수(1번~10번)
		int pageno = toInt(request.getParmeter("pageno"));
	
		while (br2.readLine() !=null) {
			allcount++;
		}
		
%>
</head>

<body>
<h3 align="center">무료 와이파이 </h3>
<table border = 1 cellspacing=0 align=center width=900 style="table-layout:fixed"> 
   <tr>
      <td width=50 align="center"> 번호 </td>
      <td width=450 align="center"> 주소 </td>
      <td width=100 align="center"> 위도 </td>
      <td width=100 align="center"> 경도 </td>
      <td width=200 align="center"> 현재 위치로부터의 거리 </td>
   </tr>
  
<%
	while((readtxt = br.readLine()) != null){	//다음줄부터 한줄씩 읽어 null값이 아닐때 까지 while문을 돌림
		
		String[] field = readtxt.split("\t");
		
		out.println("<tr>");
		out.println("<td align=center>"+LineCnt);
		out.println("<td align=center>"+field[9]+"</td>");						//지번 주소 출력
		out.println("<td align=center>"+field[12]+"</td>");						//위도 주소 출력
		out.println("<td align=center>"+field[13]+"</td>");						//경도 주소 출력
																				//현재위치로 부터 거리 출력
		double dist = Math.sqrt(Math.pow(Double.parseDouble(field[12])-lat,2)	//.parseDouble 숫자형의 문자열을 10진수 Double형으로 변환
				+Math.pow(Double.parseDouble(field[13])-lng, 2));				//.sqrt = 제곱근(루트)을 해줌 //.pow(a,2) = a의 2승
		out.println("<td align=center>"+dist+"</td>");							//거리 공식(피타고라스 정의)
			
		LineCnt++;	//줄 번호 증가
	}
		br.close();		
%>
</table>
</body>
