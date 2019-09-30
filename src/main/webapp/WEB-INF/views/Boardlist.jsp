<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="board">
		<div id="boardtitle">${category}
		</div>
		<div id="take">
		<table class="boardtable">
			<tr>
				<td></td>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회</th>
			</tr>	
		<c:forEach items="${list}" var="boardVO">
			<tr>
				<%-- <td>${boardVO.bno}</td> --%>
				<td>${boardVO.category2}</td>
				<td><a href='Readpage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno}'>${boardVO.title} </a></td>
				<td>${boardVO.writer}</td>
				<c:set var="today" value="<%=new java.util.Date()%>"/>
				<fmt:formatDate var="dateFom1" value="${boardVO.regdate}" pattern="yyyy.MM.dd"/>
				<fmt:formatDate var="now" type="date" value="${today}" pattern="yyyy.MM.dd"/>
				<td>
					<c:if test="${dateFom1>=now}">
						<fmt:formatDate pattern="HH:mm:ss" value="${boardVO.regdate}" />
					</c:if>
					<c:if test="${dateFom1<now}">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${boardVO.regdate}" />
					</c:if>
				</td>
				<td>${boardVO.viewcut}</td>
			</tr>
		</c:forEach>
		</table>
		</div>
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li><a href="${category}${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
				</c:if>
				
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li	<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
						<a href="${category}${pageMaker.makeSearch(idx)}">${idx}</a>
					</li>
				</c:forEach>
	
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="${category}${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
		
		<div class='search'>
			<select name="searchType">
				<option value="n"
					<c:out value="${cri.searchType == null?'selected':''}"/>>
					---</option>
				<option value="t"
					<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
					Title</option>
				<option value="c"
					<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
					Content</option>
				<option value="w"
					<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
					Writer</option>
				<option value="tc"
					<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
					Title OR Content</option>
				<option value="cw"
					<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
					Content OR Writer</option>
				<option value="tcw"
					<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
					Title OR Content OR Writer</option>
			</select> <input type="text" name='keyword' id="keywordInput"
				value='${cri.keyword }'>
			<button id='searchBtn'>Search</button>
			<button id='newBtn'>New Board</button>
		</div>
	</div>