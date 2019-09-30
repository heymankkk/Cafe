<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<%
	String userid = (String) session.getAttribute("userid");
	if (userid == null) {
		userid = "";
	}
%>
<head>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<link href="/TK/resources/css/CafeAll.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function login(){
	$('#login').css('display','none');
	$('#loginform').css('display','inline-block');
	
	/* if($('#loginform').css('display')=='none'){
		$('#loginform').css('display','inline-block');
	}else{
		$('#loginform').css('display','none');
	} */
}

function setimage(input, url){
	$("#"+url).css('width','145px');
	$("#"+url).css('height','80px');
	$("#"+url).css('margin-bottom','5px');
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			document.getElementById(url).src=e.target.result;
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function makecafe(){
	if($('#makecafediv').css('display')=='none'){
		$('#makecafediv').css('display','inline-block');
	}else{
		$('#makecafediv').css('display','none');
	}
}

$(document).ready(function(){
	var userid = "<%=(String) session.getAttribute("userid")%>";
	if(userid=='null'){ // 비로그인시
		$('#btrlogin').css('display','none');
		$('#btrlogoff').css('display','inline-block');
	}else{ // 로그인시
		$('#btrlogin').css('display','inline-block');
		$('#btrlogoff').css('display','none');
		$.ajax({ // 내카페 유무 확인
			type : 'POST',
			url : '/TK/iscafe',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'POST'
			},
			dataType : 'text',
			data : JSON.stringify({
				userid : userid
			}),
			success : function(result){
				if(result == '0'){
					$('#iscafe0').css('display','inline-block');
					$('#iscafe1').css('display','none');
				}else if(result == '1'){ // 내카페 있을 시 CafeVO 데이터 추출
					$('#iscafe0').css('display','none');
					$('#iscafe1').css('display','inline-block');
					/* 
					$.ajax({
						type : 'POST',
						url : '/TK/cafeinfo',
						headers : {
							'Content-Type' : 'application/json',
							'X-HTTP-Method-Override' : 'POST'
						},
						dataType : 'text',
						data : JSON.stringify({
							userid : userid
						}),
						success : function(data){
							alert(data);
							alert(data.userid);
							var str="userid : "+data.userid+
							"<br>cafename : "+data.cafename+
							"<br>cafeurl : "+data.cafeurl+
							"<br>cafepopulation : "+data.cafepopulation+
							"<br>cafeinfoimg : "+data.cafeinfoimg+
							"<br>cafeheadimg : "+data.cafeheadimg+
							"<br>regdate : "+data.regdate;
							
							$('#iscafe1').html(str);
						}
					})
					 */
					
					$.getJSON('/TK/cafeinfo/'+userid, function(data){ // return말고 model로 하려면 home컨트롤러에서 작업해야함.
						var str="<div id=\"gotocafe\" class=\"text1\" onclick=\"location.href='/TK/cafe/list/"+data.cafeurl+"/main'\">내 카페 가기</div><div id=\"iscafe11\"></div>"+
						"<div id=\"iscafe1info\">카페지기 : "+data.userid+
						"<br><br>카페이름 : "+data.cafename+
						"<br><br>카페소개 : "+data.cafeintro+
						"<br><br>카페주소 : "+data.cafeurl+
						"<br><br>명함사진 : "+data.cafeinfoimg+
						"<br><br>대문사진 : "+data.cafeheadimg+
						"<br><br>개설일자 : "+data.regdate+
						"</div>"
						$('#iscafe1').html(str);

					})
					
				}
			}
		})	
	}
	
<%if ((String) session.getAttribute("userid") != null) {%>
	$('#login').css('display', 'none');
	$('#logout').css('display', 'inline-block');
	$('#newid').css('display', 'none');
<%} else {%>
	$('#logout').css('display', 'none');
	$('#login').css('display', 'inline-block');
	$('#newid').css('display', 'inline-block');
<%}%>
	
	$('#checkidpw').on('click', function() {
					var userid = $('#userid').val();
					var userpw = $('#userpw').val();
					$.ajax({
						method : 'POST',
						url : '/TK/login',
						headers : {
							'Content-Type' : 'application/json',
							'X-HTTP-Method-Override' : 'POST'
						},
						dataType : 'text',
						data : JSON.stringify({
							userid : userid,
							userpw : userpw
						}),

						success : function(result) {
							if (result == 'SUCCESS') {
								alert('로그인 되었습니다.');
								window.location.replace("/TK");
							} else if (result == 'FAIL') {
								alert('아이디나 비밀번호가 틀렸습니다.');
							}

						}
					})
				})
				
	$('#searchBtn').on("click",	function(event) {
		self.location = '${category}'
		+ '${pageMaker.makeQuery(1)}'
		+ "&searchType="
		+ $("select option:selected").val()
		+ "&keyword=" + $('#keywordInput').val();
	});
})
</script>
</head>
<body>
	<div id="main">
		<div id="header">
			<div id="textcafe">C A F E</div>
			<div class='search' id="search">
				<select name="searchType" id="searchType">
					<option value="n"
						<c:out value="${cri.searchType == null?'selected':''}"/>>
						전체</option>
					<option value="t"
						<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
						카페소개</option>
					<option value="c"
						<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
						카페이름</option>
					<option value="w"
						<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
						카페지기</option>
				</select> <input type="text" name='keyword' id="keywordInput"
					value='${cri.keyword }'>
				<button id='searchBtn'>검색</button>
			</div>
			<div id="newid" onclick="location.href='/TK/newid'">회원가입</div>
			<div id="login" onclick="login()">로그인</div>
			<div id="loginform">
				<div id="form1">
					<span>ID :</span><input type="text" name="userid" id="userid"><br>
					<span>PW :</span><input type="password" name="userpw" id="userpw">
				</div>
				<div id="form2">
					<input id="checkidpw" type="submit" value="로그인">
				</div>
			</div>
			<div id="logout" onclick="location.href='/TK/logout'">로그아웃</div>
		</div>
		<div id="introslide">
			<img src="/TK/resources/img/introslide.jpg" id="introimg">
		</div>
		<div id="bottom">
			<div id="btl">
				<div id="btlbox">
					<c:forEach items="${btllist}" var="cafeVO">
					<div id="eachcafe" onclick="location.href='/TK/cafe/list/${cafeVO.cafeurl}/전체글보기'">
						<div><img src="/TK/resources/img/${cafeVO.cafeinfoimg}" id="btlimg"></div>
						<div>${cafeVO.cafename}</div>
						<div>${cafeVO.cafeintro}</div>
						<div>멤버 OOO명</div>
					</div>
					</c:forEach>
				</div>
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li><a href="${category}${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
						</c:if>
						
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li	<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
								<a href="${pageMaker.makeSearch(idx)}">${idx}</a>
							</li>
						</c:forEach>
			
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li><a href="${category}${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
						</c:if>
					</ul>
				</div>
			</div>
			<div id="btr">
				<div id="btrlogoff">// 공사중 //</div>
				<div id="btrlogin">
					<div id="iscafe1">
						<!-- <div id="gotocafe" class="text1" onclick="location.href='/TK/cafe/list/'">내 카페 가기</div>
						<div id="iscafe11"></div> $.getJSON으로 입력-->
					</div>

					<div id="iscafe0">
						<div class="text1" onclick="makecafe()">내 카페 만들기</div>
						<div id="makecafediv">
							<form role="form" action="" method="post" enctype="multipart/form-data">
								<div>카페이름(*)</div>
								<input type="text" name="cafename" id="cafename" required>
								<div>카페소개(*)</div>
								<textarea name="cafeintro" id="cafeinfro" required></textarea>
								<div>명함이미지</div>
								<input type="file" name="cafeinfoimg" multiple onchange="setimage(this,'cafeinfoimg')"><br>
								<img id="cafeinfoimg" src="">
								<div>대문이미지</div>
								<input type="file" name="cafeinfoimg" onchange="setimage(this,'cafeheadimg')"><br>
								<img id="cafeheadimg" src=""><br>
								<input type="hidden" name="userid" value="<%=userid%>">
							</form>
							<button type="submit" id="cafebutton" onclick="chkcafeurl()">Submit</button>
							<script>
								function chkcafeurl(){
									var chkcafeurl=$('#cafeurl').val();
									$.getJSON("/TK/chkcafeurl?cafeurl="+chkcafeurl, function(data) {
										if(data==0){
											var formObj = $("form[role='form']");
											formObj.attr("action", "/TK/makecafe");
											formObj.attr("method", "post");		
											formObj.submit();
										}else{
											alert("이미 사용중인 주소입니다.");
										}
									})
								}
							</script>
						</div>
					</div>
				</div>
			</div>
		</div>


	</div>
</body>
</html>