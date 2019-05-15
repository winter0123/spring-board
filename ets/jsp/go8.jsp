<html>
<head>
</head>
<body>
<%
String arr[] = new String[]{"111","222","333"};
 try {
	out.println(arr[4]+"<br>"); //배열 출력을 시도한다.
	
} catch(Exception e) { // 없을 경우는 에러문구 출력
	out.println("error==>"+e+"<=======<br>");
}
%>
Good...
</body>
</html>