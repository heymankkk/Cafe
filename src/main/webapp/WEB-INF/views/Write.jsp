<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$.getJSON("/TK/cafe/boardlist/"+cafeurl, function(data) {
	var str1="";
	var abc="";
	$(data).each(function(){
		if(abc != this.category1){
		str1 += "<option value="+this.category1+">"+this.category1+"</option>";
		abc = this.category1;
		};
		
	})
	$('#category1').html(str1);
})
function takecate2(){
	var category = $("#category1 option:selected").text();
	$.getJSON("/TK/cafe/boardlist/"+cafeurl+"?using="+category, function(data) {
		var str1="";
		$(data).each(function(){
			str1 += "<option value="+this.category2+">"+this.category2+"</option>";
		})
		$('#category2').html(str1);
	})
}
</script>
<div id="write">
	<div>WRITE BOARD</div>
	<form action="/TK/cafe/register" method="post">
	<input type="hidden" name="cafeurl" value="<%=(String)request.getAttribute("cafeurl")%>">
	<div>
		<div id="textcate">Category1</div><div id="textcate">Category2</div><br>
		<select id="category1" name="category1" onchange="takecate2()" required>
		</select>
		<select id="category2" name="category2" required>
		</select>
	</div>
	<div>
		<div>Title</div><input type="text" name="title" required>
	</div>
	<div>
		<div>Content</div><textarea name="content" required></textarea>
	</div>
	<div>
		<div>Writer</div><input type="text" name="writer" value="<%=session.getAttribute("userid")%>" readonly>
	</div>
	<div>
		<div>Password</div><input type="password" name="pw" required>
	</div>
	<span>
		<button type="submit">Submit</button>
	</span>
	</form>
</div>