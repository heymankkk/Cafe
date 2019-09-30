<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="Readpage">
	<div>READ BOARD</div>
	<div>
	<div>
		<div class="">Title</div>
		<input type="text" name="title" value="${boardVO.title}" readonly>
	</div>
	<div>
		<div class="">Content</div>
		<textarea name="content" readonly>${boardVO.content}</textarea>
	</div>
	<div>
		<div class="">Writer</div>
		<input type="text" name="writer" value="${boardVO.writer}" readonly>
	</div>
	<span>
		<button type="submit" class="btn btn-warning modifyBtn">MODIFY</button>
    	<button type="submit" class="btn btn-danger removeBtn">REMOVE</button>
		<button type="submit" class="btn btn-primary goListBtn">GO LIST </button>
	</span>
	</div>
</div>
	<div id="reply">
		<div>
			<c:forEach items="${reply}" var="replyVO">
			<c:if test="${replyVO.num=='1'}">
				<div class="replybox">
					<div class="replyer">${replyVO.replyer}</div>
					<div class="regdate"><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${replyVO.regdate}"/></div>
					<div class="re_reply1" id="viewreply1${replyVO.rno}${replyVO.num}" onclick="rere(${replyVO.rno},${replyVO.num})">답글 ┐</div>
					<div class="re_reply2" id="viewreply2${replyVO.rno}${replyVO.num}" onclick="rera(${replyVO.rno},${replyVO.num})">답글취소</div>
					<c:if test="${replyVO.replyer==userid}">
						<div id="del" onclick="delreply(${replyVO.rno},${replyVO.num},${replyVO.bno})">삭제</div>
					</c:if>
					<br><div class="replytext2">${replyVO.replytext}</div>
				</div>
				<div id="re${replyVO.rno}${replyVO.num}" class="makeinput${replyVO.rno}${replyVO.num}"></div>
			</c:if>
			<c:if test="${replyVO.num!='1'}">
				<div class="re_replybox">
					<div class="replyer">${replyVO.replyer}</div>
					<div class="regdate"><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${replyVO.regdate}"/></div>
					<div class="re_reply1" id="viewreply11${replyVO.rno}${replyVO.num}" onclick="rere1(${replyVO.rno},${replyVO.num})">답글 ┐</div>
					<div class="re_reply2" id="viewreply22${replyVO.rno}${replyVO.num}" onclick="rera1(${replyVO.rno},${replyVO.num})">답글취소</div>
					<c:if test="${replyVO.replyer==userid}">
						<div id="del" onclick="delreply(${replyVO.rno},${replyVO.num},${replyVO.bno})">삭제</div>
					</c:if>
					<br><div class="replytext2">${replyVO.replytext}</div>
				</div>
				<div id="re${replyVO.rno}${replyVO.num}" class="makeinput${replyVO.rno}${replyVO.num}"></div>
			</c:if>
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
						<a href="${pageMaker.makeReply(idx)}&bno=${boardVO.bno}">${idx}</a>
					</li>
				</c:forEach>
	
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="${category}${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
		<input type="text" id="replytext" name="replytext">
		<div id="upreply">등록</div>
	</div>
	
	 <form role="form" action="" method="post">
	 	<input type='hidden' name='cafeurl' value ="${boardVO.cafeurl}">
	 	<input type='hidden' name='category2' value ="${boardVO.category2}">
	    <input type='hidden' name='bno' value ="${boardVO.bno}">
	    <input type='hidden' name='page' value ="${cri.page}">
	    <input type='hidden' name='perPageNum' value ="${cri.perPageNum}">
	    <input type='hidden' name='searchType' value ="${cri.searchType}">
	    <input type='hidden' name='keyword' value ="${cri.keyword}">
 	</form>   


