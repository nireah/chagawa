<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/regEx.js"></script>

<script type="text/javascript">
	$(function() {
		$("#checkId").click(function() {
			if (!checkData(reg_id, $("#id"), reg_id_error_msg, 1)) return false;
				window.open("checkId.sub?id=" + $("#id").val(), "checkId", "width= 1000, height= 300, top= 200, left= 450");
		});
		
		$("#checkNickname").click(function() {
			if (!checkData(reg_nickname, $("#nickname"), reg_nickname_error_msg, 1)) return false;
			window.open("checkNickname.sub?nickname=" + $("#nickname").val(), "checkNickname", "width= 1000, height= 300, top= 200, left= 450");
		});
		
		$("#checkTel").click(function() {
			if (!checkData(reg_tel1, $("#tel_2"), reg_tel1_error_msg, 1)) return false;
			if (!checkData(reg_tel2, $("#tel_3"), reg_tel2_error_msg, 1)) return false;
			window.open("checkTel.sub?tel_1=" + $("#tel_1").val() + "&tel_2=" + $("#tel_2").val() + "&tel_3=" + $("#tel_3").val(), "checkTel", "width= 1000, height= 300, top= 200, left= 450");
		});

		$("#tel_2").on("keyup", function() {
			if (this.value.length == 4) {
				$("#tel_3").focus();
			}
		});

		$("#birth_d").on("keyup", function() {
			const today = new Date();
			const birthDate = new Date($("#birth_y").val(), $("#birth_m").val(), $("#birth_d").val());

			let age = today.getFullYear() - birthDate.getFullYear();
			const m = today.getMonth() - birthDate.getMonth();
			if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
			    age--;
			}
			
			if(age < 14) {
				alert("만 14세 미만은 회원가입 하실 수 없습니다.");
			}
		});
		
		
		$("#joinForm").submit(function() {
			if (!checkData(reg_id, $("#id"), reg_id_error_msg, 1)) return false;
			if (!checkData(reg_pw, $("#pw"), reg_pw_error_msg, 0)) {
				$("#pw").val("");
				return false;
			}
			if (!checkData(reg_pw, $("#pw2"), reg_pw_error_msg, 0)) {
				$("#pw2").val("");
				return false;
			}
			if ($("#pw").val() != $("#pw2").val()) {
				alert("비밀번호와 비밀번호 확인은 같아야 합니다.");
				$("#pw, #pw2").val("");
				return false;
			}
			if (!checkData(reg_nickname, $("#nickname"), reg_nickname_error_msg, 1)) return false;
			if (!checkData(reg_name, $("#name"), reg_name_error_msg, 1)) return false;
			if ($("#gender").val() == "-성별-") {
				alert("성별을 선택해주세요.");
				return false;
			}
			if (!checkData(reg_dateY, $("#birth_y"), reg_dateY_error_msg, 1)) return false;
			if ($("#birth_m").val() == "-월-") {
				alert("월을 선택해주세요.");
				return false;
			}
			if (!checkData(reg_dateD, $("#birth_d"), reg_dateD_error_msg, 1)) return false;
			if (!checkData(reg_tel1, $("#tel_2"), reg_tel1_error_msg, 1)) return false;
			if (!checkData(reg_tel2, $("#tel_3"), reg_tel2_error_msg, 1)) return false;
			if ($("#bank").val() == "-은행-") {
				alert("은행을 선택해주세요.");
				return false;
			}
			if (!checkData(reg_account, $("#account"), reg_account_error_msg, 1)) return false;

			alert("회원가입이 완료되었습니다.");
		});

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

div {
	margin: 5px auto;
}

.col-md-3 {
	text-align: right;
	vertical-align: middle;
	padding-top: 5px;
}
#checkTel, #checkId, #checkNickname{
	margin: auto 5px;;
}
</style>

</head>

