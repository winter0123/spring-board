<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<!-- Bootstrap CSS -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<head>
<title>Insert title here</title>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
tr.row-name { font-size: 18px; color:#448aff; }
tr.row-content {color:#6c7173;}
table { border: 2px solid #F0F2F2; }
</style>
</head>
<body>
<h2 style="color: #448aff; text-align: center; margin: 30px;"><b>신규 유저 입력</b></h2>
<form method="POST" id="newform" name="newform">
<div class="container col-md-5" style="float: none; margin: 0 auto;"> <!-- container는 표를 가운데 정렬하기 위해서 -->
	<table class="table table-striped">
		<thead>
    		<tr class="row-name">
	    		<th>이름</label></th>
	    		<th>전화번호</label></th>
	    		
    		</tr>
    	</thead>
    	<tbody>
    		<tr class="row-content">
	    		<td><input type="text" class="form-control" onkeyup="fnChkByte(this);" id="name" name="name"></td>
	    		<td><input type="text" class="form-control"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' id="phonenumber" name="phonenumber" placeholder="휴대폰 번호 입력(숫자만)" ></td>
    		</tr>
    	</tbody>
    </table>
    <div style="float:right;">
    	<button type="button" onclick="location.href='list.html'" class="btn btn-info">목록</button>
    	<button onClick='fn_addtoGongji1()' class="btn btn-info">등록</button>
    </div>
</div>
    
</form>
<script>
	//이름 필수 입력
	function fn_addtoGongji1(){
	    
	    var form = document.getElementById("newform");
	    
	    if(form.name.value == ""){
	        alert("이름을 입력해 주세요.");
	        frm.eachtitle.focus();
	        return;
	    }
	  form.action = "<c:url value='/save.html'/>";
	  form.submit();
	}
	//숫자만 입력받음(문자받은것 제거)
	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
	
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
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