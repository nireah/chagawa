<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 사항</title>

<!-- 라이브러리 등록 - CDN 방식 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function() {
		if ("${param.key}")
			$("#key").val("${param.key}");
		if ("${param.perPageNum}")
			$("#perPageNum").val("${param.perPageNum}");
		
		// 한 줄 클릭
		$(".dataRow")
				.click(
						function() {
							let no = $(this).find(".no").text();
							location = "view.do?no="
									+ no
									+ "&inc=1&page=${param.page}&perPageNum=${param.perPageNum}"
									+ "&key=${param.key}&word=${param.word}";
						});

		// 한 페이지에서 보여 줄 게시글 개수 변경
		$("#perPageNum").change(function() {
			$("#changePerPageNumForm").submit();
		});
	});
</script>

<style type="text/css">
.dataRow:hover {
	background: #eee;
	cursor: pointer;
}

h2 {
	color: #4B89DC;
	font-weight: bold;
	text-align: center;
}

th {
	width: 200px;
	text-align: center;
	background: #4B89DC;
	opacity: 0.9;
	color: #EDF3FB;
}

td {
	text-align: center;
}

th, td {
	border-bottom: 1px solid #dcdcdc;
	border-left: 1px solid #dcdcdc;
	padding: 10px;
}

th:first-child, td:first-child {
	border-left: none;
}
</style>
</head>

<body>
	<div class="container">
		<h2>공지 사항</h2><br>
		
		<div class="row">
			<div class="col-md-9">
				<form class="form-inline">
					<input name="perPageNum" value="${param.perPageNum }" type="hidden">
					<div class="form-group">
						<select class="form-control" id="key" name="key">
							<option value="tc">전체</option>
							<option value="t">제목</option>
							<option value="c">내용</option>
						</select>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search"
							name="word" value="${param.word }">
					</div>
					<button class="btn btn-default" type="submit">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</form>
			</div>
			<div class="col-md-3 text-right">
				<form class="form-inline" id="changePerPageNumForm">
					<div class="form-group">
						<label>게시글 개수</label> <select name="perPageNum" id="perPageNum"
							class="form-control">
							<option>10</option>
							<option>15</option>
							<option>20</option>
						</select>
					</div>
				</form>
			</div>
		</div><br>
		
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>시작일</th>
					<th>종료일</th>
					<th>최종 수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="vo">
					<tr class="dataRow">
						<td class="no">${vo.no }</td>
						<td>${vo.title }</td>
						<td>${vo.startDate }</td>
						<td>${vo.endDate }</td>
						<td>${vo.updateDate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="row">
			<div class=" text-right" style="padding: 20px;">
				<c:if test="${ login != null && login.gradeNo == 9 }">
					<a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-default">등록</a>
				</c:if>
			</div>
		</div>
			<div class="row text-center">
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
			</div>
	</div>
</body>
</html>