<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Bootstrap CSS -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<head> 
<title>Insert title here</title>
<style type="text/css">
	tr.row-name
		{ font-size: 18px; color:#448aff; }
	tr.row-content
		{color:#6c7173;}
	table
		{ border: 2px solid #F0F2F2; }
	.table-striped>tbody>tr:nth-of-type(odd)
		{ background:#F0F2F2 !important; }
</style>
</head>
<body>
<h2 style="color: #448aff; text-align: center; margin: 30px;">
	<a href="http://192.168.23.35:8082/list" style="color:#448aff;"><b>전체 사용자 List 조회</b></a></h2>
<div class="container col-md-4" style="float: none; margin: 0 auto;"> <!-- container는 표를 가운데 정렬하기 위해서 -->
	<table class="table table-striped">
		<thead>
			<tr class="row-name">
				<th style="width:25%" align=center>번호</th>
				<th style="width:25%" align=center>ID</th>
				<th style="width:50%" align=center>이름</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="list" varStatus="status">	<!-- users를 users로 받아와 for문 반복을 돌림 -->
			<tr class="row-content">
				<td>${status.count}</td>
				<td><a href='view?id=${list.id}'>${list.id}</a></td>
				<td>${list.name}</td> 
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="float:right;">
		<button type="button" onclick="location.href='newform.html'" class="btn btn-info" >신규</button> <!-- class에서 info가 생상을 의미 -->
	</div>
<br><br>
	<div align="center">
		<form action="list" method="post">
	               <select name="opt">
	                       <option value="name">이름</option>
	                       <option value="phone">번호</option>
	                </select>
	               <input type="search" name="title" onkeyup="characterCheck()" onkeydown="characterCheck()">
	               <button type="submit">검색</button>
	     </form>
     </div>
</div>
<script type="text/javascript">
//특수문자 금지  
function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
            var obj = document.getElementsByName("title")[0]
            if (RegExp.test(obj.value)) {
                alert("특수문자는 입력하실 수 없습니다.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
            }
        }
</script>

</body>
</html>