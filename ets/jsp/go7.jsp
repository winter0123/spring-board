<html>
<head>
</head>
<body>
<%
String arr[]= new String[]{"111","222","333"};
String str="abc,efg,hij"; //문자열을 불러옴
String str_arr[] = str.split(","); //불러온 문자열을 ,로 나눠서 배열화 함
%>
arr[0]:<%=arr[0]%><br>
arr[1]:<%=arr[1]%><br>
arr[2]:<%=arr[2]%><br>
str_arr[0]:<%=str_arr[0]%><br>
str_arr[1]:<%=str_arr[1]%><br>
str_arr[2]:<%=str_arr[2]%><br>
Good...
</body>
</html>