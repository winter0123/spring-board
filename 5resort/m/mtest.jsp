<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scable= no, width=device-width" />
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
 alert("회전했어요");
   location.href('#');
}, false);

//서브메뉴를 선택(하단 버튼을 누름)했을때 함수 
var muCnt = 5; //서브메뉴
var scCnt = 15; //화면
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
      
      if( i == pos ) {
         obj.style.display = '';
         obj2.style.background = "#ff0000";
      }else {
         obj.style.display = 'none';
         obj2.style.background="#FFFF00";
      }
   }
}   

// 총 화면은 15개이고 화면이 선택된 번호에 따라 화면을 보여주는 함수 

var scCnt = 15;
function ScreenShow ( pos )
{
   var i = 0;
   //모든 메뉴페이지는 막는다. 
   for ( i=0; i<muCnt; i++ ) {
      var obj = document.getElementById("menu"+i);
      obj.style.display = 'none';
   }
   
   //선택된 화면번호와 화면만 보여준다 
   for( i=0; i<scCnt; i++) {
      var obj = document.getElementById("s"+i);
         
         if ( i == pos ) {
            obj.style.display = '';
         } else {
            obj.style.display = 'none';
         }
   }
}
</script>   
</head>
<body>
<center>
   <div id="container" style="width:device-width;height:device-height;">
      <div id="header1" style="background-color:#00ffff;height:35px;width:10%;float:left;vertical-align:middle;"><center>[이전]</center></div>
      <div id="header2" style="background-color:#00ffff;height:35px;width:80%;float:left;vertical-align:middle;"><center>폰페이지입니다</center></div>
      <div id="header3" style="background-color:#00ffff;height:35px;width:10%;float:left;vertical-align:middle;"><center>[홈]</center></div>
      
      <div id="menu0" style="background-color:#EEEEEE;display:none;">
      나 메뉴0
         <li onclick='ScreenShow(0);'>메뉴0_1</li>
         <li onclick='ScreenShow(1);'>메뉴0_2</li>
         <li onclick='ScreenShow(2);'>메뉴0_3</li>
      </div>
      <div id="menu1" style="background-color:#EEEEEE;display:none;">
      나 메뉴1
         <li onclick='ScreenShow(3);'>메뉴1_1</li>
         <li onclick='ScreenShow(4);'>메뉴1_2</li>
         <li onclick='ScreenShow(5);'>메뉴1_3</li>
      </div>
      <div id="menu2" style="background-color:#EEEEEE;display:none;">
      나 메뉴2
         <li onclick='ScreenShow(6);'>메뉴2_1</li>
         <li onclick='ScreenShow(7);'>메뉴2_2</li>
         <li onclick='ScreenShow(8);'>메뉴2_3</li>
      </div>
      <div id="menu3" style="background-color:#EEEEEE;display:none;">
      나 메뉴3
         <li onclick='ScreenShow(9);'>메뉴3_1</li>
         <li onclick='ScreenShow(10);'>메뉴3_2</li>
         <li onclick='ScreenShow(11);'>메뉴3_3</li>
      </div>
      <div id="menu4" style="background-color:#EEEEEE;display:none;">
      나 메뉴4
         <li onclick='ScreenShow(12);'>메뉴4_1</li>
         <li onclick='ScreenShow(13);'>메뉴4_2</li>
         <li onclick='ScreenShow(14);'>메뉴4_3</li>
      </div>
      <div id="s0" style="height:200px;">
      나 메뉴0_1에 대한 화면만
      </div>
      <div id="s1" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴0_2에 대한 화면
      </div>
      <div id="s2" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴0_3에 대한 화면
      </div>
      <div id="s3" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴1_1에 대한 화면
      </div>
      <div id="s4" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴1_2에 대한 화면
      </div>
      <div id="s5" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴1_3에 대한 화면
      </div>
      <div id="s6" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴2_1에 대한 화면
      </div>
      <div id="s7" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴2_2에 대한 화면
      </div>
      <div id="s8" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴2_3에 대한 화면
      </div>
      <div id="s9" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴3_1에 대한 화면
      </div>
      <div id="s10" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴3_2에 대한 화면
      </div>
      <div id="s11" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴3_3에 대한 화면
      </div>
      <div id="s12" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴4_1에 대한 화면
      </div>
      <div id="s13" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴4_2에 대한 화면
      </div>
      <div id="s14" style="height:200px;background-color:#5f5f5f;display:none;">
      나 메뉴4_3에 대한 화면
      </div>
      <div id="m0" onclick='fncShow(0);' style="position:absolute;bottom:3px;position:absolute;left:1%;background-color:#FF0000;height:80px;width:18%;float:left;">
         <center>[메뉴0]</center>
      </div>
      <div id="m1" onclick='fncShow(1);' style="position:absolute;bottom:3px;position:absolute;left:21%;background-color:#FF0000;height:80px;width:18%;float:left;">
         <center>[메뉴1]</center>
      </div>
      <div id="m2" onclick='fncShow(2);' style="position:absolute;bottom:3px;position:absolute;left:41%;background-color:#FF0000;height:80px;width:18%;float:left;">
         <center>[메뉴2]</center>
      </div>
      <div id="m3" onclick='fncShow(3);' style="position:absolute;bottom:3px;position:absolute;left:61%;background-color:#FF0000;height:80px;width:18%;float:left;">
         <center>[메뉴3]</center>
      </div>
      <div id="m4" onclick='fncShow(4);' style="position:absolute;bottom:3px;position:absolute;left:81%;background-color:#FF0000;height:80px;width:18%;float:left;">
         <center>[메뉴4]</center>
      </div>
   </div>
</center>
</html>