<body>
	<div class="container">
		<div style="width: 70%">
			<h2>회원가입</h2>
			<br>
			<form action="join.do" method="post" id="joinForm"
				enctype="multipart/form-data" class="form-group well">
				<div class="row">
					<div class="col-md-3">
						<label for="id">아이디:</label>
					</div>
					<div class="col-md-7 form-inline">
						<input class="form-control" name="id" id="id" value="${param.id}" placeholder="영문, 숫자 4자 이상">
						<button class="btn btn-success btn-sm" type="button" id="checkId">중복확인</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="pw">비밀번호:</label>
					</div>
					<div class="col-md-7">
						<input class="form-control" name="pw" id="pw" type="password" style="width: 300px;" placeholder="영문, 숫자, 특수기호 4자 이상">
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="pw2">비밀번호 확인:</label>
					</div>
					<div class="col-md-7">
						<input class="form-control" name="pw2" id="pw2" type="password" style="width: 300px;">
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="nickname">닉네임:</label>
					</div>
					<div class="col-md-7 form-inline">
						<input class="form-control" name="nickname" id="nickname" placeholder="한글, 영문 2자 이상">
						<button class="btn btn-success btn-sm" type="button" id="checkNickname">중복확인</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="name">이름:</label>
					</div>
					<div class="col-md-7">
						<input class="form-control" name="name" id="name" style="width: 250px;" placeholder="한글">
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="profileImage">프로필사진:</label>
					</div>
					<div class="col-md-7">
						<input class="form-control" name="profileImage" id="profileImageame" type="file" style="width: 250px;">
						<div class="alert alert-success" style="padding: 10px; margin: 5px 0 0 0;"> ※ 사진을 선택하지 않은 경우, 기본 이미지로 등록됩니다.</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="gender">성별:</label>
					</div>
					<div class="col-md-7">
						<select class="form-control" name="gender" id="gender" style="width: 250px;">
							<option selected>-성별-</option>
							<option>남자</option>
							<option>여자</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="birth_y">생년월일:</label>
					</div>
					<div class="col-md-7 form-inline">
						<input class="form-control" name="birth_y" id="birth_y" style="width: 100px;" placeholder="연도(4자)">
						<select class="form-control" name="birth_m" id="birth_m" style="width: 70px;">
							<option selected>-월-</option>
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
							<option>6</option>
							<option>7</option>
							<option>8</option>
							<option>9</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						</select>
						<input class="form-control" name="birth_d" id="birth_d" style="width: 70px;" placeholder="일(2자)">
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="tel_1">연락처:</label>
					</div>
					<div class="col-md-7 form-inline">
						<select class="form-control" name="tel_1" id="tel_1" style="width: 80px;">
							<option>010</option>
							<option>011</option>
							<option>012</option>
							<option>013</option>
							<option>014</option>
							<option>015</option>
							<option>016</option>
							<option>017</option>
							<option>018</option>
							<option>019</option>
						</select>
						<input class="form-control" name="tel_2" id="tel_2" style="width: 100px;" placeholder="3-4자">
						<input class="form-control" name="tel_3" id="tel_3" style="width: 100px;" placeholder="4자">
						<button class="btn btn-success btn-sm" type="button" id="checkTel">중복확인</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="bank">계좌:</label>
					</div>
					<div class="col-md-7 form-inline">
						<select class="form-control" name="bank" id="bank" style="width: 100px;">
							<option selected>-은행-</option>
							<option>농협</option>
							<option>신한</option>
							<option>국민</option>
							<option>우리</option>
							<option>하나</option>
							<option>카카오</option>
							<option>새마을</option>
							<option>우체국</option>
						</select>
						<input class="form-control" name="account" id="account" style="width: 250px;" placeholder="-를 포함하여 정확히 입력해주세요.">
					</div>
				</div>
				<div class="pull-right" style="padding: 10px 0;">
					<br>
					<button class="btn btn-default">회원가입</button>
					<button class="btn btn-default" type="reset">새로입력</button>
					<button class="btn btn-default" type="button" id="cancelBtn">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>