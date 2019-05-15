<%@ page contentType="text/html; charset=utf-8"%> <%--라틴어가 아닌 언어 출력을 위한 인코딩--%>
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scable= no, width=device-width" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Pragma" content="no-cache"/>
<script language='javascript' type='text/javascript'>
var orientationEvent;
var uAgent=navigator.userAgent.toLowerCase();
var mobilePhones= 'android';
if(uAgent.indexOf(mobilePhones) != -1) {
   orientationEvent="resize"; // 안드로이드는 resize로 
}
else orientationEvent="orientationchange"; // 아이폰이 들어오는 것 
window.addEventListener(orientationEvent, function()
{
// alert("회전했어요");
   location.href('#');
}, false);

var prevScreen = 0;
var sv_prevScreen= 0;
function prevShow()
{
      ScreenShow( prevScreen ); 
}   
//서브메뉴를 선택(하단 버튼을 누름)했을때 함수 
var muCnt = 5; //서브메뉴
var scCnt = 13; //화면
function fncShow( pos )
{
   var i = 0;
   
   // 모든 일반화면은 막는다.
   for( i = 0; i <scCnt; i++)
   {
      var obj = document.getElementById("s"+i);
      obj.style.display = 'none';
   }
   
   // 메뉴선택에 따라 중간메뉴 div는 보여주고, 누른 버튼의 배경을 바꿔준다. 
   
   for( i=0; i<muCnt; i++)
   {
      var obj = document.getElementById("menu"+i);
      var obj2 = document.getElementById("m"+i);
      
      if( i == pos ) {//클릭했을때 하단메뉴
         obj.style.display = '';
         obj2.style.background = "#ffffff";
      }else {//클릭안했을때 하단 메뉴
         obj.style.display = 'none';
         obj2.style.background="#DCDCDC";
      }
   }
}   

// 총 화면은 15개이고 화면이 선택된 번호에 따라 화면을 보여주는 함수 

var scCnt = 13;
var ScrObj;

var timer1;

function ScrAnimation() {
         var offset = -50;
         
         if(parseInt(ScrObj.style.left) > 10)
         {
            ScrObj.style.left = parseInt(ScrObj.style.left) + offset + "px";
            timer1 = setTimeout("ScrAnimation()", 1);
         }
         else 
         {
            ScrObj.style.left=5;
            clearTimeout(timer1);
         }
}

function ScreenShow ( pos )
{
   var i = 0;
   //모든 메뉴페이지는 막는다. 
   for ( i=0; i<muCnt; i++ ) {
      var obj = document.getElementById("menu"+i);
      obj.style.display = 'none';
   }
   
   //선택된 화면번호와 화면만 보여준다 
for( i = 0; i < scCnt; i++ )
   {
      var obj = document.getElementById("s"+i);
      
      if( i == pos )
      {
         prevScreen = sv_prevScreen;
         sv_prevScreen=i;
      
       obj.style.display = '';
      
         obj.style.position = "relative";
         obj.style.top=35;
         obj.style.left=screen.width;
         obj.style.height=screen.height-120;
         
         ScrObj=obj;
         ScrAnimation();
      } else {
         obj.style.display = 'none';
      }   
   }
}
</script>

