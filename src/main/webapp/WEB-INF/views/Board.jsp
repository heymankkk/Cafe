<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="/TK/resources/js/Board.js" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<link href="/TK/resources/css/Board.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<script>
var cafeurl="<%=(String)request.getAttribute("cafeurl")%>";

function login(){
	$('#login').css('display','none');
	$('#loginform').css('display','inline-block');
}
function logout(){
	$.ajax({
		method : 'POST',
		url : '/TK/cafe/logout',
		headers : {
			'Content-Type' : 'application/json',
			'X-HTTP-Method-Override' : 'POST'
		}
	})
	alert('로그아웃되었습니다.');
	$('#logout').css('display','none');
	$('#login').css('display','inline-block');
}

function addboardcate2(cate1,kind){
	var addboardname="";
	var count=0;
	
	var abc = true;
	addboardname=prompt(cate1+"에 추가할 게시판 이름을 입력하세요.(8자 이하)");
	while(abc){
		if(addboardname.length>8){
			alert("글자수 초과");
			addboardname=prompt(cate1+"에 추가할 게시판 이름을 입력하세요.(8자 이하)");
		}else{abc=false;}
	}
	
	if(!(addboardname=="" || addboardname==null)){
		$.getJSON("/TK/cafe/prikeycate/"+cafeurl+"/"+kind, function(data) {
			$(data).each(function(){
				if(this.category2==addboardname){count++;}
			})
			if(count==0){
				location.href="/TK/cafe/addboardcate2?cafeurl="+cafeurl+"&category1="+cate1+"&name="+addboardname;
			}else{
				alert("같은 이름의 게시판이 존재합니다.");
			}
		})
	}else{
		alert("잘못 입력하였습니다.")
	}
}
function addboardcate1(kind){
	var addboardname="";
	var count=0;
	
	var abc = true;
	addboardname=prompt("추가할 카테고리 이름을 입력하세요.(8자 이하)");
	while(abc){
		if(addboardname.length>8){
			alert("글자수 초과");
			addboardname=prompt("추가할 카테고리 이름을 입력하세요.(8자 이하)");
		}else{abc=false;}
	}
	
	if(!(addboardname=="" || addboardname==null)){
		$.getJSON("/TK/cafe/prikeycate/"+cafeurl+"/"+kind, function(data) {
			$(data).each(function(){
				if(this.category1==addboardname){count++;}
			})
			if(count==0){
				location.href="/TK/cafe/addboardcate1?cafeurl="+cafeurl+"&name="+addboardname;
			}else{
				alert("같은 이름의 게시판이 존재합니다.");
			}
		})
	}else{
		alert("잘못 입력하였습니다.")
	}
}
function headd(aa){
	if($(aa).val()=='1'){
		aa.parentElement.childNodes[4].checked=false;
	}else{
		aa.parentElement.childNodes[2].checked=false;
	}
}
var cate1num=1;
var cate2num=1;

function adjcate(input, kind){
	if(document.getElementById('chk1').checked==true){
		var category = input.innerHTML;
		var count=0;
		var adjname="";
		
		var abc = true;
		adjname=prompt("새로운 이름을 입력하세요");
		while(abc){
			if(adjname.length>8){
				alert("글자수 초과");
		  		adjname=prompt("새로운 이름을 입력하세요.(8자 이하)");
			}else{abc=false;}
		}
		
	  	if(!(adjname=="" || adjname==null)){
			$.getJSON("/TK/cafe/prikeycate/"+cafeurl+"/"+kind, function(data) {
				$(data).each(function(){
					if(kind=="category1"){
						if(this.category1==adjname){count++;}
					}else if(kind=="category2"){
						if(this.category2==adjname){count++;}
					}
				})
				if(count==0){
					location.href="/TK/cafe/adjcate?cafeurl="+cafeurl+"&category="+category+"&name="+adjname+"&kind="+kind;
				}else{
					alert("같은 이름의 게시판이 존재합니다.");
				}
			})
		}else{
			alert("잘못 입력하였습니다.")
		}
	}else if(kind=="category2"){
		location.href="/TK/cafe/list/"+cafeurl+"/"+input.innerHTML;
	}
}

function removeboard(category,kind){
	$.getJSON("/TK/cafe/removeboardnone?category="+category+'&kind='+kind+'&cafeurl='+cafeurl, function(data) {
		if(data==1){
			alert("해당 카테고리의 마지막 게시판입니다.\n마지막 게시판은 삭제할 수 없습니다.");
			return;
		}else{
			if(confirm("'"+category+"' 을/를 삭제하시겠습니까?")){
				location.href='/TK/cafe/removeboard?category='+category+'&kind='+kind+'&cafeurl='+cafeurl;
			}else{
				return;
			}
		}
	})

}

