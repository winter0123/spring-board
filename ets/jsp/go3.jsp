<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<script>
function call1(){
	var a = "abc";
	var b = "efg";
	document.write("String연산:"+(a+b));
}
function call2(){
	var a = 1;
	var b = 2;
	document.write("integer연산"+(a+b));
}
</script>
</head>
<body>
<script>call1();</script>
<script>call2();</script>
Good...
</body>
</html>