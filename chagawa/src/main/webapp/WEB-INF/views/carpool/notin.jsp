<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카풀 등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<form method="post">
<input type="hidden" name="id" value="${login.id }">
	<h1>차가 가 버렸어요</h1>
	동승확정 후 출발하기 전까지 탑승하지 않아 미탑승처리 되었어요.<br>
	포인트는 차감되지 않아요. <br>
	해당 차량 운행 종료 후 새로운 카풀을 이용할 수 있어요.
</form>
</div>
</body>
</html>