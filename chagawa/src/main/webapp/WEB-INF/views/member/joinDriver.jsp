<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운전자등급으로 전환</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/js/regEx.js"></script>

<script type="text/javascript">
$(function() {
	$("#checkCar").click(function() {
		if (!checkData(reg_carNo, $("#carNo"), reg_carNo_error_msg, 1)) return false;
		window.open("checkCar.sub?carNo=" + $("#carNo").val(), "checkCar", "width= 1000, height= 300, top= 200, left= 450");
	});
	
	$("#checkLicense").click(function() {
		const reg_licenseNo_2 = /^[0-9]{2}$/;
		const reg_licenseNo_6 = /^[0-9]{6}$/;
		const reg_licenseNo_error_msg = "면허번호는 [xx-xx-xxxxxx-xx] 패턴으로 입력해야 합니다.";
		
		if (!checkData(reg_licenseNo_2, $("#licenseNo_1"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_2, $("#licenseNo_2"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_6, $("#licenseNo_3"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_2, $("#licenseNo_4"), reg_licenseNo_error_msg, 1)) return false;
		window.open("checkLicense.sub?licenseNo_1="+$("#licenseNo_1").val()+"&licenseNo_2="+$("#licenseNo_2").val()+"&licenseNo_3="+$("#licenseNo_3").val()+"&licenseNo_4="+$("#licenseNo_4").val(), "checkLicense", "width= 1000, height= 300, top= 200, left= 450");
	});
	
	$("#joinForm").submit(function() {
		if (!checkData(reg_carModel, $("#carModel"), reg_carModel_error_msg, 1)) return false;
		if (!checkData(reg_carNo, $("#carNo"), reg_carNo_error_msg, 1)) return false;
		
		const reg_licenseNo_2 = /^[0-9]{2}$/;
		const reg_licenseNo_6 = /^[0-9]{6}$/;
		const reg_licenseNo_error_msg = "면허번호는 [xx-xx-xxxxxx-xx] 패턴으로 입력해야 합니다.";
		
		if (!checkData(reg_licenseNo_2, $("#licenseNo_1"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_2, $("#licenseNo_2"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_6, $("#licenseNo_3"), reg_licenseNo_error_msg, 1)) return false;
		if (!checkData(reg_licenseNo_2, $("#licenseNo_4"), reg_licenseNo_error_msg, 1)) return false;
		
		window.open("notice.sub?id="+$("#id").val()+"&type=3", "checkCar", "width= 1000, height= 300, top= 200, left= 450");
	});

	$("#licenseNo_1").on("keyup", function() {
		if(this.value.length == 2) {
			$("#licenseNo_2").focus();
		}
	});
	$("#licenseNo_2").on("keyup", function() {
		if(this.value.length == 2) {
			$("#licenseNo_3").focus();
		}
	});
	$("#licenseNo_3").on("keyup", function() {
		if(this.value.length == 6) {
			$("#licenseNo_4").focus();
		}
	});
	
	$("#cancelBtn").click(function() {
// 		window.close();
		history.back();
	});
});
</script>

<style type="text/css">
h2{
	color: #4B89DC;
	font-weight: bold;
	text-align: center;
}
div{
	margin: 5px auto;
}
.col-md-3 {
	text-align: right;
	vertical-align: middle;
	padding-top: 5px;
}
#checkCar, #checkLicense{
	margin: auto 5px;;
}
#carNo, #carModel{
	width: 250px;
}
</style>

</head>

<body>
	<div class="container">
		<div style="width: 70%">
			<h2>운전자등급으로 전환</h2>
			<br>
			<form action="joinDriver.do" method="post" id="joinForm" class="well">
				<div>
					<input name="id" id="id" value="${param.id}" type="hidden">
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="carModel">차종:</label>
					</div>
					<div class="col-md-7 form-inline">
						<input class="form-control" name="carModel" id="carModel">
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="carNo">차량번호:</label>
					</div>
					<div class="col-md-7 form-inline">
						<input class="form-control" name="carNo" id="carNo" placeholder="공백없이 정확히 입력해주세요.">
						<button class="btn btn-success btn-sm" type="button" id="checkCar">중복확인</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<label for="licenseNo">면허번호:</label>
					</div>
					<div class="col-md-7 form-inline">
						<input class="form-control" name="licenseNo_1" id="licenseNo_1" placeholder="2자" style="width: 50px;"> -
						<input class="form-control" name="licenseNo_2" id="licenseNo_2" placeholder="2자" style="width: 50px;"> -
						<input class="form-control" name="licenseNo_3" id="licenseNo_3" placeholder="6자" style="width: 150px;"> -
						<input class="form-control" name="licenseNo_4" id="licenseNo_4" placeholder="2자" style="width: 50px;">
						<button class="btn btn-success btn-sm" type="button" id="checkLicense">중복확인</button>
					</div>
				</div>
				<div class="pull-right" style="padding: 10px 0;">
					<br>
					<button class="btn btn-default">등급변경</button>
					<button class="btn btn-default" type="reset">새로입력</button>
					<button class="btn btn-default" type="button" id="cancelBtn">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>