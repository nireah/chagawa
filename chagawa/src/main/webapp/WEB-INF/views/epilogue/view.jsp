<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 글 보기</title>

<!-- 라이브러리 등록  : CDN 방식 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#deleteDiv{
	display: none;
}
</style>

<script type="text/javascript">
$(function(){
	// 삭제 버튼 이벤트 처리 - a tag
	$("#deleteBtn").click(function(){
		$("#deleteDiv").slideDown(); // 보이게
		return false;
	});
	$("#deleteBtnCk").click(function(){
		if(!confirm("정말 삭제하시겠습니까?"))
		return false; 
	});
	$("#cancelDeleteBtn").click(function(){
		$("#deleteDiv").slideUp(); // 안보이게
	});
});
</script>

</head>
<body>
<div class="container">
	<h1>후기 글 보기</h1>
	<table class="table">
		<tbody>
			<tr>
				<th>글번호</th>
				<td>${vo.no }</td>
			</tr>
			<tr>
				<th>카풀번호</th>
				<td>${vo.cpNo }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${vo.title }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${vo.writer }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${vo.writeDate }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${vo.content }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.hit }</td>
			</tr>
		</tbody>
	</table>
	<c:if test="${login != null && (vo.writer == login.id || login.gradeNo == 9)}">
	<a href="update.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word}" 
	class="btn btn-default">수정</a>
	<a href="delete.do" class="btn btn-default" id="deleteBtn">삭제</a>
	</c:if>
	<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key }&word=${param.word}" 
		class="btn btn-default">글목록</a>
	<div id="deleteDiv" class="well">
		<form action="delete.do" method="post">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">
			<input type="hidden" name="no" value="${vo.no }">
			<input type="hidden" name="cpNo" value="${vo.cpNo }">
			<button id="deleteBtnCk">삭제</button>
			<button type="button" id="cancelDeleteBtn">취소</button>
		</form>
	</div>
</div>
</body>
</html>