<style type="text/css">

	@import url('https://fonts.googleapis.com/css?family=Noto+Serif+KR');
	.text_box3 {
	font-family: 'Noto Serif KR', serif;
	font-size: 42px;
	text-align: left;
	color: #ffffff;
	margin:10px;	<!-- 글씨 외부 여백 공간 -->
	padding-left:8px;	<!-- 글씨 문단 통으로 여백주는것 -->
	line-height:130%;	<!-- 글씨 상하 줄간격 -->
	}
	.text_box4 {
	font-family: 'Noto Serif KR', serif;
	font-size: 18px;
	text-align: left;
	color: #ffffff;
	margin:10px;	<!-- 글씨 외부 여백 공간 -->
	padding-left:8px;	<!-- 글씨 문단 통으로 여백주는것 -->
	line-height:130%;	<!-- 글씨 상하 줄간격 -->
	}
	.text_box5 {
	font-family: 'Noto Serif KR', serif;
	font-size: 14px;
	text-align: left;
	color: #ffffff;
	line-height:180%;
	padding-left:8px;
	padding-right:8px;
	}

   li { text-align:left; vertical-align:middle; margin:2; padding:10; height:20; background-color:#ffff00; border:2px; solid:red; font-size:16px}	<!-- 하단 메뉴 클릭했을때 뜨는 항목들 -->
   ui { text-align:left; vertical-align:middle; margin:2; padding:10; height:20; background-color:#ffffff; border:2px; solid:red; font-size:16px}	<!-- ui가 뭔지 정확히 모르겠음 -->
	<!--글씨색 크기 부분 -->

</style>
	  
</head>
<body>
<body onload='ScreenShow(0);' style="background-color:#000000;>
<center>
   <div id="container" style="width:device-width;height:device-height;">
      <div id="header1" style="background-color:#000000; height:30px; width:20%; float:left; vertical-align:middle; color:white;" onclick='prevShow();'><center>[이전]</center></div>
      <div id="header2" style="background-color:#000000; height:30px; width:60%; float:left; vertical-align:middle; color:white;" onclick='prevShow();'><center><b>Castle</b></center></div>
      <div id="header3" style="background-color:#000000; height:30px; width:20%; float:left; vertical-align:middle; color:white;" onclick='prevShow();'><center>[홈]</center></div>
      <div id="menu0" style="background-color:#000000;display:none;">
      <h1 style="color: #ffffff; padding-top:50px;">ABOUT</h1>
         <li onclick='ScreenShow(0);'>Castle</li>
         <li onclick='ScreenShow(1);'>VIP Room</li>
         <li onclick='ScreenShow(2);'>Suite Room</li>
         <li onclick='ScreenShow(3);'>Standard Room</li>
      </div>
      <div id="menu1" style="background-color:#000000; display:none;">
      <h1 style="color: #ffffff; padding-top:50px;">Map</h1>
         <li onclick='ScreenShow(4);'>The Way</li>
         <li onclick='ScreenShow(5);'>Public Transit</li>
         <li onclick='ScreenShow(6);'>Private Car</li>
      </div>
      <div id="menu2" style="background-color:#000000;display:none;">
      <h1 style="color: #ffffff; padding-top:50px;">TOURIST SPOT</h1>
         <li onclick='ScreenShow(7);'>Seoultower</li>
         <li onclick='ScreenShow(8);'>Bukchon Village</li>
         <li onclick='ScreenShow(9);'>Hangang River</li>
      </div>
      <div id="menu3" style="background-color:#000000;display:none;">
      <h1 style="color: #ffffff; padding-top:50px;">Reservation</h1>
         <li onclick='ScreenShow(10);'>예약상황</li>
         <li onclick='ScreenShow(11);'>예약하기</li>
      </div>
      <div id="menu4" style="background-color:#000000;display:none;">
      <h1 style="color: #ffffff; padding-top:50px;">Notice</h1>
         <li onclick='ScreenShow(12);'>News</li>
      </div>
      <div id="s0" style="height:200px; background-color:#000000;">
		<img src="image/main1.jpg" style='width:100%;'>
		<p class="text_box3">Welcom to<br>Castle</p>
		<p class="text_box5">Castle은 도심에 위치한 유럽풍 호텔으로 대한민국 수도, 서울의 비즈니스, 문화, 역사, 쇼핑의 중심부에 위치하고 있습니다. 비즈니스 중심지는 약 15분 거리 이내에 있으며, 인천국제공항에서도 1시간 이내에 도착할 수 있습니다.</p>
      </div>
      <div id="s1" style="height:200px; display:none;" class="text_box4">
		<h2 style="color: #ffffff;">VIP Room</h2>
		<center><img src="image/a_01.jpg" width="100%"><br><br>vip룸은 럭셔리 휴식 공간입니다</center>
      </div>
      <div id="s2" style="height:200px; display:none;" class="text_box4">
		<h2 style="color: #ffffff;">Suite Room</h2>
		<center><img src="image/a_02.jpg" width="100%"><br>일반룸은 아늑한 휴식 공간입니다</center>
      </div>
      <div id="s3" style="height:200px; display:none;" class="text_box4">
		<h2 style="color: #ffffff;">Standard Room</h2>
		<center><img src="image/a_03.jpg" width="100%"><br>합리적인룸 편안한 휴식 공간입니다</center>
      </div>
      <div id="s4" class="text_box5" style="height:200px; display:none;">
		  <img src="image/map_m.JPG" width="95%" height="40%">
		  <center><br>지도를 보고 잘 찾아오세요</center>
      </div>
      <div id="s5" align="left" style="height:200px; display:none; ">
		<p class="text_box5">
         <br><b>버스</b>
         <br>남산에 위치한 Castle은 남산 공원의 생태 환경 보호의 일환으로 2005년 5월 1일부터 일반 승용차량 통행이 제한되었습니다.
		 <br>여러분의 협조가 맑고 푸른 남산을 만듭니다.
         <br>
         <br><b>버스이용안내</b>
         <br>2번, 3번, 5번 남산순환버스
         <br>단체 관광객 버스
         <br>서울시티투어버스
		</p>
      </div>
      <div id="s6" align="left" style="height:200px; display:none;">
		<p class="text_box5">
         <br><b>자가차량</b>
         <br>2005년 5월 1일부터 남산 일반차량 통행제한에 따라 자가차량 이용시 인근 주차장을 이용해 주시기 바랍니다.
         <br>
         <br><b>인근주차장</b>
         <br>자세한 사항은 해당 홈페이지 또는 전화로 문의하시기 바랍니다.<br>
         <br>남산 케이블카 : 02-756-8881~4
         <br>서울스퀘어 : 02-6456-0100
         <br>국립극장 : 02-2280-4114
         <br>남산제이그랜하우스 : 02-2234-8000
         <br>남산공원 : 02-3783-5900
		</p>
      </div>
      <div id="s7" class="text_box4" style="height:200px; display:none;">
		<iframe width="95%" height="40%" src="https://www.youtube.com/embed/OxZ_rBT2t8w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		<center><br>리조트 바로 옆에 위치한 남산타워</center>
      </div>
      <div id="s8" class="text_box4" style="height:200px; display:none;">
		<iframe width="95%" height="40%" src="https://www.youtube.com/embed/ok4uMinefdM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        <center><br>한국의 정취를 느낄 수 있는 북촌한옥마을</center>
      </div>
      <div id="s9" class="text_box4" style="height:200px; display:none;">
		<iframe width="95%" height="40%" src="https://www.youtube.com/embed/fzE2lJJ08AY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		<center><br>도심 속 쉼터 한강</center>
      </div>
      <div id="s10" style="height:100%; display:none;">
		<iframe src="d_01_m.jsp" frameborder="0" border="0" bordercolor="white" width="95%" height="90%" marginwidth="0" marginheight="0" scroling="yes"></iframe>
      </div>
      <div id="s11" style="height:100%; display:none;">
		<iframe src="d_02_m.jsp" frameborder="0" border="0" bordercolor="white" width="95%" height="90%" marginwidth="0" marginheight="0" scroling="yes"></iframe>
      </div>
      <div id="s12" style="height:100%; display:none;">
		<iframe src="e_01_m.jsp" frameborder="0" border="0" bordercolor="white" width="95%" height="90%" marginwidth="0" marginheight="0" scroling="yes"></iframe>
      </div>
      <div id="m0" onclick='fncShow(0);' style="position:absolute; bottom:6px; position:absolute; left:3%; background-color:#ffffff; height:60px; width:17%; float:left; font-size:14px;">
         <center><img src="image/i_castle.png" width=40px height=40px><br><b>About</b></center>
      </div>
      <div id="m1" onclick='fncShow(1);' style="position:absolute; bottom:6px; position:absolute; left:22%; background-color:#ffffff; height:60px; width:17%; float:left; font-size:14px;">
         <center><img src="image/i_pin.png" width=40px height=40px><br><b>Map</b></center>
      </div>
      <div id="m2" onclick='fncShow(2);' style="position:absolute; bottom:6px; position:absolute; left:41%; background-color:#ffffff; height:60px; width:17%; float:left; font-size:14px;">
         <center><img src="image/i_spot.png" width=40px height=40px><br><b>HotSpot</b></center>
      </div>
      <div id="m3" onclick='fncShow(3);' style="position:absolute; bottom:6px; position:absolute; left:60%; background-color:#ffffff; height:60px; width:17%; float:left; font-size:14px;">
         <center><img src="image/i_booking.png" width=40px height=40px><br><b>Booking</b></center>
      </div>
      <div id="m4" onclick='fncShow(4);' style="position:absolute; bottom:6px; position:absolute; left:79%; background-color:#ffffff; height:60px; width:17%; float:left; font-size:14px;">
         <center><img src="image/i_news.png" width=40px height=40px><br><b>Notice</b></center>
      </div>
   </div>
</center>
</html>