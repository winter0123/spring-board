<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
<title>Welcome to Castle</title>
<style>
body,html { 
    margin: 0;
    padding: 0;
    height: 100%;
}
.bgimg {	
    border: 0;
    padding: 0; 
    background-image: url('image/main.jpg');
    min-height: 100%;
    background-position: center;
    background-size: cover;
}
</style>
</head>
<body>
    <%
    Cookie lastDate = null; //new Cookie("lastDate", nowDate)
    String nowDate = ""+System.currentTimeMillis();
	
    //cookie의 value로 문자열을 저장하기 위해
    //lastDate라는 쿠키가 없으면 최초 방문이다. -> lastDate 쿠키를 만든다.
    //최초 방문이면 "처음 방문입니다." 라는 메세지를 출력
    //최초 방문이 아니면 언제 접속했는지 lastDate를 출력하라
    //오랜만에 접속 시 비밀번호를 바꾸게 한다.
    //강의 페이지 -> 접속하지 않으면 여러가지 메세지.
    Cookie[] cookies = request.getCookies();
    if(cookies!=null){//null을 for문으로 돌릴 수 없기 때문에.
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("lastDate")){
                lastDate = cookie;
                //이 때는 최초 방문이 아니다.
            }
        }
    }
    if(lastDate==null){
        %>
        <div class="bgimg" align=right><h3>처음 방문입니다. 환영합니다.</h3></div>
        <%
        lastDate = new Cookie("lastDate", nowDate);
        lastDate.setMaxAge(365*24*60*60);
        //lastDate.setPath("./");//./기본경로 "/" 절대경로로 지정하지 말 것.
        //(Localhost:3306)/절대경로로 지정하면 다른 프로젝트에서도 쿠키카 유효함
        //(Localhost:3306/L01Cookie/) 상대경로
        response.addCookie(lastDate);
    }else{
        long conv = new Long(lastDate.getValue()).longValue();
        //String type -> long type으로 변환
        Date date = new Date(conv);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초",Locale.KOREA);
		sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
        
        %>
		<div class="bgimg" align=right><h3>당신의 마지막 방문일은 : <%=sdf.format(date)%></h3></div>  
        <%
        lastDate.setValue(nowDate); //마지막 방문일 업데이트 
        response.addCookie(lastDate);
    }
    %>
</frameset>
</body>
</html>