<script>
function delreply(rno,num,bno){

	$.ajax({
		method : 'POST',
		url : '/TK/cafe/delreply',
		headers : {
			'Content-Type' : 'application/json',
			'X-HTTP-Method-Override' : 'POST'
		},
		dataType : 'text',
		data : JSON.stringify({
			rno : rno,
			bno : bno,
			num : num
		}),
		success:function(result){
			if(result=='SUCCESS'){
				window.location.replace("");
			}else if(result=='FAIL'){
				alert('실패');
			}
		}
	})
}
function rere(rno,num){
	$('#viewreply1'+rno+num).css('display','none');
	$('#viewreply2'+rno+num).css('display','inline-block');
	$('.makeinput'+rno+num).css('border-bottom','1px dotted #666');
	$('.makeinput'+rno+num).css('margin-left','19px');
	var text = "re"+rno+num;
	var str = "<input type=\"text\" id=\"re_replytext\" name=\"replytext\">"
	+"<div id=\"re_upreply\" onclick=\"re_upreply("+rno+")\">등록</div>"
	$("#"+text).html(str);
}
function rera(rno,num){
	$('#viewreply1'+rno+num).css('display','inline-block');
	$('#viewreply2'+rno+num).css('display','none');
	$('.makeinput'+rno+num).css('border-bottom','0');
	var text = "re"+rno+num;
	var str = ""
	$("#"+text).html(str);
}
function rere1(rno,num){
	$('#viewreply11'+rno+num).css('display','none');
	$('#viewreply22'+rno+num).css('display','inline-block');
	$('.makeinput'+rno+num).css('border-bottom','1px dotted #666');
	$('.makeinput'+rno+num).css('margin-left','19px');
	var text = "re"+rno+num;
	var str = "<input type=\"text\" id=\"re_replytext\" name=\"replytext\">"
	+"<div id=\"re_upreply\" onclick=\"re_upreply("+rno+")\">등록</div>"
	$("#"+text).html(str);
}
function rera1(rno,num){
	$('#viewreply11'+rno+num).css('display','inline-block');
	$('#viewreply22'+rno+num).css('display','none');
	$('.makeinput'+rno+num).css('border-bottom','0');
	var text = "re"+rno+num;
	var str = ""
	$("#"+text).html(str);
}
/* 대댓글달기 */

function re_upreply(rno){
	var method="대댓";
	var rno = rno;
	var replytext =  $('#re_replytext').val();
	if("<%=(String)session.getAttribute("userid")%>"!="null"){
		$.ajax({
			method : 'POST',
			url : '/TK/cafe/setreply',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'POST'
			},
			dataType : 'text',
			data : JSON.stringify({
				rno : rno,
				bno : "${boardVO.bno}",
				replytext : replytext,
				replyer : "<%=(String)session.getAttribute("userid")%>",
				method : method
			}),
			success:function(result){
				if(result=='SUCCESS'){
					window.location.replace("");
				}else if(result=='FAIL'){
				}
			}
		})
	}else{
		alert("로그인 후 이용할 수 있습니다.")
	}
}
/* 댓글달기 */
$('#upreply').click(function(){
	var method="댓";
	var replytext =  $('#replytext').val();
	if("<%=(String)session.getAttribute("userid")%>"!="null"){
		$.ajax({
			method : 'POST',
			url : '/TK/cafe/setreply',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'POST'
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : "${boardVO.bno}",
				replytext : replytext,
				replyer : "<%=(String)session.getAttribute("userid")%>",
				method : method
			}),
			success:function(result){
				if(result=='SUCCESS'){
					alert('댓글성공');
					window.location.replace("");
				}else if(result=='FAIL'){
					alert('실패');
				}
			}
		})
	}else{
		alert("로그인 후 이용할 수 있습니다.")
	}
})

$(document).ready(function(){	
	if("${reply}"=="[]"){
		$('#replytext').css('margin-top','0');
	}
	
	/* 글쓴이만 수정,삭제 가능 */
	if("${boardVO.writer}"=="<%=(String)session.getAttribute("userid")%>"){
		$(".modifyBtn").css('display','inline-blick')
		$(".removeBtn").css('display','inline-blick')
	}else{
		$(".modifyBtn").css('display','none')
		$(".removeBtn").css('display','none')
	}
	
	var formObj = $("form[role='form']");
	$(".modifyBtn").on("click", function(){
		formObj.attr("action", "Modifypage");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	$(".removeBtn").on("click", function(){
		formObj.attr("action", "/TK/cafe/removePage");
		formObj.attr("method", "post");
		formObj.submit();
	});
	$(".goListBtn").on("click", function(){
		formObj.attr("method", "get");
		formObj.attr("action", "${boardVO.category2}");
		formObj.submit();
	});
});
</script>