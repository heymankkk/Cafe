<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="/TK/resources/js/Newid.js" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<link href="/TK/resources/css/Newid.css" rel="stylesheet" type="text/css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="all">
	<div id="gotocafe" onclick="location.href='/TK/'"> C A F E
	</div>
	<div id="con">
		<form action="/TK/makeid" method="post">
			<div>아이디</div>
			<input type="text" onblur="idchk()" id="idchk1" name="userid" maxlength="22" required>
			<br><label id="la_chk"></label>
			<div>비밀번호</div>
			<input type="password" onblur="pwchk()" id="pwchk1" name="userpw" maxlength="22" required>
			<br><label id="la_pwchk"></label>
			<div>비밀번호재확인</div>
			<input type="password" onblur="pwchk2()" id="pwchk12" maxlength="22" required>
			<br><label id="la_pwchk2"></label>
			<div>닉네임</div>
			<input type="text" name="usernick" maxlength="16" required>
			<div>이름</div>
			<input type="text" name="username" maxlength="22" required>
			<br><label id="la_nickchk"></label>
			<div>휴대폰번호</div>
			<input type="text" id="phone" name="userphone" onblur="phone_chk()" maxlength="13" required>
			<br><label id="phone_chk"></label>
			<div>이메일</div>
			<input type="text" name="email" id="email" onblur="email_chk()" maxlength="50" required>
			<br><label id="la_chk4"></label>
			<div><input type="submit" value="가입하기"></div>
		</form>
	</div>
</div>
</body>
</html>