<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<!-- Bootstrap CSS -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

<head>
<title>사용자 수정</title>
<style type="text/css">
	tr.row-name
		{ font-size: 18px; color:#448aff;}
	tr.row-content
		{color:#6c7173;}
	.table
		{ border: 2px solid #F0F2F2;
		background:#fcfcfc; }

	.table-striped>tbody>tr:nth-of-type(odd)
		{ background:#F0F2F2 !important; }
	a.del {
	    background:#d9534f;
	    width: 30px;
	    height:30px;
	    }
	a.edit{
	    padding-left:9px;
	    padding-top:8px;
	    background:#337ab7;
	    color:#ffffff;
	    width: 30px;
	    height:30px;
	    border:none;}
	a.btn-danger:hover
		{ background: #de6c69; }
	a.btn-danger
		{ background:#d9534f; }
</style>
</head>
<body>
<form method="POST" id="update" name="update">
<input type="hidden" name="id" value="${user.id }">
<div class="container col-md-6" style="float: none; margin: 0 auto;"> <!-- container는 표를 가운데 정렬하기 위해서 -->
<h2 style="color: #448aff; text-align: center; margin: 30px;"><b>사용자 상세보기</b></h2>
<table class="table table-striped">
	<thead>
		<tr class="row-name">
			<th style="width:15%">User id</th>
			<th style="width:20%">이름</th>
			<th style="width:15%">Phone id</th>
			<th style="width:26%">전화번호</th>
			<th style="width:12%">P.수정</th>
			<th style="width:12%">P.삭제</th>
		</tr>
	</thead>
	<tbody>
		<tr class="row-content">
			<td rowspan=10><input type="text" class="form-control" name="id" size="10px" value="${user.id}" readonly></td>
			<td rowspan=10><input type="text" class="form-control" onkeyup="fnChkByte(this);" name="name" size="20px" value="${user.name}"></td>
		</tr>
		<c:forEach items="${phones}" var="phones">
		<tr class="row-content">
			<td><input type="text" class="form-control" size="10px" value="${phones.id}" readonly></td>
			<c:set var="TextValue" value="${phones.phoneNumber}"/>  
			<td><input type="text" class="form-control" size="15px" value="${fn:substring(TextValue,0,3) }-${fn:substring(TextValue,3,7) }-${fn:substring(TextValue,7,11) }" readonly></td>
			<td><a class="btn btn-info edit" href=<c:url value='/phoneEditform?phoneId=${phones.id}'/>>
				<i class="fa fa-pencil-square-o" ></i></a></td>
			<td><a class="btn btn-danger edit" href=<c:url value='/phoneDelete?phoneId=${phones.id}'/>>
				<i class="fa fa-trash"></i></a></td>
		</tr>
		</c:forEach>
	</tbody>
</table>
	<div style="float:right;">
	  <button onClick='fn_addtoGongji2()' class="btn btn-info">이름 수정</button>
      <a href=<c:url value='/delete?userId=${user.id}'/> class="btn btn-info" role="button">이름 삭제</a>
      <a href=<c:url value='/phoneAddform?userId=${user.id}'/> class="btn btn-info" role="button">전화번호 추가</a>
      <a href=<c:url value='/list'/> class="btn btn-info" role="button">목록</a>
     </div>
</div>
</form>

<script>
	//글쓰기
	function fn_addtoGongji2(){
	    
	    var form = document.getElementById("update");
	    
	    if(form.name.value == ""){
	        alert("이름을 입력해 주세요.");
	        frm.name.focus();
	        return;
	    }
	  form.action = "<c:url value='/update.html'/>"; //다 돌고 나서 작성 버튼 클릭시 Gongji1Controller에 있는 write를 돌려서 작성
	  form.submit();
	}
	//글자 수 제한 
	function fnChkByte(obj) {
		  
		   var obj = document.getElementsByName("name")[0]
		   
		   var maxByte = 20; //최대 입력 바이트 수
		    var str = obj.value;
		    var str_len = str.length;

		    var rbyte = 0;
		    var rlen = 0;
		    var one_char = "";
		    var str2 = "";

		    for (var i = 0; i < str_len; i++) {
		        one_char = str.charAt(i);
		 
		        if (escape(one_char).length > 4) {
		            rbyte += 2; //한글2Byte
		        } else {
		            rbyte++; //영문 등 나머지 1Byte
		        }

		        if (rbyte <= maxByte) {
		            rlen = i + 1; //return할 문자열 갯수
		        }
		    }
		 
		    if (rbyte > maxByte) {
		        alert("한글 " + (maxByte / 2) + "자 / 영문 " + maxByte + "자를 초과 입력할 수 없습니다.");
		        str2 = str.substr(0, rlen); //문자열 자르기
		        obj.value = str2;
		        fnChkByte(obj, maxByte);
		    } else {
		        document.getElementById('byteInfo').innerText = rbyte;
		    }
		}
</script>
</body>
</html>