function position(name,updown,category){
	var realname = name.parentElement.parentElement.childNodes[0].innerHTML
	location.href="/TK/cafe/position?updown="+updown+"&kind="+category+"&category="+realname+"&cafeurl="+cafeurl
}

$(document).ready(function(){
	<%if((String)session.getAttribute("userid")!=null){%>
		$('#login').css('display','none');
		$('#logout').css('display','inline-block');
	<%}else{%>
		$('#logout').css('display','none');
		$('#login').css('display','inline-block');
	<%}%>
	/* 카페주인만 관리자기능 뜨게함 */
	$.getJSON("/TK/cafe/getcafe?cafeurl="+cafeurl, function(data){
		if(data.userid=="<%=(String)session.getAttribute("userid")%>"){
			$('#head').css('display','inline-block');
		}else{
			$('#head').css('display','none');
		}
	})
	/* 카페별 게시판목록 출력 */
	$.getJSON("/TK/cafe/boardlist/"+cafeurl, function(data) {
		var str="<div id=\"nocate\" onclick=\"location.href='/TK/cafe/list/"+cafeurl+"/전체글보기'\">전체글보기</div>";
		var abc="";
		$(data).each(function(){
			if(abc != this.category1){
				str += "<div id=\"cate1_"+cate1num+"\" class=\"category1\">"
					+  "<span onclick=\"adjcate(this, 'category1')\">"+this.category1+"</span>"
					+  "<span class=\"removeboard\" onclick=\"removeboard('"+this.category1+"','category1')\">-</span>"
					+  "<span class=\"addboard\" onclick=\"addboardcate2('"+this.category1+"','category2')\">+</span>"
					+  "<span id=\"pos1_"+cate1num+"\" class=\"position1\"></span>"
					+  "</div>";
				abc = this.category1;
				cate1num++;
			}
			str += "<div id=\"cate2_"+cate2num+"\" class=\"category2\">"
				+  "<span onclick=\"adjcate(this, 'category2')\">"+this.category2+"</span>"
				+  "<div class=\"fakeaddboard\"></div>"
				+  "<span id=\"pos2_"+cate2num+"\" class=\"position2\"></span>"
				+  "<span class=\"removeboard\" onclick=\"removeboard('"+this.category2+"','category2')\">-</span>"
				+  "</div>";
			cate2num++;
		})
		str += "<div class=\"addboard\" onclick=\"addboardcate1('category1')\">+</div>";
		$('#boardlist').html(str);
				/* 게시판 위치 이동 기능 */
				$.getJSON("/TK/cafe/boardlist/"+cafeurl, function(data) {
					var sendabc=""; var abc=""; var cate1count=1; var cate2count=1; var flw=0; var count=0; var abcd=0;
					$(data).each(function(){
						if(abc != this.category1){
							abcd=flw-cate1count;
							if(abcd==1){
								sendabc = "";
								$('#pos2_'+count).html(sendabc);
							}else{
								sendabc = "<span onclick=\"position(this,'up','category2')\">∧</span>";
								$('#pos2_'+count).html(sendabc);						
							}
							if(cate1count==1){
								sendabc = "<span onclick=\"position(this,'down','category1')\">▽</span>";
								$('#pos1_'+cate1count).html(sendabc);
							}else if(cate1count==cate1num-1){
								sendabc = "<span onclick=\"position(this,'up','category1')\">△</span>";
								$('#pos1_'+cate1count).html(sendabc);
							}else{
								sendabc = "<span onclick=\"position(this,'up','category1')\">△</span>"
										+  "<span onclick=\"position(this,'down','category1')\">▽</span>";
								$('#pos1_'+cate1count).html(sendabc);
							}
							abc = this.category1;
							cate1count++;
							flw = cate1count;
						}
						if(cate1count==flw){
							sendabc = "<span onclick=\"position(this,'down','category2')\">∨</span>";
							$('#pos2_'+cate2count).html(sendabc);
							flw++;
						}else if(cate2count==9999){
							sendabc = "<span onclick=\"position(this,'up','category2')\">∧</span>";
							$('#pos2_'+cate2count).html(sendabc);
							flw++;
						}else{
							sendabc = "<span onclick=\"position(this,'up','category2')\">∧</span>"
									+  "<span onclick=\"position(this,'down','category2')\">∨</span>";
							$('#pos2_'+cate2count).html(sendabc);
							flw++;
						}
						count=cate2count;
						cate2count++;
					})
					abcd=flw-cate1count;
					if(abcd==1){
						sendabc = "";
						$('#pos2_'+count).html(sendabc);
					}else{
						sendabc = "<span onclick=\"position(this,'up','category2')\">∧</span>";
						$('#pos2_'+count).html(sendabc);						
					}
				})
	})
	/* 로그인기능 */
	$('#checkidpw').on('click', function(){
		var userid=$('#userid').val();
		var userpw=$('#userpw').val();
		$.ajax({
			method : 'POST',
			url : '/TK/cafe/login',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'POST'
			},
			dataType : 'text',
			data : JSON.stringify({
				userid : userid,
				userpw : userpw
			}),
			success:function(result){
				if(result=='SUCCESS'){
					alert('로그인 되었습니다.');
					window.location.replace("");
				}else if(result=='FAIL'){
					alert('아이디나 비밀번호가 틀렸습니다.');
				}
			}
		})
	})
	/* hover 관리자기능 */
	$('#boardlist').mouseenter(function(){
		if(document.getElementById('chk1').checked==true){
			$('#a').css('position','absolute');
			$('#a').css('left','0');
			$('#a').css('right','0');
			$('#a').css('top','0');
			$('#a').css('bottom','0');
			$('#a').css('background','url(//img.echosting.cafe24.com/smartAdmin/img/design/bg_linker.png) repeat 0 0');
			$('#b').css('position','absolute');
			$('#b').css('top','179px');
			$('#b').css('left','-1px');
			$('#b').css('width', '200px');
			$('#b').css('min-height', $('#boardlist').css('height'));
			$('#b').css('border','1px solid orange');
			$('#b').css('padding','20px 0px 0px 20px');
			$('#b').html($('#boardlist').html());
			
			$('.removeboard').css('display','inline-block');
			$('.addboard').css('display','inline-block');
			$('.fakeaddboard').css('display','inline-block');
			$('.position1').css('display','inline-block');
			$('.position2').css('display','inline-block');
		}
	})
	$('#b').mouseleave(function(){
		if(document.getElementById('chk1').checked==true){
			$('#a').css('right','');
			$('#a').css('bottom','');
			$('#b').css('border','0px');
			$('#b').css('top','');
			$('#b').css('width','');
			$('#b').html('');
			$('#b').css('padding','0');
			$('.removeboard').css('display','none');
			$('.addboard').css('display','none');
			$('.fakeaddboard').css('display','none');
			$('.position1').css('display','none');
			$('.position2').css('display','none');
		}
	})
})
</script>
</head>
<body>
<div id="main">
<div id="a"></div><!-- 관리자기능 -->
<div id="b"></div><!-- 관리자기능 -->
<div id="zzz"></div><!-- 관리자기능 -->
	<div id="header">// 공사중 //
		<div id='gotocafe' onclick="location.href='/TK/cafe'">CAFE.com</div>
		<div id="login" onclick="login()">로그인</div>
		<div id="loginform">
			<div id="form2">
				<input id="checkidpw" type="submit" value="로그인">
			</div>
			<div id="form1">
				<span>ID :</span><input type="text" name="userid" id="userid"><br>
				<span>PW :</span><input type="password" name="userpw" id="userpw">
			</div>
		</div>
		<div id="logout" onclick="logout()">로그아웃</div>
		<div id="head"><!-- 관리자기능 추가 -->
			<input id="chk1" type="radio" value="1" onclick="headd(this)">사용함
			<input id="chk2" type="radio" value="0" onclick="headd(this)">사용안함
		</div>
		
	</div>
	<div id="left">
		<div id="lefttop">
			[카페지기]<br> ${cafe.userid}<br><br>
			[카페소개]<br> 
			${cafe.cafename}<br>
			${cafe.cafeintro}
		</div>
		<div id="boardlist" style="padding:20px 0px 0px 20px;">
			
		</div>
	</div>
	<c:if test="${action=='Boardlist'}">
		<%@ include file="Boardlist.jsp" %>
	</c:if>
	<c:if test="${action=='Write'}">
		<%@ include file="Write.jsp" %>
	</c:if>
	<c:if test="${action=='Readpage'}">
		<%@ include file="Readpage.jsp" %>
	</c:if>
	<c:if test="${action=='Modifypage'}">
		<%@ include file="Modifypage.jsp" %>
	</c:if>
	
</div>


<script>
$(document).ready(function() {
	$('#searchBtn').on("click",	function(event) {
		self.location = '${category}'
		+ '${pageMaker.makeQuery(1)}'
		+ "&searchType="
		+ $("select option:selected").val()
		+ "&keyword=" + $('#keywordInput').val();
	});

	$('#newBtn').on("click", function(evt) {
		<%if((String)session.getAttribute("userid")!=null){%>
			self.location = "Write";	// 글쓰기 
		<%}else{%>
			alert("로그인 후 사용 가능합니다.");
		<%}%>
	});
});
</script>
</body>
</html>