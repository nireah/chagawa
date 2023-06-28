<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	if ("${login.nickname}")
		alert("${login.nickname}님 환영합니다.");
	if ("${param.logout}")
		alert("로그아웃 되었습니다.");
	if ("${param.leave}")
		alert("탈퇴 처리 되었습니다.");
});
</script>

<style>
.leftDiv {
	float: left;
	width: 50%;
	margin: 50px 20px 0px 0px;
}

.msgBox {
	width: 100%;
	margin: 80px 0px 0px 0px;
}

.title {
	margin-bottom: 30px;
}

.msg {
	margin-bottom: 70px;
	width: 80%;
}
</style>

</head>
<body>
	<div class="container">

		<div class="leftDiv">
			<img src="/upload/main/main.png" style="width: 100%;">
		</div>
		<div class="rightDiv">
			<div class="msgBox">

				<!-- 			비회원 메인 -->
				<c:if test="${login eq null}">
					<div class="title">
						<h2>
							<b>당신을 위한 차가 와요</b>
						</h2>
					</div>
					<div class="msg">
						붐비는 대중교통에 지치셨나요?<br> 차가와에서 비슷한 경로의 차를 찾아, <br> 편안한 운행을
						즐기세요.
					</div>
					<div class="title">
						<h2>
							<b>함께할 동행이 와요</b>
						</h2>
					</div>
					<div class="msg">
						차를 타고 이동할 계획이 있으신가요? <br> 빈 자리에 동행할 승객을 태우고, <br> 동승료
						수입을 얻으세요.
					</div>
					<div class="title">
						<h2>
							<b>아직 회원이 아니시라면</b>
						</h2>
					</div>
					<div class="msg">
						<a class="btn btn-primary pull-right" href="/member/terms.do">바로
							가입하기</a>
					</div>
				</c:if>

				<!-- 				회원 메인 -->
				<c:if test="${login ne null && login.gradeNo ne 9}">
					<div class="title">
						<h2>
							<b>동행을 찾으시나요?</b>
						</h2>
					</div>
					<div class="msg">
						차를 공유하고 싶으시다면 <a class="btn btn-primary pull-right"
							href="/carpool/write.do">카풀 등록하기</a>
					</div>
					<div class="msg">
						같이 탈 차를 찾고 있으시다면 <a class="btn btn-primary pull-right"
							href="/carpool/list.do">카풀 찾기</a>
					</div>
					<div class="title">
						<h2>
							<b>다른 사람들의 후기가 궁금하신가요?</b>
						</h2>
					</div>
					<div class="msg">
						<a class="btn btn-primary pull-right" href="/epilogue/list.do">카풀
							후기 보러 가기</a>
					</div>
				</c:if>

				<!-- 				관리자 메인 -->
				<c:if test="${login ne null && login.gradeNo eq 9}">
					<div class="title">
						<h2>
							<b>문의사항에 답변해 주세요</b>
						</h2>
					</div>
					<div class="msg">
						읽지 않은 메시지가 있나요?<br>
						상단 바의 배지를 확인하세요<br><br>
						<a class="btn btn-primary pull-right"
							href="/messageroom/list.do">메시지 리스트</a>
					</div>
					<div class="title">
						<h2>
							<b>수수료 수입을 확인하세요</b>
						</h2>
					</div>
					<div class="msg">
						카풀 서비스 차가와는<br>
						포인트 충전 금액의 일부를<br>
						수익으로 하여 운영되고 있어요<br><br>
						<a class="btn btn-primary pull-right"
							href="/point/list.do?id=${login.id }">수수료 수입 내역</a>
					</div>

				</c:if>
			</div>
		</div>

	</div>
</body>
</html>