<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <script src="https://code.jquery.com/jquery-1.11.3.js"></script> -->
<!-- <script src="/TK/resources/js/Center.js" type="text/javascript"></script> -->
<!-- <link href="/TK/resources/css/Center.css" rel="stylesheet" type="text/css"> -->
<meta charset="UTF-8">
<title>김국건</title>
<style>
body{
	margin:0 auto;
}
#MRCdiv{
	
}
#MRC{
	width: 265px;
	height: 150px;
}
#CVS{
	width: 100%;
	height: 850px;
	display:block;
	background:black; 
}
</style>
</head>
<body>
<button onclick="location.href='/IKEA/IKEA_com/IKEA_COM.jsp'">ikea</button>
<button onclick="location.href='cafe'">cafe</button>
<!-- <div id="RMCdiv">
	<video autoplay muted id="MRC" src="/TK/resources/media/MRC.mp4"></video>
</div> -->

<canvas id="CVS"></canvas>
<script>
//Initialising the canvas
var canvas = document.querySelector('canvas'),
  ctx = canvas.getContext('2d');

//Setting the width and height of the canvas
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

//Setting up the letters
var letters = 'ABCDEFGHIJKLMNOPQRSTUVXYZABCDEFGHIJKLMNOPQRSTUVXYZABCDEFGHIJKLMNOPQRSTUVXYZABCDEFGHIJKLMNOPQRSTUVXYZABCDEFGHIJKLMNOPQRSTUVXYZABCDEFGHIJKLMNOPQRSTUVXYZ';
letters = letters.split('');

//Setting up the columns
var fontSize = 15,
  columns = canvas.width / fontSize;

//Setting up the drops
var drops = [];
for (var i = 0; i < columns; i++) {
drops[i] = 1;
}

alert("fontSize : "+fontSize+
		"\n drops.length : "+drops.length+
		"\n canvas.width : "+canvas.width+
		"\n canvas.height : "+canvas.height);
//Setting up the draw function
function draw() {
ctx.fillStyle = 'rgba(0, 0, 0, .1)';
ctx.fillRect(0, 0, canvas.width, canvas.height);
for (var i = 0; i < drops.length; i++) {
  var text = letters[Math.floor(Math.random() * letters.length)];
  ctx.fillStyle = '#0f0';
  ctx.fillText(text, i * fontSize, drops[i] * fontSize);
  drops[i]++;
  if (drops[i] * fontSize > canvas.height && Math.random() > .95) {
    drops[i] = 0;
  }
}
}

//Loop the animation
setInterval(draw, 33);
</script>
</body>
</html>