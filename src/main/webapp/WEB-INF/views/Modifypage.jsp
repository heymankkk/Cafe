<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="modify">
	<div>MODIFY BOARD</div>
	<form role="form" action="" method="post">
		<input type="hidden" name="cafeurl" value ="${boardVO.cafeurl}">
		<input type="hidden" id="bno" name="bno" value="${boardVO.bno}">
		<div>
			<div>Title</div><input type="text" name="title" value="${boardVO.title}" required>
		</div>
		<div>
			<div>Content</div><textarea name="content" required>${boardVO.content}</textarea>
		</div>
		<div>
			<div>Writer</div><input type="text" name="writer" value="${boardVO.writer}" readonly>
		</div>
		<div>
			<div>Password</div>
			<input id="password" type="password" name="pw" required>
		</div>
	</form>
	<span>
		<button type="submit" onclick="chkpw()">Submit</button>
		<button type="submit" class="btn btn-primary goListBtn" onclick="history.back()">Back</button>
	</span>
</div>
<script>
function chkpw(){
var pw = $('#password').val();
var bno = $('#bno').val();
	$.getJSON("/TK/cafe/modifypwchk?pw="+pw+"&bno="+bno, function(data) {
		if(data==pw){
			var formObj = $("form[role='form']");
			formObj.attr("action", "/TK/cafe/modifyPage");
			formObj.attr("method", "post");		
			formObj.submit();
		}else{
			alert("비밀번호가 다릅니다.");
		}
	})
}
</script>