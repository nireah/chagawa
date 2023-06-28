<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="/js/regEx.js"></script>

<script type="text/javascript">
	$(function() {
		$("#updateForm").submit(
				function() {
					// 제목
					if (!checkData(reg_title, $("#title"), reg_title_error_msg,
							1))
						return false;
					// 내용
					if (!checkData(reg_content, $("#content"),
							reg_content_error_msg, 1))
						return false;
				});

		// 취소 이벤트 처리
		$("#cancelBtn").click(function() {
			history.back();
		});
	});
</script>

<style type="text/css">
h2 {
	color: #4B89DC;
	font-weight: bold;
	text-align: center;
}
</style>
</head>

<body>
	<div class="container">
		<h2 style="text-align: center;">공지 사항</h2>
		<br>
		<form action="update.do" method="post" id="updateForm">
			<input type="hidden" name="page" value="${param.page }">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">
			<input type="hidden" name="key" value="${param.key }">
			<input type="hidden" name="word" value="${param.word }">
			
			<div class="form-group">
				<label for="no">번호</label> <input name="no" id="no" readonly value="${vo.no }" class="form-control">
			</div>
			<br>
			<div class="form-group">
				<label for="title">제목</label> <input name="title" id="title" value="${vo.title }" class="form-control">
			</div>
			<br>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea style='resize: none;' rows="10" name="content" id="content" class="form-control">${vo.content }</textarea>
			</div>
			<br>
			<div style="display: inline-block; width: 48%;" class="form-group">
				<label for="startDate">시작일</label> <input type="date" name="startDate" id="startDate" value="${vo.startDate }" class="form-control">
			</div>
			<div style="display: inline-block; float: right; width: 48%;" class="form-group">
				<label for="endDate">종료일</label> <input type="date" name="endDate" id="endDate" value="${vo.endDate }" class="form-control">
			</div>
			<br>
			<div class=" text-right" style="margin-top: 20px;">
				<button class="btn btn-default" type="reset">초기화</button>
				<button class="btn btn-default" type="button" id="cancelBtn">취소</button>
				<button id=btn class="btn btn-default">등록</button>
			</div>
		</form>
	</div>
</body>
</html>